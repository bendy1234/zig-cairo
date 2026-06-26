# this was hacked together over ~9 days and has some questionable choices

# this is also fragile so be careful when editing
# some improvements that could be made:
# separating the code eg parsing, resolving types
# rename vars
# replace strings with ir layer
# make code gen more deterministic (the sort function in main)

# command used to generate cairo.xml
# castxml --castxml-output=1 --castxml-cc-gnu-c /usr/bin/gcc /usr/include/cairo/cairo.h

import xml.etree.ElementTree as ET

c_to_zig_generic = {
    "int8_t": "i8",
    "uint8_t": "u8",
    "int16_t": "i16",
    "uint16_t": "u16",
    "int32_t": "i32",
    "uint32_t": "u32",
    "int64_t": "i64",
    "uint64_t": "u64",
    "__int128": "i128",
    "unsigned __int128": "u128",
    "intptr_t": "isize",
    "uintptr_t": "usize",
    "size_t": "usize",
    "char": "c_char",
    "short": "c_short",
    "unsigned short": "c_ushort",
    "int": "c_int",
    "unsigned int": "c_uint",
    "long": "c_long",
    "unsigned long": "c_ulong",
    "long long": "c_longlong",
    "unsigned long long": "c_ulonglong",
    "long double": "c_longdouble",
    "_Float16": "f16",
    "float": "f32",
    "double": "f64",
    # "long double": "f80",
    "_Float128": "f128",
    "bool": "bool",
    "void": "anyopaque",
}
c_to_zig_types = {
    "__int128": "i128",
    "unsigned __int128": "u128",
    "int": "c_int",
    "unsigned int": "c_uint",
    "double": "f64",
    "void": "void",
    "long int": "c_long",  #
    "long unsigned int": "c_ulong",  #
    "char": "c_char",
    "unsigned char": "u8",  #
}

rename_overrides = {
    "cairo_t": "Ctx",
    "cairo_bool_t": "cairo_bool_t",
    "cairo_region_union": "regionUnion",  # got renamed to "union"
}

ignore_types = {
    # "_cairo*",
    "__builtin_va_list",
    "__builtin_ms_va_list",
    "__NSConstantString",
    "__uint128_t",
    "__int128_t",
}

namespaces = {  # space, prefixes
    "Pattern": {
        "pattern",
        "mesh_pattern",
        "raster_source",  # _pattern",
    },
    "Surface": {"surface", "image_surface", "recording_surface"},
    "FontFace": {"font_face"},
    "ToyFontFace": {"toy_font_face"},
    "UserFontFace": {"user_font_face", "user_scaled_font"},
    "ScaledFont": {"scaled_font"},
    "FontOptions": {"font_options"},
    "Path": {"path"},
    # others
    "Region": {"region"},
    "Matrix": {"matrix"},
    "Device": {"device"},
}

scope_overrides = {
    "color_mode_t": "FontOptions",
    "dither_t": "Pattern",
    "extend_t": "Pattern",
    "filter_t": "Pattern",
    "hint_style_t": "FontOptions",
    "hint_metrics_t": "FontOptions",
    "read_func_t": "Surface",
    "subpixel_order_t": "FontOptions",
    "format_stride_for_width": "Surface",
    "t": "Ctx",  # cairo_t => context
    "status_to_string": "global",
    "version": "global",
    "version_string": "global",
    # "create" : "",
}


class Parser:
    __slots__ = (
        "raw",
        "all_fields",
        "loose",
        "tmp_loose",
        # "files",
        "remaped_names",
        "separated",
        "type_table",
        "func_defs",
        "struct_defs",
        "typedefs",
        "enum_defs",
        "comments",
    )

    def __init__(self) -> None:
        # raw data
        self.raw: dict[str, ET.Element] = {}  # id: elem
        self.all_fields: list[ET.Element] = []

        self.loose: dict[str, list[tuple[str, str] | str]] = {}  # id: [data]
        self.tmp_loose: list[tuple[str, str] | str] = []

        # self.files: dict[str, str] = {}  # id: path

        # data used in code gen
        self.remaped_names: dict[str, str] = {}  # id: name
        self.separated: dict[str, set] = {"global": set(), "Ctx": set()}  # space, ids
        for space in namespaces.keys():
            self.separated[space] = set()

        # self.processed: dict[str, str] = {}  # id, code
        self.type_table: dict[str, str] = {}  # id: type (zig)
        self.typedefs: dict[str, str] = {}  # id: realtype (expanded)
        self.func_defs: dict[str, str] = {}  # id: func def
        self.struct_defs: dict[str, str] = {}  # id: struct def (no name + unions)
        self.enum_defs: dict[str, str] = {}  # id: enum def (no name)
        self.comments: dict[str, str] = {}  # id: comment

    def consume_element(self, elem: ET.Element):
        if elem.tag in ["CastXML", "GCC_XML"]:
            return

        tag = elem.tag
        id = elem.attrib.get("id")
        name = elem.attrib.get("name")

        if id is None:
            if tag == "Argument":
                val = elem.attrib["type"]
                val = val if name is None else (name, val)
                self.tmp_loose.append(val)
            elif tag == "EnumValue":
                self.tmp_loose.append((name, elem.attrib["init"]))  # type:ignore
            else:
                raise ValueError("Unexpected xml tag: " + tag)
            return

        self.raw[id] = elem

        # Stuff that have children
        # Yea this will break if the schema changes but im lazy
        if tag == "Function":
            self.loose[id] = self.tmp_loose
            self.tmp_loose = []
        elif tag == "FunctionType":
            self.loose[id] = self.tmp_loose
            self.tmp_loose = []
        elif tag == "Enumeration":
            self.loose[id] = self.tmp_loose
            self.tmp_loose = []

        elif tag == "Field":
            self.all_fields.append(elem)
        # elif tag == "File":
        #     self.files[id] = name  # type: ignore

    def _(self, id: str) -> str:
        while self.raw[id].tag == "ElaboratedType":
            id = self.raw[id].attrib["type"]
        return id

    def get_renamed(self, id: str) -> str:
        id = self._(id)
        if id in self.remaped_names:
            return self.remaped_names[id]

        elem = self.raw[id]
        a = elem.attrib
        name = a["name"]
        self.gather_scoped(id)

        if name in rename_overrides:
            # so there's no garbo in the table
            self.remaped_names[id] = rename_overrides[name]
            return rename_overrides[name]

        elif name.startswith("cairo_"):
            n = self.get_renamed_scoped(id)

            self.remaped_names[id] = n
            return n
        self.remaped_names[id] = name
        return name

    def get_renamed_scoped(self, id: str) -> str:
        elem = self.raw[self._(id)]
        tag = elem.tag
        a = elem.attrib

        name = a["name"].removeprefix("cairo_").removesuffix("_t")

        s = ""
        for space, prefixes in namespaces.items():
            for prefix in prefixes:
                if name.startswith(prefix) and name != prefix:
                    s = space
                    break

        n = name.replace("_", " ").title().replace(" ", "")
        if s not in n and s == "UserFontFace":
            n = n.removeprefix("User").replace("Font", "", 1)
            # print("//", n, s)

        n = n.replace(s, "", 1)

        if tag == "Function":
            n = n[0].lower() + n[1:]
        return n

    def get_type(self, id: str) -> str:
        id = self._(id)
        if id in self.type_table:
            return self.type_table[id]
        elem = self.raw[id]
        tag = elem.tag
        a = elem.attrib

        # "simple" types
        if tag == "FundamentalType":
            name = a["name"]
            self.type_table[id] = c_to_zig_types[name]
        elif tag in ["Struct", "Union"]:
            self.type_table[id] = self.get_renamed(id)
            self.get_structure_layout(id)
        elif tag == "Enumeration":
            self.type_table[id] = self.get_renamed(id)
            self.get_enum_layout(id)
        elif tag == "Typedef":
            self.type_table[id] = self.get_renamed(id)
            underlying = self._(a["type"])
            underlying_elem = self.raw[underlying]
            tp = self.get_type(underlying)

            if underlying_elem.tag in ["Struct", "Union"]:
                self.typedefs[id] = self.get_structure_layout(underlying)
            elif underlying_elem.tag == "Enumeration":
                self.typedefs[id] = self.get_enum_layout(underlying)
            else:
                self.typedefs[id] = tp

        elif tag == "PointerType":
            prefix = "?*"
            type = a["type"]
            base = self.get_type(type)
            if self.raw[type].tag == "FunctionType":
                prefix = "*const "  # func pointer
            elif base.endswith("u8"):
                prefix = "[*]"  # buffer
            elif base == "c_char":
                prefix = "[*:0]"  # string
                base = "u8"
            elif base == "const c_char":
                prefix = "[*:0]"  # const string
                base = "const u8"
            elif base == "void":
                base = "anyopaque"
            elif base.startswith("const"):
                prefix = "*"

            self.type_table[id] = prefix + base
        elif tag == "CvQualifiedType":
            assert a.get("const") == "1"
            type = a["type"]
            self.type_table[id] = "const " + self.get_type(type)  # type:ignore
        elif tag == "FunctionType":
            args = ",".join((self.get_type(e) for e in self.loose[id]))  # type:ignore
            ret_type = self.get_type(a["returns"])
            self.type_table[id] = f"fn({args}) callconv(.c) {ret_type}"

        if id in self.type_table:
            return self.type_table[id]
        raise ValueError(f"Could not resolve type (id: {id})")

    def gather_scoped(self, id: str) -> None:
        id = self._(id)
        elem = self.raw[id]
        a = elem.attrib

        if elem.tag not in ["Function", "Struct", "Enumeration", "Typedef", "Union"]:
            return

        name = a["name"]
        if not name.startswith("cairo_"):
            return  # shouldn't happen

        name = name.removeprefix("cairo_")

        if name in scope_overrides.keys():
            scope = scope_overrides[name]
            self.separated[scope].add(id)
            return

        for space, prefixes in namespaces.items():
            for prefix in prefixes:
                if name.startswith(prefix):
                    self.separated[space].add(id)
                    return

        # TODO: override for those *not* in Ctx
        if elem.tag == "Function":
            self.separated["Ctx"].add(id)
        else:
            self.separated["global"].add(id)

    def get_func_def(self, id: str) -> str | None:
        id = self._(id)
        if id in self.func_defs.keys():
            return self.func_defs[id]

        elem = self.raw[id]
        tag = elem.tag

        if tag != "Function":
            return

        a = elem.attrib
        name = a["name"]
        self.get_renamed(id)  # build table

        args = ", ".join(f"{a[0]}: {self.get_type(a[1])}" for a in self.loose[id])
        ret = self.get_type(a["returns"])

        line = f"extern fn {name}({args}) {ret}"
        self.func_defs[id] = line
        return line

    def build_func_defs_table(self) -> None:
        for id, elem in self.raw.items():
            tag = elem.tag

            if tag != "Function":
                continue
            self.get_func_def(self._(id))

    def get_structure_layout(self, id: str) -> str:
        id = self._(id)
        if id in self.struct_defs.keys():
            return self.struct_defs[id]
        elem = self.raw[id]
        tag = elem.tag

        if tag not in ["Struct", "Union"]:
            return ""

        layout = f"extern {tag.lower()} {{"

        fields = list(elem for elem in self.all_fields if elem.attrib["context"] == id)
        fields.sort(key=lambda f: int(f.attrib["offset"]))

        for field in fields:
            field_name = field.attrib["name"]
            field_type_id = self._(field.attrib["type"])
            if self.raw[field_type_id].tag in ["Struct", "Union"]:
                field_type = self.get_structure_layout(field_type_id)
            else:
                field_type = self.get_type(field_type_id)

            layout += f"{field_name}: {field_type}, "

        if len(fields) == 0:
            layout = "opaque {"

        self.struct_defs[id] = layout + "}"
        return layout + "}"

    def get_enum_layout(self, id: str) -> str:
        id = self._(id)
        if id in self.enum_defs.keys():
            return self.enum_defs[id]
        elem = self.raw[id]
        tag = elem.tag
        a = elem.attrib

        if tag != "Enumeration":
            return ""

        enum_name = a["name"]

        layout = f"enum({self.get_type(a['type'])}) {{"
        for name, value in self.loose[id]:
            for t in enum_name.removeprefix("_").upper().split("_"):
                if name.startswith(t):
                    name = name.removeprefix(t + "_")
                else:
                    break
            layout += f"{name} = {value},"

        self.enum_defs[id] = layout + "}"
        return layout + "}"

    # def get_comment(self, id: str) -> str:
    #     if id in self.comments.keys():
    #         return self.comments[id]

    #     elem = self.raw[id]
    #     a = elem.attrib

    #     file_id = a["file"]
    #     begin = int(a["begin_offset"])
    #     end = int(a["end_offset"])

    #     path = self.files[file_id]
    #     comment = ""
    #     with open(path, "r") as file:
    #         file.seek(begin)
    #         comment = file.read(end - begin)

    #     # c = comment
    #     c = comment.removeprefix("/**").removesuffix(" **/").replace("\n *", "\n///")

    #     self.comments[id] = c
    #     return c

    @staticmethod
    def build_tables(file="cairo.xml") -> "Parser":
        self = Parser()
        for _, elem in ET.iterparse(file, events=("end",)):
            self.consume_element(elem)

        self.build_func_defs_table()
        return self


def s(b: Parser, scope: str, id: str) -> tuple[int, int, str]:
    id = b._(id)
    elem = b.raw[id]
    tag = elem.tag
    # a = elem.attrib
    name = b.get_renamed(id)

    # print("//", tag, name, a["name"], scope)
    if tag == "Typedef":
        return (0, name != scope, name)
    elif tag in ["Struct", "Union", "Enumeration"]:
        return (1, 0, name)

    return (10, 10, name)


def main():
    b = Parser.build_tables()

    everything = ""

    for scope, lst in b.separated.items():
        # yup lots of mem usage
        lst = sorted(list(lst), key=lambda id: s(b, scope, id))
        things = []
        add = things.append

        if scope != "global":
            first = b._(lst[0])
            elem = b.raw[first]
            if elem.tag == "Typedef" and b.get_renamed(first) == scope:
                # cut off the closing bracket
                add(f"pub const {scope} = {b.typedefs[first][:-1]}")
                lst = lst[1:]
            else:
                add(f"pub const {scope} = struct {{")

        for id in lst:
            id = b._(id)
            elem = b.raw[id]
            tag = elem.tag
            name = b.get_renamed(id)

            if tag == "Function":
                add(f"    {b.get_func_def(id)};")
                ret = b.get_type(elem.attrib["returns"])

                if ret != "cairo_bool_t":
                    add(f"pub const {name} = {elem.attrib['name']};\n")
                    continue

                # convert cairo_boot_t to a zig bool
                a = ", ".join(f"{a[0]}: {b.get_type(a[1])}" for a in b.loose[id])
                ca = ", ".join(a[0] for a in b.loose[id])
                n = elem.attrib["name"]
                add(f"pub fn {name}({a}) bool {{return {n}({ca}) != 0;}}\n")
            elif tag == "Typedef":
                # comment = elem.attrib.get("comment")
                # if comment is None:
                #     # check if underlying type has a comment
                #     underlying = b.raw[b._(elem.attrib["type"])]
                #     comment = underlying.attrib.get("comment")
                # if comment is not None:
                #     c = b.get_comment(comment)
                #     add(c)  # TODO: convert to zig comment

                if name == "cairo_bool_t":  # make cairo_bool_t not public
                    add(f"const {name} = {b.typedefs[id]};\n")
                else:
                    add(f"    pub const {name} = {b.typedefs[id]};\n")
            elif tag in ["Struct", "Enumeration"]:
                # these show up as typedefs
                pass
            else:
                add(f"// did not handel {name}, {id = }")
        if scope != "global":
            add("};\n")

        everything += "\n\n".join(things)

    with open("cairo.zig", "w") as file:
        file.write(everything)


if __name__ == "__main__":
    main()

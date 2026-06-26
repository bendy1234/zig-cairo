pub const Antialias = enum(c_uint) {
    DEFAULT = 0,
    NONE = 1,
    GRAY = 2,
    SUBPIXEL = 3,
    FAST = 4,
    GOOD = 5,
    BEST = 6,
};

pub const Content = enum(c_uint) {
    COLOR = 4096,
    ALPHA = 8192,
    COLOR_ALPHA = 12288,
};

pub const DestroyFunc = *const fn (?*anyopaque) callconv(.c) void;

pub const FillRule = enum(c_uint) {
    WINDING = 0,
    EVEN_ODD = 1,
};

pub const FontExtents = extern struct {
    ascent: f64,
    descent: f64,
    height: f64,
    max_x_advance: f64,
    max_y_advance: f64,
};

pub const FontSlant = enum(c_uint) {
    NORMAL = 0,
    ITALIC = 1,
    OBLIQUE = 2,
};

pub const FontType = enum(c_uint) {
    TOY = 0,
    FT = 1,
    WIN32 = 2,
    QUARTZ = 3,
    USER = 4,
    DWRITE = 5,
};

pub const FontWeight = enum(c_uint) {
    NORMAL = 0,
    BOLD = 1,
};

pub const Format = enum(c_int) {
    INVALID = -1,
    ARGB32 = 0,
    RGB24 = 1,
    A8 = 2,
    A1 = 3,
    RGB16_565 = 4,
    RGB30 = 5,
    RGB96F = 6,
    RGBA128F = 7,
};

pub const Glyph = extern struct {
    index: c_ulong,
    x: f64,
    y: f64,
};

pub const LineCap = enum(c_uint) {
    BUTT = 0,
    ROUND = 1,
    SQUARE = 2,
};

pub const LineJoin = enum(c_uint) {
    MITER = 0,
    ROUND = 1,
    BEVEL = 2,
};

pub const Operator = enum(c_uint) {
    CLEAR = 0,
    SOURCE = 1,
    OVER = 2,
    IN = 3,
    OUT = 4,
    ATOP = 5,
    DEST = 6,
    DEST_OVER = 7,
    DEST_IN = 8,
    DEST_OUT = 9,
    DEST_ATOP = 10,
    XOR = 11,
    ADD = 12,
    SATURATE = 13,
    MULTIPLY = 14,
    SCREEN = 15,
    OVERLAY = 16,
    DARKEN = 17,
    LIGHTEN = 18,
    COLOR_DODGE = 19,
    COLOR_BURN = 20,
    HARD_LIGHT = 21,
    SOFT_LIGHT = 22,
    DIFFERENCE = 23,
    EXCLUSION = 24,
    HSL_HUE = 25,
    HSL_SATURATION = 26,
    HSL_COLOR = 27,
    HSL_LUMINOSITY = 28,
};

pub const Rectangle = extern struct {
    x: f64,
    y: f64,
    width: f64,
    height: f64,
};

pub const RectangleInt = extern struct {
    x: c_int,
    y: c_int,
    width: c_int,
    height: c_int,
};

pub const RectangleList = extern struct {
    status: Status,
    rectangles: ?*Rectangle,
    num_rectangles: c_int,
};

pub const Status = enum(c_uint) {
    SUCCESS = 0,
    NO_MEMORY = 1,
    INVALID_RESTORE = 2,
    INVALID_POP_GROUP = 3,
    NO_CURRENT_POINT = 4,
    INVALID_MATRIX = 5,
    INVALID_STATUS = 6,
    NULL_POINTER = 7,
    INVALID_STRING = 8,
    INVALID_PATH_DATA = 9,
    READ_ERROR = 10,
    WRITE_ERROR = 11,
    SURFACE_FINISHED = 12,
    SURFACE_TYPE_MISMATCH = 13,
    PATTERN_TYPE_MISMATCH = 14,
    INVALID_CONTENT = 15,
    INVALID_FORMAT = 16,
    INVALID_VISUAL = 17,
    FILE_NOT_FOUND = 18,
    INVALID_DASH = 19,
    INVALID_DSC_COMMENT = 20,
    INVALID_INDEX = 21,
    CLIP_NOT_REPRESENTABLE = 22,
    TEMP_FILE_ERROR = 23,
    INVALID_STRIDE = 24,
    FONT_TYPE_MISMATCH = 25,
    USER_FONT_IMMUTABLE = 26,
    USER_FONT_ERROR = 27,
    NEGATIVE_COUNT = 28,
    INVALID_CLUSTERS = 29,
    INVALID_SLANT = 30,
    INVALID_WEIGHT = 31,
    INVALID_SIZE = 32,
    USER_FONT_NOT_IMPLEMENTED = 33,
    DEVICE_TYPE_MISMATCH = 34,
    DEVICE_ERROR = 35,
    INVALID_MESH_CONSTRUCTION = 36,
    DEVICE_FINISHED = 37,
    JBIG2_GLOBAL_MISSING = 38,
    PNG_ERROR = 39,
    FREETYPE_ERROR = 40,
    WIN32_GDI_ERROR = 41,
    TAG_ERROR = 42,
    DWRITE_ERROR = 43,
    SVG_FONT_ERROR = 44,
    LAST_STATUS = 45,
};

pub const TextCluster = extern struct {
    num_bytes: c_int,
    num_glyphs: c_int,
};

pub const TextClusterFlags = enum(c_uint) {
    FLAG_BACKWARD = 1,
};

pub const TextExtents = extern struct {
    x_bearing: f64,
    y_bearing: f64,
    width: f64,
    height: f64,
    x_advance: f64,
    y_advance: f64,
};

pub const UserDataKey = extern struct {
    unused: c_int,
};

pub const WriteFunc = *const fn (?*anyopaque, [*]const u8, c_uint) callconv(.c) Status;

const cairo_bool_t = c_int;

extern fn cairo_status_to_string(status: Status) [*:0]const u8;
pub const statusToString = cairo_status_to_string;

extern fn cairo_version() c_int;
pub const version = cairo_version;

extern fn cairo_version_string() [*:0]const u8;
pub const versionString = cairo_version_string;

pub const Ctx = opaque {
    extern fn cairo_append_path(cr: ?*Ctx, path: *const Path) void;
    pub const appendPath = cairo_append_path;

    extern fn cairo_arc(cr: ?*Ctx, xc: f64, yc: f64, radius: f64, angle1: f64, angle2: f64) void;
    pub const arc = cairo_arc;

    extern fn cairo_arc_negative(cr: ?*Ctx, xc: f64, yc: f64, radius: f64, angle1: f64, angle2: f64) void;
    pub const arcNegative = cairo_arc_negative;

    extern fn cairo_clip(cr: ?*Ctx) void;
    pub const clip = cairo_clip;

    extern fn cairo_clip_extents(cr: ?*Ctx, x1: ?*f64, y1: ?*f64, x2: ?*f64, y2: ?*f64) void;
    pub const clipExtents = cairo_clip_extents;

    extern fn cairo_clip_preserve(cr: ?*Ctx) void;
    pub const clipPreserve = cairo_clip_preserve;

    extern fn cairo_close_path(cr: ?*Ctx) void;
    pub const closePath = cairo_close_path;

    extern fn cairo_copy_clip_rectangle_list(cr: ?*Ctx) ?*RectangleList;
    pub const copyClipRectangleList = cairo_copy_clip_rectangle_list;

    extern fn cairo_copy_page(cr: ?*Ctx) void;
    pub const copyPage = cairo_copy_page;

    extern fn cairo_copy_path(cr: ?*Ctx) ?*Path;
    pub const copyPath = cairo_copy_path;

    extern fn cairo_copy_path_flat(cr: ?*Ctx) ?*Path;
    pub const copyPathFlat = cairo_copy_path_flat;

    extern fn cairo_create(target: ?*Surface) ?*Ctx;
    pub const create = cairo_create;

    extern fn cairo_curve_to(cr: ?*Ctx, x1: f64, y1: f64, x2: f64, y2: f64, x3: f64, y3: f64) void;
    pub const curveTo = cairo_curve_to;

    extern fn cairo_debug_reset_static_data() void;
    pub const debugResetStaticData = cairo_debug_reset_static_data;

    extern fn cairo_destroy(cr: ?*Ctx) void;
    pub const destroy = cairo_destroy;

    extern fn cairo_fill(cr: ?*Ctx) void;
    pub const fill = cairo_fill;

    extern fn cairo_fill_extents(cr: ?*Ctx, x1: ?*f64, y1: ?*f64, x2: ?*f64, y2: ?*f64) void;
    pub const fillExtents = cairo_fill_extents;

    extern fn cairo_fill_preserve(cr: ?*Ctx) void;
    pub const fillPreserve = cairo_fill_preserve;

    extern fn cairo_font_extents(cr: ?*Ctx, extents: ?*FontExtents) void;
    pub const fontExtents = cairo_font_extents;

    extern fn cairo_get_antialias(cr: ?*Ctx) Antialias;
    pub const getAntialias = cairo_get_antialias;

    extern fn cairo_get_current_point(cr: ?*Ctx, x: ?*f64, y: ?*f64) void;
    pub const getCurrentPoint = cairo_get_current_point;

    extern fn cairo_get_dash(cr: ?*Ctx, dashes: ?*f64, offset: ?*f64) void;
    pub const getDash = cairo_get_dash;

    extern fn cairo_get_dash_count(cr: ?*Ctx) c_int;
    pub const getDashCount = cairo_get_dash_count;

    extern fn cairo_get_fill_rule(cr: ?*Ctx) FillRule;
    pub const getFillRule = cairo_get_fill_rule;

    extern fn cairo_get_font_face(cr: ?*Ctx) ?*FontFace;
    pub const getFontFace = cairo_get_font_face;

    extern fn cairo_get_font_matrix(cr: ?*Ctx, matrix: ?*Matrix) void;
    pub const getFontMatrix = cairo_get_font_matrix;

    extern fn cairo_get_font_options(cr: ?*Ctx, options: ?*FontOptions) void;
    pub const getFontOptions = cairo_get_font_options;

    extern fn cairo_get_group_target(cr: ?*Ctx) ?*Surface;
    pub const getGroupTarget = cairo_get_group_target;

    extern fn cairo_get_hairline(cr: ?*Ctx) cairo_bool_t;
    pub fn getHairline(cr: ?*Ctx) bool {
        return cairo_get_hairline(cr) != 0;
    }

    extern fn cairo_get_line_cap(cr: ?*Ctx) LineCap;
    pub const getLineCap = cairo_get_line_cap;

    extern fn cairo_get_line_join(cr: ?*Ctx) LineJoin;
    pub const getLineJoin = cairo_get_line_join;

    extern fn cairo_get_line_width(cr: ?*Ctx) f64;
    pub const getLineWidth = cairo_get_line_width;

    extern fn cairo_get_matrix(cr: ?*Ctx, matrix: ?*Matrix) void;
    pub const getMatrix = cairo_get_matrix;

    extern fn cairo_get_miter_limit(cr: ?*Ctx) f64;
    pub const getMiterLimit = cairo_get_miter_limit;

    extern fn cairo_get_operator(cr: ?*Ctx) Operator;
    pub const getOperator = cairo_get_operator;

    extern fn cairo_get_reference_count(cr: ?*Ctx) c_uint;
    pub const getReferenceCount = cairo_get_reference_count;

    extern fn cairo_get_scaled_font(cr: ?*Ctx) ?*ScaledFont;
    pub const getScaledFont = cairo_get_scaled_font;

    extern fn cairo_get_source(cr: ?*Ctx) ?*Pattern;
    pub const getSource = cairo_get_source;

    extern fn cairo_get_target(cr: ?*Ctx) ?*Surface;
    pub const getTarget = cairo_get_target;

    extern fn cairo_get_tolerance(cr: ?*Ctx) f64;
    pub const getTolerance = cairo_get_tolerance;

    extern fn cairo_get_user_data(cr: ?*Ctx, key: *const UserDataKey) ?*anyopaque;
    pub const getUserData = cairo_get_user_data;

    extern fn cairo_glyph_allocate(num_glyphs: c_int) ?*Glyph;
    pub const glyphAllocate = cairo_glyph_allocate;

    extern fn cairo_glyph_extents(cr: ?*Ctx, glyphs: *const Glyph, num_glyphs: c_int, extents: ?*TextExtents) void;
    pub const glyphExtents = cairo_glyph_extents;

    extern fn cairo_glyph_free(glyphs: ?*Glyph) void;
    pub const glyphFree = cairo_glyph_free;

    extern fn cairo_glyph_path(cr: ?*Ctx, glyphs: *const Glyph, num_glyphs: c_int) void;
    pub const glyphPath = cairo_glyph_path;

    extern fn cairo_has_current_point(cr: ?*Ctx) cairo_bool_t;
    pub fn hasCurrentPoint(cr: ?*Ctx) bool {
        return cairo_has_current_point(cr) != 0;
    }

    extern fn cairo_identity_matrix(cr: ?*Ctx) void;
    pub const identityMatrix = cairo_identity_matrix;

    extern fn cairo_in_clip(cr: ?*Ctx, x: f64, y: f64) cairo_bool_t;
    pub fn inClip(cr: ?*Ctx, x: f64, y: f64) bool {
        return cairo_in_clip(cr, x, y) != 0;
    }

    extern fn cairo_in_fill(cr: ?*Ctx, x: f64, y: f64) cairo_bool_t;
    pub fn inFill(cr: ?*Ctx, x: f64, y: f64) bool {
        return cairo_in_fill(cr, x, y) != 0;
    }

    extern fn cairo_in_stroke(cr: ?*Ctx, x: f64, y: f64) cairo_bool_t;
    pub fn inStroke(cr: ?*Ctx, x: f64, y: f64) bool {
        return cairo_in_stroke(cr, x, y) != 0;
    }

    extern fn cairo_line_to(cr: ?*Ctx, x: f64, y: f64) void;
    pub const lineTo = cairo_line_to;

    extern fn cairo_mask(cr: ?*Ctx, pattern: ?*Pattern) void;
    pub const mask = cairo_mask;

    extern fn cairo_mask_surface(cr: ?*Ctx, surface: ?*Surface, surface_x: f64, surface_y: f64) void;
    pub const maskSurface = cairo_mask_surface;

    extern fn cairo_move_to(cr: ?*Ctx, x: f64, y: f64) void;
    pub const moveTo = cairo_move_to;

    extern fn cairo_new_path(cr: ?*Ctx) void;
    pub const newPath = cairo_new_path;

    extern fn cairo_new_sub_path(cr: ?*Ctx) void;
    pub const newSubPath = cairo_new_sub_path;

    extern fn cairo_paint(cr: ?*Ctx) void;
    pub const paint = cairo_paint;

    extern fn cairo_paint_with_alpha(cr: ?*Ctx, alpha: f64) void;
    pub const paintWithAlpha = cairo_paint_with_alpha;

    extern fn cairo_pop_group(cr: ?*Ctx) ?*Pattern;
    pub const popGroup = cairo_pop_group;

    extern fn cairo_pop_group_to_source(cr: ?*Ctx) void;
    pub const popGroupToSource = cairo_pop_group_to_source;

    extern fn cairo_push_group(cr: ?*Ctx) void;
    pub const pushGroup = cairo_push_group;

    extern fn cairo_push_group_with_content(cr: ?*Ctx, content: Content) void;
    pub const pushGroupWithContent = cairo_push_group_with_content;

    extern fn cairo_rectangle(cr: ?*Ctx, x: f64, y: f64, width: f64, height: f64) void;
    pub const rectangle = cairo_rectangle;

    extern fn cairo_rectangle_list_destroy(rectangle_list: ?*RectangleList) void;
    pub const rectangleListDestroy = cairo_rectangle_list_destroy;

    extern fn cairo_reference(cr: ?*Ctx) ?*Ctx;
    pub const reference = cairo_reference;

    extern fn cairo_rel_curve_to(cr: ?*Ctx, dx1: f64, dy1: f64, dx2: f64, dy2: f64, dx3: f64, dy3: f64) void;
    pub const relCurveTo = cairo_rel_curve_to;

    extern fn cairo_rel_line_to(cr: ?*Ctx, dx: f64, dy: f64) void;
    pub const relLineTo = cairo_rel_line_to;

    extern fn cairo_rel_move_to(cr: ?*Ctx, dx: f64, dy: f64) void;
    pub const relMoveTo = cairo_rel_move_to;

    extern fn cairo_reset_clip(cr: ?*Ctx) void;
    pub const resetClip = cairo_reset_clip;

    extern fn cairo_restore(cr: ?*Ctx) void;
    pub const restore = cairo_restore;

    extern fn cairo_rotate(cr: ?*Ctx, angle: f64) void;
    pub const rotate = cairo_rotate;

    extern fn cairo_save(cr: ?*Ctx) void;
    pub const save = cairo_save;

    extern fn cairo_scale(cr: ?*Ctx, sx: f64, sy: f64) void;
    pub const scale = cairo_scale;

    extern fn cairo_select_font_face(cr: ?*Ctx, family: [*:0]const u8, slant: FontSlant, weight: FontWeight) void;
    pub const selectFontFace = cairo_select_font_face;

    extern fn cairo_set_antialias(cr: ?*Ctx, antialias: Antialias) void;
    pub const setAntialias = cairo_set_antialias;

    extern fn cairo_set_dash(cr: ?*Ctx, dashes: *const f64, num_dashes: c_int, offset: f64) void;
    pub const setDash = cairo_set_dash;

    extern fn cairo_set_fill_rule(cr: ?*Ctx, fill_rule: FillRule) void;
    pub const setFillRule = cairo_set_fill_rule;

    extern fn cairo_set_font_face(cr: ?*Ctx, font_face: ?*FontFace) void;
    pub const setFontFace = cairo_set_font_face;

    extern fn cairo_set_font_matrix(cr: ?*Ctx, matrix: *const Matrix) void;
    pub const setFontMatrix = cairo_set_font_matrix;

    extern fn cairo_set_font_options(cr: ?*Ctx, options: *const FontOptions) void;
    pub const setFontOptions = cairo_set_font_options;

    extern fn cairo_set_font_size(cr: ?*Ctx, size: f64) void;
    pub const setFontSize = cairo_set_font_size;

    extern fn cairo_set_hairline(cr: ?*Ctx, set_hairline: cairo_bool_t) void;
    pub const setHairline = cairo_set_hairline;

    extern fn cairo_set_line_cap(cr: ?*Ctx, line_cap: LineCap) void;
    pub const setLineCap = cairo_set_line_cap;

    extern fn cairo_set_line_join(cr: ?*Ctx, line_join: LineJoin) void;
    pub const setLineJoin = cairo_set_line_join;

    extern fn cairo_set_line_width(cr: ?*Ctx, width: f64) void;
    pub const setLineWidth = cairo_set_line_width;

    extern fn cairo_set_matrix(cr: ?*Ctx, matrix: *const Matrix) void;
    pub const setMatrix = cairo_set_matrix;

    extern fn cairo_set_miter_limit(cr: ?*Ctx, limit: f64) void;
    pub const setMiterLimit = cairo_set_miter_limit;

    extern fn cairo_set_operator(cr: ?*Ctx, op: Operator) void;
    pub const setOperator = cairo_set_operator;

    extern fn cairo_set_scaled_font(cr: ?*Ctx, scaled_font: *const ScaledFont) void;
    pub const setScaledFont = cairo_set_scaled_font;

    extern fn cairo_set_source(cr: ?*Ctx, source: ?*Pattern) void;
    pub const setSource = cairo_set_source;

    extern fn cairo_set_source_rgb(cr: ?*Ctx, red: f64, green: f64, blue: f64) void;
    pub const setSourceRgb = cairo_set_source_rgb;

    extern fn cairo_set_source_rgba(cr: ?*Ctx, red: f64, green: f64, blue: f64, alpha: f64) void;
    pub const setSourceRgba = cairo_set_source_rgba;

    extern fn cairo_set_source_surface(cr: ?*Ctx, surface: ?*Surface, x: f64, y: f64) void;
    pub const setSourceSurface = cairo_set_source_surface;

    extern fn cairo_set_tolerance(cr: ?*Ctx, tolerance: f64) void;
    pub const setTolerance = cairo_set_tolerance;

    extern fn cairo_set_user_data(cr: ?*Ctx, key: *const UserDataKey, user_data: ?*anyopaque, destroy: DestroyFunc) Status;
    pub const setUserData = cairo_set_user_data;

    extern fn cairo_show_glyphs(cr: ?*Ctx, glyphs: *const Glyph, num_glyphs: c_int) void;
    pub const showGlyphs = cairo_show_glyphs;

    extern fn cairo_show_page(cr: ?*Ctx) void;
    pub const showPage = cairo_show_page;

    extern fn cairo_show_text(cr: ?*Ctx, utf8: [*:0]const u8) void;
    pub const showText = cairo_show_text;

    extern fn cairo_show_text_glyphs(cr: ?*Ctx, utf8: [*:0]const u8, utf8_len: c_int, glyphs: *const Glyph, num_glyphs: c_int, clusters: *const TextCluster, num_clusters: c_int, cluster_flags: TextClusterFlags) void;
    pub const showTextGlyphs = cairo_show_text_glyphs;

    extern fn cairo_status(cr: ?*Ctx) Status;
    pub const status = cairo_status;

    extern fn cairo_stroke(cr: ?*Ctx) void;
    pub const stroke = cairo_stroke;

    extern fn cairo_stroke_extents(cr: ?*Ctx, x1: ?*f64, y1: ?*f64, x2: ?*f64, y2: ?*f64) void;
    pub const strokeExtents = cairo_stroke_extents;

    extern fn cairo_stroke_preserve(cr: ?*Ctx) void;
    pub const strokePreserve = cairo_stroke_preserve;

    extern fn cairo_tag_begin(cr: ?*Ctx, tag_name: [*:0]const u8, attributes: [*:0]const u8) void;
    pub const tagBegin = cairo_tag_begin;

    extern fn cairo_tag_end(cr: ?*Ctx, tag_name: [*:0]const u8) void;
    pub const tagEnd = cairo_tag_end;

    extern fn cairo_text_cluster_allocate(num_clusters: c_int) ?*TextCluster;
    pub const textClusterAllocate = cairo_text_cluster_allocate;

    extern fn cairo_text_cluster_free(clusters: ?*TextCluster) void;
    pub const textClusterFree = cairo_text_cluster_free;

    extern fn cairo_text_extents(cr: ?*Ctx, utf8: [*:0]const u8, extents: ?*TextExtents) void;
    pub const textExtents = cairo_text_extents;

    extern fn cairo_text_path(cr: ?*Ctx, utf8: [*:0]const u8) void;
    pub const textPath = cairo_text_path;

    extern fn cairo_transform(cr: ?*Ctx, matrix: *const Matrix) void;
    pub const transform = cairo_transform;

    extern fn cairo_translate(cr: ?*Ctx, tx: f64, ty: f64) void;
    pub const translate = cairo_translate;

    extern fn cairo_user_to_device(cr: ?*Ctx, x: ?*f64, y: ?*f64) void;
    pub const userToDevice = cairo_user_to_device;

    extern fn cairo_user_to_device_distance(cr: ?*Ctx, dx: ?*f64, dy: ?*f64) void;
    pub const userToDeviceDistance = cairo_user_to_device_distance;
};

pub const Pattern = opaque {
    pub const Dither = enum(c_uint) {
        NONE = 0,
        DEFAULT = 1,
        FAST = 2,
        GOOD = 3,
        BEST = 4,
    };

    pub const Extend = enum(c_uint) {
        NONE = 0,
        REPEAT = 1,
        REFLECT = 2,
        PAD = 3,
    };

    pub const Filter = enum(c_uint) {
        FAST = 0,
        GOOD = 1,
        BEST = 2,
        NEAREST = 3,
        BILINEAR = 4,
        GAUSSIAN = 5,
    };

    pub const RasterSourceAcquireFunc = *const fn (?*Pattern, ?*anyopaque, ?*Surface, *const RectangleInt) callconv(.c) ?*Surface;

    pub const RasterSourceCopyFunc = *const fn (?*Pattern, ?*anyopaque, *const Pattern) callconv(.c) Status;

    pub const RasterSourceFinishFunc = *const fn (?*Pattern, ?*anyopaque) callconv(.c) void;

    pub const RasterSourceReleaseFunc = *const fn (?*Pattern, ?*anyopaque, ?*Surface) callconv(.c) void;

    pub const RasterSourceSnapshotFunc = *const fn (?*Pattern, ?*anyopaque) callconv(.c) Status;

    pub const Type = enum(c_uint) {
        SOLID = 0,
        SURFACE = 1,
        LINEAR = 2,
        RADIAL = 3,
        MESH = 4,
        RASTER_SOURCE = 5,
    };

    extern fn cairo_pattern_add_color_stop_rgb(pattern: ?*Pattern, offset: f64, red: f64, green: f64, blue: f64) void;
    pub const addColorStopRgb = cairo_pattern_add_color_stop_rgb;

    extern fn cairo_pattern_add_color_stop_rgba(pattern: ?*Pattern, offset: f64, red: f64, green: f64, blue: f64, alpha: f64) void;
    pub const addColorStopRgba = cairo_pattern_add_color_stop_rgba;

    extern fn cairo_pattern_create_for_surface(surface: ?*Surface) ?*Pattern;
    pub const createForSurface = cairo_pattern_create_for_surface;

    extern fn cairo_pattern_create_linear(x0: f64, y0: f64, x1: f64, y1: f64) ?*Pattern;
    pub const createLinear = cairo_pattern_create_linear;

    extern fn cairo_pattern_create_mesh() ?*Pattern;
    pub const createMesh = cairo_pattern_create_mesh;

    extern fn cairo_pattern_create_radial(cx0: f64, cy0: f64, radius0: f64, cx1: f64, cy1: f64, radius1: f64) ?*Pattern;
    pub const createRadial = cairo_pattern_create_radial;

    extern fn cairo_pattern_create_raster_source(user_data: ?*anyopaque, content: Content, width: c_int, height: c_int) ?*Pattern;
    pub const createRasterSource = cairo_pattern_create_raster_source;

    extern fn cairo_pattern_create_rgb(red: f64, green: f64, blue: f64) ?*Pattern;
    pub const createRgb = cairo_pattern_create_rgb;

    extern fn cairo_pattern_create_rgba(red: f64, green: f64, blue: f64, alpha: f64) ?*Pattern;
    pub const createRgba = cairo_pattern_create_rgba;

    extern fn cairo_pattern_destroy(pattern: ?*Pattern) void;
    pub const destroy = cairo_pattern_destroy;

    extern fn cairo_pattern_get_color_stop_count(pattern: ?*Pattern, count: ?*c_int) Status;
    pub const getColorStopCount = cairo_pattern_get_color_stop_count;

    extern fn cairo_pattern_get_color_stop_rgba(pattern: ?*Pattern, index: c_int, offset: ?*f64, red: ?*f64, green: ?*f64, blue: ?*f64, alpha: ?*f64) Status;
    pub const getColorStopRgba = cairo_pattern_get_color_stop_rgba;

    extern fn cairo_pattern_get_dither(pattern: ?*Pattern) Dither;
    pub const getDither = cairo_pattern_get_dither;

    extern fn cairo_pattern_get_extend(pattern: ?*Pattern) Extend;
    pub const getExtend = cairo_pattern_get_extend;

    extern fn cairo_pattern_get_filter(pattern: ?*Pattern) Filter;
    pub const getFilter = cairo_pattern_get_filter;

    extern fn cairo_pattern_get_linear_points(pattern: ?*Pattern, x0: ?*f64, y0: ?*f64, x1: ?*f64, y1: ?*f64) Status;
    pub const getLinearPoints = cairo_pattern_get_linear_points;

    extern fn cairo_pattern_get_matrix(pattern: ?*Pattern, matrix: ?*Matrix) void;
    pub const getMatrix = cairo_pattern_get_matrix;

    extern fn cairo_pattern_get_radial_circles(pattern: ?*Pattern, x0: ?*f64, y0: ?*f64, r0: ?*f64, x1: ?*f64, y1: ?*f64, r1: ?*f64) Status;
    pub const getRadialCircles = cairo_pattern_get_radial_circles;

    extern fn cairo_pattern_get_reference_count(pattern: ?*Pattern) c_uint;
    pub const getReferenceCount = cairo_pattern_get_reference_count;

    extern fn cairo_pattern_get_rgba(pattern: ?*Pattern, red: ?*f64, green: ?*f64, blue: ?*f64, alpha: ?*f64) Status;
    pub const getRgba = cairo_pattern_get_rgba;

    extern fn cairo_pattern_get_surface(pattern: ?*Pattern, surface: ?*?*Surface) Status;
    pub const getSurface = cairo_pattern_get_surface;

    extern fn cairo_pattern_get_type(pattern: ?*Pattern) Type;
    pub const getType = cairo_pattern_get_type;

    extern fn cairo_pattern_get_user_data(pattern: ?*Pattern, key: *const UserDataKey) ?*anyopaque;
    pub const getUserData = cairo_pattern_get_user_data;

    extern fn cairo_mesh_pattern_begin_patch(pattern: ?*Pattern) void;
    pub const meshBeginPatch = cairo_mesh_pattern_begin_patch;

    extern fn cairo_mesh_pattern_curve_to(pattern: ?*Pattern, x1: f64, y1: f64, x2: f64, y2: f64, x3: f64, y3: f64) void;
    pub const meshCurveTo = cairo_mesh_pattern_curve_to;

    extern fn cairo_mesh_pattern_end_patch(pattern: ?*Pattern) void;
    pub const meshEndPatch = cairo_mesh_pattern_end_patch;

    extern fn cairo_mesh_pattern_get_control_point(pattern: ?*Pattern, patch_num: c_uint, point_num: c_uint, x: ?*f64, y: ?*f64) Status;
    pub const meshGetControlPoint = cairo_mesh_pattern_get_control_point;

    extern fn cairo_mesh_pattern_get_corner_color_rgba(pattern: ?*Pattern, patch_num: c_uint, corner_num: c_uint, red: ?*f64, green: ?*f64, blue: ?*f64, alpha: ?*f64) Status;
    pub const meshGetCornerColorRgba = cairo_mesh_pattern_get_corner_color_rgba;

    extern fn cairo_mesh_pattern_get_patch_count(pattern: ?*Pattern, count: ?*c_uint) Status;
    pub const meshGetPatchCount = cairo_mesh_pattern_get_patch_count;

    extern fn cairo_mesh_pattern_get_path(pattern: ?*Pattern, patch_num: c_uint) ?*Path;
    pub const meshGetPath = cairo_mesh_pattern_get_path;

    extern fn cairo_mesh_pattern_line_to(pattern: ?*Pattern, x: f64, y: f64) void;
    pub const meshLineTo = cairo_mesh_pattern_line_to;

    extern fn cairo_mesh_pattern_move_to(pattern: ?*Pattern, x: f64, y: f64) void;
    pub const meshMoveTo = cairo_mesh_pattern_move_to;

    extern fn cairo_mesh_pattern_set_control_point(pattern: ?*Pattern, point_num: c_uint, x: f64, y: f64) void;
    pub const meshSetControlPoint = cairo_mesh_pattern_set_control_point;

    extern fn cairo_mesh_pattern_set_corner_color_rgb(pattern: ?*Pattern, corner_num: c_uint, red: f64, green: f64, blue: f64) void;
    pub const meshSetCornerColorRgb = cairo_mesh_pattern_set_corner_color_rgb;

    extern fn cairo_mesh_pattern_set_corner_color_rgba(pattern: ?*Pattern, corner_num: c_uint, red: f64, green: f64, blue: f64, alpha: f64) void;
    pub const meshSetCornerColorRgba = cairo_mesh_pattern_set_corner_color_rgba;

    extern fn cairo_raster_source_pattern_get_acquire(pattern: ?*Pattern, acquire: ?*RasterSourceAcquireFunc, release: ?*RasterSourceReleaseFunc) void;
    pub const rasterSourceGetAcquire = cairo_raster_source_pattern_get_acquire;

    extern fn cairo_raster_source_pattern_get_callback_data(pattern: ?*Pattern) ?*anyopaque;
    pub const rasterSourceGetCallbackData = cairo_raster_source_pattern_get_callback_data;

    extern fn cairo_raster_source_pattern_get_copy(pattern: ?*Pattern) RasterSourceCopyFunc;
    pub const rasterSourceGetCopy = cairo_raster_source_pattern_get_copy;

    extern fn cairo_raster_source_pattern_get_finish(pattern: ?*Pattern) RasterSourceFinishFunc;
    pub const rasterSourceGetFinish = cairo_raster_source_pattern_get_finish;

    extern fn cairo_raster_source_pattern_get_snapshot(pattern: ?*Pattern) RasterSourceSnapshotFunc;
    pub const rasterSourceGetSnapshot = cairo_raster_source_pattern_get_snapshot;

    extern fn cairo_raster_source_pattern_set_acquire(pattern: ?*Pattern, acquire: RasterSourceAcquireFunc, release: RasterSourceReleaseFunc) void;
    pub const rasterSourceSetAcquire = cairo_raster_source_pattern_set_acquire;

    extern fn cairo_raster_source_pattern_set_callback_data(pattern: ?*Pattern, data: ?*anyopaque) void;
    pub const rasterSourceSetCallbackData = cairo_raster_source_pattern_set_callback_data;

    extern fn cairo_raster_source_pattern_set_copy(pattern: ?*Pattern, copy: RasterSourceCopyFunc) void;
    pub const rasterSourceSetCopy = cairo_raster_source_pattern_set_copy;

    extern fn cairo_raster_source_pattern_set_finish(pattern: ?*Pattern, finish: RasterSourceFinishFunc) void;
    pub const rasterSourceSetFinish = cairo_raster_source_pattern_set_finish;

    extern fn cairo_raster_source_pattern_set_snapshot(pattern: ?*Pattern, snapshot: RasterSourceSnapshotFunc) void;
    pub const rasterSourceSetSnapshot = cairo_raster_source_pattern_set_snapshot;

    extern fn cairo_pattern_reference(pattern: ?*Pattern) ?*Pattern;
    pub const reference = cairo_pattern_reference;

    extern fn cairo_pattern_set_dither(pattern: ?*Pattern, dither: Dither) void;
    pub const setDither = cairo_pattern_set_dither;

    extern fn cairo_pattern_set_extend(pattern: ?*Pattern, extend: Extend) void;
    pub const setExtend = cairo_pattern_set_extend;

    extern fn cairo_pattern_set_filter(pattern: ?*Pattern, filter: Filter) void;
    pub const setFilter = cairo_pattern_set_filter;

    extern fn cairo_pattern_set_matrix(pattern: ?*Pattern, matrix: *const Matrix) void;
    pub const setMatrix = cairo_pattern_set_matrix;

    extern fn cairo_pattern_set_user_data(pattern: ?*Pattern, key: *const UserDataKey, user_data: ?*anyopaque, destroy: DestroyFunc) Status;
    pub const setUserData = cairo_pattern_set_user_data;

    extern fn cairo_pattern_status(pattern: ?*Pattern) Status;
    pub const status = cairo_pattern_status;
};

pub const Surface = opaque {
    pub const ObserverCallback = *const fn (?*Surface, ?*Surface, ?*anyopaque) callconv(.c) void;

    pub const ObserverMode = enum(c_uint) {
        NORMAL = 0,
        RECORD_OPERATIONS = 1,
    };

    pub const ReadFunc = *const fn (?*anyopaque, [*]u8, c_uint) callconv(.c) Status;

    pub const Type = enum(c_uint) {
        IMAGE = 0,
        PDF = 1,
        PS = 2,
        XLIB = 3,
        XCB = 4,
        GLITZ = 5,
        QUARTZ = 6,
        WIN32 = 7,
        BEOS = 8,
        DIRECTFB = 9,
        SVG = 10,
        OS2 = 11,
        WIN32_PRINTING = 12,
        QUARTZ_IMAGE = 13,
        SCRIPT = 14,
        QT = 15,
        RECORDING = 16,
        VG = 17,
        GL = 18,
        DRM = 19,
        TEE = 20,
        XML = 21,
        SKIA = 22,
        SUBSURFACE = 23,
        COGL = 24,
    };

    extern fn cairo_surface_copy_page(surface: ?*Surface) void;
    pub const copyPage = cairo_surface_copy_page;

    extern fn cairo_surface_create_for_rectangle(target: ?*Surface, x: f64, y: f64, width: f64, height: f64) ?*Surface;
    pub const createForRectangle = cairo_surface_create_for_rectangle;

    extern fn cairo_surface_create_observer(target: ?*Surface, mode: ObserverMode) ?*Surface;
    pub const createObserver = cairo_surface_create_observer;

    extern fn cairo_surface_create_similar(other: ?*Surface, content: Content, width: c_int, height: c_int) ?*Surface;
    pub const createSimilar = cairo_surface_create_similar;

    extern fn cairo_surface_create_similar_image(other: ?*Surface, format: Format, width: c_int, height: c_int) ?*Surface;
    pub const createSimilarImage = cairo_surface_create_similar_image;

    extern fn cairo_surface_destroy(surface: ?*Surface) void;
    pub const destroy = cairo_surface_destroy;

    extern fn cairo_surface_finish(surface: ?*Surface) void;
    pub const finish = cairo_surface_finish;

    extern fn cairo_surface_flush(surface: ?*Surface) void;
    pub const flush = cairo_surface_flush;

    extern fn cairo_format_stride_for_width(format: Format, width: c_int) c_int;
    pub const formatStrideForWidth = cairo_format_stride_for_width;

    extern fn cairo_surface_get_content(surface: ?*Surface) Content;
    pub const getContent = cairo_surface_get_content;

    extern fn cairo_surface_get_device(surface: ?*Surface) ?*Device;
    pub const getDevice = cairo_surface_get_device;

    extern fn cairo_surface_get_device_offset(surface: ?*Surface, x_offset: ?*f64, y_offset: ?*f64) void;
    pub const getDeviceOffset = cairo_surface_get_device_offset;

    extern fn cairo_surface_get_device_scale(surface: ?*Surface, x_scale: ?*f64, y_scale: ?*f64) void;
    pub const getDeviceScale = cairo_surface_get_device_scale;

    extern fn cairo_surface_get_fallback_resolution(surface: ?*Surface, x_pixels_per_inch: ?*f64, y_pixels_per_inch: ?*f64) void;
    pub const getFallbackResolution = cairo_surface_get_fallback_resolution;

    extern fn cairo_surface_get_font_options(surface: ?*Surface, options: ?*FontOptions) void;
    pub const getFontOptions = cairo_surface_get_font_options;

    extern fn cairo_surface_get_mime_data(surface: ?*Surface, mime_type: [*:0]const u8, data: [*][*]const u8, length: ?*c_ulong) void;
    pub const getMimeData = cairo_surface_get_mime_data;

    extern fn cairo_surface_get_reference_count(surface: ?*Surface) c_uint;
    pub const getReferenceCount = cairo_surface_get_reference_count;

    extern fn cairo_surface_get_type(surface: ?*Surface) Type;
    pub const getType = cairo_surface_get_type;

    extern fn cairo_surface_get_user_data(surface: ?*Surface, key: *const UserDataKey) ?*anyopaque;
    pub const getUserData = cairo_surface_get_user_data;

    extern fn cairo_surface_has_show_text_glyphs(surface: ?*Surface) cairo_bool_t;
    pub fn hasShowTextGlyphs(surface: ?*Surface) bool {
        return cairo_surface_has_show_text_glyphs(surface) != 0;
    }

    extern fn cairo_image_surface_create(format: Format, width: c_int, height: c_int) ?*Surface;
    pub const imageCreate = cairo_image_surface_create;

    extern fn cairo_image_surface_create_for_data(data: [*]u8, format: Format, width: c_int, height: c_int, stride: c_int) ?*Surface;
    pub const imageCreateForData = cairo_image_surface_create_for_data;

    extern fn cairo_image_surface_create_from_png(filename: [*:0]const u8) ?*Surface;
    pub const imageCreateFromPng = cairo_image_surface_create_from_png;

    extern fn cairo_image_surface_create_from_png_stream(read_func: ReadFunc, closure: ?*anyopaque) ?*Surface;
    pub const imageCreateFromPngStream = cairo_image_surface_create_from_png_stream;

    extern fn cairo_image_surface_get_data(surface: ?*Surface) [*]u8;
    pub const imageGetData = cairo_image_surface_get_data;

    extern fn cairo_image_surface_get_format(surface: ?*Surface) Format;
    pub const imageGetFormat = cairo_image_surface_get_format;

    extern fn cairo_image_surface_get_height(surface: ?*Surface) c_int;
    pub const imageGetHeight = cairo_image_surface_get_height;

    extern fn cairo_image_surface_get_stride(surface: ?*Surface) c_int;
    pub const imageGetStride = cairo_image_surface_get_stride;

    extern fn cairo_image_surface_get_width(surface: ?*Surface) c_int;
    pub const imageGetWidth = cairo_image_surface_get_width;

    extern fn cairo_surface_map_to_image(surface: ?*Surface, extents: *const RectangleInt) ?*Surface;
    pub const mapToImage = cairo_surface_map_to_image;

    extern fn cairo_surface_mark_dirty(surface: ?*Surface) void;
    pub const markDirty = cairo_surface_mark_dirty;

    extern fn cairo_surface_mark_dirty_rectangle(surface: ?*Surface, x: c_int, y: c_int, width: c_int, height: c_int) void;
    pub const markDirtyRectangle = cairo_surface_mark_dirty_rectangle;

    extern fn cairo_surface_observer_add_fill_callback(abstract_surface: ?*Surface, func: ObserverCallback, data: ?*anyopaque) Status;
    pub const observerAddFillCallback = cairo_surface_observer_add_fill_callback;

    extern fn cairo_surface_observer_add_finish_callback(abstract_surface: ?*Surface, func: ObserverCallback, data: ?*anyopaque) Status;
    pub const observerAddFinishCallback = cairo_surface_observer_add_finish_callback;

    extern fn cairo_surface_observer_add_flush_callback(abstract_surface: ?*Surface, func: ObserverCallback, data: ?*anyopaque) Status;
    pub const observerAddFlushCallback = cairo_surface_observer_add_flush_callback;

    extern fn cairo_surface_observer_add_glyphs_callback(abstract_surface: ?*Surface, func: ObserverCallback, data: ?*anyopaque) Status;
    pub const observerAddGlyphsCallback = cairo_surface_observer_add_glyphs_callback;

    extern fn cairo_surface_observer_add_mask_callback(abstract_surface: ?*Surface, func: ObserverCallback, data: ?*anyopaque) Status;
    pub const observerAddMaskCallback = cairo_surface_observer_add_mask_callback;

    extern fn cairo_surface_observer_add_paint_callback(abstract_surface: ?*Surface, func: ObserverCallback, data: ?*anyopaque) Status;
    pub const observerAddPaintCallback = cairo_surface_observer_add_paint_callback;

    extern fn cairo_surface_observer_add_stroke_callback(abstract_surface: ?*Surface, func: ObserverCallback, data: ?*anyopaque) Status;
    pub const observerAddStrokeCallback = cairo_surface_observer_add_stroke_callback;

    extern fn cairo_surface_observer_elapsed(abstract_surface: ?*Surface) f64;
    pub const observerElapsed = cairo_surface_observer_elapsed;

    extern fn cairo_surface_observer_print(abstract_surface: ?*Surface, write_func: WriteFunc, closure: ?*anyopaque) Status;
    pub const observerPrint = cairo_surface_observer_print;

    extern fn cairo_recording_surface_create(content: Content, extents: *const Rectangle) ?*Surface;
    pub const recordingCreate = cairo_recording_surface_create;

    extern fn cairo_recording_surface_get_extents(surface: ?*Surface, extents: ?*Rectangle) cairo_bool_t;
    pub fn recordingGetExtents(surface: ?*Surface, extents: ?*Rectangle) bool {
        return cairo_recording_surface_get_extents(surface, extents) != 0;
    }

    extern fn cairo_recording_surface_ink_extents(surface: ?*Surface, x0: ?*f64, y0: ?*f64, width: ?*f64, height: ?*f64) void;
    pub const recordingInkExtents = cairo_recording_surface_ink_extents;

    extern fn cairo_surface_reference(surface: ?*Surface) ?*Surface;
    pub const reference = cairo_surface_reference;

    extern fn cairo_surface_set_device_offset(surface: ?*Surface, x_offset: f64, y_offset: f64) void;
    pub const setDeviceOffset = cairo_surface_set_device_offset;

    extern fn cairo_surface_set_device_scale(surface: ?*Surface, x_scale: f64, y_scale: f64) void;
    pub const setDeviceScale = cairo_surface_set_device_scale;

    extern fn cairo_surface_set_fallback_resolution(surface: ?*Surface, x_pixels_per_inch: f64, y_pixels_per_inch: f64) void;
    pub const setFallbackResolution = cairo_surface_set_fallback_resolution;

    extern fn cairo_surface_set_mime_data(surface: ?*Surface, mime_type: [*:0]const u8, data: [*]const u8, length: c_ulong, destroy: DestroyFunc, closure: ?*anyopaque) Status;
    pub const setMimeData = cairo_surface_set_mime_data;

    extern fn cairo_surface_set_user_data(surface: ?*Surface, key: *const UserDataKey, user_data: ?*anyopaque, destroy: DestroyFunc) Status;
    pub const setUserData = cairo_surface_set_user_data;

    extern fn cairo_surface_show_page(surface: ?*Surface) void;
    pub const showPage = cairo_surface_show_page;

    extern fn cairo_surface_status(surface: ?*Surface) Status;
    pub const status = cairo_surface_status;

    extern fn cairo_surface_supports_mime_type(surface: ?*Surface, mime_type: [*:0]const u8) cairo_bool_t;
    pub fn supportsMimeType(surface: ?*Surface, mime_type: [*:0]const u8) bool {
        return cairo_surface_supports_mime_type(surface, mime_type) != 0;
    }

    extern fn cairo_surface_unmap_image(surface: ?*Surface, image: ?*Surface) void;
    pub const unmapImage = cairo_surface_unmap_image;

    extern fn cairo_surface_write_to_png(surface: ?*Surface, filename: [*:0]const u8) Status;
    pub const writeToPng = cairo_surface_write_to_png;

    extern fn cairo_surface_write_to_png_stream(surface: ?*Surface, write_func: WriteFunc, closure: ?*anyopaque) Status;
    pub const writeToPngStream = cairo_surface_write_to_png_stream;
};

pub const FontFace = opaque {
    extern fn cairo_font_face_destroy(font_face: ?*FontFace) void;
    pub const destroy = cairo_font_face_destroy;

    extern fn cairo_font_face_get_reference_count(font_face: ?*FontFace) c_uint;
    pub const getReferenceCount = cairo_font_face_get_reference_count;

    extern fn cairo_font_face_get_type(font_face: ?*FontFace) FontType;
    pub const getType = cairo_font_face_get_type;

    extern fn cairo_font_face_get_user_data(font_face: ?*FontFace, key: *const UserDataKey) ?*anyopaque;
    pub const getUserData = cairo_font_face_get_user_data;

    extern fn cairo_font_face_reference(font_face: ?*FontFace) ?*FontFace;
    pub const reference = cairo_font_face_reference;

    extern fn cairo_font_face_set_user_data(font_face: ?*FontFace, key: *const UserDataKey, user_data: ?*anyopaque, destroy: DestroyFunc) Status;
    pub const setUserData = cairo_font_face_set_user_data;

    extern fn cairo_font_face_status(font_face: ?*FontFace) Status;
    pub const status = cairo_font_face_status;
};

pub const ToyFontFace = struct {
    extern fn cairo_toy_font_face_create(family: [*:0]const u8, slant: FontSlant, weight: FontWeight) ?*FontFace;
    pub const create = cairo_toy_font_face_create;

    extern fn cairo_toy_font_face_get_family(font_face: ?*FontFace) [*:0]const u8;
    pub const getFamily = cairo_toy_font_face_get_family;

    extern fn cairo_toy_font_face_get_slant(font_face: ?*FontFace) FontSlant;
    pub const getSlant = cairo_toy_font_face_get_slant;

    extern fn cairo_toy_font_face_get_weight(font_face: ?*FontFace) FontWeight;
    pub const getWeight = cairo_toy_font_face_get_weight;
};

pub const UserFontFace = struct {
    pub const ScaledInitFunc = *const fn (?*ScaledFont, ?*Ctx, ?*FontExtents) callconv(.c) Status;

    pub const ScaledRenderGlyphFunc = *const fn (?*ScaledFont, c_ulong, ?*Ctx, ?*TextExtents) callconv(.c) Status;

    pub const ScaledTextToGlyphsFunc = *const fn (?*ScaledFont, [*:0]const u8, c_int, ?*?*Glyph, ?*c_int, ?*?*TextCluster, ?*c_int, ?*TextClusterFlags) callconv(.c) Status;

    pub const ScaledUnicodeToGlyphFunc = *const fn (?*ScaledFont, c_ulong, ?*c_ulong) callconv(.c) Status;

    extern fn cairo_user_font_face_create() ?*FontFace;
    pub const create = cairo_user_font_face_create;

    extern fn cairo_user_font_face_get_init_func(font_face: ?*FontFace) ScaledInitFunc;
    pub const getInitFunc = cairo_user_font_face_get_init_func;

    extern fn cairo_user_font_face_get_render_color_glyph_func(font_face: ?*FontFace) ScaledRenderGlyphFunc;
    pub const getRenderColorGlyphFunc = cairo_user_font_face_get_render_color_glyph_func;

    extern fn cairo_user_font_face_get_render_glyph_func(font_face: ?*FontFace) ScaledRenderGlyphFunc;
    pub const getRenderGlyphFunc = cairo_user_font_face_get_render_glyph_func;

    extern fn cairo_user_font_face_get_text_to_glyphs_func(font_face: ?*FontFace) ScaledTextToGlyphsFunc;
    pub const getTextToGlyphsFunc = cairo_user_font_face_get_text_to_glyphs_func;

    extern fn cairo_user_font_face_get_unicode_to_glyph_func(font_face: ?*FontFace) ScaledUnicodeToGlyphFunc;
    pub const getUnicodeToGlyphFunc = cairo_user_font_face_get_unicode_to_glyph_func;

    extern fn cairo_user_scaled_font_get_foreground_marker(scaled_font: ?*ScaledFont) ?*Pattern;
    pub const scaledGetForegroundMarker = cairo_user_scaled_font_get_foreground_marker;

    extern fn cairo_user_scaled_font_get_foreground_source(scaled_font: ?*ScaledFont) ?*Pattern;
    pub const scaledGetForegroundSource = cairo_user_scaled_font_get_foreground_source;

    extern fn cairo_user_font_face_set_init_func(font_face: ?*FontFace, init_func: ScaledInitFunc) void;
    pub const setInitFunc = cairo_user_font_face_set_init_func;

    extern fn cairo_user_font_face_set_render_color_glyph_func(font_face: ?*FontFace, render_glyph_func: ScaledRenderGlyphFunc) void;
    pub const setRenderColorGlyphFunc = cairo_user_font_face_set_render_color_glyph_func;

    extern fn cairo_user_font_face_set_render_glyph_func(font_face: ?*FontFace, render_glyph_func: ScaledRenderGlyphFunc) void;
    pub const setRenderGlyphFunc = cairo_user_font_face_set_render_glyph_func;

    extern fn cairo_user_font_face_set_text_to_glyphs_func(font_face: ?*FontFace, text_to_glyphs_func: ScaledTextToGlyphsFunc) void;
    pub const setTextToGlyphsFunc = cairo_user_font_face_set_text_to_glyphs_func;

    extern fn cairo_user_font_face_set_unicode_to_glyph_func(font_face: ?*FontFace, unicode_to_glyph_func: ScaledUnicodeToGlyphFunc) void;
    pub const setUnicodeToGlyphFunc = cairo_user_font_face_set_unicode_to_glyph_func;
};

pub const ScaledFont = opaque {
    extern fn cairo_scaled_font_create(font_face: ?*FontFace, font_matrix: *const Matrix, ctm: *const Matrix, options: *const FontOptions) ?*ScaledFont;
    pub const create = cairo_scaled_font_create;

    extern fn cairo_scaled_font_destroy(scaled_font: ?*ScaledFont) void;
    pub const destroy = cairo_scaled_font_destroy;

    extern fn cairo_scaled_font_extents(scaled_font: ?*ScaledFont, extents: ?*FontExtents) void;
    pub const extents = cairo_scaled_font_extents;

    extern fn cairo_scaled_font_get_ctm(scaled_font: ?*ScaledFont, ctm: ?*Matrix) void;
    pub const getCtm = cairo_scaled_font_get_ctm;

    extern fn cairo_scaled_font_get_font_face(scaled_font: ?*ScaledFont) ?*FontFace;
    pub const getFontFace = cairo_scaled_font_get_font_face;

    extern fn cairo_scaled_font_get_font_matrix(scaled_font: ?*ScaledFont, font_matrix: ?*Matrix) void;
    pub const getFontMatrix = cairo_scaled_font_get_font_matrix;

    extern fn cairo_scaled_font_get_font_options(scaled_font: ?*ScaledFont, options: ?*FontOptions) void;
    pub const getFontOptions = cairo_scaled_font_get_font_options;

    extern fn cairo_scaled_font_get_reference_count(scaled_font: ?*ScaledFont) c_uint;
    pub const getReferenceCount = cairo_scaled_font_get_reference_count;

    extern fn cairo_scaled_font_get_scale_matrix(scaled_font: ?*ScaledFont, scale_matrix: ?*Matrix) void;
    pub const getScaleMatrix = cairo_scaled_font_get_scale_matrix;

    extern fn cairo_scaled_font_get_type(scaled_font: ?*ScaledFont) FontType;
    pub const getType = cairo_scaled_font_get_type;

    extern fn cairo_scaled_font_get_user_data(scaled_font: ?*ScaledFont, key: *const UserDataKey) ?*anyopaque;
    pub const getUserData = cairo_scaled_font_get_user_data;

    extern fn cairo_scaled_font_glyph_extents(scaled_font: ?*ScaledFont, glyphs: *const Glyph, num_glyphs: c_int, extents: ?*TextExtents) void;
    pub const glyphExtents = cairo_scaled_font_glyph_extents;

    extern fn cairo_scaled_font_reference(scaled_font: ?*ScaledFont) ?*ScaledFont;
    pub const reference = cairo_scaled_font_reference;

    extern fn cairo_scaled_font_set_user_data(scaled_font: ?*ScaledFont, key: *const UserDataKey, user_data: ?*anyopaque, destroy: DestroyFunc) Status;
    pub const setUserData = cairo_scaled_font_set_user_data;

    extern fn cairo_scaled_font_status(scaled_font: ?*ScaledFont) Status;
    pub const status = cairo_scaled_font_status;

    extern fn cairo_scaled_font_text_extents(scaled_font: ?*ScaledFont, utf8: [*:0]const u8, extents: ?*TextExtents) void;
    pub const textExtents = cairo_scaled_font_text_extents;

    extern fn cairo_scaled_font_text_to_glyphs(scaled_font: ?*ScaledFont, x: f64, y: f64, utf8: [*:0]const u8, utf8_len: c_int, glyphs: ?*?*Glyph, num_glyphs: ?*c_int, clusters: ?*?*TextCluster, num_clusters: ?*c_int, cluster_flags: ?*TextClusterFlags) Status;
    pub const textToGlyphs = cairo_scaled_font_text_to_glyphs;
};

pub const FontOptions = opaque {
    pub const ColorMode = enum(c_uint) {
        DEFAULT = 0,
        NO_COLOR = 1,
        COLOR = 2,
    };

    pub const HintMetrics = enum(c_uint) {
        DEFAULT = 0,
        OFF = 1,
        ON = 2,
    };

    pub const HintStyle = enum(c_uint) {
        DEFAULT = 0,
        NONE = 1,
        SLIGHT = 2,
        MEDIUM = 3,
        FULL = 4,
    };

    pub const SubpixelOrder = enum(c_uint) {
        DEFAULT = 0,
        RGB = 1,
        BGR = 2,
        VRGB = 3,
        VBGR = 4,
    };

    extern fn cairo_font_options_copy(original: *const FontOptions) ?*FontOptions;
    pub const copy = cairo_font_options_copy;

    extern fn cairo_font_options_create() ?*FontOptions;
    pub const create = cairo_font_options_create;

    extern fn cairo_font_options_destroy(options: ?*FontOptions) void;
    pub const destroy = cairo_font_options_destroy;

    extern fn cairo_font_options_equal(options: *const FontOptions, other: *const FontOptions) cairo_bool_t;
    pub fn equal(options: *const FontOptions, other: *const FontOptions) bool {
        return cairo_font_options_equal(options, other) != 0;
    }

    extern fn cairo_font_options_get_antialias(options: *const FontOptions) Antialias;
    pub const getAntialias = cairo_font_options_get_antialias;

    extern fn cairo_font_options_get_color_mode(options: *const FontOptions) ColorMode;
    pub const getColorMode = cairo_font_options_get_color_mode;

    extern fn cairo_font_options_get_color_palette(options: *const FontOptions) c_uint;
    pub const getColorPalette = cairo_font_options_get_color_palette;

    extern fn cairo_font_options_get_custom_palette_color(options: ?*FontOptions, index: c_uint, red: ?*f64, green: ?*f64, blue: ?*f64, alpha: ?*f64) Status;
    pub const getCustomPaletteColor = cairo_font_options_get_custom_palette_color;

    extern fn cairo_font_options_get_hint_metrics(options: *const FontOptions) HintMetrics;
    pub const getHintMetrics = cairo_font_options_get_hint_metrics;

    extern fn cairo_font_options_get_hint_style(options: *const FontOptions) HintStyle;
    pub const getHintStyle = cairo_font_options_get_hint_style;

    extern fn cairo_font_options_get_subpixel_order(options: *const FontOptions) SubpixelOrder;
    pub const getSubpixelOrder = cairo_font_options_get_subpixel_order;

    extern fn cairo_font_options_get_variations(options: ?*FontOptions) [*:0]const u8;
    pub const getVariations = cairo_font_options_get_variations;

    extern fn cairo_font_options_hash(options: *const FontOptions) c_ulong;
    pub const hash = cairo_font_options_hash;

    extern fn cairo_font_options_merge(options: ?*FontOptions, other: *const FontOptions) void;
    pub const merge = cairo_font_options_merge;

    extern fn cairo_font_options_set_antialias(options: ?*FontOptions, antialias: Antialias) void;
    pub const setAntialias = cairo_font_options_set_antialias;

    extern fn cairo_font_options_set_color_mode(options: ?*FontOptions, color_mode: ColorMode) void;
    pub const setColorMode = cairo_font_options_set_color_mode;

    extern fn cairo_font_options_set_color_palette(options: ?*FontOptions, palette_index: c_uint) void;
    pub const setColorPalette = cairo_font_options_set_color_palette;

    extern fn cairo_font_options_set_custom_palette_color(options: ?*FontOptions, index: c_uint, red: f64, green: f64, blue: f64, alpha: f64) void;
    pub const setCustomPaletteColor = cairo_font_options_set_custom_palette_color;

    extern fn cairo_font_options_set_hint_metrics(options: ?*FontOptions, hint_metrics: HintMetrics) void;
    pub const setHintMetrics = cairo_font_options_set_hint_metrics;

    extern fn cairo_font_options_set_hint_style(options: ?*FontOptions, hint_style: HintStyle) void;
    pub const setHintStyle = cairo_font_options_set_hint_style;

    extern fn cairo_font_options_set_subpixel_order(options: ?*FontOptions, subpixel_order: SubpixelOrder) void;
    pub const setSubpixelOrder = cairo_font_options_set_subpixel_order;

    extern fn cairo_font_options_set_variations(options: ?*FontOptions, variations: [*:0]const u8) void;
    pub const setVariations = cairo_font_options_set_variations;

    extern fn cairo_font_options_status(options: ?*FontOptions) Status;
    pub const status = cairo_font_options_status;
};

pub const Path = extern struct {
    status: Status,
    data: ?*Data,
    num_data: c_int,
    pub const Data = extern union {
        header: extern struct {
            type: DataType,
            length: c_int,
        },
        point: extern struct {
            x: f64,
            y: f64,
        },
    };

    pub const DataType = enum(c_uint) {
        MOVE_TO = 0,
        LINE_TO = 1,
        CURVE_TO = 2,
        CLOSE_PATH = 3,
    };

    extern fn cairo_path_destroy(path: ?*Path) void;
    pub const destroy = cairo_path_destroy;

    extern fn cairo_path_extents(cr: ?*Ctx, x1: ?*f64, y1: ?*f64, x2: ?*f64, y2: ?*f64) void;
    pub const extents = cairo_path_extents;
};

pub const Region = opaque {
    pub const Overlap = enum(c_uint) {
        IN = 0,
        OUT = 1,
        PART = 2,
    };

    extern fn cairo_region_contains_point(region: *const Region, x: c_int, y: c_int) cairo_bool_t;
    pub fn containsPoint(region: *const Region, x: c_int, y: c_int) bool {
        return cairo_region_contains_point(region, x, y) != 0;
    }

    extern fn cairo_region_contains_rectangle(region: *const Region, rectangle: *const RectangleInt) Overlap;
    pub const containsRectangle = cairo_region_contains_rectangle;

    extern fn cairo_region_copy(original: *const Region) ?*Region;
    pub const copy = cairo_region_copy;

    extern fn cairo_region_create() ?*Region;
    pub const create = cairo_region_create;

    extern fn cairo_region_create_rectangle(rectangle: *const RectangleInt) ?*Region;
    pub const createRectangle = cairo_region_create_rectangle;

    extern fn cairo_region_create_rectangles(rects: *const RectangleInt, count: c_int) ?*Region;
    pub const createRectangles = cairo_region_create_rectangles;

    extern fn cairo_region_destroy(region: ?*Region) void;
    pub const destroy = cairo_region_destroy;

    extern fn cairo_region_equal(a: *const Region, b: *const Region) cairo_bool_t;
    pub fn equal(a: *const Region, b: *const Region) bool {
        return cairo_region_equal(a, b) != 0;
    }

    extern fn cairo_region_get_extents(region: *const Region, extents: ?*RectangleInt) void;
    pub const getExtents = cairo_region_get_extents;

    extern fn cairo_region_get_rectangle(region: *const Region, nth: c_int, rectangle: ?*RectangleInt) void;
    pub const getRectangle = cairo_region_get_rectangle;

    extern fn cairo_region_intersect(dst: ?*Region, other: *const Region) Status;
    pub const intersect = cairo_region_intersect;

    extern fn cairo_region_intersect_rectangle(dst: ?*Region, rectangle: *const RectangleInt) Status;
    pub const intersectRectangle = cairo_region_intersect_rectangle;

    extern fn cairo_region_is_empty(region: *const Region) cairo_bool_t;
    pub fn isEmpty(region: *const Region) bool {
        return cairo_region_is_empty(region) != 0;
    }

    extern fn cairo_region_num_rectangles(region: *const Region) c_int;
    pub const numRectangles = cairo_region_num_rectangles;

    extern fn cairo_region_reference(region: ?*Region) ?*Region;
    pub const reference = cairo_region_reference;

    extern fn cairo_region_union(dst: ?*Region, other: *const Region) Status;
    pub const regionUnion = cairo_region_union;

    extern fn cairo_region_status(region: *const Region) Status;
    pub const status = cairo_region_status;

    extern fn cairo_region_subtract(dst: ?*Region, other: *const Region) Status;
    pub const subtract = cairo_region_subtract;

    extern fn cairo_region_subtract_rectangle(dst: ?*Region, rectangle: *const RectangleInt) Status;
    pub const subtractRectangle = cairo_region_subtract_rectangle;

    extern fn cairo_region_translate(region: ?*Region, dx: c_int, dy: c_int) void;
    pub const translate = cairo_region_translate;

    extern fn cairo_region_union_rectangle(dst: ?*Region, rectangle: *const RectangleInt) Status;
    pub const unionRectangle = cairo_region_union_rectangle;

    extern fn cairo_region_xor(dst: ?*Region, other: *const Region) Status;
    pub const xor = cairo_region_xor;

    extern fn cairo_region_xor_rectangle(dst: ?*Region, rectangle: *const RectangleInt) Status;
    pub const xorRectangle = cairo_region_xor_rectangle;
};

pub const Matrix = extern struct {
    xx: f64,
    yx: f64,
    xy: f64,
    yy: f64,
    x0: f64,
    y0: f64,
    extern fn cairo_matrix_init(matrix: ?*Matrix, xx: f64, yx: f64, xy: f64, yy: f64, x0: f64, y0: f64) void;
    pub const init = cairo_matrix_init;

    extern fn cairo_matrix_init_identity(matrix: ?*Matrix) void;
    pub const initIdentity = cairo_matrix_init_identity;

    extern fn cairo_matrix_init_rotate(matrix: ?*Matrix, radians: f64) void;
    pub const initRotate = cairo_matrix_init_rotate;

    extern fn cairo_matrix_init_scale(matrix: ?*Matrix, sx: f64, sy: f64) void;
    pub const initScale = cairo_matrix_init_scale;

    extern fn cairo_matrix_init_translate(matrix: ?*Matrix, tx: f64, ty: f64) void;
    pub const initTranslate = cairo_matrix_init_translate;

    extern fn cairo_matrix_invert(matrix: ?*Matrix) Status;
    pub const invert = cairo_matrix_invert;

    extern fn cairo_matrix_multiply(result: ?*Matrix, a: *const Matrix, b: *const Matrix) void;
    pub const multiply = cairo_matrix_multiply;

    extern fn cairo_matrix_rotate(matrix: ?*Matrix, radians: f64) void;
    pub const rotate = cairo_matrix_rotate;

    extern fn cairo_matrix_scale(matrix: ?*Matrix, sx: f64, sy: f64) void;
    pub const scale = cairo_matrix_scale;

    extern fn cairo_matrix_transform_distance(matrix: *const Matrix, dx: ?*f64, dy: ?*f64) void;
    pub const transformDistance = cairo_matrix_transform_distance;

    extern fn cairo_matrix_transform_point(matrix: *const Matrix, x: ?*f64, y: ?*f64) void;
    pub const transformPoint = cairo_matrix_transform_point;

    extern fn cairo_matrix_translate(matrix: ?*Matrix, tx: f64, ty: f64) void;
    pub const translate = cairo_matrix_translate;
};

pub const Device = opaque {
    pub const Type = enum(c_int) {
        DRM = 0,
        GL = 1,
        SCRIPT = 2,
        XCB = 3,
        XLIB = 4,
        XML = 5,
        COGL = 6,
        WIN32 = 7,
        INVALID = -1,
    };

    extern fn cairo_device_acquire(device: ?*Device) Status;
    pub const acquire = cairo_device_acquire;

    extern fn cairo_device_destroy(device: ?*Device) void;
    pub const destroy = cairo_device_destroy;

    extern fn cairo_device_finish(device: ?*Device) void;
    pub const finish = cairo_device_finish;

    extern fn cairo_device_flush(device: ?*Device) void;
    pub const flush = cairo_device_flush;

    extern fn cairo_device_get_reference_count(device: ?*Device) c_uint;
    pub const getReferenceCount = cairo_device_get_reference_count;

    extern fn cairo_device_get_type(device: ?*Device) Type;
    pub const getType = cairo_device_get_type;

    extern fn cairo_device_get_user_data(device: ?*Device, key: *const UserDataKey) ?*anyopaque;
    pub const getUserData = cairo_device_get_user_data;

    extern fn cairo_device_observer_elapsed(abstract_device: ?*Device) f64;
    pub const observerElapsed = cairo_device_observer_elapsed;

    extern fn cairo_device_observer_fill_elapsed(abstract_device: ?*Device) f64;
    pub const observerFillElapsed = cairo_device_observer_fill_elapsed;

    extern fn cairo_device_observer_glyphs_elapsed(abstract_device: ?*Device) f64;
    pub const observerGlyphsElapsed = cairo_device_observer_glyphs_elapsed;

    extern fn cairo_device_observer_mask_elapsed(abstract_device: ?*Device) f64;
    pub const observerMaskElapsed = cairo_device_observer_mask_elapsed;

    extern fn cairo_device_observer_paint_elapsed(abstract_device: ?*Device) f64;
    pub const observerPaintElapsed = cairo_device_observer_paint_elapsed;

    extern fn cairo_device_observer_print(abstract_device: ?*Device, write_func: WriteFunc, closure: ?*anyopaque) Status;
    pub const observerPrint = cairo_device_observer_print;

    extern fn cairo_device_observer_stroke_elapsed(abstract_device: ?*Device) f64;
    pub const observerStrokeElapsed = cairo_device_observer_stroke_elapsed;

    extern fn cairo_device_reference(device: ?*Device) ?*Device;
    pub const reference = cairo_device_reference;

    extern fn cairo_device_release(device: ?*Device) void;
    pub const release = cairo_device_release;

    extern fn cairo_device_set_user_data(device: ?*Device, key: *const UserDataKey, user_data: ?*anyopaque, destroy: DestroyFunc) Status;
    pub const setUserData = cairo_device_set_user_data;

    extern fn cairo_device_status(device: ?*Device) Status;
    pub const status = cairo_device_status;

    extern fn cairo_device_to_user(cr: ?*Ctx, x: ?*f64, y: ?*f64) void;
    pub const toUser = cairo_device_to_user;

    extern fn cairo_device_to_user_distance(cr: ?*Ctx, dx: ?*f64, dy: ?*f64) void;
    pub const toUserDistance = cairo_device_to_user_distance;
};

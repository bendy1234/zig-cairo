const std = @import("std");

pub fn build(b: *std.Build) void {
    _ = b.addModule("cairo", .{
        .root_source_file = b.path("src/cairo/root.zig"),
    });
}

const std = @import("std");

pub fn build(b: *std.Build) !void {
    const optimize = b.standardOptimizeOption(.{});
    const host_target = b.standardTargetOptions(.{});

    const lib = b.addStaticLibrary(.{
        .name = "host",
        .root_source_file = b.path("host/main.zig"),
        .target = host_target,
        .optimize = optimize,
        .link_libc = true,
        .pic = true,
    });

    const raylib_dep = b.dependency("raylib-zig", .{
        .target = host_target,
        .optimize = optimize,
    });

    const raylib_artifact = raylib_dep.artifact("raylib");
    const raylib = raylib_dep.module("raylib");
    lib.linkLibrary(raylib_artifact);
    lib.root_module.addImport("raylib", raylib);
    lib.addObjectFile(raylib_artifact.getEmittedBin());

    b.installArtifact(lib);
}

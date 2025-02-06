const std = @import("std");
const builtin = @import("builtin");
const str = @import("vendor/str.zig");
const rl = @import("raylib");
const RocStr = str.RocStr;
const RocResult = @import("result.zig").RocResult;
const testing = std.testing;
const expectEqual = testing.expectEqual;
const expect = testing.expect;

const Align = 2 * @alignOf(usize);
extern fn malloc(size: usize) callconv(.C) ?*align(Align) anyopaque;
extern fn realloc(c_ptr: [*]align(Align) u8, size: usize) callconv(.C) ?*anyopaque;
extern fn free(c_ptr: [*]align(Align) u8) callconv(.C) void;
extern fn memcpy(dst: [*]u8, src: [*]u8, size: usize) callconv(.C) void;
extern fn memset(dst: [*]u8, value: i32, size: usize) callconv(.C) void;

const DEBUG: bool = false;

export fn roc_alloc(size: usize, alignment: u32) callconv(.C) ?*anyopaque {
    if (DEBUG) {
        const ptr = malloc(size);
        const stdout = std.io.getStdOut().writer();
        stdout.print("alloc:   {d} (alignment {d}, size {d})\n", .{ ptr, alignment, size }) catch unreachable;
        return ptr;
    } else {
        return malloc(size);
    }
}

export fn roc_realloc(c_ptr: *anyopaque, new_size: usize, old_size: usize, alignment: u32) callconv(.C) ?*anyopaque {
    if (DEBUG) {
        const stdout = std.io.getStdOut().writer();
        stdout.print("realloc: {d} (alignment {d}, old_size {d})\n", .{ c_ptr, alignment, old_size }) catch unreachable;
    }

    return realloc(@as([*]align(Align) u8, @alignCast(@ptrCast(c_ptr))), new_size);
}

export fn roc_dealloc(c_ptr: *anyopaque, alignment: u32) callconv(.C) void {
    if (DEBUG) {
        const stdout = std.io.getStdOut().writer();
        stdout.print("dealloc: {d} (alignment {d})\n", .{ c_ptr, alignment }) catch unreachable;
    }

    free(@as([*]align(Align) u8, @alignCast(@ptrCast(c_ptr))));
}

export fn roc_panic(msg: *RocStr, tag_id: u32) callconv(.C) void {
    const stderr = std.io.getStdErr().writer();
    switch (tag_id) {
        0 => {
            stderr.print("Roc standard library crashed with message\n\n    {s}\n\nShutting down\n", .{msg.asSlice()}) catch unreachable;
        },
        1 => {
            stderr.print("Application crashed with message\n\n    {s}\n\nShutting down\n", .{msg.asSlice()}) catch unreachable;
        },
        else => unreachable,
    }
    std.process.exit(1);
}

export fn roc_dbg(loc: *RocStr, msg: *RocStr, src: *RocStr) callconv(.C) void {
    const stderr = std.io.getStdErr().writer();
    stderr.print("[{s}] {s} = {s}\n", .{ loc.asSlice(), src.asSlice(), msg.asSlice() }) catch unreachable;
}

export fn roc_memset(dst: [*]u8, value: i32, size: usize) callconv(.C) void {
    return memset(dst, value, size);
}

extern fn kill(pid: c_int, sig: c_int) c_int;
extern fn shm_open(name: *const i8, oflag: c_int, mode: c_uint) c_int;
extern fn mmap(addr: ?*anyopaque, length: c_uint, prot: c_int, flags: c_int, fd: c_int, offset: c_uint) *anyopaque;
extern fn getppid() c_int;

fn roc_getppid() callconv(.C) c_int {
    return getppid();
}

fn roc_getppid_windows_stub() callconv(.C) c_int {
    return 0;
}

fn roc_shm_open(name: *const i8, oflag: c_int, mode: c_uint) callconv(.C) c_int {
    return shm_open(name, oflag, mode);
}
fn roc_mmap(addr: ?*anyopaque, length: c_uint, prot: c_int, flags: c_int, fd: c_int, offset: c_uint) callconv(.C) *anyopaque {
    return mmap(addr, length, prot, flags, fd, offset);
}

comptime {
    if (builtin.os.tag == .macos or builtin.os.tag == .linux) {
        @export(roc_getppid, .{ .name = "roc_getppid", .linkage = .strong });
        @export(roc_mmap, .{ .name = "roc_mmap", .linkage = .strong });
        @export(roc_shm_open, .{ .name = "roc_shm_open", .linkage = .strong });
    }

    if (builtin.os.tag == .windows) {
        @export(roc_getppid_windows_stub, .{ .name = "roc_getppid", .linkage = .strong });
    }
}

extern fn roc__render_for_host_1_exposed(i32) callconv(.C) i32;
extern fn roc__setup_for_host_1_exposed(i32) callconv(.C) i32;

pub fn main() void {
    // const stdout = std.io.getStdOut().writer();
    const stderr = std.io.getStdErr().writer();
    const setup_exit_code = roc__setup_for_host_1_exposed(0);
    if (setup_exit_code != 0) {
        stderr.print("Exited with code {d}\n", .{setup_exit_code}) catch unreachable;
        return;
    }

    defer rl.closeWindow();
    rl.setTargetFPS(60);

    while (!rl.windowShouldClose()) {
        rl.beginDrawing();
        defer rl.endDrawing();

        const exit_code = roc__render_for_host_1_exposed(0);
        if (exit_code != 0) {
            stderr.print("Exited with code {d}\n", .{exit_code}) catch unreachable;
            rl.closeWindow();
        }
    }
}

// an example effect to provide to the platform
// this is where roc will call back into the host
export fn roc_fx_stdout_line(msg: *RocStr) callconv(.C) void {
    const stdout = std.io.getStdOut().writer();
    stdout.print("{s}\n", .{msg.asSlice()}) catch unreachable;
}

// RAYLIB exports

export fn roc_fx_init_window(width: i32, height: i32, title: [*c]const u8) callconv(.C) void {
    rl.initWindow(width, height, title);
}

export fn roc_fx_set_target_fps(fps: i32) callconv(.C) void {
    rl.setTargetFPS(fps);
}

export fn roc_fx_clear_background(color: rl.Color) callconv(.C) void {
    rl.clearBackground(color);
}

export fn roc_fx_make_color(r: u8, g: u8, b: u8, a: u8) callconv(.C) rl.Color {
    return rl.Color.init(r, g, b, a);
}

export fn roc_fx_display_fps(x: i32, y: i32) callconv(.C) void {
    rl.drawFPS(x, y);
}

export fn roc_fx_enable_event_waiting() callconv(.C) void {
    std.debug.print("Enable Event Waiting", .{});
    rl.enableEventWaiting();
}

export fn roc_fx_disable_event_waiting() callconv(.C) void {
    std.debug.print("Disable Event Waiting", .{});
    rl.disableEventWaiting();
}

export fn roc_fx_draw_text(text: [*c]const u8, x: i32, y: i32, font_size: i32, color: rl.Color) callconv(.C) void {
    rl.drawText(text, x, y, font_size, color);
}

module [set_config_flags!, make_config_flags, T]

import Raylib

T : {
    fullscreen_mode : Bool,
    window_resizable : Bool,
    window_undecorated : Bool,
    window_transparent : Bool,
    msaa_4x_hint : Bool,
    vsync_hint : Bool,
    window_hidden : Bool,
    window_always_run : Bool,
    window_minimized : Bool,
    window_maximized : Bool,
    window_unfocused : Bool,
    window_topmost : Bool,
    window_mouse_passthrough : Bool,
    borderless_windowed_mode : Bool,
    interlaced_hint : Bool,
}

make_config_flags : { borderless_windowed_mode ?? Bool, fullscreen_mode ?? Bool, interlaced_hint ?? Bool, msaa_4x_hint ?? Bool, vsync_hint ?? Bool, window_always_run ?? Bool, window_hidden ?? Bool, window_maximized ?? Bool, window_minimized ?? Bool, window_mouse_passthrough ?? Bool, window_resizable ?? Bool, window_topmost ?? Bool, window_transparent ?? Bool, window_undecorated ?? Bool, window_unfocused ?? Bool }* -> { borderless_windowed_mode : Bool, fullscreen_mode : Bool, interlaced_hint : Bool, msaa_4x_hint : Bool, vsync_hint : Bool, window_always_run : Bool, window_hidden : Bool, window_maximized : Bool, window_minimized : Bool, window_mouse_passthrough : Bool, window_resizable : Bool, window_topmost : Bool, window_transparent : Bool, window_undecorated : Bool, window_unfocused : Bool }
make_config_flags = |{ fullscreen_mode ?? Bool.false, window_resizable ?? Bool.false, window_undecorated ?? Bool.false, window_transparent ?? Bool.false, msaa_4x_hint ?? Bool.false, vsync_hint ?? Bool.false, window_hidden ?? Bool.false, window_always_run ?? Bool.false, window_minimized ?? Bool.false, window_maximized ?? Bool.false, window_unfocused ?? Bool.false, window_topmost ?? Bool.false, window_mouse_passthrough ?? Bool.false, borderless_windowed_mode ?? Bool.false, interlaced_hint ?? Bool.false }| {
    fullscreen_mode,
    window_resizable,
    window_undecorated,
    window_transparent,
    msaa_4x_hint,
    vsync_hint,
    window_hidden,
    window_always_run,
    window_minimized,
    window_maximized,
    window_unfocused,
    window_topmost,
    window_mouse_passthrough,
    borderless_windowed_mode,
    interlaced_hint,
}

set_config_flags! : T => {}
set_config_flags! = |flags|
    Raylib.set_config_flags!
        flags.fullscreen_mode
        flags.window_resizable
        flags.window_undecorated
        flags.window_transparent
        flags.msaa_4x_hint
        flags.vsync_hint
        flags.window_hidden
        flags.window_always_run
        flags.window_minimized
        flags.window_maximized
        flags.window_unfocused
        flags.window_topmost
        flags.window_mouse_passthrough
        flags.borderless_windowed_mode
        flags.interlaced_hint

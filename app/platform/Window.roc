module [make, init!]

import Raylib
import ConfigFlags
import Color

DisplayFps : [
    Hidden,
    Visible (I32, I32),
]

Window : {
    width : I32,
    height : I32,
    title : Str,
    display_fps : DisplayFps,
    background : Color.RayColor,
    event_waiting : Bool,
    config_flags : ConfigFlags.T,
}

make : { background ?? Color.RayColor, config_flags ?? { borderless_windowed_mode : Bool, fullscreen_mode : Bool, interlaced_hint : Bool, msaa_4x_hint : Bool, vsync_hint : Bool, window_always_run : Bool, window_hidden : Bool, window_maximized : Bool, window_minimized : Bool, window_mouse_passthrough : Bool, window_resizable : Bool, window_topmost : Bool, window_transparent : Bool, window_undecorated : Bool, window_unfocused : Bool }, display_fps ?? [Hidden]e, event_waiting ?? Bool, height ?? I32, title : Str, width ?? I32 }* -> Window
make = |{ width ?? 400, height ?? 400, title, display_fps ?? Hidden, background ?? Color.white, event_waiting ?? Bool.true, config_flags ?? ConfigFlags.make_config_flags {} }| {
    width,
    height,
    title,
    display_fps,
    background,
    event_waiting,
    config_flags,
}

init! : Window => Result Window Str
init! = |w|
    ConfigFlags.set_config_flags! w.config_flags

    Raylib.init_window! w.width w.height w.title
    Raylib.set_target_fps! 60

    when w.display_fps is
        Hidden -> {}
        Visible (x, y) -> Raylib.display_fps! x y

    if w.event_waiting then
        Raylib.enable_event_waiting! {}
    else
        Raylib.disable_event_waiting! {}

    Ok(w)

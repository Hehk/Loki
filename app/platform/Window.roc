module [make, init!]

import Raylib

DisplayFps : [
    Hidden,
    Visible (I32, I32),
]

Color : {
    r : U8,
    g : U8,
    b : U8,
    a : U8,
}

Window : {
    width : I32,
    height : I32,
    title : Str,
    display_fps : DisplayFps,
    background : Color,
    event_waiting : Bool,
}

make = |{ width ?? 400, height ?? 400, title, display_fps ?? Hidden, background ?? { r: 255, g: 255, b: 255, a: 255 }, event_waiting ?? Bool.true }| { width, height, title, display_fps, background, event_waiting }

init! : Window => Result Window Str
init! = |w|
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

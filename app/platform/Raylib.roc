hosted [
    init_window!,
    set_target_fps!,
    clear_background!,
    make_color!,
    display_fps!,
    disable_event_waiting!,
    enable_event_waiting!,
    draw_text!,
]

init_window! : I32, I32, Str => {}
set_target_fps! : I32 => {}
display_fps! : I32, I32 => {}

Color : {
    r : U8,
    g : U8,
    b : U8,
    a : U8,
}

clear_background! : Color => {}
make_color! : U8, U8, U8, U8 => Color

disable_event_waiting! : {} => {}
enable_event_waiting! : {} => {}

draw_text! : Str, I32, I32, I32, Color => {}

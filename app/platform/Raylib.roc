hosted [
    init_window!,
    set_target_fps!,
    clear_background!,
    make_color!,
    display_fps!,
    disable_event_waiting!,
    enable_event_waiting!,
    draw_text!,
    draw_text_ex!,
    set_config_flags!,
    load_font!,
]
import Color
import Font

init_window! : I32, I32, Str => {}
set_target_fps! : I32 => {}
display_fps! : I32, I32 => {}

clear_background! : Color.RayColor => {}
make_color! : U8, U8, U8, U8 => Color.RayColor

disable_event_waiting! : {} => {}
enable_event_waiting! : {} => {}

draw_text! : Str, I32, I32, I32, Color.RayColor => {}
draw_text_ex! : Str, Str, I32, I32, I32, F32, Color.RayColor => {}

set_config_flags! : Bool, Bool, Bool, Bool, Bool, Bool, Bool, Bool, Bool, Bool, Bool, Bool, Bool, Bool, Bool => {}

load_font! : Str, Str => {}

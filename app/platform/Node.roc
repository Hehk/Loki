module [draw_tree!, text]

import Raylib
import Color

Text : {
    x : I32,
    y : I32,
    size : I32,
    color : Color.RayColor,
    content : Str,
    font : [None, Some Str],
}

T : [
    Text Text,
]

text : { color ?? Color.RayColor, content : Str, font ?? [None, Some Str], size ?? I32, x ?? I32, y ?? I32 } -> T
text = |{ x ?? 0, y ?? 0, size ?? 16, color ?? Color.black, content, font ?? None }|
    Text { x, y, size, color, content, font }

draw_tree! : T => {}
draw_tree! = |node|
    when node is
        Text { x, y, size, color, content, font } ->
            when font is
                None -> Raylib.draw_text! content x y size color
                Some f -> Raylib.draw_text_ex! f content x y size 3.0 color

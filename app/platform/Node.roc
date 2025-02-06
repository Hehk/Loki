module [drawTree!, text]

import Raylib

Color : {
    r : U8,
    g : U8,
    b : U8,
    a : U8,
}

Node : [
    Text { x : I32, y : I32, size : I32, color : Color, content : Str },
]

text = |{ x ?? 0, y ?? 0, size ?? 16, color ?? { r: 0, g: 0, b: 0, a: 255 }, content }|
    Text { x, y, size, color, content }

drawTree! = |node|
    when node is
        Text { x, y, size, color, content } ->
            rl_color = Raylib.make_color! color.r color.g color.b color.a
            Raylib.draw_text! content x y size rl_color

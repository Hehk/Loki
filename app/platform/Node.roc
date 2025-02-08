module [drawTree!, text]

import Raylib
import Color

Node : [
    Text { x : I32, y : I32, size : I32, color : Color.RayColor, content : Str },
]

text = |{ x ?? 0, y ?? 0, size ?? 16, color ?? Color.black, content }|
    Text { x, y, size, color, content }

drawTree! = |node|
    when node is
        Text { x, y, size, color, content } ->
            Raylib.draw_text! content x y size color

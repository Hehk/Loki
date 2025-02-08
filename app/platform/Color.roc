module [rgba, to_ray_color, white, black, RayColor, hex]

RayColor := U64 implements [Eq]

to_ray_color : { r : U8, g : U8, b : U8, a : U8 } -> RayColor
to_ray_color = |{ r, g, b, a }|
    (Num.int_cast a |> Num.shift_left_by 24)
    |> Num.bitwise_or (Num.int_cast b |> Num.shift_left_by 16)
    |> Num.bitwise_or (Num.int_cast g |> Num.shift_left_by 8)
    |> Num.bitwise_or (Num.int_cast r)
    |> @RayColor

rgba = |{ r, g, b, a }|
    { r, g, b, a } |> to_ray_color

hex : U64 -> RayColor
hex = |code|
    r = Num.bitwise_and code 0xFF0000 |> Num.shift_right_by 16 |> Num.int_cast
    g = code |> Num.bitwise_and 0xFF00 |> Num.shift_right_by 8 |> Num.int_cast
    b = code |> Num.bitwise_and 0xFF |> Num.int_cast
    rgba { r, g, b, a: 255 }

white = rgba { r: 255, g: 255, b: 255, a: 255 }
black = rgba { r: 0, g: 0, b: 0, a: 255 }

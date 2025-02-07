module [rgba, to_ray_color, white, black, RayColor]

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

white = rgba { r: 255, g: 255, b: 255, a: 255 }
black = rgba { r: 0, g: 0, b: 0, a: 255 }

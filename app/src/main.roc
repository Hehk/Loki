app [render!, setup!] { byfrost: platform "../platform/main.roc" }

import byfrost.Window
import byfrost.Raylib
import byfrost.Node

setup! : {} => Result {} _
setup! = |{}|
    window = Window.make { width: 800, height: 600, title: "Loki", display_fps: Visible (4, 300) }
    _ = Window.init! window

    Ok({})

render! : {} => Result {} _
render! = |{}|
    Raylib.make_color! 255 255 255 255
    |> Raylib.clear_background!

    Node.drawTree! (Node.text { content: "Hello World!",})

    Ok({})

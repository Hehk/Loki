app [render!, setup!] { byfrost: platform "../platform/main.roc" }

import byfrost.Window
import byfrost.Raylib
import byfrost.Node
import byfrost.ConfigFlags
import byfrost.Stdout

setup! : {} => Result {} _
setup! = |{}|
    config_flags = ConfigFlags.make_config_flags { window_resizable: Bool.true }
    if config_flags.window_resizable then
        Stdout.line! "Window resizable"
    else
        Stdout.line! "Window not resizable"

    window = Window.make {
        width: 800,
        height: 600,
        title: "Loki",
        display_fps: Visible (4, 300),
        config_flags,
    }
    _ = Window.init! window

    Ok({})

render! : {} => Result {} _
render! = |{}|
    Raylib.make_color! 255 255 255 255
    |> Raylib.clear_background!

    Node.drawTree! (Node.text { content: "Hello World!" })

    Ok({})

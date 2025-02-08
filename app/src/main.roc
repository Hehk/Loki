app [render!, setup!] { byfrost: platform "../platform/main.roc" }

import byfrost.Window
import byfrost.Raylib
import byfrost.Node
import byfrost.ConfigFlags

import Theme

setup! : {} => Result {} _
setup! = |{}|
    config_flags = ConfigFlags.make_config_flags { window_resizable: Bool.true }

    window = Window.make {
        width: 800,
        height: 600,
        title: "Loki",
        display_fps: Visible (4, 300),
        background_color: Theme.bg,
        config_flags,
    }
    _ = Window.init! window

    Ok({})

render! : {} => Result {} _
render! = |{}|
    Raylib.clear_background! Theme.bg

    Node.drawTree! (Node.text { content: "Hello World!", color: Theme.tx, x: 4, y: 4 })

    Ok({})

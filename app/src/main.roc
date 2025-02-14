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

    Raylib.load_font! "Quattrocento" "assets/fonts/Quattrocento-Regular.ttf"
    Raylib.load_font! "Quattrocento-Bold" "assets/fonts/Quattrocento-Bold.ttf"
    Raylib.load_font! "Lora" "assets/fonts/Lora-VariableFont_wght.ttf"
    Raylib.load_font! "Lora-Italic" "assets/fonts/Lora-Italic-VariableFont_wght.ttf"

    Ok({})

render! : {} => Result {} Str
render! = |{}|
    Raylib.clear_background! Theme.bg

    tree = Node.text { content: "Hello World!", color: Theme.tx, x: 4, y: 4, font: Some "Quattrocento-Bold", size: 64 }
    Node.draw_tree! tree

    Ok({})

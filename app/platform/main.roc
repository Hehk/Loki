platform "byfrost"
    requires {} {
        render! : {} => Result {} Str,
        setup! : {} => Result {} Str,
    }
    exposes [Stdout, Raylib]
    packages {}
    imports []
    provides [render_for_host!, setup_for_host!]

import Stdout

setup_for_host! : I32 => I32
setup_for_host! = |_|
    when setup!({}) is
        Ok({}) -> 0
        Err(msg) ->
            Stdout.line!(msg)
            1

render_for_host! : I32 => I32
render_for_host! = |_|
    when render!({}) is
        Ok({}) -> 0
        Err(msg) ->
            Stdout.line!(msg)
            1

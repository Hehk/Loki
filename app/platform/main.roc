platform "byfrost"
    requires {} {
        render! : {} => Result {} []_,
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
        Err(Exit(code, str)) ->
            if Str.is_empty(str) then
                code
            else
                Stdout.line!(str)
                code

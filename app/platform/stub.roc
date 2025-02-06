# App stub, used to create a prebuilt surgical host
app [render!, setup!] { pf: platform "../platform/main.roc" }

render! : {} => Result {} _
render! = |{}| Ok({})

setup! : {} => Result {} _
setup! = |{}| Ok({})

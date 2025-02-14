app [main!] {
    cli: platform "https://github.com/roc-lang/basic-cli/releases/download/0.19.0/Hj-J_zxz7V9YurCSTFcFdu6cQJie4guzsPMUi5kBYUk.tar.br",
}

import cli.Cmd
import cli.Env

main! = |_args|
    { os } = Env.platform!({})

    roc = Env.var!("ROC") ?? "roc"

    build_stub!(roc, os)?

    Cmd.exec!("zig", ["build", "-Doptimize=Debug"]) ? ErrBuildingZigHost

    Cmd.exec!("cp", ["-f", "zig-out/lib/libhost.a", "./platform/libhost.a"]) ? ErrCopyPrebuiltLegacyHost

    Ok({})


build_stub! = |roc, os|
    # zig will link these shared libraries to build a dynhost executable
    # which is used to build the surgical host
    when os is
        LINUX ->
            Cmd.exec!(roc, ["build", "--lib", "--output", "./platform/libapp.so", "./platform/stub.roc"]) ? ErrBuildingStubDylibLinux

        MACOS ->
            Cmd.exec!(roc, ["build", "--lib", "--output", "./platform/libapp.dylib", "./platform/stub.roc"]) ? ErrBuildingStubDylibMacos

        WINDOWS ->
            Cmd.exec!(roc, ["build", "--lib", "--output", "./platform/app.lib", "./platform/stub.roc"]) ? ErrBuildingStubDylibWindows

        OTHER(os_str) ->
            crash("OS ${os_str} not supported, build.roc probably needs updating")

    Ok({})

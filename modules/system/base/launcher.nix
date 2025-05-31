{
    inputs,
    lib,
    config,
    pkgs,
    ...
}: 
{   imports = [
        ./walker.nix
    ];
    rum.programs.walker = {
        enable = true;
        systemd.enable = true;
        runAsService = true;
        config = ./../../../configs/walker/config.toml;
        theme = {
            layout = ./../../../configs/walker/themes/base16.toml;
            style = ./../../../configs/walker/themes/base16.css;
        };
    };
}

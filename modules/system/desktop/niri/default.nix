{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./niri.nix
  ];

  hj = {
    packages = [pkgs.niri-unstable pkgs.astal-shell pkgs.swaybg];
    files = {
      ".config/niri/config.kdl".text = ''
        ${import ./settings.nix {inherit config pkgs inputs;}}
        ${import ./binds.nix {inherit config pkgs inputs;}}
        ${import ./startup.nix {inherit config pkgs inputs;}}
      '';
    };
  };
}

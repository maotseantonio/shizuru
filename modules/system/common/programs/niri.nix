{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: let
  mkIf = lib.mkIf;
  kdl = import ./kdl.nix {inherit lib;};
  cfg = config.rum.programs.niri;
in {
  options.rum.programs.niri = {
    enable = lib.mkEnableOption "niri window manager";
    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.niri; # or your preferred default package
      description = "Niri package";
    };
    settings = lib.mkOption {
      type = lib.types.attrs;
      default = {};
      description = "Niri configuration as a nested attribute set, written to config.kdl";
    };
    # Optional extraPackages if you want to extend later
    extraPackages = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = [];
      description = "Extra system packages for Niri.";
    };
  };

  config = mkIf cfg.enable {
    # Add main package + any extras
    hj.packages = [cfg.package] ++ cfg.extraPackages;

    # Write config.kdl using source (serialized from KDL format)
    hj.files.".config/niri/config.kdl".source = kdl.toKDL cfg.settings;
  };
}

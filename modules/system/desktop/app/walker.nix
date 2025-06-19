{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: let
  inherit (lib) mkIf mkEnableOption mkOption;
  inherit (lib.types) nullOr either str path attrs;
  inherit (lib.meta) getExe;

  tomlFormat = pkgs.formats.toml {};

  cfg = config.rum.programs.walker;

  defaultPackage = pkgs.walker or null;
in {
  options.rum.programs.walker = {
    enable = mkEnableOption "Walker application launcher";

    package = mkOption {
      type = lib.types.package;
      default = defaultPackage;
      description = "Walker package to use";
    };

    config = mkOption {
      type = nullOr (either path (either str attrs));
      default = null;
      description = ''
        Walker configuration can be provided as:
        - Path to a TOML file
        - Raw TOML string
        - Nix attribute set (will be converted to TOML)
      '';
    };

    theme = mkOption {
      type = nullOr (lib.types.submodule {
        options = {
          layout = mkOption {
            type = nullOr (either path attrs);
            default = null;
            description = "Theme layout: path or attrset (TOML)";
          };
          style = mkOption {
            type = nullOr (either path str);
            default = null;
            description = "Theme style: path to CSS file or raw CSS string";
          };
        };
      });
      default = null;
      description = ''
        Optional theme configuration:
        - layout: path to TOML file or attribute set (converted to TOML)
        - style: path to CSS file or raw CSS string
      '';
    };

    systemd = {
      enable = mkEnableOption "Enable systemd user service for Walker";
    };

    runAsService = mkOption {
      type = lib.types.bool;
      default = true;
      description = "Run Walker as systemd user service";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [cfg.package];

    # Replace environment.etc with hj.files
    hj.files = lib.mkMerge [
      (lib.mkIf (cfg.config != null) {
        ".config/walker/config.toml" =
          if lib.isString cfg.config
          then {
            text = cfg.config;
          }
          else if lib.isPath cfg.config
          then {
            source = cfg.config;
          }
          else {
            text = tomlFormat.generate "walker-config" cfg.config;
          };
      })

      (lib.mkIf (cfg.theme != null) (let
        layoutEntry =
          if cfg.theme.layout == null
          then null
          else if lib.isPath cfg.theme.layout
          then {source = cfg.theme.layout;}
          else {text = tomlFormat.generate "walker-theme-layout" cfg.theme.layout;};

        styleEntry =
          if cfg.theme.style == null
          then null
          else if lib.isPath cfg.theme.style
          then {source = cfg.theme.style;}
          else {text = cfg.theme.style;};
      in {
        ".config/walker/themes/default.toml" = layoutEntry;
        ".config/walker/themes/default.css" = styleEntry;
      }))
    ];

    # systemd user service for walker
    systemd.user.services.walker = mkIf (cfg.systemd.enable && cfg.runAsService) {
      enable = true;
      wantedBy = ["graphical-session.target"];
      serviceConfig = {
        ExecStart = "${getExe cfg.package} --gapplication-service";
        Restart = "on-failure";
        RestartSec = "5s";
      };
    };
  };
}

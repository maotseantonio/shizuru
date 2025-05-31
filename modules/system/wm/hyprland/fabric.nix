
{ config, lib, pkgs, inputs, ... }:

let
  inherit (lib) mkIf mkEnableOption mkOption;
  inherit (lib.types) nullOr path;

  cfg = config.rum.programs.fabricbar;

  axShellSource = inputs.ax-shell-config;
  fabricBarScript = pkgs.writeScriptBin "fabric-bar" (builtins.readFile ./fabric.sh);
in
{
  options.rum.programs.fabricbar = {
    enable = mkEnableOption "Fabric Bar and Ax-Shell integration";

    axShellPath = mkOption {
      type = nullOr path;
      default = axShellSource;
      description = "Path to ax-shell config directory";
    };

    fabricBarScriptPath = mkOption {
      type = nullOr path;
      default = null;
      description = "Path to fabric-bar script (if overriding)";
    };

    extraPackages = mkOption {
      type = lib.types.listOf lib.types.package;
      default = [];
      description = "Additional packages to install";
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      matugen
      cava
      (if cfg.fabricBarScriptPath != null then
         pkgs.writeScriptBin "fabric-bar" (builtins.readFile cfg.fabricBarScriptPath)
       else fabricBarScript)
      wlinhibit
      tesseract
      imagemagick
      nur.repos.HeyImKyu.fabric-cli
      (nur.repos.HeyImKyu.run-widget.override {
        extraPythonPackages = with pkgs.python3Packages; [
          ijson
          pillow
          psutil
          requests
          setproctitle
          toml
          watchdog
          thefuzz
          numpy
          chardet
        ];
        extraBuildInputs = [
          nur.repos.HeyImKyu.fabric-gray
          pkgs.networkmanager
          pkgs.networkmanager.dev
          pkgs.playerctl
        ];
      })
    ] ++ cfg.extraPackages;

    hj.files = lib.mkMerge [
      {
        ".config/Ax-Shell" = {
          source = cfg.axShellPath;
          recursive = true;
        };

        ".local/share/fonts/tabler-icons.ttf" = {
          source = "${cfg.axShellPath}/assets/fonts/tabler-icons/tabler-icons.ttf";
        };

        "${config.xdg.configHome}/matugen/config.toml" = {
          source = ./matugen.toml;
        };
      }
    ]; 
  };
}

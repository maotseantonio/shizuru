{ lib, pkgs, config, ... }:
let
  inherit (lib) mkEnableOption mkIf getExe;

  hyprlockPackage = config.hj.rum.programs.hyprlock.package;
  hypridlePackage = config.hj.rum.programs.hypridle.package;
  hyprlandPackage = config.programs.hyprland.package;

  cfg = config.mine.hypridle;
in
{
  options.mine.hypridle = {
    enable = mkEnableOption "hypridle service";
  };

  config = mkIf cfg.enable {
    hj.rum.programs.hypridle = {
      enable = true;
      settings = {
        general = {
          before_sleep_cmd = "loginctl lock-session";
          lock_cmd = "pidof hyprlock || hyprlock";
          ignore_dbus_inhibit = false;
        };

        listener = [
          # Turn off display after 10 minutes
          {
            timeout = 600;
            on-timeout = "hyprctl dispatch dpms off";
            on-resume = "hyprctl dispatch dpms on";
          }
          # Lock screen after another 10 minutes (20 minutes total)
          {
            timeout = 1200;
            on-timeout = "loginctl lock-session";
          }
        ];
      };
    };

    # Standard systemd service without UWSM dependencies
   
    systemd.user.services.hypridle = {
    description = "Hyprland idle daemon";
    documentation = [ "https://wiki.hyprland.org/Hypr-Ecosystem/hypridle" ];
    partOf = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];

    serviceConfig = {
      ExecStart = "${pkgs.hypridle}/bin/hypridle";
      Restart = "on-failure";
      RestartSec = 1;
    };

    wantedBy = [ "graphical-session.target" ];
  };

    # DPMS wake configuration
    programs.hyprland.settings.misc = {
      key_press_enables_dpms = true;
      mouse_move_enables_dpms = true;
    };
  };
}

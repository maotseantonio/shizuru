{ lib, pkgs, config, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.mine.hypridle;
in
{
  options.mine.hypridle = {
    enable = mkEnableOption "Enable Hypridle service";
  };

  config = mkIf cfg.enable {
    hj.rum.programs.hypridle = {
      enable = true;
      settings = {
        general = {
          lock_cmd = ''
            sh -c 'notify-send "Locking" && pidoff hyprlock || hyprlock'
          '';
          unlock_cmd = ''notify-send "Unlocked"'';
          before_sleep_cmd = ''sh -c 'notify-send "Sleeping" && loginctl lock-session' '';
          after_sleep_cmd = ''sh -c 'notify-send "Woke up" && hyprctl dispatch dpms on' '';
          ignore_dbus_inhibit = false;
          ignore_systemd_inhibit = false;
        };

        listener = [
          {
            # DPMS off after 10 minutes idle
            timeout = 6000;
            on-timeout = ''sh -c 'notify-send "Idle" && hyprctl dispatch dpms off' '';
            on-resume = ''sh -c 'notify-send "Resumed" && hyprctl dispatch dpms on' '';
          }
          {
            # Lock screen after 20 minutes total idle
            timeout = 12000;
            #on-timeout = ''sh -c 'notify-send "Locking after idle" && loginctl lock-session' '';
          }
        ];
      };
    };


  hm.systemd.user.services.hypridle = {
    Unit = {
      Description = "Hyprland idle daemon";
      Documentation = [ "https://wiki.hyprland.org/Hypr-Ecosystem/hypridle" ];
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
    };

    Service = {
      ExecStart = "${pkgs.hypridle}/bin/hypridle";
      Restart = "on-failure";
      RestartSec = 1;
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };


    hj.rum.programs.hyprland.settings.misc = {
      key_press_enables_dpms = true;
      mouse_move_enables_dpms = true;
    };
  };
}



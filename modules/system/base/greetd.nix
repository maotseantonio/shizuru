
{
  pkgs,
  config,
  host,
  username,
  options,
  lib,
  inputs,
  system,
  ...
}:
with lib; let
  cfg = config.system.greetd;
in {
  options.system.greetd = {
    enable = mkEnableOption "Enable Greetd Display Manager Services";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      greetd.tuigreet
      lyra-cursors
    ];

    services.greetd = {
      enable = true;
      vt = 1;
      settings = {
        default_session = {
          user = username;
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet \
            --user-menu \
            -w 30 \
            --window-padding 40 \
            --container-padding 8 \
            --remember \
            --remember-session \
            --time \
            --theme 'border=cyan;text=cyan;prompt=cyan;time=cyan;action=cyan;button=cyan;container=black;input=cyan' \
            --cmd uwsm start hyprland-uwsm.desktop";
        };
      };
    };

    programs.uwsm.enable = true;
    programs.uwsm.waylandCompositors = {
      hyprland = {
        prettyName = "Hyprland";
        comment = "Hyprland compositor manager by UWSM";
        binPath = "/run/current-system/sw/bin/Hyprland";
      };
      niri = {
        prettyName = "Niri";
        comment = "Niri compositor managed by UWSM";
        binPath = "/run/current-system/sw/bin/niri-session";
      };
    };
    systemd.services.greetd.serviceConfig = {
        Type = "idle";
        StarndardInput = "tty";
        StarndardOutput = "tty";
        StandardError = "journal";
        TTYReset = true; 
        TTYHangup = true;
        TTYVTDisallocate = true;
    };
    systemd.extraConfig = "DefaultTimeoutStopSec=1os";
  };
}

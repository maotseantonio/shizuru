{
  pkgs,
  inputs,
  configs,
  lib,
  ...
}: {
  hj.packages = with pkgs; [swayidle hypridle];
  hm = {
    systemd.user.services.swayidle = {
      Unit = {
        Description = "Idle management with swayidle";
        PartOf = ["graphical-session.target"];
        After = ["graphical-session.target"];
      };
      Service = {
        Environment = "WAYLAND_DISPLAY=wayland-1"; # Change if needed
        ExecStart = ''
          ${pkgs.swayidle}/bin/swayidle -w \
            timeout 3000 '${pkgs.hyprlock}/bin/hyprlock' \
            timeout 1000 '${pkgs.hyprland}/bin/hyprctl dispatch dpms off' \
            resume '${pkgs.hyprland}/bin/hyprctl dispatch dpms on' \
            before-sleep '${pkgs.hyprlock}/bin/hyprlock'
        '';
        Restart = "always";
      };
      Install = {
        WantedBy = ["graphical-session.target"];
      };
    };
  };
}

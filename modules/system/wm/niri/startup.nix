
{ config, pkgs, inputs, ... }:

let
  kaneru = "${inputs.astal-bar.packages.${pkgs.system}.default}/bin/kaneru";
  wallpaperScript = pkgs.writeScriptBin "niri-wallpaper" (builtins.readFile ./wallpaperAutoChange.sh);
in ''
spawn-at-startup "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"
spawn-at-startup "${pkgs.wl-clipboard}/bin/wl-paste --type image --watch cliphist store"
spawn-at-startup "${pkgs.wl-clipboard}/bin/wl-paste --type text --watch cliphist store"
spawn-at-startup "${pkgs.wl-clipboard}/bin/wl-paste --watch walker --update-clipboard"
spawn-at-startup "${pkgs.swww}/bin/swww-daemon"
spawn-at-startup "kaneru"
spawn-at-startup "uwsm finalize"
spawn-at-startup "${wallpaperScript}/bin/niri-wallpaper"
spawn-at-startup "${pkgs.dbus}/bin/dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
spawn-at-startup "${pkgs.systemd}/bin/systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
spawn-at-startup "${pkgs.dbus}/bin/dbus-update-activation-environment --all"
spawn-at-startup "${pkgs.xdg-desktop-portal-gnome}/libexec/xdg-desktop-portal-gnome"
spawn-at-startup "systemctl --user start hypridle"
spawn-at-startup " systemctl restart --user arRPC.service"
spawn-at-startup "systemctl --user start walker"
spawn-at-startup "systemctl --user start cliphist"

''

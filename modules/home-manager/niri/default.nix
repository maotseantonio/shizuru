{
  inputs,
  pkgs,
  lib,
  config,
  ...
}: let
  wallpaperScript = pkgs.writeScriptBin "niri-wallpaper" (builtins.readFile ./wallpaperAutoChange.sh);
  swww = inputs.swww.packages.${pkgs.system}.swww;
in {
  imports = [
    inputs.niri.homeModules.niri
    ./settings.nix
    ./binds.nix
    ./rules.nix
  ];

  xdg.portal.extraPortals = [
        pkgs.xdg-desktop-portal-gtk
        pkgs.xdg-desktop-portal-gnome
        pkgs.gnome-keyring
  ];
  services.arrpc.enable = true;
  services.swww = {
    enable = true;
    package = swww;
  };
  home = {
    packages = with pkgs; [
      gnome-keyring
      wl-clipboard
      inputs.astal-bar.packages.${pkgs.system}.default
      inputs.astal.packages.${pkgs.system}.default
      wallpaperScript
      seatd
      jaq
      eww
      brillo
      cage
      qt6.qtwayland
      wl-clip-persist
      cliphist
      xwayland-satellite
      wl-clipboard
      gnome-control-center
      catppuccin-cursors.mochaGreen
    ];
    sessionVariables = {
      QT_QPA_PLATFORMTHEME = "qt6ct";
      QT_STYLE_OVERRIDE = "kvantum";
      XDG_SESSION_TYPE = "wayland";
    };
  };

  systemd.user.services.wayland-satalite = {
    Unit = {
      Description = "Xwayland Satalite Service";
      After = " config.wayland.systemd.target";
      PartOf = " config.wayland.systemd.target";
    };
    Install.WantedBy = ["config.wayland.systemd.target "];
    Service = {
      Type = "simple";
      ExecStart = "${pkgs.xwayland-satellite}/bin/xwayland-satellite";
      Restart = "on-failure";
      Environment = [
        "WAYLAND_DISPLAY=wayland-1"
        "XDG_RUNTIME_DIR=/run/user/%U"
      ];
    };
  };
}

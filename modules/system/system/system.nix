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
}: {
  system.autoUpgrade = {
    enable = true;
    flake = inputs.self.outPath;
    flags = [
      "--update-input"
      "nixpkgs"
      "-L"
    ];
    randomizedDelaySec = "45min";
  };
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    config = {
      common.default = [ "gtk" ];
      hyprland.default = [
        "gtk"
        "hyprland"
      ];
    };

    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };
  environment.systemPackages = with pkgs; [
    wget
    git
    baobab
    #btrfs-progs
    clang
    curl
    cpufrequtils
    duf
    eza
    ffmpeg
    glib #for gsettings to work
    gsettings-qt
    git
    killall
    libappindicator
    libnotify
    openssl #required by Rainbow borders
    pciutils
    vim
    xdg-user-dirs
    xdg-utils
    hyprpicker
    fastfetch
  ]; 
  system.stateVersion = "25.05";
}

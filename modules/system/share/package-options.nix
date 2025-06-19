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
  swww = inputs.swww.packages.${pkgs.system}.swww;
  cfg = config.system.packages;
  qsConfig = ../../../configs/quickshell/qml;
  quickshell = inputs.quickshell.packages.${pkgs.system}.default.override {
    withWayland = true;
    withHyprland = true;
    withQtSvg = true;
  };

  qsWrapper = pkgs.symlinkJoin rec {
    name = "qs-wrapper";
    paths = [pkgs.quickshell];

    buildInputs = [pkgs.makeWrapper];

    qtDeps = with pkgs.kdePackages; [
      qtbase
      qtdeclarative
      qtmultimedia
      qtstyleplugin-kvantum
    ];
    qmlPath = let
      qt5Path = "${pkgs.libsForQt5.qtstyleplugin-kvantum}/lib/qt-5/qml";
      qt6Paths = lib.pipe (with pkgs.kdePackages; [qtbase qtdeclarative qtmultimedia]) [
        (builtins.map (lib: "${lib}/lib/qt-6/qml"))
      ];
    in
      lib.concatStringsSep ":" (qt6Paths ++ [qt5Path]);

    postBuild = ''
      wrapProgram $out/bin/quickshell \
        --set QML2_IMPORT_PATH "${qmlPath}" \
        --add-flags '-p ${qsConfig}'
    '';

    meta.mainProgram = "quickshell";
  };
in {
  options.system.packages = {
    enable = mkEnableOption "Enable Laptop Specific Packages";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      ags_1
      brightnessctl # for brightness control
      libinput
      #qsWrapper
      #libinput-gestures
      python313Packages.pywayland
      neovide
      starship
      cliphist
      eog
      gnome-system-monitor
      file-roller
      grim
      #protonvpn-gui
      hiddify-app
      #inputs.walker.packages.${pkgs.system}.default
      gtk-engine-murrine # for gtk themes
      hyprcursor # requires unstable channel
      #hypridle # requires unstable channel
      imagemagick
      inxi
      jq
      kitty
      libsForQt5.qtstyleplugin-kvantum # kvantum
      master.networkmanagerapplet
      nwg-look # requires unstable channel
      nwg-dock-hyprland
      #inputs.hyprswitch.packages.${pkgs.system}.default
      master.pamixer
      master.gitui
      pavucontrol
      playerctl
      polkit_gnome
      pyprland
      libsForQt5.qt5ct
      # kdePackages.full
      qt6ct
      qt6.qtwayland
      qt6Packages.qtstyleplugin-kvantum # kvantum
      rofi-wayland
      slurp
      swappy
      swww
      unzip
      wallust
      wl-clipboard
      wlogout
      yad
      yt-dlp
      nix-ld
      power-profiles-daemon
      fd
      master.home-manager
      bluez-tools
      wgpu-utils
      gtk3
      gtk4
      atuin
      bun
      zoxide
      dart-sass
      sass
      readest
      wf-recorder
      sassc
      libgtop
      telegram-desktop
      vesktop
      papirus-folders
      papirus-icon-theme
      spotify
      bibata-cursors
      gpu-screen-recorder
      libqalculate
      dbus-glib
      gtkmm4
      komikku
      mangal
      mangareader
      master.tmux
      stable.neofetch
      gtk4
      vivid
      (pkgs.callPackage ../../../pkgs/nitch.nix {})
      nurl
      yazi
      #firefox_nightly
      inputs.hyprsunset.packages.${pkgs.system}.hyprsunset
      master.microfetch
      socat
      hyprpicker
      hyprpanel
      inputs.nyxexprs.packages.${pkgs.system}.ani-cli-git
    ];
  };
}

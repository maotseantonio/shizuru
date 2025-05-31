{
  pkgs,
  pkgs-master,
  config,
  inputs,
  lib,
  options,
  chaotic,
  quickshell,
  ...
}:
let 
  qsConfig = ../../../configs/quickshell/kurukurubar; 
  qsWrapper = pkgs.symlinkJoin rec {
    name = "qs-wrapper";
    paths = [ pkgs.quickshell ];

    buildInputs = [ pkgs.makeWrapper ];

    qtDeps = with pkgs.kdePackages; [
      qtbase
      qtdeclarative
      qtmultimedia
      qtstyleplugin-kvantum
    ];    
    qmlPath = let
       qt5Path = "${pkgs.libsForQt5.qtstyleplugin-kvantum}/lib/qt-5/qml";
       qt6Paths = lib.pipe (with pkgs.kdePackages; [ qtbase qtdeclarative qtmultimedia ]) [
      (builtins.map (lib: "${lib}/lib/qt-6/qml"))
     ];
   in lib.concatStringsSep ":" (qt6Paths ++ [ qt5Path ]);

    postBuild = ''
      wrapProgram $out/bin/quickshell \
        --set QML2_IMPORT_PATH "${qmlPath}" \
        --add-flags '-p ${./../../../configs/quickshell/kurukurubar}'
    '';

    meta.mainProgram = "quickshell";
  };
in 
{
#    _module.args.pkgs-master = import inputs.nixpkgs-master {
#      inherit (pkgs.stdenv.hostPlatform) system;
#      inherit (config.nixpkgs) config;
#    };
  environment.systemPackages = with pkgs;[
      ags_1
      brightnessctl # for brightness control
      libinput
      qsWrapper 
      #libinput-gestures
      starship
      cliphist
      eog
      gnome-system-monitor 
      file-roller
      grim
      #protonvpn-gui
      #hiddify-app
      #inputs.walker.packages.${pkgs.system}.default
      gtk-engine-murrine # for gtk themes
      hyprcursor # requires unstable channel
      hypridle # requires unstable channel
      imagemagick
      inxi
      jq
      kitty
      libsForQt5.qtstyleplugin-kvantum # kvantum
      pkgs-master.networkmanagerapplet
      nwg-look # requires unstable channel
      nwg-dock-hyprland
      #inputs.hyprswitch.packages.${pkgs.system}.default
      pkgs-master.pamixer
      pkgs-master.gitui
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
      pkgs-master.home-manager
      bluez-tools
      wgpu-utils
      gtk3
      gtk4
      atuin
      #bun
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
      tmux
      gtk4
      vivid
      (pkgs.callPackage ../../../pkgs/nitch.nix {})
      nurl
      yazi
      #firefox_nightly
      inputs.hyprsunset.packages.${pkgs.system}.hyprsunset
      pkgs-master.microfetch
      socat
      hyprpicker
      hyprpanel
      inputs.nyxexprs.packages.${pkgs.system}.ani-cli-git
    ];
}

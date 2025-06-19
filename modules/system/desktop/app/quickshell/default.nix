{
  inputs,
  pkgs,
  config,
  lib,
  ...
}: let
  inherit
    (lib)
    mkEnableOption
    mkOption
    types
    mkIf
    ;

  quickshellPackage = inputs.quickshell.packages.${pkgs.system}.default;

  qtDeps = with pkgs.kdePackages; [
    qtbase
    qtdeclarative
    qtmultimedia
    qtstyleplugin-kvantum
  ];

  qsWrapper = pkgs.symlinkJoin {
    name = "qs-wrapper";
    paths = [quickshellPackage];
    buildInputs = [pkgs.makeWrapper];

    postBuild = let
      qt6Qml = lib.concatMapStringsSep ":" (pkg: "${pkg}/lib/qt-6/qml") qtDeps;
      qt5Qml = "${pkgs.libsForQt5.qtstyleplugin-kvantum}/lib/qt-5/qml";
      qmlPath = "${qt6Qml}:${qt5Qml}";
    in ''
      wrapProgram $out/bin/quickshell \
        --set QML2_IMPORT_PATH "${qmlPath}" \
        --add-flags '-p ${./config/shell.qml}'
    '';
    meta.mainProgram = "quickshell";
  };
in {
  # Some addition qml module paths needed for qmlls and quickshell
  environment.variables = let
    extraQmlPaths = [
      # kirigami is wrapped, access the unwrapped version to retrieve binaries/source files
      "${pkgs.kdePackages.kirigami.passthru.unwrapped}/lib/qt-6/qml"
      "${inputs.quickshell.packages.${pkgs.system}.default}/lib/qt-6/qml/"
      "${pkgs.kdePackages.qtbase}/lib/qt-6/qml"
      "${pkgs.kdePackages.qtdeclarative}/lib/qt-6/qml"
    ];
  in {
    # May not need to append here since pretty much everything we need is included
    QML2_IMPORT_PATH = "$QML2_IMPORT_PATH:${lib.strings.concatStringsSep ":" extraQmlPaths}";
  };

  environment.systemPackages = with pkgs; [
    qsWrapper
    quickshellPackage
    libsForQt5.qtstyleplugin-kvantum
    kdePackages.qtstyleplugin-kvantum
    wlsunset
    libsForQt5.qt5.qtgraphicaleffects
    kdePackages.qt5compat
    kdePackages.qtbase
    kdePackages.qtdeclarative
    kdePackages.qtmultimedia
    libqalculate
    colloid-kde
    kdePackages.qt5compat # For Qt5Compat.GraphicalEffects
    # For styling QtQuick controls within Quickshell
    kdePackages.qqc2-desktop-style
    kdePackages.sonnet
    kdePackages.kirigami
    kdePackages.kirigami-addons # Not sure if this is needed
    # Icon theme
    kdePackages.breeze
  ];
}

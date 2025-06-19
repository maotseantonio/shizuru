{
  config,
  lib,
  pkgs,
  system,
  inputs,
  options,
  ...
}: {
  # Explicitly disable
  home.packages = with pkgs; [
    neovide
    libsForQt5.qtstyleplugin-kvantum
    kdePackages.qtstyleplugin-kvantum
    inputs.ags.packages.${pkgs.system}.agsFull
  ];
}

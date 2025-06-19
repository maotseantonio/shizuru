{
  inputs,
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    inputs.agsv1.homeManagerModules.agsv1
  ];
  programs.agsv1 = {
    enable = true;
    configPath = null;
  };
}

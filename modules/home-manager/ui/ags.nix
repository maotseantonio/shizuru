{
  inputs,
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    inputs.agsv1.homeManagerModules.agsv1
        #    inputs.qs-bar.homeManagerModules.quickshell
  ];
  programs.agsv1 = {
    enable = true;
    configPath = null;
  };
    #myQuickshell.enable = true;

}

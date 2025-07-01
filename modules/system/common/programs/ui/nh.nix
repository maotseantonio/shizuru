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
let
  nh = inputs.nh.packages.${pkgs.system}.default;
  custom-nh = nh.overrideAttrs (oldAttrs: {
    patches = (oldAttrs.patches or []) ++ [./nh_clean_show_output.patch];
  });
in {

  programs.nh = {
    enable = true;
    package = custom-nh;
    flake = "/home/antonio/shizuru/";
    clean = {
      enable = true;
      extraArgs = "--keep-since 3d --keep 3";
    };
  };
  environment.systemPackages = with pkgs; [
    nix-output-monitor
    nvd
  ];
}

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
  imports = [
     ./base
    ./common 
    ./drivers 
    ./system
    ./terminal
    ./media
    ./themes
    ./wm/hyprland 
    ./wm/niri 
  ];
}

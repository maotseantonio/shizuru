{
  pkgs,
  config,
  lib,
  inputs,
  ...
}: {
  services.cliphist = {
    enable = true;
    allowImages = true;
    systemdTarget = " config.wayland.systemd.target ";
  };
}

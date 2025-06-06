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
  cfg = config.system.bootloader-systemd;
in {
  options.system.bootloader-systemd = {
    enable = mkEnableOption "Enable Bootloader systemd-boot";
  };

  config = mkIf cfg.enable {
    boot = {
      loader.efi = {
        canTouchEfiVariables = true;
      };
      loader.timeout = 3;
      loader.systemd-boot = {
        enable = true;
        consoleMode = "auto";
        configurationLimit = 8;
      };
      tmp = {
        useTmpfs = false;
        tmpfsSize = "30%";
      };
      binfmt.registrations.appimage = {
        wrapInterpreterInShell = true;
        interpreter = "${pkgs.appimage-run}/bin/appimage-run";
        recognitionType = "magic";
        offset = 0;
        mask = ''\xff\xff\xff\xff\x00\x00\x00\x00\xff\xff\xff'';
        magicOrExtension = ''\x7fELF....AI\x02'';
      };
    };
  };
}

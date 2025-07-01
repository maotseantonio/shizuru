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
  cfg = config.system.kernel;
in {
  options.system.kernel = {
    enable = mkEnableOption "Enable custom kernel configuration";
  };

  config = mkIf cfg.enable {
    boot = {
      # Use CachyOS kernel with patched v4l2loopback
      kernelPackages = let
        apply = _: prevModules: {
          v4l2loopback =
            if strings.hasPrefix "0.13.2" prevModules.v4l2loopback.version
            then
              prevModules.v4l2loopback.overrideAttrs (_: rec {
                version = "0.15.0";
                src = pkgs.fetchFromGitHub {
                  owner = "umlaeute";
                  repo = "v4l2loopback";
                  rev = "v${version}";
                  hash = "sha256-fa3f8GDoQTkPppAysrkA7kHuU5z2P2pqI8dKhuKYh04=";
                };
              })
            else prevModules.v4l2loopback;
        };
      in
        pkgs.linuxPackages_cachyos.extend apply;

      consoleLogLevel = 0;

      kernelParams = [
        "quiet"
        "splash"
        "boot.shell_on_fail"
        "loglevel=0"
        "rd.udev.log_level=0"
        "rd.systemd.show_status=false"
        "udev.log_priority=3"
        "systemd.mask=systemd-vconsole-setup.service"
        "systemd.mask=dev-tpmrm0.device"
        "nowatchdog"
        "modprobe.blacklist=iTCO_wdt"
        "nohibernate"
      ];

      kernelModules = [
        "v4l2loopback"
        "kvm-intel"
        "drm"
        "i2c-dev"
      ];

      extraModulePackages = [
        config.boot.kernelPackages.v4l2loopback
      ];

      initrd = {
        verbose = false;
        availableKernelModules = [
          "xhci_pci"
          "ahci"
          "nvme"
          "usb_storage"
          "usbhid"
          "sd_mod"
        ];

        kernelModules = []; # GPU kernel modules removed here
      };
    };
  };
}

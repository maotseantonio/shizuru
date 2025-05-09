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
    enable = mkEnableOption "Enable kernel";
  };

  config = mkIf cfg.enable {
    boot = {
      kernelPackages = pkgs.linuxPackages_cachyos;
      #kernelPackages = pkgs.linuxKernel.packages.linux_zen.zfs_unstable;
      consoleLogLevel = 0;
      kernelParams = [
        "quiet"
        "splash"
        "boot.shell_on_fail"
        "loglevel=3"
        "rd.udev.log_level=3"
        "rd.systemd.show_status=false"
        "udev.log_priority=3"
        "systemd.mask=systemd-vconsole-setup.service"
        "systemd.mask=dev-tpmrm0.device"
        "nowatchdog"
        "nvidia-drm.modeset=1"
        "nvidia-drm.fbdev=1"
        "modprobe.blacklist=iTCO_wdt"
        "nohibernate"
        "i915.enable_guc=2"     # 2=GuC + HuC, 1=GuC only, 0=disable
        "i915.fastboot=1"       # Faster boot times
        "i915.enable_psr=0"
      ];
      kernelModules = ["v4l2loopback" "kvm-intel" "drm"];
      extraModulePackages = [config.boot.kernelPackages.v4l2loopback];
      initrd = {
        verbose = false;
        availableKernelModules = ["xhci_pci" "ahci" "nvme" "usb_storage" "usbhid" "sd_mod"];
        kernelModules = ["i915"];
      };
    };
  };
}

{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.drivers.intel;
in
  with lib; {
    options.drivers.intel.enable = mkEnableOption "Enable Intel Graphics Drivers";

    config = mkIf cfg.enable {
      environment.systemPackages = with pkgs; [
        vulkan-loader
        vulkan-validation-layers
        vulkan-tools
        libva-utils
      ];

      environment.variables = {
        LIBVA_DRIVER_NAME = "iHD";
        VDPAU_DRIVER = "va_gl";
        LIBVA_DRIVERS_PATH = "${pkgs.intel-media-driver}/lib/dri";
      };

      boot = {
        kernelModules = ["i915"];

        kernelParams = [
          "i915.enable_guc=2" # Enable GuC + HuC firmware loading
          "i915.fastboot=1" # Faster boot times
          "i915.enable_psr=0" # Disable Panel Self Refresh (fix flicker)
        ];
      };

      nixpkgs.config.packageOverrides = pkgs: {
        vaapiIntel = pkgs.vaapiIntel.override {enableHybridCodec = true;};
      };

      hardware.graphics = {
        enable = true;
        extraPackages = with pkgs; [
          intel-media-driver
          intel-vaapi-driver
          libva
          vaapiVdpau
          intel-compute-runtime
          libvdpau-va-gl
          mesa
        ];
      };
    };
  }

{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.drivers.nvidia-prime;
in
  with lib; {
    options.drivers.nvidia-prime = {
      enable = mkEnableOption "Enable NVIDIA Prime Hybrid GPU Offload";

      intelBusID = mkOption {
        type = types.str;
        default = "PCI:0:2:0";
        description = "Bus ID for Intel GPU (primary)";
      };

      nvidiaBusID = mkOption {
        type = types.str;
        default = "PCI:1:0:0";
        description = "Bus ID for NVIDIA GPU (secondary)";
      };
    };

    config = mkIf cfg.enable {
      environment.systemPackages = with pkgs; [
        vulkanPackages_latest.vulkan-loader
        vulkanPackages_latest.vulkan-validation-layers
        vulkanPackages_latest.vulkan-tools
        libva-utils
      ];

      hardware.nvidia.prime = {
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
        intelBusId = cfg.intelBusID;
        nvidiaBusId = cfg.nvidiaBusID;
      };
    };
  }

# Main default config
{
  config,
  pkgs,
  host,
  username,
  options,
  lib,
  inputs,
  outputs,
  system,
  ...
}: let
  inherit (import ./variables.nix) keyboardLayout;
  python-packages = pkgs.python3.withPackages (
    ps:
      with ps; [
        requests
        pyquery # needed for hyprland-dots Weather script
      ]
  );
in {
  imports = [
    ./hardware.nix
    ./users.nix
    ./hjem.nix
    ./themes.nix
    ../../modules
  ];

  #drivers.amdgpu.enable = false;
  drivers.intel.enable = true;
  drivers.nvidia.enable = true;
  drivers.nvidia-prime = {
    enable = true;
    intelBusID = "PCI:0:2:0";
    nvidiaBusID = "PCI:1:0:0";
  };
  vm.guest-services.enable = false;
  local.hardware-clock.enable = true;
  system.packages.enable = true;
  system.kernel.enable = true;
  system.bootloader-systemd.enable = true;
  system.bootloader-grub.enable = false;
  system.plymouth.enable = true;
  system.audio.enable = true;
  system.displayManager.enable = true;
  system.greetd.enable = false;
  system.powermanagement.enable = true;
  system.scheduler.enable = true;
  #myOptions.cliphist.enable = false;
  mine.hypridle.enable = false;
  #system.btrfs.enable = false;
  system.zfs.enable = true;
  system.zram.enable = true;
  #boot.loader.systemd-boot.enable = true;
  #boot.loader.efi.canTouchEfiVariables = true;
  catppuccin.tty.enable = true;
  programs.command-not-found.enable = true;
  services.xserver.videoDrivers = ["modesetting" "nvidia"];
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowBroken = true;
  users = {
    mutableUsers = true;
  };
  environment.systemPackages =
    (with pkgs; [
      libva-utils
      libvdpau-va-gl
      intel-compute-runtime
      intel-vaapi-driver
      vaapiVdpau
      vaapi-intel-hybrid
      mesa
      egl-wayland
      master.waybar # if wanted experimental next line
      #(pkgs.waybar.overrideAttrs (oldAttrs: { mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];}))
    ])
    ++ [
      python-packages
    ];
  # OpenGL
  hardware.graphics = {
    enable = true;
  };
  console.keyMap = "${keyboardLayout}";
  # For Electron apps to use wayland
  environment.variables = {
    VDAPU_DRIVER = lib.mkIf config.hardware.graphics.enable (lib.mkDefault "va_gl");
  };
  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  environment.sessionVariables = {
    EDITOR = "nvim";
    BROWSER = "firefox";
    TERMINAL = "wezterm";
    VISUAL = "vscodium";
    GSK_RENDERER = "gl";
    LIBVA_DRIVER_NAME = "nvidia";
    # Use NVIDIA for VDPAU           # Default to Intel for Wayland
    GBM_BACKEND = "nvidia-drm";
    NIXPKGS_ALLOW_UNFREE = "1";
    WLR_NO_HARDWARE_CURSORS = "1"; # Fix cursor issues in Hyprland
    __GLX_VENDOR_LIBRARY_NAME = "nvidia"; # NVIDIA GLX (when offloading)# Best for HD 620 (Kaby Lake)
  };
  system.stateVersion = "25.05"; # Did you read the comment?
}

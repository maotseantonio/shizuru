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
}:
let

  inherit (import ./variables.nix) keyboardLayout;
  python-packages = pkgs.python3.withPackages (
    ps: with ps; [
      requests
      pyquery # needed for hyprland-dots Weather script
    ]
  );

in
{
  imports = [
    ./hardware.nix
    ./users.nix
    ./hjem.nix
    ./../../modules/system/options/shizuru.nix
  ];

  nixpkgs.overlays = [
    

    (final: prev: {
      sf-mono-liga-bin = prev.stdenvNoCC.mkDerivation rec {
        pname = "sf-mono-liga-bin";
        version = "dev";
        src = inputs.sf-mono-liga-src;
        dontConfigure = true;
        installPhase = ''
          mkdir -p $out/share/fonts/opentype
          cp -R $src/*.otf $out/share/fonts/opentype/
        '';
      };
      pkgs-master = import inputs.nixpkgs-master {
         system = final.system;
         config.allowUnfree = true;
      };
   linuxPackages_cachyos = prev.linuxPackages_cachyos.extend (_: prev': {
    v4l2loopback = prev'.v4l2loopback.overrideAttrs (_: rec {
      version = "0.15.0";
      src = final.fetchFromGitHub {
        owner = "umlaeute";
        repo = "v4l2loopback";
        rev = "v${version}";
        hash = "sha256-fa3f8GDoQTkPppAysrkA7kHuU5z2P2pqI8dKhuKYh04=";
      };
    });
  });

    })
  ];
  
    _module.args.theme = {
      colors = inputs.basix.schemeData.base24.catppuccin-mocha.palette;
      fonts = {
        monospace = {
          package = pkgs.nerd-fonts.jetbrains-mono; # packaged by yours truly
          name = "JetBrainsMono Nerd Font";
        };
        sans = {
          package = pkgs.inter;
          name = "Inter";
          path = "${pkgs.inter}/share/fonts/truetype/Inter.ttc";
        };
        serif = {
          package = pkgs.roboto-serif;
          name = "Roboto Serif";
        };
        emoji = {
          package = pkgs.noto-fonts-color-emoji;
          name = "Noto Color Emoji";
        };
        cjk = {
          sans = {
            package = pkgs.noto-fonts-cjk-sans;
            name = "Noto Sans CJK SC";
          };
          serif = {
            package = pkgs.noto-fonts-cjk-serif;
            name = "Noto Serif CJK SC";
          };
        };
        size = 11;
      };
      wallpapers = {
        primary = "/home/antonio/Pictures/wallpapers/guts-5k-berserk-3840x2160-13631.jpg";
      };
    };
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
  #mine.hypridle.enable = true;
  #system.btrfs.enable = false;
  system.zfs.enable = true;
  system.zram.enable = true;
  #boot.loader.systemd-boot.enable = true;
  #boot.loader.efi.canTouchEfiVariables = true;
  catppuccin.tty.enable = true;
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
      pkgs-master.waybar # if wanted experimental next line
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
    LIBVA_DRIVER_NAME = "iHD";             # Use NVIDIA for VDPAU           # Default to Intel for Wayland
    NIXPKGS_ALLOW_UNFREE = "1";
    WLR_NO_HARDWARE_CURSORS = "1";       # Fix cursor issues in Hyprland
    __GLX_VENDOR_LIBRARY_NAME = "nvidia"; # NVIDIA GLX (when offloading)# Best for HD 620 (Kaby Lake)
  };
  system.stateVersion = "25.05"; # Did you read the comment?
}

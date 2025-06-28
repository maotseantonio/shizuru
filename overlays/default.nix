{
  inputs,
  system,
}: let
  nixpkgs-master = import inputs.nixpkgs-master {
    inherit system;
    config.allowUnfree = true;
  };
in [
  inputs.hyprpanel.overlay
  inputs.niri.overlays.niri
  inputs.nur.overlays.default
  inputs.custom-nixpkgs.overlays.default

  (final: prev: {
    stable = import inputs.nixpkgs-stable {
      inherit system;
      config.allowUnfree = true;
      config.nvidia.acceptLicense = true;
    };
    unstable = prev; # Explicit alias for nixos-unstable
    master = nixpkgs-master; # Already defined
    walker = inputs.walker.packages.${system}.default;
    quickshell = inputs.quickshell.packages.${system}.default;
    nvchad = inputs.nvchad4nix.packages.${system}.nvchad;
    zjstatus = inputs.zjstatus.packages.${system}.default;
    agsv1 = inputs.agsv1.legacyPackages.${system}.agsv1;
  })

  (final: prev: {
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
  })
]

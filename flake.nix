
{
  description = "MaotseNyein NixOS-Hyprland";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-master.url = "github:NixOS/nixpkgs/master";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";

    nix = {
      url = "github:NixOS/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    agsv1.url = "github:dtomvan/agsv1";
    agsv1.inputs.nixpkgs.follows = "nixpkgs";

    maomaowm.url = "github:DreamMaoMao/maomaowm";

    hycov = {
      url = "github:DreamMaoMao/hycov";
      inputs.hyprland.follows = "hyprland";
    };

    illogical-impulse = {
      url = "github:maotseantonio/end-4-dots";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    quickshell = {
      url = "github:outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lunarsLib = {
      url = "github:lunarnovaa/lunarslib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    astal-shell = {
      url = "github:knoopx/astal-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hjem = {
      url = "github:feel-co/hjem";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hjem-rum = {
      url = "github:snugnug/hjem-rum";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.hjem.follows = "hjem";
    };

    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    anyrun.url = "github:fufexan/anyrun/launch-prefix";

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-alien.url = "github:thiagokokada/nix-alien";
    wezterm.url = "github:wezterm/wezterm?dir=nix";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    catppuccin.url = "github:catppuccin/nix";
    walker.url = "github:abenz1267/walker";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-anywhere = {
      url = "github:numtide/nixos-anywhere";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.disko.follows = "disko";
    };

    matugen.url = "github:/InioX/Matugen";
    matugen.inputs.nixpkgs.follows = "nixpkgs";
    nvf.url = "github:notashelf/nvf";
    yazi.url = "github:sxyazi/yazi";

    sf-mono-liga-src = {
      url = "github:shaunsingh/SFMono-Nerd-Font-Ligaturized";
      flake = false;
    };

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    astal-bar = {
      url = "github:maotseantonio/astal-bar";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ags = {
      url = "github:aylur/ags";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    astal = {
      url = "github:aylur/astal";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "github:hyprwm/Hyprland";
    };
    
    hyprland-qt-support = {
        url = "github:hyprwm/hyprland-qt-support";
    };
    hyprland-qtutils = {
        url = "github:hyprwm/hyprland-qtutils";
    };
    hyprland-plugins = {
      url = "github:ItsOhen/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    hyprsunset.url = "github:hyprwm/hyprsunset";
    ghostty.url = "github:ghostty-org/ghostty";

    hyprpanel = {
      url = "github:Jas-SinghFSU/HyprPanel";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixcord.url = "github:kaylorben/nixcord";

    custom-nixpkgs = {
      url = "github:maotseantonio/custom-nixpkgs";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    textfox.url = "github:adriankarlen/textfox";
    hyprscroller = {
      url = "github:maotseantonio/hyprscroller";
      inputs.hyprland.follows = "hyprland";
    };

    hyprddm.url = "github:maotseantonio/hyprddm";

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
 
    ax-shell-config = {
      url = "github:maotseantonio/AX-Shell";
      flake = false;
    };

    nyxexprs.url = "github:notashelf/nyxexprs";
    nix-flatpak.url = "github:gmodena/nix-flatpak";

    nvchad4nix = {
      url = "github:MOIS3Y/nvchad4nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvchad-on-steroids = {
      url = "github:maotseantonio/nvchad_config";
      flake = false;
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nh.url = "github:viperML/nh";

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zjstatus.url = "github:dj95/zjstatus";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    nixpkgs-master,
    nixpkgs-stable,
    home-manager,
    chaotic,
    nur,
    ...
  }: let
    system = "x86_64-linux";
    host = "shizuru";
    username = "antonio";

    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };

    pkgs-master = import nixpkgs-master {
      inherit system;
      config.allowUnfree = true;
    };
  in {
    devShells = (pkgs: {
      quickshell = let
        qs = inputs.quickshell.packages.${pkgs.system}.default.override {
          withJemalloc = true;
          withQtSvg = true;
          withWayland = true;
          withX11 = false;
          withPipewire = true;
          withPam = true;
          withHyprland = true;
          withI3 = false;
        };
        qtDeps = [
          qs
          pkgs.kdePackages.qtbase
          pkgs.kdePackages.qtdeclarative
        ];
      in pkgs.mkShell {
        shellHook = let
          qmlPath = pkgs.lib.pipe qtDeps [
            (builtins.map (lib: "${lib}/lib/qt-6/qml"))
            (builtins.concatStringsSep ":")
          ];
        in ''
          export QML2_IMPORT_PATH="$QML2_IMPORT_PATH:${qmlPath}"
        '';
        buildInputs = qtDeps;
      };
    });

    nixosConfigurations = {
      shizuru = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit system inputs username host chaotic pkgs-master;
        };
        modules = [
          ./hosts/${host}/config.nix
          inputs.chaotic.nixosModules.default
          inputs.home-manager.nixosModules.home-manager
          inputs.stylix.nixosModules.stylix
          inputs.catppuccin.nixosModules.catppuccin
          inputs.nixos-hardware.nixosModules.huawei-machc-wa
          inputs.nvf.nixosModules.default
          inputs.maomaowm.nixosModules.maomaowm

          {
            nixpkgs.overlays = import ./overlays {
              inherit inputs system;
            };
          }
        ];
      };
    };
  };
}

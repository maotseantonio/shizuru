{
  description = "MaotseNyein NixOS-Hyprland";

  inputs = {
    # Core Nixpkgs sources
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-master.url = "github:NixOS/nixpkgs/master";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";
    font-flake.url = "github:redyf/font-flake";
    # Fish shell flake
    fish-flake = {
      url = "github:maotseantonio/fish-flakes";
    };
    #anyrun related flakes
    custom-nixpkgs = {
      url = "github:maotseantonio/custom-nixpkgs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # izLix module
    izlix = {
      type = "github"; # legacy-style declaration (optional)
      owner = "isabelroses";
      repo = "izlix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };

    # Personal packages and cursors
    shizuruPkgs.url = "github:maotseantonio/shizuruPkgs";
    kureiji-ollie-cursor.url = "github:maotseantonio/Kureiji-Ollie-Cursors";
    waifu-cursors.url = "github:maotseantonio/waifu-cursors";

    # Modules and utilities
    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.93.0.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-programs-sqlite = {
      url = "github:wamserma/flake-programs-sqlite";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-anywhere = {
      url = "github:numtide/nixos-anywhere";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.disko.follows = "disko";
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvf.url = "github:notashelf/nvf";
    nix-flatpak.url = "github:gmodena/nix-flatpak";
    nvchad4nix = {
      url = "github:MOIS3Y/nvchad4nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    matugen = {
      url = "github:/InioX/Matugen";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    anyrun-fufexan.url = "github:fufexan/anyrun/launch-prefix";
    walker.url = "github:abenz1267/walker";
    yazi.url = "github:sxyazi/yazi";

    # Hyprland ecosystem
    hyprland.url = "github:hyprwm/Hyprland";
    hypridle.url = "github:hyprwm/hypridle";
    hyprlock.url = "github:hyprwm/hyprlock";
    hyprsunset.url = "github:hyprwm/hyprsunset";
    hyprland-qt-support.url = "github:hyprwm/hyprland-qt-support";
    hyprland-qtutils.url = "github:hyprwm/hyprland-qtutils";

    hyprland-plugins = {
      url = "github:ItsOhen/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    hyprpanel = {
      url = "github:Jas-SinghFSU/HyprPanel";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprscroller = {
      url = "github:maotseantonio/hyprscroller";
      inputs.hyprland.follows = "hyprland";
    };

    hyprddm.url = "github:maotseantonio/hyprddm";

    # Other tools / DE components
    maomaowm.url = "github:DreamMaoMao/maomaowm";
    hycov = {
      url = "github:DreamMaoMao/hycov";
      inputs.hyprland.follows = "hyprland";
    };

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    quickshell = {
      url = "github:outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    astal = {
      url = "github:aylur/astal";
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

    agsv1 = {
      url = "github:dtomvan/agsv1";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lunarsLib = {
      url = "github:lunarnovaa/lunarslib";
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

    # Themes, overlays, fonts
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    catppuccin.url = "github:catppuccin/nix";
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    sf-mono-liga-src = {
      url = "github:shaunsingh/SFMono-Nerd-Font-Ligaturized";
      flake = false;
    };

    ax-shell-config = {
      url = "github:maotseantonio/AX-Shell";
      flake = false;
    };

    nvchad-on-steroids = {
      url = "github:maotseantonio/nvchad_config";
      flake = false;
    };

    illogical-impulse = {
      url = "github:maotseantonio/end-4-dots";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    wayland-pipewire-idle-inhibit = {
      url = "github:rafaelrc7/wayland-pipewire-idle-inhibit";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ghostty.url = "github:ghostty-org/ghostty";
    nixcord.url = "github:kaylorben/nixcord";
    textfox.url = "github:adriankarlen/textfox";
    nh = {
        url = "github:nix-community/nh/better-env-handling";
        inputs.nixpkgs.follows = "nixpkgs";
     };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    swww = {
      url = "github:LGFae/swww/v0.10.3";
    };

    sddm-stray.url = "github:maotseantonio/sddm-stray-flakes";
    nix-alien.url = "github:thiagokokada/nix-alien";
    wezterm.url = "github:wezterm/wezterm?dir=nix";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    nyxexprs.url = "github:notashelf/nyxexprs";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    nixpkgs-master,
    nixpkgs-stable,
    home-manager,
    chaotic,
    nur,
    lix-module,
    quickshell,
    ...
  }: let
    system = "x86_64-linux";
    host = "shizuru";
    username = "antonio";

    # Import nixpkgs for main and master channels
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };

    pkgs-master = import nixpkgs-master {
      inherit system;
      config.allowUnfree = true;
    };
  in {
    # Development shell for quickshell QML development
    devShells.${system} = {
      quickshell = let
        qs = quickshell.packages.${system}.default.override {
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
          pkgs.qt6.qtbase
          pkgs.qt6.qtdeclarative
        ];
      in
        pkgs.mkShell {
          name = "quickshell-dev";
          nativeBuildInputs = qtDeps;
          shellHook = let
            qmlPath = pkgs.lib.makeSearchPath "lib/qt-6/qml" qtDeps;
          in ''
            export QML2_IMPORT_PATH="$QML2_IMPORT_PATH:${qmlPath}"
          '';
        };
    };

    # NixOS configuration for host 'shizuru'
    nixosConfigurations = {
      shizuru = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit system inputs username host chaotic pkgs-master;
        };
        modules = [
          ./hosts/${host}/config.nix
          inputs.chaotic.nixosModules.default
          #inputs.fish-flake.nixosModules.myfish
          inputs.home-manager.nixosModules.home-manager
          inputs.stylix.nixosModules.stylix
          inputs.catppuccin.nixosModules.catppuccin
          inputs.nixos-hardware.nixosModules.huawei-machc-wa
          inputs.nvf.nixosModules.default
          lix-module.nixosModules.default
          inputs.maomaowm.nixosModules.maomaowm
          inputs.flake-programs-sqlite.nixosModules.programs-sqlite
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

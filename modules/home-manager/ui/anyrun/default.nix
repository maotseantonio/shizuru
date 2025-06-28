{
  pkgs,
  inputs,
  ...
}: {
  programs.anyrun = {
    enable = true;
    package = inputs.anyrun.packages.${pkgs.system}.default;

    config = {
      plugins = with inputs.anyrun-fufexan.packages.${pkgs.system}; [
        uwsm_app
        randr
        rink
        shell
        symbols
        inputs.anyrun-nixos-options.packages.${pkgs.system}.default
      ];

      width.fraction = 0.25;
      y.fraction = 0.3;
      hidePluginInfo = true;
      closeOnClick = true;
    };

    extraCss = builtins.readFile (./. + "/style-dark.css");

    extraConfigFiles = {
      "uwsm_app.ron".text = ''
        Config(
          desktop_actions: false,
          max_entries: 5,
        )
      '';

      "shell.ron".text = ''
        Config(
          prefix: ">"
        )
      '';

      "randr.ron".text = ''
        Config(
          prefi: ":dp",
          max_entries: 5,
        )
      '';
       "nixos-options.ron".text = let
        #               ↓ home-manager refers to the nixos configuration as osConfig
            nixos-options = osConfig.system.build.manual.optionsJSON + "/share/doc/nixos/options.json";
        # merge your options
            options = builtins.toJSON {
          ":nix" = [nixos-options];
        };
        # or alternatively if you wish to read any other documentation options, such as home-manager
        # get the docs-json package from the home-manager flake
        # hm-options = inputs.home-manager.packages.${pkgs.system}.docs-json + "/share/doc/home-manager/options.json";
        # options = builtins.toJSON {
        #   ":nix" = [nixos-options];
        #   ":hm" = [hm-options];
        #   ":something-else" = [some-other-option];
        #   ":nall" = [nixos-options hm-options some-other-option];
        # };

    in ''
        Config(
            // add your option paths
            options: ${options},
         )
    '';
    };
  };
}

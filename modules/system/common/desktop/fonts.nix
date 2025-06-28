{
  pkgs,
  theme,
  inputs,
  ...
}: let
  inherit (theme) fonts;

  fallbackPackages = [
    pkgs.corefonts
    pkgs.vistafonts
  ];
  fallbackFonts = [
    "JetBrainsMono Nerd Font"
    "corefonts"
    "vistafonts"
  ];
in {
  fonts = {
    enableDefaultPackages = false;
    packages = with pkgs;
      [
        noto-fonts
        #fira-code
        noto-fonts-cjk-sans
        jetbrains-mono
        material-icons
        sf-mono-liga-bin
        font-awesome
        #terminus_font
        #nerd-fonts.monaspace
        nerd-fonts.jetbrains-mono
        nerd-fonts.caskaydia-cove
        #nerd-fonts.iosevka
        material-symbols
        material-design-icons
        nerd-fonts.caskaydia-mono
        nerd-fonts.iosevka-term-slab
        #iosevka-bin
        nerd-fonts.lilex
      ]
      ++ fallbackPackages;
    fontconfig = {
      defaultFonts = {
        serif =
          [
            "JetBrainsMono Nerd Font"
          ]
          ++ fallbackFonts;
        sansSerif =
          [
            "JetBrainsMono Nerd Font"
          ]
          ++ fallbackFonts;
        monospace = [
          "JetBrainsMono Nerd Font"
        ];
      };
    };
  };
}

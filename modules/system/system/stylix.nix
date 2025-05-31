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
{
  stylix.enable = true;
  stylix.autoEnable = false;
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-dark.yaml";
  stylix = {
      targets = {
          gtk.enable = true;
          nixos-icons.enable = true;
          #kitty.enable = true;
          #ghostty.enable = true;
          #wezterm.enable = true;
      };
  };
  stylix.polarity = "dark";
  stylix.image = "/home/antonio/Pictures/wallpapers/Catpuccin_carv1.png";
  stylix = {
    fonts = {
      sizes = {
        terminal = 14;
        applications = 13;
        popups = 13;
      };

      serif = {
        name = "JetBrainsMono Nerd Font";
        package = pkgs.nerd-fonts.jetbrains-mono;
      };

      sansSerif = {
        name = "JetBrainsMono Nerd Font";
        package = pkgs. nerd-fonts.jetbrains-mono;
      };

      monospace = {
        package = pkgs. nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font";
      };

      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
    };
  };
}

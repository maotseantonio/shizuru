{
  pkgs,
  config,
  lib,
  inputs,
  ...
}: {
  hj.rum.programs.ghostty = {
    enable = true;
    settings = {
      font-family = "JetBrainsMono Nerd Font";
      font-size = 14;
      font-thicken = true;
      bold-is-bright = false;
      adjust-box-thickness = 1;
      theme = "catppuccin-mocha";
      background-opacity = 1.0;
      cursor-style = "bar";
      cursor-style-blink = true;
      adjust-cursor-thickness = 1;
      copy-on-select = false;
      confirm-close-surface = false;
      window-theme = "ghostty";
      window-padding-x = 4;
      window-padding-y = 6;
      window-padding-balance = true;
      window-padding-color = "background";
      window-inherit-working-directory = true;
      window-inherit-font-size = true;
      window-decoration = false;
      gtk-titlebar = false;
      gtk-single-instance = true;
      gtk-tabs-location = "bottom";
      gtk-wide-tabs = false;
      keybind = [
        "ctrl+d=new_split:right"
        "ctrl+f=new_split:down"
      ];
    };
    themes = {
      catppuccin-mocha = {
        palette = [
          " 0=#414868 "
          " 1=#f7768e "
          " 2=#9ece6a "
          " 3=#e0af68 "
          " 4=#7aa2f7 "
          " 5=#bb9af7 "
          " 6=#7dcfff "
          " 7=#c0caf5 "
          " 8=#414868 "
          " 9=#f7768e "
          " 10=#9ece6a"
          " 11=#e0af68"
          " 12=#7aa2f7"
          " 13=#bb9af7"
          " 14=#7dcfff"
          " 15=#c0caf5"
        ];
        background = "#11121D";
        foreground = "#CDD6F4";
        cursor-color = "#E78284";
        cursor-text = "#CDD6F4";
        selection-background = "#11121D";
        selection-foreground = "#CDD6F4";
      };
    };
  };
}

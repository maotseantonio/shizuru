{
  inputs,
  config,
  pkgs,
  lib,
  ...
}: {
  hj.rum.programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        include = "/home/antonio/.config/fuzzel/rosewater.ini";
        font = "JetBrainsMono Nerd Font:size=8";
        anchor = "top-left";
        prompt = " 󰊠 Applications:";
        width = "35";
        horizontal-pad = "10";
        vertical-pad = "10";
        inner-pad = "10";
        line-height = "20";
        lines = "8";
        letter-spacing = "0.5";
        icons-enabled = "yes";
        icon-theme = "Papirus-Dark";
        image-size-ratio = "1.0";
        x-margin = "10";
        y-margin = "10";
        match-counter = "yes";
        filter-desktop = "yes";
        layer = "overlay";
      };
    };
  };
}

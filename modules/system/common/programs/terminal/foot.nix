{ lib, config, pkgs, inputs, ... }:
let
  cfg = config.modules.terminal.foot;
in {
  options.modules.terminal.foot.enable = lib.mkEnableOption "Enable foot module";

  config = lib.mkIf cfg.enable {
    
      hj.rum.programs.foot = {
        enable = true;
        settings = {
          main = {
            term = "foot";
            font = "IoshelfkaMono Nerd Font:size=14";
            include = "/home/antonio/.config/foot/catppuccin-mocha.ini";
          };
          mouse = {
            hide-when-typing = "yes";
          };
          colors = {
            alpha = 0.98;
          };
          key-bindings = {
            font-increase = "Mod1+Shift+k";
            font-decrease = "Mod1+Shift+j";
            search-start = "Mod1+Shift+f";
            clipboard-copy = "Mod1+c";
            clipboard-paste = "Mod1+v";
            scrollback-up-half-page = "Mod1+k";
            scrollback-down-half-page = "Mod1+j";
            show-urls-launch = "Mod1+Shift+l";
            prompt-prev = "Mod1+Shift+z";
            prompt-next = "Mod1+Shift+x";
            spawn-terminal = "Mod1+Shift+n";
          };
          scrollback = {
            indicator-position = "fixed";
            indicator-format = "percentage";
          };
        };
      };
  };
}

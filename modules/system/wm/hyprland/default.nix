{
  pkgs,
  lib,
  config,
  inputs,
    ...
}:{
    imports = [
      ./bind.nix
      ./hyprland.nix
      #./hyprpanel.nix
    ];
       
    hj.rum.programs.hyprland = {
          enable = true;
          extraConfig = ''
                   $configs = $HOME/.config/hypr/configs
                   source=$configs/Settings.conf
                   $UserConfigs = $HOME/.config/hypr/UserConfigs
                   source= $UserConfigs/Startup_Apps.conf
                   source= $UserConfigs/ENVariables.conf
                   source= $UserConfigs/Monitors.conf 
                   source= $UserConfigs/LaptopDisplay.conf
                   source= $UserConfigs/Laptops.conf
                   source= $UserConfigs/WindowRules.conf
                   source= $UserConfigs/UserDecorAnimations.conf
                   source= $UserConfigs/UserSettings.conf
                   source= $UserConfigs/WorkspaceRules.conf
                   source= $HOME/.config/hypr/themes/mocha.conf
            '';

   };
    hj.rum.programs.hyprland = {
           plugins = [
              #inputs.hyprland-plugins.packages.${pkgs.system}.borders-plus-plus
              inputs.hyprscroller.packages.${pkgs.system}.hyprscroller
              #inputs.hyprland-plugins.packages.${pkgs.system}.hyprscrolling 
          ];
     };  
      hj.rum.programs.hyprland.settings = {
          exec-once = [
             "hyprpanel"
             "uwsm finalize"
             "hyprctl setcursor LyraR-cursors 34"
             "wl-paste --type text --watch cliphist store"  
             "wl-paste --type image --watch cliphist store"
             "systemctl --user start walker"
             "systemctl --user start hypridle"
             "systemctl --user start cliphist"
             "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
             "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP" 
             "dbus-update-activation-environment --all"
];
          bind = [
             "SUPER, tab, exec, ${pkgs.ags_1}/bin/ags -t 'overview' "
          ];
        };
}

{
  config,
  pkgs,
  inputs,
  ...
}: let 
  set-volume = "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@";
  brillo = "${pkgs.brillo}/bin/brillo" "-q" "-u" "300000";
  playerctl = "${pkgs.playerctl}/bin/playerctl";
  control-center = "env" "XDG_CURRENT_DESKTOP=gnome" "gnome-control-center";
  walkern = "${inputs.walker.packages.${pkgs.system}.default}/bin/walker";
  wallPicker = "walker" "-m" "wallpaper";
  walker-clip = "niri-clip";
  wallpaperScript = pkgs.writeScriptBin "niri-wallpaper" (builtins.readFile ./wallpaperAutoChange.sh);
in ''
  binds {
    XF86AudioMute         { spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle"; }
    XF86AudioMicMute      { spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle"; }
    XF86AudioPlay         { spawn "playerctl" "play-pause"; }
    XF86AudioStop         { spawn "playerctl" "pause"; }
    XF86AudioPrev         { spawn "playerctl" "previous"; }
    XF86AudioNext         { spawn "playerctl" "next"; }
    XF86AudioRaiseVolume  { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%+"; }
    XF86AudioLowerVolume  { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%-"; }
    XF86MonBrightnessUp   { spawn "brightness" "--inc"; }
    XF86MonBrightnessDown { spawn "brightness" "--dec"; }
    Print { screenshot-screen; }
    Mod+Shift+Alt+S { screenshot-window; }
    Mod+Shift+S { screenshot; }
    Mod+D                 { spawn "walker"; }
    Mod+R                 { spawn "fuzzel"; }
    Mod+N                 { spawn "toggle-waybar"; }
    Mod+Return            { spawn "wezterm"; }
    Mod+X                 { spawn "walker" "-m" "power"; }
    Alt+Tab               { spawn "walker" "-m" "windows"; }
    Mod+Shift+X           { spawn "ani-cli" "--rofi"; }
    Alt+Space             { spawn "${pkgs.anyrun}/bin/anyrun"; }
    Mod+Shift+Return      { spawn "ghostty"; }
    Ctrl+Alt+L            { spawn "hyprlock"; }
    Mod+T                 { spawn "thunar"; }
    Mod+U                 { spawn "env" "XDG_CURRENT_DESKTOP=gnome" "gnome-control-center"; }
    Mod+E                 { spawn "walker" "-m" "wallpaper"; }
    Mod+Backspace         { spawn "wlogout-new"; }
    Mod+B                 { spawn "eww-bar"; }
    Mod+Q                 { close-window; }
    Mod+S                 { switch-preset-column-width; }
    Mod+F                 { maximize-column; }
    Mod+M                 { spawn "niri-edit"; }
    Mod+Shift+F           { expand-column-to-available-width; }
    Mod+Space             { toggle-window-floating; }
    Mod+W                 { toggle-column-tabbed-display; }
    Mod+V                 { spawn "walker" "-m" "clipboard"; }
    Mod+Comma             { consume-window-into-column; }
    Mod+Period            { expel-window-from-column; }
    Mod+C                 { center-window; }
    Mod+Tab               { switch-focus-between-floating-and-tiling; }
    Mod+Minus             { set-column-width "-10%"; }
    Mod+Equal             { set-column-width "+10%"; }
    Mod+Shift+Minus       { set-window-height "-10%"; }
    Mod+Shift+Equal       { set-window-height "+10%"; }
    Mod+H                 { focus-column-left; }
    Mod+L                 { focus-column-right; }
    Mod+J                 { focus-window-or-workspace-down; }
    Mod+K                 { focus-window-or-workspace-up; }
    Mod+Left              { focus-column-left; }
    Mod+Right             { focus-column-right; }
    Mod+Down              { focus-workspace-down; }
    Mod+Up                { focus-workspace-up; }
    Mod+Shift+H           { move-column-left; }
    Mod+Shift+L           { move-column-right; }
    Mod+Shift+K           { move-column-to-workspace-up; }
    Mod+Shift+J           { move-column-to-workspace-down; }
    Mod+Shift+Ctrl+J      { move-column-to-monitor-down; }
    Mod+Shift+Ctrl+K      { move-column-to-monitor-up; }
    Mod+1 { focus-workspace 1; }
    Mod+2 { focus-workspace 2; } 
    Mod+3 { focus-workspace 3; }
 }
''

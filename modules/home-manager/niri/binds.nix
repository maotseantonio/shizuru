{
  config,
  inputs,
  pkgs,
  ...
}: {
  programs.niri.settings.binds = with config.lib.niri.actions; let
    set-volume = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@";
    brillo = spawn "${pkgs.brillo}/bin/brillo" "-q" "-u" "300000";
    playerctl = spawn "${pkgs.playerctl}/bin/playerctl";
    control-center = spawn "env" "XDG_CURRENT_DESKTOP=gnome" "gnome-control-center";
    walkern = spawn "${inputs.walker.packages.${pkgs.system}.default}/bin/walker";
    wallPicker = spawn "walker" "-m" "wallpaper";
    walker-clip = spawn "niri-clip";
    brightness-up = spawn "~/.local/bin/brightness" "--inc";
    brightness-down = spawn "~/.local/bin/brightness" "--dec";
    wlogout-new = spawn "~/.local/bin/wlogout-new";
    eww-bar = spawn "~/.local/bin/eww-bar";
    toggle-waybar = spawn "~/.local/bin/toggle-waybar";
  in {
    "XF86AudioMute".action = spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle";
    "XF86AudioMicMute".action = spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle";

    "XF86AudioPlay".action = playerctl "play-pause";
    "XF86AudioStop".action = playerctl "pause";
    "XF86AudioPrev".action = playerctl "previous";
    "XF86AudioNext".action = playerctl "next";

    "XF86AudioRaiseVolume".action = set-volume "5%+";
    "XF86AudioLowerVolume".action = set-volume "5%-";

    "XF86MonBrightnessUp".action = brightness-up;
    "XF86MonBrightnessDown".action = brightness-down;

    "Print".action.screenshot-screen = {write-to-disk = true;};
    "Mod+Shift+Alt+S".action = screenshot-window;
    "Mod+Shift+S".action = screenshot;
    "Mod+D".action = spawn "${inputs.walker.packages.${pkgs.system}.default}/bin/walker";
    "Mod+N".action = toggle-waybar;
    "Mod+Return".action = spawn "wezterm";
    "Mod+X".action = walkern "-m" "power";
    "Alt+Tab".action = walkern "-m" "windows";
    "Mod+Shift+X".action = spawn "ani-cli" "--rofi";
    "Alt+Space".action = spawn "fuzzel";
    "Mod+Shift+Return".action = spawn "kitty";
    "Ctrl+Alt+L".action = spawn "hyprlock";
    "Mod+T".action = spawn "thunar";
    "Mod+U".action = control-center;
    "Mod+E".action = wallPicker;
    "Mod+Backspace".action = wlogout-new;
    "Mod+B".action = eww-bar;
    "Mod+Q".action = close-window;
    "Mod+S".action = switch-preset-column-width;
    "Mod+F".action = maximize-column;
    "Mod+M".action = spawn "niri-edit";
    "Mod+Shift+Space".action = fullscreen-window;
    "Mod+Shift+F".action = expand-column-to-available-width;
    "Mod+Space".action = toggle-window-floating;
    "Mod+W".action = toggle-column-tabbed-display;
    "Mod+V".action = walkern "-m" "clipboard";
    "Mod+Comma".action = consume-window-into-column;
    "Mod+Period".action = expel-window-from-column;
    "Mod+C".action = center-window;
    "Mod+Tab".action = switch-focus-between-floating-and-tiling;

    "Mod+1".action = focus-workspace 1;
    "Mod+2".action = focus-workspace 2;
    "Mod+3".action = focus-workspace 3;
    "Mod+4".action = focus-workspace 4;
    "Mod+5".action = focus-workspace 5;
    "Mod+6".action = focus-workspace 6;
    "Mod+7".action = focus-workspace 7;
    "Mod+8".action = focus-workspace 8;
    "Mod+9".action = focus-workspace 9;
    "Mod+Minus".action = set-column-width "-10%";
    "Mod+Equal".action = set-column-width "+10%";
    "Mod+Shift+Minus".action = set-window-height "-10%";
    "Mod+Shift+Equal".action = set-window-height "+10%";

    "Mod+H".action = focus-column-left;
    "Mod+L".action = focus-column-right;
    "Mod+J".action = focus-window-or-workspace-down;
    "Mod+K".action = focus-window-or-workspace-up;
    "Mod+Left".action = focus-column-left;
    "Mod+Right".action = focus-column-right;
    "Mod+Down".action = focus-workspace-down;
    "Mod+Up".action = focus-workspace-up;

    "Mod+Shift+H".action = move-column-left;
    "Mod+Shift+L".action = move-column-right;
    "Mod+Shift+K".action = move-column-to-workspace-up;
    "Mod+Shift+J".action = move-column-to-workspace-down;

    "Mod+Shift+Ctrl+J".action = move-column-to-monitor-down;
    "Mod+Shift+Ctrl+K".action = move-column-to-monitor-up;
  };
}

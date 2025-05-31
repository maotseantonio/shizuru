{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: {
  hj.rum.programs.hyprland.settings = {
    "$mainMod" = "SUPER";
    "$scriptsDir" = "$HOME/.config/hypr/scripts";
    "$configs" = "$HOME/.config/hypr/configs";
    "$UserConfigs" = "$HOME/.config/hypr/UserConfigs";
    "$UserScripts" = "$HOME/.config/hypr/UserScripts";
    "$files" = "thunar";
    "$term" = "wezterm-gui";
    #bindr = [
     # "$mainMod , $mainMod_L , exec , pkill rofi || rofi -show drun -modi drun,filebrowser,run,window"
    #];
    bindr = [
      "$mainMod , $mainMod_L, exec , pkill fuzzel || fuzzel"
    ];
    bind = [
      # Default Keybinds
      "CTRL ALT , Delete , exec , hyprctl dispatch exit 0"
      "$mainMod , Q , killactive ,"
      "ALT , F , fullscreen ,"
      "$mainMod SHIFT , Q , exec , $scriptsDir/KillActiveProcess.sh"
      "$mainMod , Space , togglefloating ,"
      "$mainMod ALT , F , exec , hyprctl dispatch workspaceopt allfloat"
      "$mainMod , X , exec , pkill rofi || ags -b hyprpanel -t \"powermenu\""
      "$mainMod , Backspace , exec , wlogout-new"

      # Features / Extras
      "$mainMod SHIFT , H , exec , $UserScripts/RofiBeats.sh"
      "$mainMod ALT , R , exec , $scriptsDir/Refresh.sh"
      "$mainMod ALT , E , exec , $scriptsDir/RofiEmoji.sh"
      "$mainMod , S , exec , $scriptsDir/RofiSearch.sh"
      "$mainMod SHIFT , B , exec , $scriptsDir/ChangeBlur.sh"
      "$mainMod SHIFT , G , exec , $scriptsDir/GameMode.sh"
      "$mainMod ALT , L , exec , $scriptsDir/ChangeLayout.sh"
      "$mainMod SHIFT , N , exec , pkill -SIGUSR1 waybar"

      # UserScripts
      "$mainMod , E , exec , $UserScripts/QuickEdit.sh"
      "$mainMod SHIFT , M , exec , pkill rofi || $HOME/.config/rofi/applets/bin/mpd.sh"
      "$mainMod , W , exec , $UserScripts/WallpaperSelect.sh"
      "$mainMod SHIFT , W , exec , $UserScripts/WallpaperEffects.sh"
      "CTRL ALT , W , exec , $UserScripts/WallpaperRandom.sh"
      "$mainMod ALT , O , exec , hyprctl setprop active opaque toggle"
      "$mainMod SHIFT , K , exec , $scriptsDir/KeyBinds.sh"

      # Waybar
      "$mainMod CTRL , B , exec , $scriptsDir/WaybarStyles.sh"
      "$mainMod ALT , B , exec , $scriptsDir/WaybarLayout.sh"

      # Master Layout
      "$mainMod CTRL , D , layoutmsg , removemaster"
      # "$mainMod , I , layoutmsg , addmaster"
      # "$mainMod , J , layoutmsg , cyclenext"
      # "$mainMod , K , layoutmsg , cycleprev"
      "$mainMod , M , exec , hyprctl dispatch splitratio 0.3"
      "$mainMod , P , pseudo ,"
      "$mainMod CTRL , Return , layoutmsg , swapwithmaster"

      # Group
      "$mainMod , G , togglegroup ,"
      "$mainMod CTRL , tab , changegroupactive ,"

      # Window Cycling
      "ALT , tab , cyclenext ,"
      "ALT , tab , bringactivetotop ,"

      # Media Keys
      ", xf86audioraisevolume , exec , $scriptsDir/Volume.sh --inc"
      ", xf86audiolowervolume , exec , $scriptsDir/Volume.sh --dec"
      ", xf86AudioMicMute , exec , $scriptsDir/TouchPad.sh"
      ", xf86audiomute , exec , $scriptsDir/Volume.sh --toggle"
      ", xf86Sleep , exec , systemctl suspend"
      ", xf86Rfkill , exec , $scriptsDir/AirplaneMode.sh"
      ", xf86AudioPlayPause , exec , $scriptsDir/MediaCtrl.sh --pause"
      ", xf86AudioNext , exec , $scriptsDir/MediaCtrl.sh --nxt"
      ", xf86AudioPrev , exec , $scriptsDir/MediaCtrl.sh --prv"
      ", xf86audiostop , exec , $scriptsDir/MediaCtrl.sh --stop"

      # Screenshots
      "$mainMod SHIFT , Print , exec , $scriptsDir/ScreenShot.sh --area"
      "$mainMod CTRL , Print , exec , $scriptsDir/ScreenShot.sh --in5"
      "$mainMod CTRL SHIFT , Print , exec , $scriptsDir/ScreenShot.sh --in10"
      "ALT , Print , exec , $scriptsDir/ScreenShot.sh --active"
      ", Print , exec , ~/.config/hypr/screenshot.sh full"
      "$mainMod SHIFT , S , exec , $scriptsDir/ScreenShot.sh --swappy"

      # Window Resize
      # "$mainMod , Minus , resizeactive , -150 0"
      # "$mainMod , Equal , resizeactive , 150 0"
      "$mainMod SHIFT , up , resizeactive , 0 -50"
      "$mainMod SHIFT , down , resizeactive , 0 50"

      # Window Move
      "$mainMod CTRL , left , movewindow , l"
      "$mainMod CTRL , right , movewindow , r"
      "$mainMod CTRL , up , movewindow , u"
      "$mainMod CTRL , down , movewindow , d"

      # Focus Movement
      # "$mainMod , j , movefocus , d"
      # "$mainMod , k , movefocus , u"
      # "$mainMod , h , movefocus , l"
      # "$mainMod , l , movefocus , r"
      # "$mainMod , up , movefocus , u"
      # "$mainMod , down , movefocus , d"
      # "$mainMod , right , movefocus , r"
      # "$mainMod , left , movefocus , l"
      #
      # Workspaces
      "$mainMod , grave , workspace , m-1"
      # "$mainMod , up , workspace , r-1"
      # "$mainMod , down , workspace , r+1"
      "$mainMod SHIFT , U , movetoworkspace , special"
      "$mainMod , U , togglespecialworkspace ,"

      # Workspace Numbers (code:10 = 1, code:11 = 2, etc.)
      "$mainMod , code:10 , workspace , 1"
      "$mainMod , code:11 , workspace , 2"
      "$mainMod , code:12 , workspace , 3"
      "$mainMod , code:13 , workspace , 4"
      "$mainMod , code:14 , workspace , 5"
      "$mainMod , code:15 , workspace , 6"
      "$mainMod , code:16 , workspace , 7"
      "$mainMod , code:17 , workspace , 8"
      "$mainMod , code:18 , workspace , 9"
      "$mainMod , code:19 , workspace , 10"

      # Move to Workspace
      "$mainMod SHIFT , code:10 , movetoworkspace , 1"
      "$mainMod SHIFT , code:11 , movetoworkspace , 2"
      "$mainMod SHIFT , code:12 , movetoworkspace , 3"
      "$mainMod SHIFT , code:13 , movetoworkspace , 4"
      "$mainMod SHIFT , code:14 , movetoworkspace , 5"
      "$mainMod SHIFT , code:15 , movetoworkspace , 6"
      "$mainMod SHIFT , code:16 , movetoworkspace , 7"
      "$mainMod SHIFT , code:17 , movetoworkspace , 8"
      "$mainMod SHIFT , code:18 , movetoworkspace , 9"
      "$mainMod SHIFT , code:19 , movetoworkspace , 10"
      "$mainMod SHIFT , bracketleft , movetoworkspace , -1"
      "$mainMod SHIFT , bracketright , movetoworkspace , +1"

      # Move to Workspace Silent
      "$mainMod CTRL , code:10 , movetoworkspacesilent , 1"
      "$mainMod CTRL , code:11 , movetoworkspacesilent , 2"
      "$mainMod CTRL , code:12 , movetoworkspacesilent , 3"
      "$mainMod CTRL , code:13 , movetoworkspacesilent , 4"
      "$mainMod CTRL , code:14 , movetoworkspacesilent , 5"
      "$mainMod CTRL , code:15 , movetoworkspacesilent , 6"
      "$mainMod CTRL , code:16 , movetoworkspacesilent , 7"
      "$mainMod CTRL , code:17 , movetoworkspacesilent , 8"
      "$mainMod CTRL , code:18 , movetoworkspacesilent , 9"
      "$mainMod CTRL , code:19 , movetoworkspacesilent , 10"

      # Mouse Controls
      "$mainMod , mouse_down , workspace , e+1"
      "$mainMod , mouse_up , workspace , e-1"
      "$mainMod , period , workspace , e+1"
      "$mainMod , comma , workspace , e-1"
      # Keyboard and Display Controls
      ", xf86KbdBrightnessDown , exec , $scriptsDir/BrightnessKbd.sh --dec"
      ", xf86KbdBrightnessUp , exec , $scriptsDir/BrightnessKbd.sh --inc"
      ", xf86Launch1 , exec , rog-control-center"
      ", xf86Launch3 , exec , asusctl led-mode -n"
      ", xf86Launch4 , exec , asusctl profile -n"
      ", xf86MonBrightnessDown , exec , $scriptsDir/Brightness.sh --dec"
      ", xf86MonBrightnessUp , exec , $scriptsDir/Brightness.sh --inc"
      ", xf86TouchpadToggle , exec , $scriptsDir/TouchPad.sh"
      ", xf86Display , exec , $scriptsDir/TouchPad.sh"
      ", code:179 , exec , $scriptsDir/TouchPad.sh"

      # Screenshot Keybinds for Asus G15
      "$mainMod SHIFT , F6 , exec , $scriptsDir/ScreenShot.sh --area"
      "$mainMod CTRL , F6 , exec , $scriptsDir/ScreenShot.sh --in5"
      "$mainMod ALT , F6 , exec , $scriptsDir/ScreenShot.sh --in10"
      "ALT , F6 , exec , $scriptsDir/ScreenShot.sh --active"

      # Lid Switch Behavior
      ", switch:Lid Switch , exec , hyprlock && sleep 10 && hyprctl dispatch dpms off" 
      "$mainMod SHIFT , X , exec , ani-cli --rofi"
      "$mainMod SHIFT , V , exec , vesktop"
      "$mainMod , X , exec , pkill rofi || hyprpanel t powermenu"
      "$mainMod , B , exec , hyprpanel t bar-0" 
      "$mainMod , Return , exec , uwsm app $term"
      "$mainMod , T , exec , uwsm app $files"
      "$mainMod ALT , C , exec , $UserScripts/RofiCalc.sh"
      "$mainMod SHIFT , T , exec , pypr toggle yazi"

      # Pyprland Controls
      "$mainMod SHIFT , Return , exec , pypr toggle term"
      "$mainMod SHIFT , D , exec , pypr toggle spotify"
      "$mainMod , Z , exec , pypr zoom"

      # Custom User Binds
      "$mainMod SHIFT , O , exec , $UserScripts/ZshChangeTheme.sh"
      "ALT_L SHIFT , , exec , $scriptsDir/SwitchKeyboardLayout.sh"
      "$mainMod SHIFT , a , movetoworkspace , special"

      # Passthrough Submap
      "$mainMod ALT , P , submap , passthru"
      "$mainMod ALT , P , submap , reset"
    ];
  };
}

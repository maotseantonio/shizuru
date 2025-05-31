{ lib, pkgs, ... }:

let
  blazinscripts = pkgs.writeShellScriptBin "hyprlock-blazinscripts" ''
    #!/usr/bin/env bash
    # Battery and Music Status Script
    if [ "$1" == "-bat" ]; then
      battery=$(cat /sys/class/power_supply/BAT0/capacity)
      status=$(cat /sys/class/power_supply/BAT0/status)
      icons=("󰂃" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰁹")
      idx=$((battery / 10))
      [ $idx -eq 10 ] && idx=9
      icon=''${icons[idx]}
      [ "$status" = "Charging" ] && icon="󰂄"
      echo "$icon $battery%"
    elif [ "$1" == "-music" ]; then
      case "$2" in
        --title)
          title=$(playerctl metadata --format '{{ xesam:title }}' 2>/dev/null)
          [ -z "$title" ] && echo "Nothing Playing" || echo "''${title:0:13}..."
          ;;
        --artist)
          artist=$(playerctl metadata --format '{{ xesam:artist }}' 2>/dev/null)
          [ -z "$artist" ] || echo "''${artist:0:10}..."
          ;;
        --status)
          case $(playerctl status 2>/dev/null) in
            "Playing") echo "󰎆" ;;
            "Paused") echo "󱑽" ;;
            *) echo "" ;;
          esac
          ;;
        --source)
          trackid=$(playerctl metadata --format '{{ mpris:trackid }}' 2>/dev/null)
          case "$trackid" in
            *"firefox"*) echo "Firefox 󰈹" ;;
            *"spotify"*) echo "Spotify " ;;
            *"chromium"*) echo "Chrome " ;;
            *) echo "Source " ;;
          esac
          ;;
        --arturl)
          url=$(playerctl metadata --format '{{ mpris:artUrl }}' 2>/dev/null)
          if [[ "$url" == file://* ]]; then
            echo "''${url#file://}"
          elif [[ "$url" == https://i.scdn.co/* ]]; then
            echo "$HOME/.cache/hyprlock-art/''$(basename "$url")"
          fi
          ;;
      esac
    fi
  '';
in {
  hj.rum.programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        grace = 1;
        ignore_empty_input = true;
        text_trim = false;
        disable_loading_bar = true;
        screencopy_mode = 1;
        bezier = "linear, 1, 1, 0, 0";
        animation = "fade, 1, 1.8, linear";
      };

      background = {
        color = "rgba(181825EE)";
        path = "screenshot";
        blur_size = 2;
        blur_passes = 2;
        zindex = -1;
        contrast = 0.8;
        brightness = 0.8;
        vibrancy = 0.4;
        vibrancy_darkness = 0.3;
      };

      input-field = {
        monitor = "";
        size = "290, 60";
        outline_thickness = 4;
        dots_size = 0.3;
        dots_spacing = 0.4;
        dots_center = true;
        outer_color = "rgba(22222299)";
        fail_color = "rgba(d65a5add)";
        inner_color = "rgba(11121dff)";
        font_color = "rgba(c4e88bff)";
        fade_on_empty = false;
        font_family = "JetBrainsMono Nerd Font";
        placeholder_text = ''<i><span foreground="##d9e0ee">Input Password...</span></i>'';
        hide_input = false;
        position = "0, -220";
        halign = "center";
        valign = "center";
        zindex = 10;
      };

      label = [
        {
          monitor = "";
          text = "$TIME";
          color = "rgba(bfe386ff)";
          font_size = 90;
          shadow_passes = 3;
          shadow_boost = 0.5;
          font_family = "JetBrains Mono Nerd Font Mono ExtraBold";
          position = "0, -100";
          halign = "center";
          valign = "top";
          zindex = 3;
        }
        {
          monitor = "";
          text = "cmd[update:5000] ${blazinscripts}/bin/hyprlock-blazinscripts -bat";
          shadow_passes = 1;
          shadow_boost = 0.5;
          color = "rgba(11121dFF)";
          font_size = 14;
          font_family = "Maple Mono";
          position = "-21, -8";
          halign = "right";
          valign = "bottom";
          zindex = 3;
        }
        {
          monitor = "";
          text = "cmd[update:24000000] echo \"Session : $XDG_SESSION_DESKTOP\"";
          color = "rgba(222222FF)";
          font_size = 12;
          font_family = "JetBrainsMono Nerd Font";
          position = "0, -5";
          halign = "center";
          valign = "bottom";
          zindex = 2;
        }
        {
          monitor = "";
          text = "$USER";
          shadow_passes = 1;
          shadow_boost = 0.5;
          color = "rgba(d65a5aff)";
          font_size = 16;
          font_family = "JetBrainsMono Nerd Font";
          position = "180, 34";
          halign = "left";
          valign = "bottom";
          zindex = 2;
        }
        {
          monitor = "";
          text = "cmd[update:24000000] echo \"@$(uname -n)\"";
          shadow_passes = 1;
          shadow_boost = 0.5;
          color = "rgba(d65a5aaa)";
          font_size = 16;
          font_family = "JetBrainsMono Nerd Font Italic";
          position = "180, -20";
          halign = "left";
          valign = "bottom";
          zindex = 2;
        }
        {
          monitor = "";
          text = "";
          shadow_passes = 1;
          shadow_boost = 0.5;
          color = "rgba(255, 255, 255, 1)";
          font_size = 20;
          font_family = "Font Awesome 6 Free Solid";
          position = "0, -65";
          halign = "center";
          valign = "top";
          zindex = 2;
        }
        {
          monitor = "";
          text = "cmd[update:1000] ${blazinscripts}/bin/hyprlock-blazinscripts -music --title";
          color = "rgba(255, 255, 255, 0.8)";
          font_size = 14;
          font_family = "JetBrainsMono Nerd Font";
          position = "50, -12";
          halign = "center";
          valign = "center";
          zindex = 1;
        }
        {
          monitor = "";
          text = "cmd[update:1000] ${blazinscripts}/bin/hyprlock-blazinscripts -music --status";
          color = "rgba(255, 255, 255, 1)";
          font_size = 18;
          font_family = "JetBrainsMono Nerd Font";
          position = "-50, -15";
          halign = "center";
          valign = "center";
          zindex = 1;
        }
        {
          monitor = "";
          text = "cmd[update:1000] ${blazinscripts}/bin/hyprlock-blazinscripts -music --source";
          color = "rgba(255, 255, 255, 0.6)";
          font_size = 10;
          font_family = "JetBrainsMono Nerd Font";
          position = "-20, 16";
          halign = "center";
          valign = "center";
          zindex = 1;
        }
        {
          monitor = "";
          text = "cmd[update:1000] ${blazinscripts}/bin/hyprlock-blazinscripts -music --artist";
          color = "rgba(255, 255, 255, 0.8)";
          font_size = 12;
          font_family = "JetBrainsMono Nerd Font";
          position = "10, -35";
          halign = "center";
          valign = "center";
          zindex = 1;
        }
      ];

      shape = [
        {
          monitor = "";
          size = "100%, 60";
          color = "rgba(11121dff)";
          halign = "center";
          valign = "bottom";
          zindex = 0;
        }
        {
          monitor = "";
          size = "70, 32";
          rounding = 12;
          color = "rgba(c4e88bFF)";
          halign = "right";
          valign = "bottom";
          position = "-14, 14";
          zindex = 1;
        }
        {
          monitor = "";
          size = "220, 38";
          rounding = 10;
          color = "rgba(c4e88bff)";
          halign = "center";
          valign = "bottom";
          position = "0, 10";
          zindex = 1;
        }
        {
          monitor = "";
          color = "rgba(181825BB)";
          size = "400, 100";
          rounding = 10;
          position = "0, 0";
          halign = "center";
          valign = "center";
          zindex = 0;
        }
      ];

      image = [
        {
          monitor = "";
          path = "$HOME/.config/hypr/hyprlock/pfp.jpg";
          size = 150;
          rounding = -1;
          border_size = 3;
          border_color = "rgba(c4e88bFF)";
          position = "10, 10";
          halign = "left";
          valign = "bottom";
          zindex = 3;
        }
        {
          monitor = "";
          path = "$HOME/.config/hypr/hyprlock/music.webp";
          size = 60;
          rounding = 5;
          border_size = 0;
          rotate = 0;
          reload_time = 2;
          reload_cmd = "${blazinscripts}/bin/hyprlock-blazinscripts -music --arturl";
          position = "-106, 0";
          halign = "center";
          valign = "center";
          zindex = 1;
        }
      ];
    };
  };

  home.packages = [ pkgs.playerctl ];
  systemd.user.tmpfiles.rules = [
    "d ${config.home.homeDirectory}/.cache/hyprlock-art 0755 ${config.home.username} ${config.home.username} - -"
  ];
}

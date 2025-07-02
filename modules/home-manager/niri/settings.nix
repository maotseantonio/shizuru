{
  config,
  pkgs,
  inputs,
  ...
}: let
  makeCommand = command: {
    command = [command];
  };
  wallpaperScript = pkgs.writeScriptBin "niri-wallpaper" (builtins.readFile ./wallpaperAutoChange.sh);
in {
  xdg.portal.extraPortals = [
         pkgs.xdg-desktop-portal-gtk
         pkgs.xdg-desktop-portal-gnome
         pkgs.gnome-keyring
  ];
  home.packages = [
         pkgs.wl-clipboard
         inputs.astal-bar.packages.${pkgs.system}.default
         inputs.astal.packages.${pkgs.system}.default
         wallpaperScript
  ];
  programs.niri = {
    enable = true;
    package = pkgs.niri-unstable;
    settings = {
      xwayland-satellite.enable = true;
      environment = {
        CLUTTER_BACKEND = "wayland";
        GDK_BACKEND = "wayland,x11";
        MOZ_ENABLE_WAYLAND = "1";
        NIXOS_OZONE_WL = "1";
        QT_QPA_PLATFORM = "wayland;xcb";
        QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
        SDL_VIDEODRIVER = "wayland";
        QT_QPA_PLATFORMTHEME = "qt6ct";
        QT_STYLE_OVERRIDE = "kvantum";
        GTK_THEME = "Catppuccin-Dark";
        ELECTRON_OZONE_PLATFORM_HINT = "auto";
        OZONE_PLATFORM = "wayland";
        JAVA_AWT_WM_NONEREPARENTING = "1";
        ELECTRON_ENABLE_HARDWARE_ACCELERATION = "1";
        XDG_SESSION_TYPE = "wayland";
        XDG_CURRENT_DESKTOP = "niri";
        DISPLAY = null; #  DISPLAY = ":0";
      };
      spawn-at-startup = [
        (makeCommand "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1")
        (makeCommand "wl-paste --type image --watch cliphist store")
        (makeCommand "wl-paste --type text --watch cliphist store")
        (makeCommand "wl-paste --watch walker --update-clipboard")
        (makeCommand "swww-daemon")
        (makeCommand "python /home/antonio/wayland-idle-inhibitor/wayland-idle-inhibitor.py")
        (makeCommand "qs")
        (makeCommand "~/.local/bin/mod-qs")
        (makeCommand "uwsm-app ${wallpaperScript}/bin/niri-wallpaper")
        (makeCommand "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
        (makeCommand "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
        (makeCommand "dbus-update-activation-environment --all")
        (makeCommand "${pkgs.xwayland-satellite}/bin/xwayland-satellite")
        (makeCommand "${pkgs.xdg-desktop-portal-gnome}/libexec/xdg-desktop-portal-gnome")
      ];
      input = {
        keyboard.xkb.layout = "us";
        keyboard.xkb.options = "caps:swapescape";
        touchpad = {
          click-method = "button-areas";
          dwt = true;
          dwtp = true;
          natural-scroll = false;
          scroll-method = "two-finger";
          tap = true;
          tap-button-map = "left-right-middle";
          middle-emulation = true;
          accel-profile = "adaptive";
          scroll-factor = 0.7;
        };
        focus-follows-mouse.enable = true;
        warp-mouse-to-focus.enable = true;
        workspace-auto-back-and-forth = true;
      };
      overview = {backdrop-color = "#11121d";}; # Tokyo Night background color
      screenshot-path = "~/Pictures/Screenshots/Screenshot-from-%Y-%m-%d-%H-%M-%S.png";
      outputs = {
        "eDP-1" = {
          mode = {
            width = 2160;
            height = 1440;
            refresh = null;
          };
          scale = 1.0;
        };
      };
      cursor = {
        size = 32;
        theme = "Kureiji-Ollie-v2";
      };
      layout = {
        background-color = "transparent";
        focus-ring.enable = false;
        border = {
          enable = true;
          width = 4;
          active = {
            gradient = {
              from = "#e97078"; # Tokyo Night red
              to = "#80c8ff"; # Tokyo Night purple/magenta
              angle = 150; # Diagonal gradient
            };
          };
          inactive = {
            gradient = {
              from = "#414868"; # Dark gray (Tokyo Night)
              to = "#1e1e2e"; # Fade to muted red
              angle = 180;
            };
          };
        };
        shadow = {
          enable = true;
          softness = 40;
          spread = 6; # Blur strength
          offset = {
            x = 2;
            y = 2;
          }; # Shadow direction
          color = "rgba(0, 0, 0, 0.5)"; # Semi-transparent black
        };
        preset-column-widths = [
          {proportion = 0.33;}
          {proportion = 0.5;}
          {proportion = 0.75;}
          {proportion = 1.0;}
        ];
        default-column-width = {proportion = 0.55;};
        always-center-single-column = true;
        gaps = 6;
        struts = {
          left = 12;
          right = 12;
          top = 12;
          bottom = 12;
        };

        tab-indicator = {
          hide-when-single-tab = true;
          place-within-column = true;
          position = "left";
          corner-radius = 10.0;
          gap = -12.0;
          gaps-between-tabs = 10.0;
          width = 4.0;
          length.total-proportion = 0.1;
        };
      };
      animations = {
        enable = true;
        slowdown = 2.0;
        window-open = {
          kind = {
            easing = {
              curve = "linear";
              duration-ms = 200;
            };
          };
        };
        window-close = {
          kind = {
            easing = {
              curve = "linear";
              duration-ms = 250;
            };
          };
        };
        window-resize = {
          kind = {
            easing = {
              curve = "linear";
              duration-ms = 250;
            };
          };
        };
        window-open.custom-shader = ''
                              vec4 expanding_circle(vec3 coords_geo, vec3 size_geo) {
                              vec3 coords_tex = niri_geo_to_tex * coords_geo;
                              vec4 color = texture2D(niri_tex, coords_tex.st);
                              vec2 coords = (coords_geo.xy - vec2(0.5, 0.5)) * size_geo.xy * 2.0;
                              coords = coords / length(size_geo.xy);
                              float p = niri_clamped_progress;
                              if (p * p <= dot(coords, coords))
                              color = vec4(0.0);

            return color;
          }
                             vec4 open_color(vec3 coords_geo, vec3 size_geo) {
                             return expanding_circle(coords_geo, size_geo);
            }
        '';
        window-close.custom-shader = ''
                             vec4 fall_and_rotate(vec3 coords_geo, vec3 size_geo) {
                             float progress = niri_clamped_progress * niri_clamped_progress;
                             vec2 coords = (coords_geo.xy - vec2(0.5, 1.0)) * size_geo.xy;
                             coords.y -= progress * 1440.0;
                             float random = (niri_random_seed - 0.5) / 2.0;
                             random = sign(random) - random;
                             float max_angle = 0.5 * random;
                             float angle = progress * max_angle;
                             mat2 rotate = mat2(cos(angle), -sin(angle), sin(angle), cos(angle));
                             coords = rotate * coords;
                             coords_geo = vec3(coords / size_geo.xy + vec2(0.5, 1.0), 1.0);
                             vec3 coords_tex = niri_geo_to_tex * coords_geo;
                             vec4 color = texture2D(niri_tex, coords_tex.st);

                             return color;
          }

                             vec4 close_color(vec3 coords_geo, vec3 size_geo) {
                             return fall_and_rotate(coords_geo, size_geo);
             }


        '';
      };
      animations.window-resize.custom-shader = ''
          vec4 resize_color(vec3 coords_curr_geo, vec3 size_curr_geo) {
          vec3 coords_next_geo = niri_curr_geo_to_next_geo * coords_curr_geo;

          vec3 coords_stretch = niri_geo_to_tex_next * coords_curr_geo;
          vec3 coords_crop = niri_geo_to_tex_next * coords_next_geo;

          // We can crop if the current window size is smaller than the next window
          // size. One way to tell is by comparing to 1.0 the X and Y scaling
          // coefficients in the current-to-next transformation matrix.
          bool can_crop_by_x = niri_curr_geo_to_next_geo[0][0] <= 1.0;
          bool can_crop_by_y = niri_curr_geo_to_next_geo[1][1] <= 1.0;

          vec3 coords = coords_stretch;
          if (can_crop_by_x)
              coords.x = coords_crop.x;
          if (can_crop_by_y)
              coords.y = coords_crop.y;

          vec4 color = texture2D(niri_tex_next, coords.st);

          // However, when we crop, we also want to crop out anything outside the
          // current geometry. This is because the area of the shader is unspecified
          // and usually bigger than the current geometry, so if we don't fill pixels
          // outside with transparency, the texture will leak out.
          //
          // When stretching, this is not an issue because the area outside will
          // correspond to client-side decoration shadows, which are already supposed
          // to be outside.
          if (can_crop_by_x && (coords_curr_geo.x < 0.0 || 1.0 < coords_curr_geo.x))
              color = vec4(0.0);
          if (can_crop_by_y && (coords_curr_geo.y < 0.0 || 1.0 < coords_curr_geo.y))
              color = vec4(0.0);

          return color;
        }
      '';
      prefer-no-csd = true;
      hotkey-overlay.skip-at-startup = true;
    };
  };

  systemd.user.services.niri-wallpaper = {
    Unit.Description = "Daily Wallpaper Rotation";
    Service = {
      Type = "oneshot";
      ExecStart = "${wallpaperScript}/bin/niri-wallpaper";
    };
  };

  systemd.user.timers.niri-wallpaper = {
    Unit.Description = "Daily Wallpaper Rotation Timer";
    Timer = {
      OnCalendar = "*-*-* 00:01:00";
      Persistent = true;
    };
    Install.WantedBy = ["timers.target"];
  };
}

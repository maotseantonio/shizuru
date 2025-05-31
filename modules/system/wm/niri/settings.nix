{ config, pkgs, ... }:
''
input {
  keyboard {
    xkb {
      layout "us"
      model ""
      rules ""
      variant ""
    }
    repeat-delay 600
    repeat-rate 25
    track-layout "global"
  }
  touchpad {
    tap
    dwt
    dwtp
    middle-emulation
    accel-speed 0.000000
    accel-profile "adaptive"
    scroll-method "two-finger"
    click-method "button-areas"
    tap-button-map "left-right-middle"
    scroll-factor 0.700000
  }
  mouse { accel-speed 0.000000; }
  trackpoint { accel-speed 0.000000; }
  trackball { accel-speed 0.000000; }
  tablet
  touch
  warp-mouse-to-focus
  focus-follows-mouse
  workspace-auto-back-and-forth
}

output "HDMI-A-1" {
  scale 1.000000
  transform "normal"
  position x=0 y=-1080
  mode "1920x1080"
}

output "eDP-1" {
  scale 1.000000
  transform "normal"
  position x=0 y=0
  mode "2160x1440"
}

screenshot-path "~/Pictures/Screenshots/Screenshot-from-%Y-%m-%d-%H-%M-%S.png"
prefer-no-csd
overview { backdrop-color "#11121d"; }

layout {
  background-color "transparent"
  gaps 6
  struts {
    left 0
    right 0
    top 0
    bottom 0
  }
  focus-ring { off; }
  border {
    width 2
    active-gradient angle=150 from="#e97078" relative-to="window" to="#80c8ff"
    inactive-gradient angle=180 from="#414868" relative-to="window" to="#1e1e2e"
  }
  shadow {
    on
    offset x=2 y=2
    softness 40
    spread 6
    draw-behind-window false
    color "rgba(0, 0, 0, 0.5)"
  }
  tab-indicator {
    hide-when-single-tab
    place-within-column
    gap -12.000000
    width 4.000000
    length total-proportion=0.100000
    position "left"
    gaps-between-tabs 10.000000
    corner-radius 10.000000
  }
  insert-hint { color "rgb(127 200 255 / 50%)"; }
  default-column-width { proportion 0.750000; }
  preset-column-widths {
    proportion 0.330000
    proportion 0.500000
    proportion 0.750000
    proportion 1.000000
  }
  center-focused-column "never"
  always-center-single-column
}

cursor {
  xcursor-theme "LyraR-cursors"
  xcursor-size 32
}

hotkey-overlay { skip-at-startup; }

environment {
  "CLUTTER_BACKEND" "wayland"
  DISPLAY null
  "ELECTRON_OZONE_PLATFORM_HINT" "auto"
  "GDK_BACKEND" "wayland,x11"
  "GTK_THEME" "Material-DeepOcean-BL-LB"
  "JAVA_AWT_WM_NONEREPARENTING" "1"
  "MOZ_ENABLE_WAYLAND" "1"
  "NIXOS_OZONE_WL" "1"
  "OZONE_PLATFORM" "wayland"
  "QT_QPA_PLATFORM" "wayland;xcb"
  "QT_QPA_PLATFORMTHEME" "qt6ct"
  "QT_STYLE_OVERRIDE" "kvantum"
  "QT_WAYLAND_DISABLE_WINDOWDECORATION" "1"
  "SDL_VIDEODRIVER" "wayland"
}

window-rule {
  draw-border-with-background false
  geometry-corner-radius 5.000000 5.000000 5.000000 5.000000
  clip-to-geometry true
}

window-rule {
    match app-id="^niri$"
    opacity 1.000000
}
window-rule {
    match is-focused=false
    opacity 0.950000
}
window-rule {
    match is-floating=true
    shadow { on; }
}
window-rule {
    match is-window-cast-target=true
    border { inactive-color "#a9b1d600 "; }
    focus-ring {
        active-color "#f38ba8"
        inactive-color "#a9b1d600 "
    }
    shadow { color "#f38ba800 "; }
    tab-indicator {
        active-color "#f38ba8"
        inactive-color "#a9b1d600"
    }
}
window-rule {
    match app-id="org.telegram.desktop"
    block-out-from "screencast"
}
window-rule {
    match app-id="app.drey.PaperPlane"
    block-out-from "screencast"
}
window-rule {
    match app-id="^(zen|firefox|chromium-browser|chrome-.*|zen-.*)$"
    match app-id="^(xdg-desktop-portal-gtk)$"
    scroll-factor 0.85
}
window-rule {
    match app-id="^(Komikku|info.febvre.Komikku.*)$"
    match app-id="^(xdg-desktop-portal-gtk)$"
    scroll-factor 0.15
}

window-rule {
    match app-id="^(zen|firefox|equibop|chromium-browser|edge|chrome-.*|zen-.*)$"
    open-maximized false
}
window-rule {
    match app-id="firefox$" title="^Picture-in-Picture$"
    match app-id="zen-.*$" title="^Picture-in-Picture$"
    match title="^Picture in picture$"
    match title="^Discord Popout$"
    open-floating true
    default-floating-position relative-to="top-right" x=32 y=32
}
window-rule {
    match app-id="^(org.wezfurlong.wezterm)$"
    match app-id="^(kitty)$"
    match app-id="^(com.mitchellh.ghostty)$"
    opacity 0.960000
}
window-rule {
    match app-id="^(pwvucontrol)" title=""
    open-floating true
}
window-rule {
    match app-id="^(Volume Control)" title=""
    open-floating true
}
window-rule {
    match app-id="^(dialog)" title=""
    open-floating true
}
window-rule {
    match app-id="^(file_progress)" title=""
    open-floating true
}
window-rule {
    match app-id="^(confirm)" title=""
    open-floating true
}
window-rule {
    match app-id="^(download)" title=""
    open-floating true
}
window-rule {
    match app-id="^(error)" title=""
    open-floating true
}
window-rule {
    match app-id="^(notification)" title=""
    open-floating true
}
window-rule {
    match app-id="^(thunar)" title=""
    open-floating true
}
window-rule {
    match app-id="^(discord)" title=""
    open-floating true
}
window-rule {
    match app-id="^(spotify)" title=""
    open-floating true
}

layer-rule { 
    match namespace="^swww-daemon$"
    place-within-backdrop true
}


animations {
    slowdown 2.0
    window-open {
      duration-ms 200
      curve "linear"
      custom-shader r"
    
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
  "
 }

   window-close {
      duration-ms 250
      curve "linear"
      custom-shader r"

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
    "
   }
  window-resize {
    spring damping-ratio=1.000000 epsilon=0.000100 stiffness=800
    custom-shader "vec4 resize_color(vec3 coords_curr_geo, vec3 size_curr_geo) {
      vec3 coords_next_geo = niri_curr_geo_to_next_geo * coords_curr_geo;
      vec3 coords_stretch = niri_geo_to_tex_next * coords_curr_geo;
      vec3 coords_crop = niri_geo_to_tex_next * coords_next_geo;
      bool can_crop_by_x = niri_curr_geo_to_next_geo[0][0] <= 1.0;
      bool can_crop_by_y = niri_curr_geo_to_next_geo[1][1] <= 1.0;
      vec3 coords = coords_stretch;
      if (can_crop_by_x) coords.x = coords_crop.x;
      if (can_crop_by_y) coords.y = coords_crop.y;
      vec4 color = texture2D(niri_tex_next, coords.st);
      if (can_crop_by_x && (coords_curr_geo.x < 0.0 || 1.0 < coords_curr_geo.x))
        color = vec4(0.0);
      if (can_crop_by_y && (coords_curr_geo.y < 0.0 || 1.0 < coords_curr_geo.y))
        color = vec4(0.0);
      return color;
    }"
  }
}
''


#!/bin/bash
# Wallpaper selector script using swww + mpvpaper, with rofi thumbnails

terminal=kitty
wallDIR="$HOME/Pictures/wallpapers"
SCRIPTSDIR="$HOME/.config/hypr/scripts"
wallpaper_current="$HOME/.config/hypr/wallpaper_effects/.wallpaper_current"
startup_conf="$HOME/.config/hypr/UserConfigs/Startup_Apps.conf"
iDIR="$HOME/.config/swaync/images"
state_dir="$HOME/.local/state/caelestia/wallpaper"
mkdir -p "$state_dir"

# swww transition config
FPS=60
TYPE="any"
DURATION=2
BEZIER=".43,1.19,1,.4"
SWWW_PARAMS="--transition-fps $FPS --transition-type $TYPE --transition-duration $DURATION --transition-bezier $BEZIER"

# Check bc dependency
if ! command -v bc &>/dev/null; then
  notify-send -i "$iDIR/error.png" "bc missing" "Install package bc first"
  exit 1
fi

rofi_theme="$HOME/.config/rofi/config-wallpaper.rasi"

focused_monitor=$(hyprctl monitors -j | jq -r '.[] | select(.focused) | .name')
if [[ -z "$focused_monitor" ]]; then
  notify-send -i "$iDIR/error.png" "Error" "No focused monitor detected"
  exit 1
fi

scale_factor=$(hyprctl monitors -j | jq -r --arg mon "$focused_monitor" '.[] | select(.name == $mon) | .scale')
monitor_height=$(hyprctl monitors -j | jq -r --arg mon "$focused_monitor" '.[] | select(.name == $mon) | .height')

icon_size=$(echo "scale=1; ($monitor_height * 3) / ($scale_factor * 150)" | bc)
adjusted_icon_size=$(echo "$icon_size" | awk '{if ($1 < 15) $1 = 20; if ($1 > 25) $1 = 25; print $1}')
rofi_override="element-icon{size:${adjusted_icon_size}%;}"

# Kill existing wallpaper daemons
kill_wallpaper_for_video() {
  swww kill 2>/dev/null
  pkill mpvpaper 2>/dev/null
  pkill swaybg 2>/dev/null
  pkill hyprpaper 2>/dev/null
}
kill_wallpaper_for_image() {
  pkill mpvpaper 2>/dev/null
  pkill swaybg 2>/dev/null
  pkill hyprpaper 2>/dev/null
}

# Load wallpapers
mapfile -d '' PICS < <(find -L "${wallDIR}" -type f \( \
  -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" -o \
  -iname "*.bmp" -o -iname "*.tiff" -o -iname "*.webp" -o \
  -iname "*.mp4" -o -iname "*.mkv" -o -iname "*.mov" -o -iname "*.webm" \) -print0)

RANDOM_PIC="${PICS[$((RANDOM % ${#PICS[@]}))]}"
RANDOM_PIC_NAME=". random"

menu() {
  IFS=$'\n' sorted_options=($(sort <<<"${PICS[*]}"))
  printf "%s\x00icon\x1f%s\n" "$RANDOM_PIC_NAME" "$RANDOM_PIC"
  for pic_path in "${sorted_options[@]}"; do
    pic_name=$(basename "$pic_path")
    if [[ "$pic_name" =~ \.gif$ ]]; then
      cache_gif_image="$HOME/.cache/gif_preview/${pic_name}.png"
      [[ ! -f "$cache_gif_image" ]] && mkdir -p "$HOME/.cache/gif_preview" && magick "$pic_path[0]" -resize 1920x1080 "$cache_gif_image"
      printf "%s\x00icon\x1f%s\n" "$pic_name" "$cache_gif_image"
    elif [[ "$pic_name" =~ \.(mp4|mkv|mov|webm|MP4|MKV|MOV|WEBM)$ ]]; then
      cache_preview_image="$HOME/.cache/video_preview/${pic_name}.png"
      [[ ! -f "$cache_preview_image" ]] && mkdir -p "$HOME/.cache/video_preview" && ffmpeg -v error -y -i "$pic_path" -ss 00:00:01.000 -vframes 1 "$cache_preview_image"
      printf "%s\x00icon\x1f%s\n" "$pic_name" "$cache_preview_image"
    else
      printf "%s\x00icon\x1f%s\n" "$(basename "$pic_name" | cut -d. -f1)" "$pic_path"
    fi
  done
}

set_sddm_wallpaper() {
  sleep 1
  sddm_sequoia="/usr/share/sddm/themes/sequoia_2"
  if [ -d "$sddm_sequoia" ]; then
    if pidof yad >/dev/null; then killall yad; fi
    if yad --info --text="Set current wallpaper as SDDM background?\n\nNOTE: This only applies to SEQUOIA SDDM Theme" --text-align=left --title="SDDM Background" --timeout=5 --timeout-indicator=right --button="yes:0" --button="no:1"; then
      if ! command -v "$terminal" &>/dev/null; then
        notify-send -i "$iDIR/error.png" "Missing $terminal" "Install $terminal to set wallpaper as SDDM background"
        exit 1
      fi
      $terminal -e bash -c "echo 'Enter your password to set wallpaper as SDDM Background'; sudo cp -r $wallpaper_current '$sddm_sequoia/backgrounds/default' && notify-send -i '$iDIR/ja.png' 'SDDM' 'Background SET'"
    fi
  fi
}

modify_startup_config() {
  local selected_file="$1"
  local startup_config="$startup_conf"
  if [[ "$selected_file" =~ \.(mp4|mkv|mov|webm)$ ]]; then
    sed -i '/^\s*exec-once\s*=\s*swww-daemon\s*--format\s*xrgb\s*$/s/^/#/' "$startup_config"
    sed -i '/^\s*#\s*exec-once\s*=\s*mpvpaper\s*.*$/s/^#\s*//;' "$startup_config"
    selected_file="${selected_file/#$HOME/\$HOME}"
    sed -i "s|^\$livewallpaper=.*|\$livewallpaper=\"$selected_file\"|" "$startup_config"
    echo "Configured for live wallpaper (video)."
  else
    sed -i '/^\s*#\s*exec-once\s*=\s*swww-daemon\s*--format\s*xrgb\s*$/s/^\s*#\s*//;' "$startup_config"
    sed -i '/^\s*exec-once\s*=\s*mpvpaper\s*.*$/s/^/#/' "$startup_config"
    echo "Configured for static wallpaper (image)."
  fi
}

apply_image_wallpaper() {
  local image_path="$1"
  kill_wallpaper_for_image
  if ! pgrep -x "swww-daemon" >/dev/null; then
    swww-daemon --format xrgb &
    sleep 1
  fi
  swww img -o "$focused_monitor" "$image_path" $SWWW_PARAMS
  ln -sf "$image_path" "$wallpaper_current"
  echo "$image_path" > "$state_dir/last.txt"
  "$SCRIPTSDIR/WallustSwww.sh"
  sleep 2
  "$SCRIPTSDIR/Refresh.sh"
  sleep 1
  set_sddm_wallpaper
}

apply_video_wallpaper() {
  local video_path="$1"
  if ! command -v mpvpaper &>/dev/null; then
    notify-send -i "$iDIR/error.png" "Error" "mpvpaper not found"
    return 1
  fi
  kill_wallpaper_for_video
  mpvpaper '*' -o "load-scripts=no no-audio --loop" "$video_path" &
  ln -sf "$video_path" "$wallpaper_current"
  echo "$video_path" > "$state_dir/last.txt"
}

main() {
  if pidof rofi >/dev/null; then pkill rofi; fi
  choice=$(menu | rofi -i -show -dmenu -config "$rofi_theme" -theme-str "$rofi_override")
  choice=$(echo "$choice" | xargs)
  if [[ -z "$choice" ]]; then
    echo "No selection made."
    exit 0
  fi

  if [[ "$choice" == "$RANDOM_PIC_NAME" ]]; then
    choice=$(basename "$RANDOM_PIC")
  fi

  choice_basename=$(basename "$choice" | sed 's/\(.*\)\.[^.]*$/\1/')
  selected_file=$(find "$wallDIR" -iname "$choice_basename.*" -print -quit)

  if [[ -z "$selected_file" ]]; then
    notify-send "Error" "Wallpaper not found: $choice"
    exit 1
  fi

  modify_startup_config "$selected_file"

  if [[ "$selected_file" =~ \.(mp4|mkv|mov|webm)$ ]]; then
    apply_video_wallpaper "$selected_file"
  else
    apply_image_wallpaper "$selected_file"
  fi
}

main

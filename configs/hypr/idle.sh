#!/usr/bin/env bash

INHIBITOR_PID=""

while true; do
  if pgrep -x Komikku >/dev/null; then
    if [ -z "$INHIBITOR_PID" ]; then
      # Start hypridle inhibitor or disable idle with hyprctl or another method
      hyprctl dispatch dpms on  # keep screen on just in case
      # hypothetically, some hypridle supports inhibitors via CLI or DBus
      hyprctl dispatch "inhibit_idle start" &
      INHIBITOR_PID=$!
      echo "Idle inhibited because Komikku is running"
    fi
  else
    if [ ! -z "$INHIBITOR_PID" ]; then
      # Stop the inhibitor if Komikku closed
      kill "$INHIBITOR_PID"
      INHIBITOR_PID=""
      echo "Idle inhibition stopped"
    fi
  fi
  sleep 5
done

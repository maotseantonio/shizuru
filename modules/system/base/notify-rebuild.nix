{ config, pkgs, ... }:
let
  notifyScript = pkgs.writeShellScriptBin "rebuild-notify" ''
    # Wait for user session to be ready
    USER="antonio"
    export XDG_RUNTIME_DIR="/run/user/$(id -u $USER)"
    export DBUS_SESSION_BUS_ADDRESS="unix:path=$XDG_RUNTIME_DIR/bus"
    
    # Wait for bus to be available
    timeout=30
    while [ ! -S "$XDG_RUNTIME_DIR/bus" ] && [ $timeout -gt 0 ]; do
      sleep 1
      timeout=$((timeout-1))
    done
    
    if [ ! -S "$XDG_RUNTIME_DIR/bus" ]; then
      echo "Failed to connect to user bus"
      exit 0
    fi

    # Get status of the rebuild
    if systemctl --user is-failed nixos-rebuild.service nh-apply.service; then
      ${pkgs.libnotify}/bin/notify-send -u critical -t 5000 "NixOS Rebuild Failed" "Check journalctl for errors"
      ${pkgs.sound-theme-freedesktop}/bin/canberra-gtk-play -l 0 -d "error" -i "dialog-error"
    else
      ${pkgs.libnotify}/bin/notify-send -u normal -t 3000 "NixOS Rebuild Complete" "System successfully updated"
      ${pkgs.sound-theme-freedesktop}/bin/canberra-gtk-play -l 0 -d "complete" -i "complete"
    fi
  '';
in {
  # Enable lingering for the user
  systemd.tmpfiles.rules = [
    "d /run/user/1000 0755 antonio users -"  # Replace 1000 with actual UID
  ];

  # User service for notifications
  systemd.user.services.rebuild-notify = {
    unitConfig = {
      Description = "Post-rebuild notification";
      After = [ "graphical-session.target" ];
      Requires = [ "graphical-session.target" ];
    };
    
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${notifyScript}/bin/rebuild-notify";
      Restart = "no";
    };
    
    wantedBy = [ "default.target" ];
  };

  # Trigger notification after rebuild
  system.activationScripts.notifyOnRebuild = ''
    # Only trigger if we're in an active session
    if [ -n "$DISPLAY" ]; then
      ${pkgs.systemd}/bin/systemctl --user start rebuild-notify.service
    fi
  '';
  
  # Required packages
  environment.systemPackages = with pkgs; [
    libnotify
    sound-theme-freedesktop
  ];
}

{
  config,
  pkgs,
  ...
}: let
  username = "antonio"; # CHANGE THIS to your username

  # 1. NH wrapper with immediate notification
  nhWithNotify = pkgs.writeShellScriptBin "nh" ''
    # Initial notification (shows before sudo prompt)
    export XDG_RUNTIME_DIR="/run/user/$(id -u ${username})"
    export DBUS_SESSION_BUS_ADDRESS="unix:path=$XDG_RUNTIME_DIR/bus"
    ${pkgs.libnotify}/bin/notify-send -i nix-snowflake "NH" "Starting rebuild..." -t 2000

    if ${pkgs.nh}/bin/nh "$@"; then
      # Success handled by systemd service below
      exit 0
    else
      ${pkgs.libnotify}/bin/notify-send -i dialog-error "NH" "Rebuild failed!" -t 0
      ${pkgs.sound-theme-freedesktop}/bin/canberra-gtk-play -d dialog-error
      exit 1
    fi
  '';

  # 2. Systemd service for completion notification
  notifyScript = pkgs.writeShellScriptBin "rebuild-notify" ''
    #!/bin/sh
    export XDG_RUNTIME_DIR="/run/user/$(id -u ${username})"
    export DBUS_SESSION_BUS_ADDRESS="unix:path=$XDG_RUNTIME_DIR/bus"

    ${pkgs.libnotify}/bin/notify-send -i nix-snowflake \
      "NixOS Rebuild" \
      "System configuration applied successfully!"
  '';
in {
  # NH wrapper configuration
  # Required packages
  environment.systemPackages = with pkgs; [
    libnotify
    notifyScript
    nhWithNotify
  ];
  environment.shellAliases.nh = "${nhWithNotify}/bin/nh";

  # Systemd service configuration
  systemd.services.post-rebuild-notify = {
    description = "Notify after NixOS rebuild";
    after = ["nixos-rebuild.service" "nh-apply.service"];
    wants = ["nixos-rebuild.service" "nh-apply.service"];
    wantedBy = ["multi-user.target"];

    serviceConfig = {
      Type = "oneshot";
      User = username;
      ExecStart = "${notifyScript}/bin/rebuild-notify";
    };
  };

  # Ensure DBUS is properly configured
  services.dbus.packages = [pkgs.dconf];
}

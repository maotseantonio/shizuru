{pkgs, ...}: {
  # 1. Add required packages
  environment.systemPackages = with pkgs; [
    libnotify
    sound-theme-freedesktop
  ];

  # 2. Systemd service that triggers on ANY successful rebuild
  systemd.services."nixos-rebuild@" = {
    description = "Post-rebuild notification for nixos-rebuild %I";
    serviceConfig = {
      Type = "oneshot";
      User = "root";
      ExecStart = let
        notify = "${pkgs.libnotify}/bin/notify-send";
        sound = "${pkgs.sound-theme-freedesktop}/bin/canberra-gtk-play";
      in
        pkgs.writeShellScript "rebuild-notify" ''
          # Only notify for 'switch' operations
          if [[ "%I" == *switch* ]]; then
            ${notify} -i nix-snowflake "NixOS Rebuild" "System configuration applied successfully!"
            ${sound} -d complete
          fi
        '';
    };
  };

  # 3. Trigger the service after ANY nixos-rebuild completes
  systemd.user.services."nixos-rebuild-notify" = {
    unitConfig = {
      # This makes it trigger AFTER the actual rebuild
      After = "nixos-rebuild.service";
      Requires = "nixos-rebuild.service";
    };
    serviceConfig = {
      ExecStart = "${pkgs.systemd}/bin/systemctl start nixos-rebuild@%i.service";
      RemainAfterExit = true;
      Type = "oneshot";
    };
    wantedBy = ["default.target"];
  };
}

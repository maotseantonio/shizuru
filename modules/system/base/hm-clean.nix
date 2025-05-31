{ config, pkgs, ... }:
{
  systemd.services.cleanup-hm-services = {
    description = "Clean up stale Home Manager systemd user services";
    after = [ "nixos-rebuild.service" "nh-apply.service" ];
    wantedBy = [ "multi-user.target" ];
    
    path = with pkgs; [ systemd gnused findutils coreutils ]; # Add required tools

    serviceConfig = {
      Type = "oneshot";
      User = "antonio";
      # Use full paths to binaries and proper user bus access
      ExecStart = pkgs.writeShellScript "cleanup-hm-services" ''
        set -e
        echo "Cleaning up stale Home Manager systemd services..."
        
        HM_SERVICE_DIR="/home/antonio/.config/systemd/user"
        
        if [[ -d "$HM_SERVICE_DIR" ]]; then
          # Get current user session bus address
          export XDG_RUNTIME_DIR="/run/user/$(id -u antonio)"
          export DBUS_SESSION_BUS_ADDRESS="unix:path=$XDG_RUNTIME_DIR/bus"
          
          # Get active services using systemd-escape for reliability
          CURRENT_SERVICES=$(
            ${pkgs.systemd}/bin/systemctl --user list-unit-files --no-legend \
            | ${pkgs.gnused}/bin/sed 's/\.service.*//' \
            | ${pkgs.coreutils}/bin/tr '\n' '|'
          )
          
          # Clean stale services
          ${pkgs.findutils}/bin/find "$HM_SESSION_DIR" -name '*.service' | while read -r service_file; do
            service_name=$(${pkgs.coreutils}/bin/basename "$service_file" .service)
            if ! ${pkgs.gnugrep}/bin/grep -qE "($CURRENT_SERVICES)" <<< "$service_name"; then
              echo "Removing stale service: $service_name"
              ${pkgs.coreutils}/bin/rm -f "$service_file"
            fi
          done
          
          # Reload user daemon
          ${pkgs.systemd}/bin/systemctl --user daemon-reload
        fi
      '';
    };
  };
}

{
  inputs,
  pkgs,
  configs,
  lib,
  ...
}: {
  hm = {
    systemd.user.services.walker = {
      Unit = {
        Description = "walker autostart";
        After = "config.wayland.systemd.target";
        PartOf = "config.wayland.systemd.target";
      };
      Install.WantedBy = ["config.wayland.systemd.target"];
      Service = {
        Type = "simple";
        ExecStart = "${inputs.walker.packages.${pkgs.system}.default}/bin/walker --gapplication-service";
        Restart = "on-failure";
      };
    };
  };
}

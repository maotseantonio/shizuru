{
  pkgs,
  inputs,
  system,
  config,
  lib,
  options,
  username,
  host,
  inputs',
  ...
}: {
  nix = {
    package = inputs.izlix.packages.${pkgs.system}.nix;
    settings = {
      allowed-users = ["root" "@wheel" "antonio"];
      trusted-users = ["root" "@wheel" "antonio" "@builders"];
      warn-dirty = false;
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
  };
}

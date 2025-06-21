{
  pkgs,
  inputs,
  lib,
  config,
  ...
}: {
  hj = {
    packages = [pkgs.zoxide];
  };
}

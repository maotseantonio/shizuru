{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./ags
    ./fabric
    ./niri
    ./editors
    ./ui
    ./media
    #   ./zellij
  ];
}

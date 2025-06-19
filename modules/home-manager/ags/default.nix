{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [inputs.ags.homeManagerModules.default];

  programs.ags = {
    enable = true;
    configDir = null; # Don't symlink since we're using the bundled version
    # extraPackages = with pkgs; [
    #      astal.packages.${system}.astal3
    #      astal.packages.${system}.io
    #      gjs
    #      meson
    #      pkg-config
    #      ninja
    #      typescript
    #      libnotify
    #      dart-sass
    #      fd
    #      btop
    #      bluez
    #      libgtop
    #      gobject-introspection
    #      glib
    #      bluez-tools
    #      grimblast
    #      brightnessctl
    #      gnome-bluetooth
    #      gtksourceview3
    #      libsoup_3
    # ];
  };
}

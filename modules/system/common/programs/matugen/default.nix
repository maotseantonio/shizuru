{
  inputs,
  pkgs,
  configs,
  lib,
  ...
}: {
  imports = [
    inputs.matugen.nixosModules.default
  ];
  environment.systemPackages = with pkgs; [
    inputs.matugen.packages.${system}.default
  ];
  programs.matugen = {
    enable = true;
    package = pkgs.matugen;
    variant = "dark";
    jsonFormat = "hex";
    templates = {
      yazi = {
        input_path = "./templates/yazi-theme.toml";
        output_path = "~/.config/yazi/theme.toml";
      };
      hyprland = {
        input_path = "~/.config/Ax-Shell/config/matugen/templates/hyprland-colors.conf";
        output_path = "~/.config/matugen/config/hypr/colors.conf";
      };
      waybar = {
        input_path = "./templates/colors.css";
        output_path = "~/.config/niri/waybar/colors.css";
        post_hook = "pkill -SIGUSR2 waybar";
      };
      gtk3 = {
        input_path = "./templates/gtk-colors.css";
        output_path = "~/.config/gtk-3.0/colors.css";
      };
      gtk4 = {
        input_path = "./templates/gtk-colors.css";
        output_path = "~/.config/gtk-4.0/colors.css";
      };
      qt5ct = {
        input_path = "./templates/qtct-colors.conf";
        output_path = "~/.config/qt5ct/colors/matugen.conf";
      };
      system24 = {
        input_path = "./templates/tokyo-night-night.theme.css";
        output_path = "~/.config/vesktop/themes/tokyo-night-night.theme.css";
      };
    };
  };
}

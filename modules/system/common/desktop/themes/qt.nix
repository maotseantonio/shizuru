{pkgs, ...}: let
  envVars = {
    QT_STYLE_OVERRIDE = "kvantum";
    QT_QPA_PLATFORMTHEME = "qt6ct";
    ZDOTDIR = "$HOME/.config/zsh";
    PATH = "$HOME/.local/bin:$PATH";
  };
in {
  qt.enable = true;
  environment.variables = envVars;
  hj = {
    packages = [
      (pkgs.catppuccin-kde.override {
        flavour = ["mocha"];
        accents = ["green"];
      })
    ];
    environment.sessionVariables = envVars;
  };
}

{
  config,
  pkgs,
  pkgs-master,
  inputs,
  options,
  lib,
  system,
  ...
}: {
  imports = [
    inputs.catppuccin.homeModules.catppuccin
  ];

 
  programs.direnv = {
    enable = true;
    enableFishIntegration = true;
  };
  programs.bottom = {
    enable = true;
  };
  programs.zellij = {
    enable = true;
  };
  programs.gh = {
    enable = true;
    package = pkgs.gh;
  }; 
  programs.imv = {
    enable = true;
  };
  programs.htop = {
    enable = true;
  };

  catppuccin.enable = true;
  catppuccin.btop.enable = false;
  catppuccin.mako.enable = false;
  # catppuccin.cursors = {
  #     enable = true;
  #     accent = "green";
  #     flavor = "mocha";
  # };
  services.mako.enable = false; 
  services.arrpc = {
      enable = true;
      systemdTarget = "graphical-session.target";
  };
 
  home.file = {
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    TERMINAL = "wezterm";
    VISUAL = "codium";
    BROWSER = "firefox";
  };
  systemd.user.services.walker = {
	Unit = {
	   Description = "walker autostart";
	   After = "config.wayland.systemd.target";
	   PartOf = "config.wayland.systemd.target";
  };
  Install.WantedBy = [ "config.wayland.systemd.target"];
  Service = {
	Type = "simple";
    ExecStart = "${inputs.walker.packages.${pkgs.system}.default}/bin/walker --gapplication-service";
    Restart = "on-failure";	
  };

 }; 
  #home.backupFileExtension = "bkp";
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}

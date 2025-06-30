{pkgs, ...}: {
  programs.fish = {
    enable = true; 
    interactiveShellInit = ''
        ${pkgs.any-nix-shell}/bin/any-nix-shell fish --info-right | source
    '';
  };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
    flags = ["--cmd cd"];
  };
  programs.direnv.enableFishIntegration = true;
  programs.starship = {
    enable = true;
    transientPrompt.enable = true;
    # I don't know why they thought not including starship in environment.systemPackages was
    # a genius idea
    transientPrompt.left = ''
      ${pkgs.starship}/bin/starship module directory
      ${pkgs.starship}/bin/starship module character
    '';
  };
  programs.fzf.keybindings = true;

  environment.systemPackages = [
    pkgs.fishPlugins.done
    pkgs.fishPlugins.sponge 
    pkgs.eza
    pkgs.fish-lsp
  ];

  programs.bash = {
    # adapted from nixos wiki for using bash as login shell and then launching fish
    # IMPORTANT: modified to improve direnv support by using fish if IN_NIX_SHELL var is set
    # Note works with nix shell but not with nix develop
    interactiveShellInit = ''
      if [[ ($(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" || -n ''${IN_NIX_SHELL}) && -z ''${BASH_EXECUTION_STRING} ]]
      then
        shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
        exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
      fi
    '';
  };
}

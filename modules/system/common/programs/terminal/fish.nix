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
 
}

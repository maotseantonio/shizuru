{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.nvchad4nix.homeManagerModule
  ];
  programs.nvchad = {
    enable = true;
    neovim = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
    extraPackages = with pkgs; [
      nodePackages.bash-language-server 
      nodePackages.prettier
      nixfmt-rfc-style
      rustfmt
      shfmt
      emmet-language-server
      nixd
      vscode-langservers-extracted
      typescript-language-server
      vue-language-server
      (python3.withPackages(ps: with ps; [
        python-lsp-server
        python-lsp-ruff
        flake8
      ]))
    ];
    extraConfig = inputs.nvchad-on-steroids;
    hm-activation = true;
    backup = false;
  };
}

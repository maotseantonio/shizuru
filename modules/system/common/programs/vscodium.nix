{
  config,
  lib,
  pkgs,
  ...
}: {
  hj.rum.programs.vscode = {
    package = pkgs.vscodium;
    extensions = with pkgs.vscode-extensions; [
      alefragnani.project-manager
      leonardssh.vscord
      bradlc.vscode-tailwindcss
      christian-kohler.npm-intellisense
      christian-kohler.path-intellisense
      dbaeumer.vscode-eslint
      eamodio.gitlens
      editorconfig.editorconfig
      esbenp.prettier-vscode
      formulahendry.auto-close-tag
      formulahendry.code-runner
      golang.go
      jnoortheen.nix-ide
      meganrogge.template-string-converter
      mikestead.dotenv
      mkhl.direnv
      ms-azuretools.vscode-docker
      naumovs.color-highlight
      oderwat.indent-rainbow
      redhat.vscode-yaml
      svelte.svelte-vscode
      tamasfe.even-better-toml
      usernamehw.errorlens
      yzhang.markdown-all-in-one
      ms-vscode.live-server
      visualstudioexptteam.vscodeintellicode
    ];
  };
}

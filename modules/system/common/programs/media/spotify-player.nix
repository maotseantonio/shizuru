{
  config,
  pkgs,
  ...
}: let
  catppuccin-spotify-player = pkgs.fetchFromGitHub {
    owner = "maotseantonio";
    repo = "spotify-player";
    rev = "196c23e4a4cb7cbbe0236f6be98052d7a8a55193";
    hash = "sha256-WRxTrAOCMxVKC0goJaBkATMNE0XVGEt/bd8ERAETx94=";
  };
in {
  hj = {
    rum.programs.spotify-player = {
      enable = true;
      package = pkgs.spotify-player.override {
        # Useful overrides in the package
        withStreaming = true;
        withDaemon = true; # alsa, pulseaudio, rodio, portaudio, jackaudio, rodiojack, sdl
        withMediaControl = true;
        withImage = true;
        withNotify = true;
        withSixel = true;
        withFuzzy = true;
      };
      settings = {
        client_id_command = "cat a9af7e8596954c9389334185e06c45be";
        theme = "Catppuccin-mocha";
        device = {
          name = "shizuru";
          device_type = "computer";
          volume = 90;
          normalization = true;
        };
      };
    };
    files.".config/spotify-player/theme.toml".source = "${catppuccin-spotify-player}/theme.toml";
  };
}

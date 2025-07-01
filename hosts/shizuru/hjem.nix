{
  config,
  inputs,
  lib,
  username,
  ...
}: {
  imports = [
    inputs.hjem.nixosModules.default
    (lib.modules.mkAliasOptionModule ["hj"] ["hjem" "users" "${username}"]) # Stolen from gitlab/fazzi
  ];
  hjem = {
    clobberByDefault = true;
    extraModules = [inputs.hjem-rum.hjemModules.default];

    users.${username} = {
      enable = true;
      user = "${username}";
      directory = "/home/antonio";
      environment = {
        sessionVariables = {
          NIXPKGS_ALLOW_UNFREE = "1";
          ZDOTDIR = "$HOME/.config/zsh";
          # XDG Related Stuff
          #TODO:
          # XDG_CACHE_HOME = config.xdg.cacheHome;
          # XDG_CONFIG_HOME = config.xdg.configHome;
          # XDG_CONFIG_DIR = config.xdg.configHome;
          # XDG_DATA_HOME = config.xdg.dataHome;
          # XDG_STATE_HOME = config.xdg.stateHome;
          # XDG_RUNTIME_DIR = "/run/user/${toString config.users.users.airi.uid}";
          # XDG_DESKTOP_DIR = config.xdg.userDirs.desktop;
          # XDG_DOCUMENTS_DIR = config.xdg.userDirs.documents;
          # XDG_DOWNLOAD_DIR = config.xdg.userDirs.download;
          # XDG_MUSIC_DIR = config.xdg.userDirs.music;
          # XDG_PICTURES_DIR = config.xdg.userDirs.pictures;
          # XDG_PUBLICSHARE_DIR = config.xdg.userDirs.publicShare;
          # XDG_TEMPLATES_DIR = config.xdg.userDirs.templates;
          # XDG_VIDEOS_DIR = config.xdg.userDirs.videos;

          # LESSHISTFILE = "/tmp/less-hist";
          # PARALLEL_HOME = "${config.xdg.configHome}/parallel";
        };
      };
    };
  };
}

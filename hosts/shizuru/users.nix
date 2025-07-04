{
  pkgs,
  inputs,
  username,
  host,
  system,
  lib,
  ...
}: let
  inherit (import ./variables.nix) gitUsername;
in {
  imports = [
    inputs.home-manager.nixosModules.home-manager
    (lib.modules.mkAliasOptionModule ["hm"] ["home-manager" "users" "${username}"]) # gitlab/fazzi
  ];
  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    backupFileExtension = "backup";
    extraSpecialArgs = {
      inherit inputs username host;
    };
    users.${username} = {
      imports =
        if (host == "shizuru")
        then [./home.nix]
        else [./home.nix];
      home.username = "${username}";
      home.homeDirectory = "/home/${username}";
      home.stateVersion = "25.05";
      programs.home-manager.enable = true;
    };
  };
  users = {
    defaultUserShell = pkgs.fish;
    mutableUsers = true;
    users."${username}" = {
      shell = pkgs.fish;
      homeMode = "755";
      isNormalUser = true;
      description = "${gitUsername}";
      extraGroups = [
        "networkmanager"
        "wheel"
        "libvirtd"
        "scanner"
        "lp"
        "video"
        "input"
        "audio"
      ];

    # define user packages here
    packages = with pkgs; [
      ];
    };
  };
  security.sudo.wheelNeedsPassword = false;
  nix.settings.allowed-users = ["${username}"];
  environment.shells = with pkgs; [ fish ];
  environment.systemPackages = with pkgs; [ fzf ];
}

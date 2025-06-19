{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.spicetify-nix.nixosModules.default
  ];
  hm.services.spotifyd.enable = true;
  programs.spicetify = let
    spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
  in {
    enable = true;
    enabledExtensions = with spicePkgs.extensions; [
      powerBar
      fullAlbumDate
      fullAppDisplay
      listPlaylistsWithSong
      volumePercentage
      adblock
      hidePodcasts
      beautifulLyrics
      autoSkipExplicit
      shuffle # shuffle+ (special characters are sanitized out of extension names)
    ];
    enabledCustomApps = with spicePkgs.apps; [
      lyricsPlus
      newReleases
    ];
    theme = spicePkgs.themes.text;
    colorScheme = "CatppuccinMocha";
  };
}

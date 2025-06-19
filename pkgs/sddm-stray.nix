{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
  formats,
  kdePackages,
  theme ? "stray", # default subtheme
  themeConfig ? null,
}:
stdenvNoCC.mkDerivation rec {
  pname = "sddm-stray-theme";
  version = "1.0";

  src = fetchFromGitHub {
    owner = "Bqrry4";
    repo = "sddm-stray";
    rev = "8c7759d9a05ad44f71209914b7223cebf845ccd9";
    hash = "sha256-3wsQFbo545SXwfV5P4+S4/wTme/n/yunfeVpmcEmKz4=";
  };

  dontWrapQtApps = true;

  propagatedBuildInputs = [
    kdePackages.qtsvg
    kdePackages.qtmultimedia
    kdePackages.qtvirtualkeyboard
  ];

  buildPhase = ''
    runHook preBuild
    echo "No build necessary for sddm-stray theme."
    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    themeDir="$out/share/sddm/themes/sddm-stray-theme/theme"
    install -dm755 "$themeDir"
    cp -r ./* "$themeDir"

    # Install fonts system-wide (if fonts directory exists)
    if [ -d "$themeDir/fonts" ]; then
      install -dm755 "$out/share/fonts"
      cp -r "$themeDir/fonts/." "$out/share/fonts"
    fi

    # Patch metadata.desktop to point to chosen theme config if it exists
    metaFile="$themeDir/metadata.desktop"


    runHook postInstall
  '';

  postFixup = ''
    mkdir -p $out/nix-support
    echo ${kdePackages.qtsvg} >> $out/nix-support/propagated-user-env-packages
    echo ${kdePackages.qtmultimedia} >> $out/nix-support/propagated-user-env-packages
    echo ${kdePackages.qtvirtualkeyboard} >> $out/nix-support/propagated-user-env-packages
  '';

  meta = with lib; {
    description = "Stray - A sleek, modern login screen for SDDM.";
    homepage = "https://github.com/Bqrry4/sddm-stray";
    license = licenses.gpl3;
    platforms = platforms.linux;
  };
}

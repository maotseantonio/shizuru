{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
  kdePackages,
}:
stdenvNoCC.mkDerivation rec {
  pname = "sddm-stray";
  version = "1.0";

  src = fetchFromGitHub {
    owner = "Bqrry4";
    repo = "sddm-stray";
    rev = "0dfb0c59b16a985df2cc0b77a08fa9fb5c484c46";
    hash = "sha256-/vvD9ccFyPhoR0oUTHHR+kBh7BezbfmKKOupjEr6mGk=";
  };

  dontWrapQtApps = true;

  propagatedBuildInputs = [
    kdePackages.qtsvg
    kdePackages.qtmultimedia
    kdePackages.qtvirtualkeyboard
  ];

  buildPhase = ''
    runHook preBuild
    echo "No build step needed."
    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    themeDir="$out/share/sddm/themes/sddm-stray"
    install -dm755 "$themeDir"

    cp -r "$src/theme/"* "$themeDir"

    if [ -d "$themeDir/fonts" ]; then
      install -dm755 "$out/share/fonts"
      cp -r "$themeDir/fonts/"* "$out/share/fonts"
    fi

    runHook postInstall
  '';

  postFixup = ''
    mkdir -p $out/nix-support
    echo ${kdePackages.qtsvg} >> $out/nix-support/propagated-user-env-packages
    echo ${kdePackages.qtmultimedia} >> $out/nix-support/propagated-user-env-packages
    echo ${kdePackages.qtvirtualkeyboard} >> $out/nix-support/propagated-user-env-packages
  '';

  meta = with lib; {
    description = "Stray SDDM theme from maotseantonio/sddm-stray-flakes";
    homepage = "https://github.com/maotseantonio/sddm-stray-flakes";
    license = licenses.gpl3Plus;
    platforms = platforms.linux;
  };
}

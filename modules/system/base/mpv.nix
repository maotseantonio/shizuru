 { pkgs, ... }:

let
  # 1. Create a wrapped MPV binary
  wrappedMpv = pkgs.writeShellScriptBin "mpv" ''
    export __NV_PRIME_RENDER_OFFLOAD=0  # Force Intel GPU
    exec ${pkgs.mpv}/bin/mpv \
      --gpu-context=wayland \
      --vo=gpu \
      --hwdec=auto-safe \
      "$@"
  '';

  # 2. Create patched desktop file (version-independent)
  mpvWithDesktop = pkgs.runCommand "mpv-with-desktop" {
    nativeBuildInputs = [ pkgs.makeWrapper ];
  } ''
    mkdir -p $out/bin $out/share/applications
    
    # Create symlink to our wrapper
    ln -s ${wrappedMpv}/bin/mpv $out/bin/mpv
    
    # Copy and patch desktop file
    cp ${pkgs.mpv}/share/applications/mpv.desktop $out/share/applications/
    substituteInPlace $out/share/applications/mpv.desktop \
      --replace "Exec=mpv" "Exec=${wrappedMpv}/bin/mpv" \
      --replace "TryExec=mpv" "TryExec=${wrappedMpv}/bin/mpv"
    
    # Copy icons if they exist
    if [ -d ${pkgs.mpv}/share/icons ]; then
      cp -r ${pkgs.mpv}/share/icons $out/share/
    fi
  '';
in {
  environment.systemPackages = [ mpvWithDesktop ];
  xdg.mime.defaultApplications = {
    "video/*" = [ "mpv.desktop" ];
    "audio/*" = [ "mpv.desktop" ];
  };


} # Set as default video/audio player
 

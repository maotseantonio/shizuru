{
  lib,
  pkgs,
  config,
  inputs,
  ...
}: {
  hj = {
    packages = [pkgs.equibop];
    files = {
      ".config/equibop/settings.json".text = ''

        {
               "MINIMIZE_TO_TRAY": true,
               "arRPC": true,
               "discordBranch": "stable",
               "splashBackground": "rgb(30, 30, 46)",
               "splashColor":"rgb(186, 194, 222)",
               "splashTheming": true,
               "staticTitle": false,
               "splashAnimationPath": "/home/antonio/Downloads/nso-needy-streamer.gif",
               "clickTrayToShowHide": true
           }

      '';
    };
  };
}

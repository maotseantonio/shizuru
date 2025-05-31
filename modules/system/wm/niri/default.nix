{
    config,
    pkgs,
    inputs,
    ...
}:
    { 
        imports = [
          ./niri.nix
        ];
        hj = {
           packages = [ pkgs.niri pkgs.astal-shell ];
           files = {
               ".config/niri/config.kdl".text = ''
                    ${import ./settings.nix { inherit config pkgs inputs; }}
                    ${import ./binds.nix { inherit config pkgs inputs; }}
                    ${import ./startup.nix { inherit config pkgs inputs; }}
               '';
               };
            };
       }


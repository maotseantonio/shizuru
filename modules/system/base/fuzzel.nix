{
    inputs,
    config,
    pkgs,
    lib,
    ...
}:
{
   hj.rum.programs.fuzzel = {
       enable = true;
       settings = {
           main = {
               include = "/home/antonio/.config/fuzzel/rosewater.ini";
               font = "JetBrainsMono Nerd Font:size=10";
               anchor = "top";
               prompt = "❯ ";
               width = "40";
               horizontal-pad = "20";
               vertical-pad = "10";
               inner-pad = "5";
               line-height = "20";
               lines = "8";
               letter-spacing = "0.5";
               icons-enabled = "yes";
               icon-theme = "Papirus-Dark";
               image-size-ratio = "1.0";
           }; 
     };
   };
}

{
    
    inputs,
    pkgs,
    ...
}:
{
  environment.systemPackages = with pkgs; [
       pcre2 
   ];
    programs.maomaowm.enable = true;
}

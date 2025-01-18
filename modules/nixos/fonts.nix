{ pkgs, ... }:
{
  fonts = {
    packages = with pkgs; [
      maple-mono.NF-CN
      sarasa-gothic
    ];
    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = [ "Maple Mono NF CN" ];
        sansSerif = [ "Sarasa UI SC" ];
        serif = [ "Sarasa UI SC" ];
      };
    };
  };
}

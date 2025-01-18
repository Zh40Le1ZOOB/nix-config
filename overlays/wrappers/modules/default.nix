{ pkgs, wrapper-manager }:
(wrapper-manager.lib {
  inherit pkgs;
  modules = [
    ./kitty.nix
    ./kitty-wallpaper.nix
    ./niri.nix
    ./starship.nix
    ./tuigreet.nix
  ];
}).config.build.packages

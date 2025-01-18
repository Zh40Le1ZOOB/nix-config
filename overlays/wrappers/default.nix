{ wrapper-manager }:
final: _:
let
  pkgs = final;
  inherit (final) lib;
in
let
  nixpkgs-wrappers =
    (lib.evalModules {
      specialArgs = { inherit pkgs; };
      modules = [
        { options.wrappers = lib.mkOption { type = lib.types.attrs; }; }
        ./fish.nix
      ];
    }).config.wrappers;
  wrapper-manager-wrappers =
    (wrapper-manager.lib {
      inherit pkgs;
      modules = [
        ./kitty.nix
        ./kitty-wallpaper.nix
        ./niri.nix
        ./starship.nix
        ./tuigreet.nix
      ];
    }).config.build.packages;
  wrappers = nixpkgs-wrappers // wrapper-manager-wrappers;
in
{
  inherit wrappers;
}

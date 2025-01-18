{ wrapper-manager }:
final: _:
let
  pkgs = final;
  inherit (final) lib;

  helpers = pkgs.callPackage ./lib { inherit wrapper-manager; };

  wm-wrappers =
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
  unmanaged-wrappers =
    (lib.evalModules {
      specialArgs = { inherit pkgs; };
      modules = [
        { options.wrappers = lib.mkOption { type = lib.types.attrsOf lib.types.package; }; }
        ./fish.nix
      ];
    }).config.wrappers;
  wrappers = wm-wrappers // unmanaged-wrappers;
in
{
  inherit helpers wrappers;
}

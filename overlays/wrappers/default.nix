{ wrapper-manager }:
final: _:
let
  pkgs = final;
  inherit (final) lib;
in
{
  wrappers =
    (import ./modules { inherit pkgs wrapper-manager; })
    // (wrapper-manager.getPkgs pkgs)
    // (lib.packagesFromDirectoryRecursive {
      inherit (pkgs) callPackage;
      directory = ./pkgs;
    });
}

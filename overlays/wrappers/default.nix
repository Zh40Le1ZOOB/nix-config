{ wrapper-manager, catppuccin }:
final: _:
let
  pkgs = final;
  inherit (pkgs) lib;
in
{
  wrappers =
    (wrapper-manager.lib {
      pkgs = pkgs.extend (
        final: prev:
        prev.lib.packagesFromDirectoryRecursive {
          inherit (final) callPackage;
          directory = ./pkgs;
        }
        // {
          catppuccin = catppuccin.packages.${final.stdenv.hostPlatform.system};
        }
      );
      modules = lib.filesystem.listFilesRecursive ./modules;
    }).config.build.packages;
}

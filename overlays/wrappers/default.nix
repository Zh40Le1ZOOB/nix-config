{ wrapper-manager, catppuccin }:
final: _:
let
  pkgs = final;
  inherit (final) lib;
in
{
  catppuccin = catppuccin.packages.${pkgs.stdenv.hostPlatform.system};
  wrappers = lib.mergeAttrsList [
    (wrapper-manager.getPkgs pkgs)
    (lib.packagesFromDirectoryRecursive {
      inherit (pkgs) callPackage;
      directory = ./pkgs;
    })
    (wrapper-manager.lib {
      inherit pkgs;
      modules = lib.filesystem.listFilesRecursive ./modules;
    }).config.build.packages
  ];
}

{ wrapper-manager, catppuccin }:
final: _: {
  wrappers =
    (wrapper-manager.lib {
      pkgs = final.extend (
        final: prev:
        prev.lib.packagesFromDirectoryRecursive {
          inherit (final) callPackage;
          directory = ./pkgs;
        }
        // {
          catppuccin = catppuccin.packages.${final.stdenv.hostPlatform.system};
        }
      );
      modules = final.lib.filesystem.listFilesRecursive ./modules;
    }).config.build.packages;
}

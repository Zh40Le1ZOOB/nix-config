{
  lib,
  mkWrapper,
  writeTextDir,
  fd,
  wrapFd,
}:
{
  modules.default = lib.modules.importApply ./modules { inherit fd wrapFd; };
  __functor =
    _:
    lib.extendMkDerivation {
      constructDrv = mkWrapper;
      extendDrvArgs =
        finalAttrs:
        {
          package ? fd,
          hidden ? false,
          ignores ? [ ],
          extraFlags ? [ ],
          ...
        }:
        let
          finalArgs =
            (lib.evalModules {
              modules = [
                (lib.modules.importApply ./modules/args.nix { inherit fd; })
                {
                  fd = lib.filterAttrs (
                    name: _:
                    lib.elem name [
                      "package"
                      "hidden"
                      "ignores"
                      "extraFlags"
                    ]
                  ) finalAttrs;
                }
              ];
            }).config.fd;
        in
        {
          basePackage = finalArgs.package;
          prependFlags = lib.optionals finalArgs.hidden [ "--hidden" ] ++ finalArgs.extraFlags;
          envVars.XDG_CONFIG_HOME.value = writeTextDir "fd/ignore" (
            lib.concatStringsSep "\n" finalArgs.ignores
          );
        };
    };
}

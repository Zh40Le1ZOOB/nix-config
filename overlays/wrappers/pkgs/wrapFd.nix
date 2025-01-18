{
  lib,
  wrappers,
  writeTextDir,
}:
lib.extendMkDerivation {
  constructDrv = wrappers.mkWrapper;
  extendDrvArgs =
    finalAttrs:
    {
      fd,
      ignores ? [ ],
      hidden ? false,
      extraFlags ? [ ],
      ...
    }:
    {
      basePackage = fd;
      envVars.XDG_CONFIG_HOME.value = writeTextDir "fd/ignore" (
        builtins.concatStringsSep "\n" (finalAttrs.ignores or [ ])
      );
      prependFlags =
        lib.optionals (finalAttrs.hidden or false) [ "--hidden" ] ++ (finalAttrs.extraFlags or [ ]);
    };
}

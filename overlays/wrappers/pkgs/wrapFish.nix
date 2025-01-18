{
  lib,
  wrappers,
  writeText,
  runCommand,
}:
lib.extendMkDerivation {
  constructDrv = wrappers.mkWrapper;
  extendDrvArgs =
    finalAttrs:
    {
      fish,
      aliases ? { },
      config ? "",
      themes ? [ ],
      plugins ? [ ],
      extraConf ? [ ],
      extraFunctions ? [ ],
      extraCompletions ? [ ],
      ...
    }:
    let
      aliasesCommand = builtins.concatStringsSep "\n" (
        lib.mapAttrsToList (key: value: "alias ${key} ${lib.escapeShellArg value}") (
          finalAttrs.aliases or { }
        )
      );

      fishConfig = writeText "config.fish" ''
        ${finalAttrs.config or ""}

        if status is-interactive
          ${aliasesCommand}
        end
      '';

      configDir =
        runCommand "fish-config-dir"
          {
            nativeBuildInputs = [ finalAttrs.fish ];
            env =
              lib.genAttrs
                [
                  "conf"
                  "completions"
                  "functions"
                ]
                (
                  type:
                  lib.escapeShellArgs (
                    map (plugin: (plugin: type: "${plugin}/share/fish/vendor_${type}.d") plugin type) (
                      finalAttrs.plugins or [ ]
                    )
                    ++ (finalAttrs."extra${
                      {
                        conf = "Conf";
                        completions = "Completions";
                        functions = "Functions";
                      }
                      .${type}
                    }" or [ ]
                    )
                  )
                );
          }
          ''
            mkdir -p $out/conf.d/ $out/completions/ $out/functions/ $out/themes/

            cp ${fishConfig} $out/config.fish

            for theme in ${lib.escapeShellArgs (finalAttrs.themes or [ ])}; do
              cp "$theme" $out/themes/
            done

            for pathType in conf completions functions; do
              for path in ''${!pathType}; do
                if test -d $path; then
                  if test $pathType == conf; then
                    cp $path/*.fish $out/conf.d/
                  else
                    cp $path/*.fish $out/$pathType/
                  fi
                fi
              done
            done
          '';
    in
    {
      basePackage = finalAttrs.fish;
      envVars.FISH_CONFIG_DIR.value = configDir;
    };
}

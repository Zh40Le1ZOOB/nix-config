{
  lib,
  mkWrapper,
  writeText,
  runCommand,
  fish,
  wrapFish,
}:
{
  modules.default = lib.modules.importApply ./modules { inherit fish wrapFish; };
  __functor =
    _:
    lib.extendMkDerivation {
      constructDrv = mkWrapper;
      extendDrvArgs =
        finalAttrs:
        {
          package ? fish,
          aliases ? { },
          config ? "",
          themes ? [ ],
          plugins ? [ ],
          extraConf ? [ ],
          extraCompletions ? [ ],
          extraFunctions ? [ ],
          ...
        }:
        let
          finalArgs =
            (lib.evalModules {
              modules = [
                (lib.modules.importApply ./modules/args.nix { inherit fish; })
                {
                  fish = lib.filterAttrs (
                    name: _:
                    lib.elem name [
                      "package"
                      "aliases"
                      "config"
                      "themes"
                      "plugins"
                      "extraConf"
                      "extraCompletions"
                      "extraFunctions"
                    ]
                  ) finalAttrs;
                }
              ];
            }).config.fish;

          aliasesCommand = lib.concatStringsSep "\n" (
            lib.mapAttrsToList (key: value: "alias ${key} ${lib.escapeShellArg value}") finalArgs.aliases
          );

          fishConfig = writeText "config.fish" ''
            ${finalArgs.config}

            if status is-interactive
              ${aliasesCommand}
            end
          '';

          configDir =
            runCommand "fish-config-dir"
              {
                nativeBuildInputs = [ finalArgs.package ];
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
                        map (plugin: (plugin: type: "${plugin}/share/fish/vendor_${type}.d") plugin type) finalArgs.plugins
                        ++ (finalArgs."extra${
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

                for theme in ${lib.escapeShellArgs finalArgs.themes}; do
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
          basePackage = finalArgs.package.overrideAttrs (oldAttrs: {
            patches = oldAttrs.patches ++ [
              ./patches/preferred_dir_env.patch
              ./patches/vars_path_data_dir.patch
            ];
          });
          envVars.FISH_CONFIG_DIR.value = configDir;
        };
    };
}

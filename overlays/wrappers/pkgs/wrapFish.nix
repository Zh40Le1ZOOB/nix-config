{
  lib,
  wrappers,
}:
fish:
lib.extendMkDerivation {
  constructDrv = wrappers.mkWrapper;
  excludeDrvArgNames = [
    "fish"
    "aliases"
    "plugins"
    "extraConf"
    "extraFunctions"
    "extraCompletions"
  ];
  extendDrvArgs =
    _:
    {
      aliases ? { },
      plugins ? [ ],
      extraConf ? [ ],
      extraFunctions ? [ ],
      extraCompletions ? [ ],
      ...
    }:
    let
      aliasesCommand = builtins.concatStringsSep "\n" (
        lib.mapAttrsToList (name: value: "alias ${name} ${lib.escapeShellArg value}") aliases
      );

      possibleTypes = [
        "completions"
        "functions"
        "conf"
      ];
      getPluginPaths = plugin: type: "${plugin}/share/fish/vendor_${type}.d";
      pluginPaths = lib.genAttrs possibleTypes (type: map (plugin: getPluginPaths plugin type) plugins);

      initCommand = aliasesCommand + ''
        set --prepend fish_complete_path ${
          lib.escapeShellArgs (pluginPaths.completions ++ extraCompletions)
        }
        set --prepend fish_function_path ${lib.escapeShellArgs (pluginPaths.functions ++ extraFunctions)}
        set --local fish_conf_source_path ${lib.escapeShellArgs (pluginPaths.conf ++ extraConf)}
        for conf in \$fish_conf_source_path/*.fish; source \$conf; end
      '';
    in
    {
      basePackage = fish;
      appendFlags = [
        "--init-command"
        initCommand
      ];
    };
}

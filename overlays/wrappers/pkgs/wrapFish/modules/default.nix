{ fish, wrapFish }:

{ config, lib, ... }:
{
  imports = [ (lib.modules.importApply ./args.nix { inherit fish; }) ];

  options.fish.pathAdd =
    with lib;
    mkOption {
      type = with types; listOf path;
      default = [ ];
    };

  config.wrappers.fish = {
    type = "custom";
    wrapped = wrapFish {
      inherit (config.fish)
        package
        aliases
        config
        themes
        plugins
        extraConf
        extraCompletions
        extraFunctions
        pathAdd
        ;
    };
  };
}

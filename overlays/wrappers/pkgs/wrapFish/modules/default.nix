{ fish, wrapFish }:

{ config, lib, ... }:
{
  imports = [ (lib.modules.importApply ./args.nix { inherit fish; }) ];

  wrappers.fish = {
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
        ;
    };
  };
}

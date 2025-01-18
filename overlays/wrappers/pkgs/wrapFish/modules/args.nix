{ fish }:

{ lib, ... }:
let
  inherit (lib) mkOption types;
  pathsType = types.listOf types.path;
in
{
  options.fish = {
    package = mkOption {
      type = types.package;
      default = fish;
    };
    aliases = mkOption {
      type = with types; attrsOf (coercedTo anything (x: "${x}") str);
      default = { };
    };
    config = mkOption {
      type = types.lines;
      default = "";
    };
    themes = mkOption {
      type = pathsType;
      default = [ ];
    };
    plugins = mkOption {
      type = pathsType;
      default = [ ];
    };
    extraConf = mkOption {
      type = pathsType;
      default = [ ];
    };
    extraCompletions = mkOption {
      type = pathsType;
      default = [ ];
    };
    extraFunctions = mkOption {
      type = pathsType;
      default = [ ];
    };
  };
}

{ fd }:

{ lib, ... }:
let
  inherit (lib) mkOption types;
  strLike = with types; coercedTo anything (x: "${x}") str;
in
{
  options.fd = {
    package = mkOption {
      type = types.package;
      default = fd;
    };
    hidden = mkOption {
      type = types.bool;
      default = false;
    };
    ignores = mkOption {
      type = types.listOf strLike;
      default = [ ];
    };
    extraFlags = mkOption {
      type = types.listOf strLike;
      default = [ ];
    };
  };
}

{ config, pkgs, ... }:
{
  wrappers.tuigreet = {
    basePackage = pkgs.tuigreet;
    pathAdd = [ config.build.packages.niri ];
    prependFlags = [
      "--time"
      "--time-format"
      "%A %F %T"
      "--user-menu"
      "--cmd"
      "niri --session"
    ];
  };
}

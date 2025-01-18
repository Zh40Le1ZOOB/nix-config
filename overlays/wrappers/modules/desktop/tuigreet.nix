{ pkgs, ... }:
{
  wrappers.tuigreet = {
    basePackage = pkgs.tuigreet;
    pathAdd = [ pkgs.wrappers.niri ];
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

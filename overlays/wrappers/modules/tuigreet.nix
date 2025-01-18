{ pkgs, ... }:
{
  wrappers.tuigreet = {
    basePackage = pkgs.tuigreet;
    prependFlags = [
      "--time"
      "--time-format"
      "%A %F %T"
      "--user-menu"
    ];
  };
}

{ pkgs, ... }:
{
  wrappers.tuigreet = {
    basePackage = pkgs.greetd.tuigreet;
    prependFlags = [
      "--time"
      "--time-format=%A %F %T"
      "--user-menu"
    ];
  };
}

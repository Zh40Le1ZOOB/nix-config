{
  config,
  lib,
  pkgs,
  ...
}:
{
  wrappers.bat = {
    basePackage = pkgs.mkWrapper {
      basePackage = pkgs.bat;
      envVars.BAT_CONFIG_DIR.value = pkgs.runCommand "bat-config" { } ''
        mkdir -p $out/themes/
        cp ${pkgs.catppuccin.bat}/Catppuccin\ Mocha.tmTheme $out/themes/
      '';
    };
    env = {
      BAT_THEME.value = "Catppuccin Mocha";
      XDG_CACHE_HOME.value = pkgs.runCommand "bat-cache" { } ''
        mkdir -p $out/bat/
        ${lib.getExe config.wrappers.bat.basePackage} cache -b --target $out/bat/
      '';
    };
  };
}

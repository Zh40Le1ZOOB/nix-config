{ pkgs, ... }:
{
  wrappers.fd = {
    basePackage = pkgs.fd;
    envVars.XDG_CONFIG_HOME.value = pkgs.writeTextDir "fd/ignore" ''.git/'';
  };
}

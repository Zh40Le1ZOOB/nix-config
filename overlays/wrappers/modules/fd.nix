{ pkgs, ... }:
{
  wrappers.fd = {
    basePackage = pkgs.fd;
    prependFlags = [
      "--exclude"
      ".git"
    ];
  };
}

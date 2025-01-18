{ fd, wrapFd }:

{ config, lib, ... }:
{
  imports = [ (lib.modules.importApply ./args.nix { inherit fd; }) ];

  wrappers.fd = {
    type = "custom";
    wrapped = wrapFd {
      inherit (config.fd)
        package
        hidden
        ignores
        extraFlags
        ;
    };
  };
}

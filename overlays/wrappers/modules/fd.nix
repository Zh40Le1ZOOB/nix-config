{ pkgs, ... }:
{
  imports = [ pkgs.wrapFd.modules.default ];

  fd = {
    hidden = true;
    ignores = [ ".git/" ];
  };
}

{ wrappers, fd }:
wrappers.wrapFd {
  inherit fd;
  ignores = [ ".git/" ];
  hidden = true;
}

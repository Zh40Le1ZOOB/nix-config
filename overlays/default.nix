{
  lib,
  wrapper-manager,
  catppuccin,
}:
lib.composeManyExtensions (
  [ (import ./wrappers { inherit wrapper-manager catppuccin; }) ]
  ++ map (item: import item) [
    ./fish
    ./fish-plugins.nix
    ./iio-niri
    ./libfprint.nix
  ]
)

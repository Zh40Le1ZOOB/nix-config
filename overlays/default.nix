{
  lib,
  wrapper-manager,
  catppuccin,
}:
lib.composeManyExtensions (
  [ (import ./wrappers { inherit wrapper-manager catppuccin; }) ]
  ++ map (item: import item) [
    ./fish-plugins.nix
    ./grub.nix
    ./iio-niri
  ]
)

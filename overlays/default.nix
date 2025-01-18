{ lib, wrapper-manager }:
lib.composeManyExtensions (
  [ (import ./wrappers { inherit wrapper-manager; }) ]
  ++ (map (item: import item) [
    ./fish-wrapper.nix
    ./grub2
    ./iio-niri
  ])
)

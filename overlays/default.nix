{ lib, wrapper-manager }:
lib.composeManyExtensions (
  [ (import ./wrappers { inherit wrapper-manager; }) ]
  ++ map (item: import item) [
    ./fifc.nix
    ./iio-niri
  ]
)

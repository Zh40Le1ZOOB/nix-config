{ lib, wrapper-manager }:
lib.composeManyExtensions (
  (map (item: import item { inherit wrapper-manager; }) [ ./wrappers ])
  ++ (map (item: import item) [
    ./grub2
    ./iio-niri
  ])
)

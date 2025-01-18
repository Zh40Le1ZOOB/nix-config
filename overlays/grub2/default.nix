_: prev: {
  grub2 = prev.grub2.overrideAttrs (
    _: prev': {
      patches = prev'.patches ++ [
        ./fb-rotation.patch
        # https://mail.gnu.org/archive/html/grub-devel/2024-06/msg00164.html
      ];
    }
  );
}

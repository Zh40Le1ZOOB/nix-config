_: prev: {
  grub2 = prev.grub2.overrideAttrs (oldAttrs: {
    patches = oldAttrs.patches ++ [
      (prev.fetchpatch {
        name = "add_GRUB_FB_ROTATION_configuration_option.patch";
        url = "https://github.com/kbader94/grub/commit/3c31f139fdbef48269df3023029b35c43cc1772f.patch";
        hash = "sha256-+f1iK9tmwkDm6bAwnhrZ3cApbH8lsD+6/CRVNlVmPuk=";
      })
      (prev.fetchpatch {
        name = "support_2d_dirty_regions_for_partial_screen_updates.patch";
        url = "https://github.com/kbader94/grub/commit/0240a65a0f6f3cbb80c43e3bb9f13f8b4c679af1.patch";
        hash = "sha256-DvKQS7o11LEDY7tPyUxcsRLAhDhOMnNqrppB2Kld36Y=";
      })
      (prev.fetchpatch {
        name = "implement_framebuffer_rotation_transforms.patch";
        url = "https://github.com/kbader94/grub/commit/5fbe53f356bc2b2c507a5954dc85d9bcbb772d22.patch";
        hash = "sha256-7UlsIf0/PbRAQY1MPT5jgykzYAT8ct7tJvBs4gjfj/0=";
      })
    ];
  });
}

{
  lib,
  newScope,
  wrapper-manager,
}:
lib.makeScope newScope (self: {
  inherit (wrapper-manager.helpers self) mkWrapper;
  wrapFish = self.callPackage ./fish-wrapper.nix { };
})

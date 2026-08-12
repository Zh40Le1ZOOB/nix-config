_: prev: {
  fishPlugins = prev.lib.updateManyAttrsByPath [
    {
      path = [ "fifc" ];
      update =
        old:
        old.overrideAttrs rec {
          version = "0.3.4-pull-81";
          src = prev.fetchFromGitHub {
            owner = "Zh40Le1ZOOB";
            repo = "fifc";
            rev = "12214f5809a21a76cf0ae622cd7af1544c99fb15";
            hash = "sha256-KxWWNLEMf+MbF0U/jIkyJHDT0fyWREnVgcogTZYeLxM=";
          };
        };
    }
  ] prev.fishPlugins;
}

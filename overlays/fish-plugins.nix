_: prev: {
  fishPlugins = prev.lib.updateManyAttrsByPath [
    {
      path = [ "fifc" ];
      update =
        old:
        old.overrideAttrs {
          version = "0.1.1-unstable-2024-12-04";
          src = prev.fetchFromGitHub {
            owner = "gazorby";
            repo = "fifc";
            rev = "a01650cd432becdc6e36feeff5e8d657bd7ee84a";
            hash = "sha256-Ynb0Yd5EMoz7tXwqF8NNKqCGbzTZn/CwLsZRQXIAVp4=";
          };
        };
    }
  ] prev.fishPlugins;
}

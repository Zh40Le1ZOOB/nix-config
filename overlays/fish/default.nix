final: prev:
let
  pkgs = final;
  inherit (final) lib;
in
{
  fish = prev.fish.overrideAttrs (oldAttrs: {
    patches = oldAttrs.patches ++ [
      ./preferred_dir_env.patch
      ./vars_path_data_dir.patch
    ];
    nativeBuildInputs = oldAttrs.nativeBuildInputs ++ [ pkgs.breakpointHook ];
  });
}

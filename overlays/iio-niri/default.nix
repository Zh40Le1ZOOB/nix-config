final: prev:
let
  pkgs = final;
  inherit (final) lib;
in
{
  iio-niri = prev.iio-hyprland.overrideAttrs (oldAttrs: {
    pname = "iio-niri";
    src = pkgs.fetchFromGitHub {
      owner = "okeri";
      repo = "iio-sway";
      rev = "e07477d1b2478fede1446e97424a94c80767819d";
      hash = "sha256-JGacKajslCOvd/BFfFSf7s1/hgF6rJqJ6H6xNnsuMb4=";
    };
    patches = [ ./iio-niri.patch ];
    nativeBuildInputs = oldAttrs.nativeBuildInputs ++ [ pkgs.makeWrapper ];
    postFixup = ''
      wrapProgram $out/bin/iio-niri --prefix PATH : ${lib.makeBinPath [ pkgs.jq ]}
    '';
  });
}

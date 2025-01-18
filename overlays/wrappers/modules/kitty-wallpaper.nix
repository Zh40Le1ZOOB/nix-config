{ pkgs, ... }:
{
  wrappers.kitty-wallpaper = {
    basePackage = pkgs.kitty;
    prependFlags = [
      "+kitten"
      "panel"
      "--edge=background"
      "--config"
      "${pkgs.writeText "kitty.conf" ''
        background_image ${
          pkgs.runCommand "wallpaper.png" { nativeBuildInputs = [ pkgs.imagemagick ]; }
            "magick ${
              pkgs.fetchurl {
                url = "https://cs.gzmtr.com/ckfw/xlu_2020/202412/W020241228010203039845.png";
                hash = "sha256-gb7hoddE9bMMJbmaLaKNjBCWzOC2URpqklITiD3nJI4=";
              }
            } -gravity center -crop 5:4+0+60 $out"
        }
        background_image_layout cscaled
        background_tint 0.9
      ''}"
      "${pkgs.cava}/bin/cava"
    ];
  };
}

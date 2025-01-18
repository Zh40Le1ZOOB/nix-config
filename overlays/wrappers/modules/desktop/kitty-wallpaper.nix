{ lib, pkgs, ... }:
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
                url = "https://appmsg.gzmtr.cn/DNSFile/Modules/map/map-20250929.webp";
                hash = "sha256-q2gepU+6ciXw8hU9y09GWLxRpzzap6eg051zUzX6LFg=";
              }
            } -gravity center -crop 5:4+0+60 $out"
        }
        background_image_layout cscaled
        background_tint 0.9
      ''}"
      "${lib.getExe pkgs.cava}"
    ];
  };
}

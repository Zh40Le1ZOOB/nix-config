{ pkgs, ... }:
let
  mkFishIntergration =
    name: package: command:
    pkgs.runCommand "${name}.fish"
      {
        buildInputs = [ package ];
      }
      ''
        export HOME=$TEMP
        mkdir $out
        ${command} > $out/${name}.fish
      '';
in
{
  wrappers.fish = pkgs.helpers.wrapFish pkgs.fish {
    plugins = with pkgs.fishPlugins; [
      autopair
      (fifc.overrideAttrs {
        version = "0.1.1-unstable-2024-12-04";
        src = pkgs.fetchFromGitHub {
          owner = "gazorby";
          repo = "fifc";
          rev = "a01650cd432becdc6e36feeff5e8d657bd7ee84a";
          hash = "sha256-Ynb0Yd5EMoz7tXwqF8NNKqCGbzTZn/CwLsZRQXIAVp4=";
        };
      })
    ];
    extraConf = [
      "${pkgs.kitty}/lib/kitty/shell-integration/fish/vendor_conf.d"
      (mkFishIntergration "atuin" pkgs.atuin "atuin init fish")
      (mkFishIntergration "carapace" pkgs.carapace "carapace _carapace fish")
      (mkFishIntergration "fzf" pkgs.fzf "fzf --fish")
      (mkFishIntergration "starship" pkgs.wrappers.starship "starship init fish")
      (mkFishIntergration "zoxide" pkgs.zoxide "zoxide init fish")
    ];
    pathAdd = with pkgs; [
      atuin
      bat
      chafa
      carapace
      coreutils
      eza
      fd
      fzf
      file
      findutils
      gawk
      gnused
      hexyl
      less
      man
      pcre
      procs
      procps
      ripgrep
      wrappers.starship
      zoxide
    ];
  };
}

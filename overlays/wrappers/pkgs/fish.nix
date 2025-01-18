{
  wrappers,
  runCommand,
  fish,
  fishPlugins,
  atuin,
  bat,
  chafa,
  carapace,
  coreutils,
  eza,
  fd,
  fzf,
  file,
  findutils,
  gawk,
  gnused,
  hexyl,
  less,
  man,
  pcre,
  procs,
  procps,
  ripgrep,
  starship,
  zoxide,
}:
let
  mkFishIntergration =
    name: package: command:
    runCommand "${name}.fish"
      {
        buildInputs = [ package ];
      }
      ''
        export HOME=$TEMP
        mkdir $out
        ${command} > $out/${name}.fish
      '';
in
wrappers.wrapFish fish {
  plugins = with fishPlugins; [
    autopair
    fifc
  ];
  extraConf = [
    (mkFishIntergration "atuin" atuin "atuin init fish")
    (mkFishIntergration "carapace" carapace "carapace _carapace fish")
    (mkFishIntergration "fzf" fzf "fzf --fish")
    (mkFishIntergration "starship" wrappers.starship "starship init fish")
    (mkFishIntergration "zoxide" zoxide "zoxide init fish")
  ];
  pathAdd = [
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
}

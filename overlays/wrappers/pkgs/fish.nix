{
  lib,
  wrappers,
  runCommand,
  fish,
  fishPlugins,
  catppuccin,
  chafa,
  carapace,
  coreutils,
  fd,
  fzf,
  file,
  findutils,
  gawk,
  gnused,
  hexyl,
  less,
  man,
  p7zip,
  procs,
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
        echo "fish_add_path ${lib.makeBinPath [ package ]}" > $out/${name}.fish
        ${command} >> $out/${name}.fish
      '';
in
wrappers.wrapFish {
  inherit fish;
  config = ''
    fish_config theme choose "Catppuccin Mocha"

    set -U fifc_bat_opts --terminal-width={$FZF_PREVIEW_COLUMNS} --style=changes,numbers
    set -U fifc_chafa_opts --size={$FZF_PREVIEW_COLUMNS}x{$FZF_PREVIEW_LINES}
    set -U fifc_exa_opts --width={$FZF_PREVIEW_COLUMNS} --all
    set -U fifc_fd_opts --hidden
    set -U fifc_hexyl_opts --terminal-width={$FZF_PREVIEW_COLUMNS} --border=none
  '';
  themes = [ "${catppuccin.fish}/Catppuccin Mocha.theme" ];
  plugins = with fishPlugins; [
    autopair
    fifc
  ];
  extraConf = [
    (mkFishIntergration "atuin" wrappers.atuin "atuin init fish")
    (mkFishIntergration "carapace" carapace "carapace _carapace fish")
    (mkFishIntergration "fzf" fzf "fzf --fish")
    (mkFishIntergration "starship" wrappers.starship "starship init fish")
    (mkFishIntergration "zoxide" zoxide "zoxide init fish")
  ];
  pathAdd = [
    wrappers.bat
    chafa
    coreutils
    wrappers.eza
    wrappers.fd
    file
    findutils
    gawk
    gnused
    hexyl
    less
    man
    p7zip
    procs
    ripgrep
  ];
}

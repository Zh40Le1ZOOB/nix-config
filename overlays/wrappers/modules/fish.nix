{
  config,
  lib,
  pkgs,
  ...
}:
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
        echo "fish_add_path ${lib.makeBinPath [ package ]}" > $out/${name}.fish
        ${command} >> $out/${name}.fish
      '';
in
{
  imports = [ pkgs.wrapFish.modules.default ];

  fish = {
    config = ''
      fish_config theme choose "Catppuccin Mocha"

      set -U fifc_bat_opts --terminal-width={$FZF_PREVIEW_COLUMNS} --style=changes,numbers
      set -U fifc_chafa_opts --size={$FZF_PREVIEW_COLUMNS}x{$FZF_PREVIEW_LINES}
      set -U fifc_exa_opts --width={$FZF_PREVIEW_COLUMNS} --all
      set -U fifc_fd_opts --hidden
      set -U fifc_hexyl_opts --terminal-width={$FZF_PREVIEW_COLUMNS} --border=none
    '';
    themes = [ "${pkgs.catppuccin.fish}/Catppuccin Mocha.theme" ];
    plugins = with pkgs.fishPlugins; [
      autopair
      fifc
    ];
    extraConf = with pkgs; [
      (mkFishIntergration "atuin" wrappers.atuin "atuin init fish")
      (mkFishIntergration "carapace" carapace "carapace _carapace fish")
      (mkFishIntergration "fzf" fzf "fzf --fish")
      (mkFishIntergration "starship" wrappers.starship "starship init fish")
      (mkFishIntergration "zoxide" zoxide "zoxide init fish")
    ];
  };
  wrappers.fish.overrideAttrs = _: {
    pathAdd = with pkgs; [
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
  };
}

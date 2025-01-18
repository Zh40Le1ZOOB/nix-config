{
  config,
  lib,
  pkgs,
  ...
}:
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

      atuin init fish | sed "s/-k up/up/g" | source
      carapace _carapace fish | source
      fzf --fish | source
      starship init fish | source
      zoxide init fish | source
    '';
    themes = [ "${pkgs.catppuccin.fish}/Catppuccin Mocha.theme" ];
    plugins = with pkgs.fishPlugins; [
      autopair
      fifc
    ];
    pathAdd = with pkgs; [
      wrappers.atuin
      wrappers.bat
      wrappers.eza
      wrappers.fd
      wrappers.starship
      chafa
      carapace
      coreutils
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
      zoxide
      iio-niri
    ];
  };
}

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
      fish_config theme choose catppuccin-mocha

      set -U fifc_custom_fzf_opts --bind=down:down,up:up,tab:toggle+down
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
    themes = [ "${pkgs.catppuccin.fish}/catppuccin-mocha.theme" ];
    plugins = with pkgs.fishPlugins; [
      fifc
      forgit
      pisces
      puffer
      plugin-sudope
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
      fzf
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

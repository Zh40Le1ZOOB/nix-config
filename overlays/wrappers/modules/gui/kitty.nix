{ pkgs, ... }:
{
  wrappers.kitty = {
    basePackage = pkgs.kitty;
    env.KITTY_CONFIG_DIRECTORY.value = pkgs.writeTextDir "kitty.conf" ''
      cursor_trail 1
      cursor_trail_start_threshold 0
      tab_bar_style powerline
      tab_powerline_style slanted
      background_opacity 0.9
    '';
  };
}

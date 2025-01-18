{ pkgs, ... }:
{
  wrappers.atuin = {
    basePackage = pkgs.atuin;
    env.XDG_CONFIG_HOME.value = pkgs.runCommand "atuin-config" { } ''
      mkdir -p $out/atuin/themes/
      cp ${pkgs.catppuccin.atuin}/mocha/catppuccin-mocha-blue.toml $out/atuin/themes/
      cat << EOF > $out/atuin/config.toml
      workspaces = true
      style = "auto"
      inline_height = 0
      command_chaining = true
      enter_accept = true
      [theme]
      name = "catppuccin-mocha-blue"
      EOF
    '';
  };
}

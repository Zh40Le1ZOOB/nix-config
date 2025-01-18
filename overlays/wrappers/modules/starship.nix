{ pkgs, ... }:
{
  wrappers.starship = {
    basePackage = pkgs.starship;
    env.STARSHIP_CONFIG.value = pkgs.writers.writeTOML "starship.toml" {
      character = {
        error_symbol = "[](red)[](fg:red bg:red)[](red)";
        success_symbol = "[](#5bcefa)[](fg:#5bcefa bg:#f5a9b8)[](fg:#f5a9b8 bg:#ffffff)[](fg:#ffffff bg:#f5a9b8)[](fg:#f5a9b8 bg:#5bcefa)[](#5bcefa)";
      };
    };
  };
}

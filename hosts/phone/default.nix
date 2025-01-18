{ pkgs, ... }:
{
  android-integration.xdg-open.enable = true;

  environment = {
    packages = with pkgs; [
      wrappers.fish
      gh
      git
      neovim
      nixfmt-rfc-style
      openssh
    ];
    etcBackupExtension = ".bak";
    motd = null;
    sessionVariables.LANG = "zh_CN.UTF-8";
  };

  terminal.font = "${pkgs.nerd-fonts.fira-code}/share/fonts/truetype/NerdFonts/FiraCode/FiraCodeNerdFontMono-Regular.ttf";

  time.timeZone = "Asia/Shanghai";

  user.shell = "${pkgs.wrappers.fish}/bin/fish";

  system.stateVersion = "24.05";

  nix = {
    package = pkgs.nixVersions.latest;
    extraOptions = "experimental-features = nix-command flakes";
    substituters = [ "https://mirrors.sjtug.sjtu.edu.cn/nix-channels/store" ];
  };
}

{ pkgs, ... }:
{
  time.timeZone = "Asia/Shanghai";
  i18n = {
    defaultLocale = "zh_CN.UTF-8";
    inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5 = {
        waylandFrontend = true;
        addons = [ pkgs.kdePackages.fcitx5-chinese-addons ];
        ignoreUserConfig = true;
        settings = {
          inputMethod."Groups/0" = {
            "Default Layouts" = "us";
            "DefaultIM" = "pinyin";
          };
          addons.pinyin.globalSection.PageSize = 10;
        };
      };
    };
  };
}

{ pkgs, ... }:
{
  boot.kernelPatches = [
    {
      name = "cjktty";
      patch = pkgs.fetchpatch2 {
        url = "https://github.com/bigshans/cjktty-patches/raw/refs/heads/master/v6.x/cjktty-6.16.patch";
        hash = "sha256-pkifmJEK5Tyapu3SV+aHS7zhjhW2VN3IKM2bm39ohfk=";
      };
    }
    {
      name = "cjktty-32";
      patch = pkgs.fetchpatch2 {
        url = "https://github.com/bigshans/cjktty-patches/raw/refs/heads/master/cjktty-add-cjk32x32-font-data.patch";
        hash = "sha256-LMGk3NcyDNlWATK/S0AT3MglBCzxnMQYXJ/WvcFqwrI=";
      };
    }
  ];
}

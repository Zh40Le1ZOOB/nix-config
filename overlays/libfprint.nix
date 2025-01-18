final: prev:
let
  pkgs = final;
  inherit (pkgs) lib;
in
{
  libfprint-focaltech-2808 = prev.libfprint-focaltech-2808-a658.overrideAttrs (oldAttrs: {
    pname = "libfprint-focaltech-2808";
    src = pkgs.fetchurl {
      url = "https://github.com/ftfpteams/focaltech-linux-fingerprint-driver/raw/5380391592b693e092747b5dd18dbef7a5731fd4/Ubuntu_Debian/x86/libfprint-2-2_1.94.4+tod1-0ubuntu1~22.04.2_amd64_20250714.deb";
      hash = "sha256-ftcaGzguf59qUEyTPgzP4OWpM2VJVU3EJBA2cxKC/do=";
    };
    nativeBuildInputs = with pkgs; [
      dpkg
      pkg-config
      autoPatchelfHook
      copyPkgconfigItems
    ];
    buildInputs = with pkgs; [
      stdenv.cc.cc
      glib
      gusb
      pixman
      nss
      libgudev
      (libfprint.overrideAttrs (
        finalAttrs: _: {
          version = "1.94.4";
          src = fetchFromGitLab {
            domain = "gitlab.freedesktop.org";
            owner = "libfprint";
            repo = "libfprint";
            rev = "v${finalAttrs.version}";
            hash = "sha256-C8vBjk0cZm/GSqc6mgNbXG8FycnWRaXhj9wIrLcWzfE=";
          };
        }
      ))
      cairo
    ];
    unpackPhase = ''
      runHook preUnpack

      dpkg -x $src .

      runHook postUnpack
    '';
    installPhase = lib.replaceString "lib64" "lib/x86_64-linux-gnu" oldAttrs.installPhase;
    meta = lib.removeAttrs oldAttrs.meta [ "broken" ];
  });
}

{
  lib,
  stdenv,
  fetchFromGitHub,
}:

stdenv.mkDerivation rec {
  pname = "rtl8188eu";
  version = "unstable-2023-07-29";

  src = fetchFromGitHub {
    owner = "lwfinger";
    repo = "rtl8188eu";
    rev = "f5d1c8df2e2d8b217ea0113bf2cf3e37df8cb716";
    hash = "sha256-qE9P8AJu7BS/XJzXiwZt/XzrSvbAiYsfy5PM91KOQ2g=";
  };

  meta = {
    description = "Repository for stand-alone RTL8188EU driver";
    homepage = "https://github.com/lwfinger/rtl8188eu";
    license = lib.licenses.gpl2Only; # FIXME: nix-init did not find a license
    maintainers = with lib.maintainers; [ codeandb ];
    mainProgram = "rtl8188eu";
    platforms = lib.platforms.all;
  };
}

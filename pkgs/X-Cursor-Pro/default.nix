{
  lib,
  stdenv,
  fetchurl,
  pkgs,
}:

stdenv.mkDerivation rec {
  pname = "x-cursor-pro";
  version = "2.0.2";

  src = fetchurl {
    url = "https://github.com/ful1e5/XCursor-pro/releases/download/v${version}/xcursor-pro-all.tar.xz";
    sha256 = "0xhkq2x6bzmv2skfsk6m5rsx49x72qz27n8857avlxlx3h3lq1cy";
  };
 
# dontUnpack = true;
 
 nativeBuildInputs = [ pkgs.gnutar ]; 

 installPhase = ''
 runHook preInstall
 mkdir -p $out/share/icons
 cp -a XCursor-pro $out/share/icons
 runHook postInstall
 '';

  meta = {
    description = "Modern XCursors";
    homepage = "https://github.com/ful1e5/XCursor-pro/";
    changelog = "https://github.com/ful1e5/XCursor-pro/blob/${src.rev}/CHANGELOG.md";
    license = lib.licenses.gpl3Only;
    maintainers = with lib.maintainers; [ codeandb ];
    mainProgram = "x-cursor-pro";
    platforms = lib.platforms.all;
  };
}

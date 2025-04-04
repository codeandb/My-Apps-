{
  lib,
  stdenv,
  fetchFromGitHub,
}:

stdenv.mkDerivation rec {
  pname = "x-cursor-pro";
  version = "2.0.2";

  src = fetchFromGitHub {
    owner = "ful1e5";
    repo = "XCursor-pro";
    rev = "v${version}";
    hash = "sha256-vKNvTyJ50vHXoRsalmkityP7Dnf1KkD2uq13kgWniQY=";
  };
  
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

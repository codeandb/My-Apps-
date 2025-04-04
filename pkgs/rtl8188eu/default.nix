{
  lib,
  stdenv,
  fetchFromGitHub,
  kernel,
  bc,
  linuxHeaders,
}:

stdenv.mkDerivation {
  pname = "rtl8188eu";
  version = "5.2.2.4.r794.53ed527"; # Matches driver version

  src = fetchFromGitHub {
    owner = "lwfinger";
    repo = "rtl8188eu";
    rev = "f5d1c8df2e2d8b217ea0113bf2cf3e37df8cb716"; # Check if tag exists, otherwise use commit hash
    sha256 = "sha256-qE9P8AJu7BS/XJzXiwZt/XzrSvbAiYsfy5PM91KOQ2g="; # Use `nix hash to-sri sha256:$(nix-prefetch-url --unpack $url)`
  };

  hardeningDisable = [ "pic" ];

  nativeBuildInputs = [
    bc
    linuxHeaders
  ] ++ kernel.moduleBuildDependencies;

  makeFlags =
    [
      "ARCH=${stdenv.hostPlatform.linuxArch}"
    ]
    ++ lib.optionals (stdenv.hostPlatform != stdenv.buildPlatform) [
      "CROSS_COMPILE=${stdenv.cc.targetPrefix}"
    ];

  postPatch = ''
    substituteInPlace ./Makefile \
      --replace /lib/modules/ "${kernel.dev}/lib/modules/" \
      --replace "/sbin/depmod" "#" \
      --replace '$(MODDESTDIR)' "$out/lib/modules/${kernel.modDirVersion}/kernel/net/wireless/" 
    sed -i -e '152d;164d' Makefile

  '';

  preInstall = ''
    mkdir -p "$out/lib/modules/${kernel.modDirVersion}/kernel/net/wireless/"
  '';

  enableParallelBuilding = true;

  meta = {
    description = "Linux driver for RTL8188EU";
    homepage = "https://github.com/lwfinger/rtl8188eu";
    license = lib.licenses.gpl2Only;
    platforms = lib.platforms.linux;
    maintainers = with lib.maintainers; [ codeandb ];
  };
}

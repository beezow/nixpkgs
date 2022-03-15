{lib, stdenv, fetchurl, unzip, makeDesktopItem, copyDesktopItems
, nwjs
, autoPatchelfHook
, wrapGAppsHook, gsettings-desktop-schemas, gtk3 }:

let
  pname = "jesc-configurator";
  desktopItem = makeDesktopItem {
    name = pname;
    exec = pname;
    icon = pname;
    comment = "JESC configuration tool";
    desktopName = "JESC Configurator";
    genericName = "ESC configuration tool";
  };
in
stdenv.mkDerivation rec {
  inherit pname;
  version = "1.2.9";
  src = fetchurl {
    url = "https://github.com/jflight-public/jesc-configurator/releases/download/v${version}/JESC-Configurator_linux64_${version}.zip";
    sha256 = "704f63f4d6e05d9ac28bde73deeafb4119a8200c68029087e1453bd62431934f";
  };

  nativeBuildInputs = [ 
    unzip
    copyDesktopItems
    autoPatchelfHook
  ];

  buildInputs = [ nwjs gsettings-desktop-schemas gtk3 ];

  installPhase = ''
    mkdir -p $out/bin
    cp "jesc-configurator" $out/bin
  '';
}


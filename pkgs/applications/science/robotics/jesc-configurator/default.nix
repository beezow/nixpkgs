{lib, stdenv, fetchurl, unzip, makeDesktopItem, copyDesktopItems
, makeWrapper
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
    url = "https://github.com/jflight-public/jesc-configurator/archive/refs/tags/v${version}.zip";
    sha256 = "4d06b8e10ccd17c9cc219445a9a5fc9453621d956ba04fc1d43e9021e9ef0b1a";
  };

  nativeBuildInputs = [ 
    unzip
    makeWrapper
    wrapGAppsHook
    copyDesktopItems
  ];

  buildInputs = [ nwjs gsettings-desktop-schemas gtk3 ];

  installPhase = ''
    mkdir -p $out/opt/${pname}
    mv * $out/opt/${pname}
    makeWrapper ${nwjs}/bin/nw $out/bin/${pname} --add-flags $out/opt/${pname}
  '';
}


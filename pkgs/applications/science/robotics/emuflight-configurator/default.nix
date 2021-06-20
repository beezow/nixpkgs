{lib, stdenv, fetchurl, unzip, makeDesktopItem, nwjs, wrapGAppsHook, gsettings-desktop-schemas, gtk3 }:

let
  pname = "emuflight-configurator";
  desktopItem = makeDesktopItem {
    name = pname;
    exec = pname;
    icon = pname;
    comment = "Emuflight configuration tool";
    desktopName = "Emuflight Configurator";
    genericName = "Flight controller configuration tool";
  };
in
stdenv.mkDerivation rec {
  inherit pname;
  version = "0.3.5";
  src = fetchurl {
    url = "https://github.com/emuflight/EmuConfigurator/releases/download/${version}/emuflight-configurator_${version}_linux64.zip";
    sha256 = "d55bdc52cf93d58c728ccb296ef912a5fc0f42c57ed95f3ded5f85d1c10838c4";
  };

  nativeBuildInputs = [ wrapGAppsHook unzip ];

  buildInputs = [ gsettings-desktop-schemas gtk3 ];

  installPhase = ''
    mkdir -p $out/bin \
             $out/opt/${pname}

    cp -r . $out/opt/${pname}/
    install -m 444 -D icon/emu_icon_128.png $out/share/icons/hicolor/128x128/apps/${pname}.png
    cp -r ${desktopItem}/share/applications $out/share/

    makeWrapper ${nwjs}/bin/nw $out/bin/${pname} --add-flags $out/opt/${pname}
  '';

  meta = with lib; {
    description = "The Emuflight flight control system configuration tool";
    longDescription = ''
      A crossplatform configuration tool for the Emuflight flight control system.
      Various types of aircraft are supported by the tool and by Emuflight, e.g.
      quadcopters, hexacopters, octocopters and fixed-wing aircraft.
      The application allows you to configure the Emuflight software running on any supported Emuflight target.
    '';
    homepage    = "https://github.com/emuflight/EmuConfigurator/wiki";
    license     = licenses.gpl3;
    maintainers = with maintainers; [ beezow ];
    platforms   = platforms.linux;
  };
}

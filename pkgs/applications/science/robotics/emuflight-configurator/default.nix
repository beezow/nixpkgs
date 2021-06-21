{lib, stdenv, callPackage, fetchurl, unzip, makeDesktopItem, nwjs, yarn, nodePackages, yarn2nix, gnutar 
, libX11, glib, libxcb,  wrapGAppsHook, gsettings-desktop-schemas, gtk3 }:

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
    url = "https://github.com/emuflight/EmuConfigurator/archive/refs/tags/${version}.tar.gz";
    sha256 = "9861680694b7bde28fce947159f882fd47dfbc8407a55a647a51e169de0e5b5f";
  };


  nativeBuildInputs = [ gnutar yarn nwjs wrapGAppsHook nodePackages.gulp nodePackages.node2nix yarn2nix];

  buildInputs = [ gsettings-desktop-schemas gtk3 libX11 glib];

#  configurePhase = ''
#    node2nix
#    nix-build default.nix   
#    mv result
#  '';
 # let 
  nodeDependencies = (callPackage ./node.nix{}).shell.nodeDependencies;
#  in
  buildPhase = ''
    ln -s ${nodeDependencies}/lib/node_modules ./node_modules;
    export PATH="${nodeDependencies}/bin:$PATH";
    yarn gulp apps --linux64;
  '';

   installPhase = ''
      mkdir -p $out/bin \
              $out/opt/${pname}
 
     cp -r $sourcRoot/apps/${pname}/linux64 $out/opt/${pname}/

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
    license     = licenses.gpl3Only;
    maintainers = with maintainers; [ beezow ];
    platforms   = platforms.linux;
  };
}

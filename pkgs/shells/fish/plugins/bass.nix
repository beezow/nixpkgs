{ lib, buildFishPlugin, fetchFromGitHub, python }:

buildFishPlugin rec {
  pname = "bass";
  version = "1.0";

  src = fetchFromGitHub {
    owner = "edc";
    repo = pname;
    rev = "v${version}";
    sha256 = "03693ywczzr46dgpnbawcfv02v5l143dqlz1fzjbhpwwc2xpr42y";
  };

  #buildFishplugin will only move the .fish files, but bass also relies on python
  postInstall = ''
    cp functions/__bass.py $out/share/fish/vendor_functions.d/
  '';  

  checkInputs = [ python ];
  checkPhase = ''
    make test
  '';

  meta = with lib; {
    description = "Bass makes it easy to use utilities written for Bash in fish shell.";
    homepage = "https://github.com/edc/bass";
    license = licenses.mit;
    maintainers = with maintainers; [ beezow ];
  };
}

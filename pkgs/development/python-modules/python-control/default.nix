{ lib
, buildPythonPackage
, fetchPypi
, scipy
, numpy
, matplotlib
}:

buildPythonPackage rec {
  pname = "control";
  version = "0.9.1";

  src = fetchPypi {
    pname = "control";
    inherit version;
    sha256 = "8c9084bf386eafcf5d74008f780fae6dec68d243d18a380c866ac10a3549f8d3";
  };

  propagatedBuildInputs = [ numpy scipy matplotlib];

  doCheck = false;

  meta = with lib; {
    description = "A Python image library that sits on top of Pillow, Wand and OpenCV";
    homepage = "https://github.com/torchbox/Willow/";
    license = licenses.bsd2;
    maintainers = with maintainers; [ desiderius ];
  };

}

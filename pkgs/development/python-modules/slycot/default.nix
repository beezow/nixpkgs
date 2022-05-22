{ lib
, buildPythonPackage
, fetchPypi
, numpy
, scikit-build
, cmake
}:

buildPythonPackage rec {
  pname = "slycot";
  version = "0.4.0.0";

  src = fetchPypi {
    pname = "slycot";
    inherit version;
    sha256 = "1d9921e9b04a5b9892870fd3481f7b08e6fa083a1a3848ad262819de19eb5e02";
  };

  buildInputs = [ scikit-build cmake];

  propagatedBuildInputs = [ numpy ];

  doCheck = false;

  meta = with lib; {
    description = "A Python image library that sits on top of Pillow, Wand and OpenCV";
    homepage = "https://github.com/torchbox/Willow/";
    license = licenses.bsd2;
    maintainers = with maintainers; [ desiderius ];
  };

}

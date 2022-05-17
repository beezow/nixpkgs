{ lib
, buildPythonPackage
, fetchPypi
, pythonOlder
}:

buildPythonPackage rec {
  pname = "v4l2py";
  version = "0.6.1";
  disabled = pythonOlder "3.7";

  src = fetchPypi {
    inherit version;
    inherit pname;
    sha256 = "d5bcb0eb235be0817dc4398d78cb9ca5a9f375664e4cea519d5814bfcd221909";
  };

  propagatedBuildInputs = [ ];

  # Test data is not included
  # https://github.com/torchbox/Willow/issues/34
  doCheck = false;

  meta = with lib; {
    description = "A Python image library that sits on top of Pillow, Wand and OpenCV";
    homepage = "https://github.com/torchbox/Willow/";
    license = licenses.bsd2;
    maintainers = with maintainers; [ beezow  ];
  };

}

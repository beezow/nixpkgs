{ lib
, buildPythonPackage
, fetchPypi
}:

buildPythonPackage rec {
  pname = "v4l2capture";
  version = "12";

  src = fetchPypi {
    inherit version;
    inherit pname;
    sha256 = "55c67161b47d0734f69895a6e012a562cfcad5b0d105aa7b95385f61d14c8121";
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

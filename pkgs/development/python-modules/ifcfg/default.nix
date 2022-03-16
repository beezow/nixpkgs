{ lib
, fetchPypi
, buildPythonApplication
, iproute2
}:

buildPythonApplication rec{
  pname = "ifcfg";
  version = "0.22";
  format = "setuptools";

  src = fetchPypi {
    inherit pname version;
    sha256 = "2960e94e197092877309905dbe18a297c48585f88007be265e0593adae640cd1";
  };

  propagatedBuildInputs = [
    iproute2
  ];

  doCheck = false;

  meta = with lib; {
    description = "Ifcfg is a cross-platform (Windows/Unix) library for parsing ifconfig and ipconfig output in Python";
    homepage = "https://github.com/ftao/python-ifcfg";
    license = licenses.bsd3;
    platforms = platforms.linux;
    maintainers = with maintainers; [ beezow ];
  };
}

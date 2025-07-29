pkgs: (

  let

    python = pkgs.python311;
    build = python.pkgs.buildPythonPackage;
    fetch = pkgs.fetchPypi;

  in python.withPackages (ps: with ps; [

    tflite-runtime

    (build {
      pname = "numpy";
      version = "1.26.4";
      pyproject = true;
      build-system = [ setuptools ];
      src = fetch {
        pname = "numpy";
        version = "1.26.4";
        sha256 = "sha256-KgKrqe0S5KxOs+qUIcQgMBoMZGDZgw10qd+H76SRIBA=";
      };
      nativeBuildInputs = [ cython ];
    })

    (build {
      pname = "pandas";
      version = "1.5.3";
      pyproject = true;
      build-system = [ setuptools ];
      src = fetch {
        pname = "pandas";
        version = "1.5.3";
        sha256 = "sha256-dKP9flp+wFLxgyc9x7Cs06hj7fdSD106F2XAT/2zsLE=";
      };
      propagatedBuildInputs = [ numpy cython ];
    })

    (build {
      pname = "scikit-learn";
      version = "1.4.0";
      pyproject = true;
      build-system = [ setuptools ];
      src = fetch {
        pname = "scikit-learn";
        version = "1.4.0";
        sha256 = "sha256-1Dc8mE66IOOTIW7dUaPj7t5Wy+k9QkdRbSBWQ8O5MSE=";
      };
      propagatedBuildInputs = [ numpy scipy cython ];
    })

    (build {
      pname = "lightgbm";
      version = "4.6.0";
      pyproject = false;
      build-system = [ setuptools ];
      src = fetch {
        pname = "lightgbm";
        version = "4.6.0";
        sha256 = "sha256-yxxZcg61aTicC6dNFPUjUbVzr0ifIwAyocnzFPi6t/4=";
      };
      nativeBuildInputs = with pkgs; [ cmake ninja pkg-config gcc ];
      propagatedBuildInputs = [ numpy ];
    })

    (build {
      pname = "lambda-multiprocessing";
      version = "0.5";
      pyproject = true;
      build-system = [ setuptools ];
      src = fetch {
        pname = "lambda-multiprocessing";
        version = "0.5";
        sha256 = "sha256-WykGJZ3SYeToDSXPCYZxZoCMv25+ERw67L7FzskmCT4=";
      };
    })

  ])
)

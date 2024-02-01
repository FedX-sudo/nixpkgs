{ lib
, buildPythonPackage
, pythonOlder
, fetchFromGitHub
, setuptools
, torch
, wheel
, which
, cloudpickle
, numpy
, h5py
, pytestCheckHook
}:

buildPythonPackage rec {
  pname = "tensordict";
  version = "0.3.0";
  pyproject = true;

  disabled = pythonOlder "3.8";

  src = fetchFromGitHub {
    owner = "pytorch";
    repo = "tensordict";
    rev = "refs/tags/v${version}";
    hash = "sha256-XTFUzPs/fqX3DPtu/qSE1hY+7r/HToPVPaTyVRzDT/E=";
  };

  nativeBuildInputs = [
    setuptools
    torch
    wheel
    which
  ];

  propagatedBuildInputs = [
    cloudpickle
    numpy
    torch
  ];

  pythonImportsCheck = [
    "tensordict"
  ];

  # We have to delete the source because otherwise it is used instead of the installed package.
  preCheck = ''
    rm -rf tensordict
  '';

  nativeCheckInputs = [
    h5py
    pytestCheckHook
  ];

  meta = with lib; {
    description = "A pytorch dedicated tensor container";
    changelog = "https://github.com/pytorch/tensordict/releases/tag/v${version}";
    homepage = "https://github.com/pytorch/tensordict";
    license = licenses.mit;
    maintainers = with maintainers; [ GaetanLepage ];
  };
}

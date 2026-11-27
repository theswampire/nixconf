{
  fetchFromGitLab,
  rustPlatform,
  git,
}:
rustPlatform.buildRustPackage {
  pname = "sockeye";
  version = "0.0.1";

  src = fetchFromGitLab {
    owner = "project-opensockeye";
    repo = "sockeye";
    rev = "52e5b9ba0cd0443fd63fcaa1705c27318d34ce03";
    hash = "sha256-DCem15RSzohf1qxMQqgUkNtAY1nTvtMHhtFAAukUP+8=";
    domain = "gitlab.inf.ethz.ch";
  };

  nativeBuildInputs = [git];

  cargoHash = "sha256-LWvVbWm+hW0huIYPGbQVsGYAQrgmc/luBfZOfhtQzJE=";
  doCheck = false;
}

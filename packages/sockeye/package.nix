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
    rev = "6fc84958ccb425e57edefc7f28353b59e9e87897";
    hash = "sha256-uUeSN8AUqc4weyoZ2VgOE3j+yNaXiNbMKj9l9uFM2e0=";
    domain = "gitlab.inf.ethz.ch";
  };

  nativeBuildInputs = [git];

  patches = [./0001-lsp-very-adhoc-textDocument-hover-support.patch];

  cargoHash = "sha256-LWvVbWm+hW0huIYPGbQVsGYAQrgmc/luBfZOfhtQzJE=";
  doCheck = false;
}

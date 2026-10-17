{ stdenv }:
stdenv.mkDerivation {
  name = "aspm_powerswitch";
  version = "1.0";
  src = ./.;
  buildPhase = ''
    gcc -o aspm_powerswitch main.c
  '';
  installPhase = ''
    mkdir -p $out/bin
    cp aspm_powerswitch $out/bin
  '';
}

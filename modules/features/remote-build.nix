let
  builder-name = "kaieiei-builder";
  secret-key = "${builder-name}-secret-key.pem";
  public-key = "${builder-name}-public-key.pem";
in
{
  flake.nixosModules.remote-build = {

    # enable cross-architecture building of nixos configs
    nix.settings.extra-platforms = [ "aarch64-linux" ];
    boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
    nix.settings.secret-key-files = [
      "/secrets/${secret-key}"
    ];

    system.activationScripts.checkRemoteSecretKey = {
      text = ''
        if [ ! -f /secrets/${secret-key} ]; then
            cat >&2 <<EOF

        FATAL: please create the '/secrets/${secret-key}' file that contains the signing key for remote builds:
           sudo sh -c "mkdir -p /secrets && \\
            nix-store --generate-binary-cache-key \\
            ${builder-name} \\
            /secrets/${secret-key} \\
            /secrets/${public-key} \\
            && echo 'Public Key:' && cat /secrets/${public-key}"

        EOF
            exit 1
        fi
      '';
      deps = [ ];
    };

  };
}

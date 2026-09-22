{
  flake.nixosModules.kai = { pkgs, ... }: {
    users = {
      mutableUsers = false;

      users.kai = {
        isNormalUser = true;
        description = "Kai";
        extraGroups = [
          "networkmanager"
          "wheel"
        ];
        hashedPasswordFile = "/secrets/passwd";
        shell = pkgs.zsh;
      };
    };
    system.activationScripts.checkPasswordFile = {
      text = ''
        if [ ! -f /secrets/passwd ]; then
            cat >&2 <<EOF

        FATAL: please create the '/secrets/passwd' file that contains the hashedPassword for the user:
           sudo sh -c "mkdir -p /secrets && mkpasswd > /secrets/passwd && chown root:shadow /secrets/passwd && chmod 600 /secrets/passwd"

        EOF
            exit 1
        fi
      '';
      deps = [ ];
    };

  };
}

{ inputs, ... }: {
  flake.nixosModules.media =
    let
      root-dir = "/mnt/sda1/nixflix/";

      nixflix-shared-api-key = "nixflix-shared-api-key";
      arr-admin-password = "arr-admin-password";
      wireguardconfig = "wireguardconfig-protonvpn";

      nixflix-shared-api-key-path = "/secrets/${nixflix-shared-api-key}";
      arr-admin-password-path = "/secrets/${arr-admin-password}";
      wireguardconfig-path = "/secrets/${wireguardconfig}";
    in
    {
      imports = [ inputs.nixflix.nixosModules.default ];

      networking.firewall.allowedTCPPorts = [
        8282
      ];

      nixflix = {
        enable = true;

        mediaDir = root-dir + "media";
        stateDir = root-dir + "state";
        downloadsDir = root-dir + "downloads";

        # download clients
        downloadarr.enable = false;
        torrentClients.qbittorrent = {
          enable = true;
          password._secret = nixflix-shared-api-key-path;
          # Set password hash here: nix run git+https://codeberg.org/feathecutie/qbittorrent_password -- --password 'plain-text-password-here'
          # Or look up temporary password with and set in ui: journalctl -u qbittorrent.service
          #serverConfig = {
          #  Preferences.WebUI.Password_PBKDF2 = "";
          #};
          categories =
            let
              torrent-dir = "qbittorrent/";
            in
            builtins.listToAttrs (
              builtins.map
                (k: {
                  name = k;
                  value = torrent-dir + k;
                })
                [
                  "radarr"
                  "sonarr"
                  "sonarr-anime"
                  "prowlarr"
                ]
            );
        };

        # tvshows
        # port: 8989
        sonarr = {
          enable = true;
          config.apiKey._secret = nixflix-shared-api-key-path;
          config.hostConfig.username = "admin";
          config.hostConfig.password._secret = arr-admin-password-path;
          openFirewall = true;
        };
        # port: 8990
        sonarr-anime = {
          enable = true;
          config.apiKey._secret = nixflix-shared-api-key-path;
          config.hostConfig.username = "admin";
          config.hostConfig.password._secret = arr-admin-password-path;
          openFirewall = true;
        };
        # movies
        # port: 7878
        radarr = {
          enable = true;
          config.apiKey._secret = nixflix-shared-api-key-path;
          config.hostConfig.username = "admin";
          config.hostConfig.password._secret = arr-admin-password-path;
          openFirewall = true;
        };
        # indexer
        # port: 9696
        prowlarr = {
          enable = true;
          config.apiKey._secret = nixflix-shared-api-key-path;
          config.hostConfig.username = "admin";
          config.hostConfig.password._secret = arr-admin-password-path;
          openFirewall = true;
        };
        flaresolverr = {
          enable = true;
        };

        # requester
        # port: 5055
        seerr = {
          enable = true;
          apiKey._secret = nixflix-shared-api-key-path;
          openFirewall = true;
        };
        # quality upgrader
        recyclarr = {
          enable = true;
        };

        # port: 8096
        jellyfin = {
          enable = true;
          users = {
            kai = {
              mutable = true;
              password = "password123";
              policy.isAdministrator = true;
            };
          };
          apiKey._secret = nixflix-shared-api-key-path;
          openFirewall = true;
          vpn.enable = false;
        };

        vpn = {
          enable = true;
          wgConfFile = wireguardconfig-path;
          accessibleFrom = [ "192.168.1.0/24" ];
        };
      };

      system.activationScripts.checkNixflixSecrets = {
        text = ''
          if [ ! -f /secrets/${nixflix-shared-api-key} ]; then
              cat >&2 <<EOF

          FATAL: please create the '/secrets/${nixflix-shared-api-key}' file that contains the shared nixflix api key:
             sudo sh -c "mkdir -p /secrets && \\
              openssl rand -hex 16 > /secrets/${nixflix-shared-api-key}"

          EOF
              exit 1
          fi

          if [ ! -f /secrets/${arr-admin-password} ]; then
              cat >&2 <<EOF

          FATAL: please create the '/secrets/${arr-admin-password}' file that contains the password for *arr user 'admin':
             sudo sh -c 'mkdir -p /secrets; read -rsp "Password: " p; echo; printf "%s\n" "$p" > /secrets/${arr-admin-password}; chmod 600 /secrets/${arr-admin-password}'

          EOF
              exit 1
          fi

          if [ ! -f /secrets/${wireguardconfig} ]; then
              cat >&2 <<EOF

          FATAL: please create the '/secrets/${wireguardconfig}' file that contains a wireguard-config for the vpn:

          EOF
              exit 1
          fi
        '';
        deps = [ ];
      };

    };
}

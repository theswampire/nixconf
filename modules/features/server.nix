{
  flake.nixosModules.server = {
    users.users.kai.openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINgUH2sZB6qaF0JmkaagAJ4dHh/pHSJKRmkOzpvNDXNu kaieiei.nixos"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAkGHZpBNBhYnnHWNg3i0crwNTK0hpGBvJcBURw8tTD/ kaieiei.win"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILWaB7FMj8HkOcSPrtcmkMsX2AuQfKVMV+o3gikjj/m1 kai@termius"
    ];

    services.openssh = {
      enable = true;
      openFirewall = true;
      settings = {
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
        PermitRootLogin = "no";
        AllowUsers = [ "kai" ];
      };
    };

    virtualisation.docker = {
      enable = true;
      autoPrune = {
        enable = true;
        allVolumes.enable = true;
      };
      enableOnBoot = true;
    };
  };
}

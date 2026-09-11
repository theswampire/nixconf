{
  flake.nixosModules.limeHardware =
    {
      lib,
      modulesPath,
      ...
    }:

    {
      imports = [
        (modulesPath + "/installer/scan/not-detected.nix")
      ];

      # needed for raspi to boot
      boot.kernelParams = [
        "console=ttyS0,115200n8"
        "console=ttyAMA0,115200n8"
        "console=tty0"
      ];

      boot.initrd.availableKernelModules = [
        "xhci_pci"
        "uas"
        "pcie_brcmstb"
        "reset-raspberrypi"
        "vc4"
        "usb-storage"
      ];
      boot.initrd.kernelModules = [ ];
      boot.kernelModules = [ ];
      boot.extraModulePackages = [ ];

      fileSystems."/" = {
        device = "/dev/disk/by-uuid/44444444-4444-4444-8888-888888888888";
        fsType = "ext4";
      };

      fileSystems."/mnt/sda1" = {
        device = "/dev/disk/by-uuid/93f533dd-d34a-4a43-ad03-a0e1b6b36fca";
        fsType = "ext4";
      };

      #fileSystems."/data/coolify" = {
      #  device = "/mnt/sda1/lime/coolify";
      #  fsType = "none";
      #  options = [ "bind" ];
      #};

      swapDevices = [ ];

      nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";
    };
}

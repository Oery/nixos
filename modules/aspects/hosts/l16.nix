{ inputs, den, lib, ... }:
{
  den.aspects.l16 = {
    includes = [ den.aspects.core den.aspects.desktop den.aspects.nix den.aspects.network ];

    nixos = { pkgs, modulesPath, ... }: {
      imports = [
        (modulesPath + "/installer/scan/not-detected.nix")
      ];

      fileSystems."/" = {
        device = "/dev/disk/by-label/NIXROOT";
        fsType = "ext4";
      };

      fileSystems."/efi" = {
        device = "/dev/disk/by-label/NIXBOOT";
        fsType = "vfat";
        options = [ "fmask=0022" "dmask=0022" ];
      };

      boot.loader.systemd-boot.enable = true;

      hardware.graphics.enable = true;

      services = {
        fstrim.enable = true;
        fprintd.enable = true;
      };

      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
      hardware.enableRedistributableFirmware = lib.mkDefault true;
    };
  };
}

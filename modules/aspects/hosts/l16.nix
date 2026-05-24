{ inputs, den, lib, ... }:
{
  den.aspects.l16 = {
    includes = [ den.aspects.core den.aspects.desktop den.aspects.nix den.aspects.network];

    nixos = { pkgs, modulesPath, ... }: {
      imports = [
        ../../../host-hardware/hardware-l16.nix
      ];

      boot.bootspec.enable = true;
      boot.kernelPackages = pkgs.linuxPackages_latest;
      
      boot.consoleLogLevel = 3;
      boot.kernelParams = [
        "quiet"
        "systemd.show_status=auto"
        "rd.udev.log_level=3"
        "plymouth.use-simpledrm"
      ];

      boot.loader = {
        efi = {
          canTouchEfiVariables = true;
          efiSysMountPoint = "/efi";
        };

        grub = {
          enable = true;
          efiSupport = true;
          device = "nodev";
          useOSProber = true;
        };
      };

      boot.plymouth.enable = true;
    };

  };
}

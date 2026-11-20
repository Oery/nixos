{
  den,
  ...
}:
{
  den.aspects.L16 = {
    includes = [
      den.aspects.roles.base
      den.aspects.roles.workstation
      den.aspects.roles.laptop
    ];

    provides.to-users = {
      homeManager.wayland.windowManager.hyprland.settings = {
        monitor = {
          output = "";
          mode = "preferred";
          position = "auto";
          scale = 1.25;
        };
        config.input = {
          accel_profile = "flat";
        };
      };
    };

    nixos = { pkgs, ... }: {
      imports = [
        ./_hardware.nix
      ];

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

{
  inputs,
  den,
  lib,
  ...
}:
{
  den.aspects.L16 = {
    includes = [
      den.aspects.core
      den.aspects.desktop
      den.aspects.nix
      den.aspects.network
      den.aspects.games.minecraft
    ];

    provides.to-users =
      { user, ... }:
      lib.optionalAttrs (user.userName == "oery") {
        homeManager.wayland.windowManager.hyprland.settings = {
          monitor = [
            ",preferred,auto,1.25"
          ];
          input = {
            kb_layout = "fr";
            accel_profile = "flat";
          };
        };
      };

    nixos = { pkgs, modulesPath, ... }: {
      imports = [
        ../../../host-hardware/hardware-l16.nix
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

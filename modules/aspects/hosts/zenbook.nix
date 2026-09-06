{
  inputs,
  den,
  lib,
  ...
}:
{
  den.aspects.ZenBook = {
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
            ",preferred,auto,1.4"
          ];
          input = {
            kb_layout = "fr";
            # touchpad = {
            #   natural_scroll = false;
            # };
          };
        };
      };

    nixos = { pkgs, modulesPath, ... }: {
      imports = [
        ../../../host-hardware/hardware-zenbook.nix
        (modulesPath + "/installer/scan/not-detected.nix")
      ];

      boot.loader = {
        efi = {
          canTouchEfiVariables = true;
          efiSysMountPoint = "/boot/efi";
        };
        systemd-boot = {
          enable = true;
          configurationLimit = 1;
        };
      };

      services = {
        fstrim.enable = true;
        fprintd.enable = true;
      };

      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
      hardware.enableRedistributableFirmware = lib.mkDefault true;
    };
  };
}

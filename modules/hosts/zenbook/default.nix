{
  inputs,
  den,
  lib,
  ...
}:
{
  den.aspects.ZenBook = {
    includes = [
      den.aspects.roles.base
      den.aspects.roles.workstation
    ];

    provides.to-users =
      { user, ... }:
      lib.optionalAttrs (user.userName == "oery") {
        homeManager.wayland.windowManager.hyprland.settings = {
          monitor = {
            output = "";
            mode = "preferred";
            position = "auto";
            scale = 1.4;
          };
          config.input = {
            kb_layout = "fr";
            # touchpad = {
            #   natural_scroll = false;
            # };
          };
        };
      };

    nixos = { pkgs, modulesPath, ... }: {
      imports = [
        ./_hardware.nix
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

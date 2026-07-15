{
  inputs,
  den,
  lib,
  ...
}:
{
  den.aspects.Elysium = {
    includes = [
      den.aspects.core
      den.aspects.desktop
      den.aspects.nix
      den.aspects.network
    ];

    provides.to-users =
      { user, ... }:
      lib.optionalAttrs (user.userName == "oery") {
        homeManager.wayland.windowManager.hyprland.settings = {
          env = [
            "WALLPAPER_TYPE,static"
          ];
          input = {
            kb_options = "caps:swapescape";
            touchpad = {
              disable_while_typing = true;
              scroll_factor = 0.2;
              natural_scroll = true;
            };
          };
        };
      };

    nixos =
      { pkgs, ... }:
      {
        imports = [
          ../../../host-hardware/hardware-elysium.nix
          inputs.apple-silicon.nixosModules.apple-silicon-support
        ];

        boot.loader.systemd-boot = {
          enable = true;
          configurationLimit = 5;
        };

        boot.loader.efi.canTouchEfiVariables = false;
        boot.kernelParams = [ "appledrm.show_notch=1" ];

        nixpkgs.overlays = [
          inputs.apple-silicon.overlays.apple-silicon-overlay
        ];

        hardware = {
          asahi = {
            enable = true;
            # peripheralFirmwareDirectory = /home/oery/.firmware;
          };

          graphics = {
            enable = true;
            enable32Bit = lib.mkForce false;
          };

          sensor.iio.enable = true;
        };

        services.fstrim.enable = true;

        nix.settings = {
          extra-substituters = [ "https://nixos-apple-silicon.cachix.org" ];
          extra-trusted-public-keys = [
            "nixos-apple-silicon.cachix.org-1:8psDu5SA5dAD7qA0zMy5UT292TxeEPzIz8VVEr2Js20="
          ];
        };
      };
  };
}

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

          # Fix aquamarine render node detection on Asahi (M1/M2 split-node GPUs)
          # https://github.com/hyprwm/aquamarine/pull/291
          # (final: prev: {
          #   aquamarine =
          #     let
          #       version = prev.aquamarine.version;
          #       patchStillNeeded = lib.versionOlder version "0.12.0";
          #     in
          #     if patchStillNeeded then
          #       prev.aquamarine.overrideAttrs (oldAttrs: {
          #         patches = (oldAttrs.patches or []) ++ [
          #           (final.fetchpatch {
          #             url = "https://github.com/hyprwm/aquamarine/commit/f44fecf278a4b7f03e26592db1aba88edd8e51b6.diff";
          #             hash = "sha256-BMZeKnmQ1HQzfE+Fktefgw/7WcPGLP+8jLej834HbJ0=";
          #           })
          #         ];
          #       })
          #     else
          #       builtins.throw ''
          #         =====================================================================
          #         The aquamarine Asahi renderD patch overlay in elysium.nix
          #         is no longer needed for version ${version}.
          #
          #         The fix (commit f44fecf / PR #291) is now included upstream.
          #         Remove the aquamarine overlay from:
          #           modules/aspects/hosts/elysium.nix
          #
          #         Tracked at: https://github.com/hyprwm/aquamarine/pull/291
          #         =====================================================================
          #       '';
          # })
        ];

        hardware.asahi.peripheralFirmwareDirectory = /home/oery/.firmware;
        hardware.graphics = {
          enable = true;
          enable32Bit = lib.mkForce false;
        };
        hardware.sensor.iio.enable = true;

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

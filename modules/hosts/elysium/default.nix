{
  inputs,
  den,
  lib,
  ...
}:
{
  flake-file.inputs.aurora.url = "github:aurora-silicon/nixos-aurora/channel-testing";

  den.aspects.Elysium = {
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
        homeManager.wayland.windowManager.hyprland = {
          systemd.enable = false;
          settings = {
            env = [
              { _args = [ "WALLPAPER_TYPE" "static" ]; }
            ];
            config.input = {
              kb_options = "caps:swapescape";
              touchpad = {
                disable_while_typing = true;
                scroll_factor = 0.2;
                natural_scroll = true;
              };
            };
          };
        };
      };

    nixos =
      { ... }:
      {
        imports = [
          ./_hardware.nix
          inputs.aurora.inputs.apple-silicon.nixosModules.default
          inputs.aurora.nixosModules.default
        ];

        aurora.desktop = "minimal";
        # x86 guest Mesa for FEX; only buildable on x86_64, and not needed here.
        aurora.fexMesa.enable = false;
        # Ambient-light keyboard backlight daemon; disabled (races the ALS at boot).
        aurora.kbdLight.enable = false;

        # Aurora's SEP/Touch ID stack has no enable option and fails here
        # ("the enclave has no Touch ID keybag"), so turn its units off.
        systemd.timers.aurora-sep.enable = false;
        systemd.services = {
          aurora-sep.enable = false;
          aurora-sep-ready.enable = false;
          aurora-touchid-setup.enable = false;
          aurora-touchid-boot.enable = false;
        };
        services.fprintd.enable = lib.mkForce false;
        security.pam.services = {
          sudo.fprintAuth = lib.mkForce false;
          polkit-1.fprintAuth = lib.mkForce false;
        };

        # System is built from Aurora's nixpkgs (see flake/hosts.nix); keep the registry in sync.
        nix.registry.nixpkgs.flake = lib.mkForce inputs.aurora.inputs.nixpkgs;

        # Aurora boots via GRUB (removable EFI install); its kernel has no EFI stub,
        # so systemd-boot can't be used.
        # The ESP is only ~476 MB and GRUB copies every listed generation's kernel.
        boot.loader.grub.configurationLimit = 3;

        boot.loader.efi.canTouchEfiVariables = false;
        boot.kernelParams = [ "appledrm.show_notch=1" ];

        nixpkgs.overlays = [
          inputs.aurora.inputs.apple-silicon.overlays.default
          inputs.aurora.overlays.default
          # opencode's node_modules hash is broken in Aurora's pinned nixpkgs.
          (_final: prev: {
            inherit (inputs.nixpkgs.legacyPackages.${prev.stdenv.hostPlatform.system}) opencode;
          })
        ];

        hardware = {
          asahi.enable = true;

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

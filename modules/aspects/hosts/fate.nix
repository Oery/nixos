{ inputs, den, lib, ... }:
{
  den.aspects.fate = {
    includes = [ den.aspects.core den.aspects.desktop den.aspects.nix den.aspects.network ];

    nixos = { pkgs, ... }: {
      imports = [
        ../../../host-hardware/hardware-fate.nix
      ];

      boot.loader.systemd-boot = {
        enable = true;
        configurationLimit = 5;
      };
    };
  };
}

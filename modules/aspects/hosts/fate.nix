{ inputs, den, lib, ... }:
{
  den.aspects.Fate = {
    includes = [ den.aspects.core den.aspects.desktop den.aspects.nix den.aspects.network den.aspects.games.minecraft ];

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

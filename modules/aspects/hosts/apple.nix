{ inputs, den, lib, ... }:
{
  den.aspects.apple = {
    includes = [ den.aspects.core den.aspects.nix den.aspects.network den.aspects.games.minecraft ];

    darwin = { pkgs, ... }: {
      networking.hostName = "apple";
    };
  };
}

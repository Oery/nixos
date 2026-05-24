{ inputs, den, lib, ... }:
{
  den.aspects.apple = {
    includes = [ den.aspects.core den.aspects.nix den.aspects.network ];

    darwin = { pkgs, ... }: {
      networking.hostName = "apple";
    };
  };
}

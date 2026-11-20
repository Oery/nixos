# Every host.
{ den, ... }:
{
  den.aspects.roles.base.includes = [
    den.aspects.core
    den.aspects.nix
    den.aspects.network
  ];
}

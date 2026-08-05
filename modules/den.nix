{ lib, den, ... }:
{
  den.hosts.aarch64-linux.Elysium = {
    hostName = "Elysium";
    users.oery = { };
  };
  den.hosts.x86_64-linux.L16 = {
    hostName = "L16";
    users.oery = { };
  };
  den.hosts.x86_64-linux.ZenBook = {
    hostName = "ZenBook";
    users.oery = { };
  };
  den.hosts.x86_64-linux.Fate = {
    hostName = "Fate";
    users.oery = { };
  };
  den.hosts.x86_64-linux.Stronghold = {
    hostName = "Stronghold";
    users.oery = { };
  };
  den.hosts.aarch64-darwin.apple = {
    hostName = "apple";
    users.oery = { };
  };

  den.homes.aarch64-linux.oery = { };
  den.homes.x86_64-linux.oery = { };

  den.schema.user.classes = lib.mkDefault [ "homeManager" ];
  den.schema.user.includes = [ den.batteries.mutual-provider ];
}

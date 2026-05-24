{ lib, ... }:
{
  den.hosts.aarch64-linux.elysium = {
    hostName = "Elysium";
    users.oery = { };
  };
  den.hosts.x86_64-linux.l16 = {
    hostName = "L16";
    users.oery = { };
  };
  den.hosts.x86_64-linux.zenbook = {
    hostName = "ZenBook";
    users.oery = { };
  };
  den.hosts.aarch64-darwin.apple = {
    hostName = "apple";
    users.oery = { };
  };

  den.homes.aarch64-linux.oery = { };
  den.homes.x86_64-linux.oery = { };

  den.schema.user.classes = lib.mkDefault [ "homeManager" ];
}

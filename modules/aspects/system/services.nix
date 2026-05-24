{ den, ... }:
{
  den.aspects.services = {
    nixos = { ... }: {
      services = {
        dbus.implementation = "broker";

        psd = {
          enable = true;
          resyncTimer = "10m";
        };
      };
    };
  };
}

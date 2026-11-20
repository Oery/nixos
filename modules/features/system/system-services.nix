{ den, ... }:
{
  den.aspects.system-services = {
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

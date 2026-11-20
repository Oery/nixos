_: {
  den.aspects.system-services = {
    nixos = _: {
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

{ den, ... }:
{
  den.aspects.bluetooth = {
    nixos = { pkgs, lib, ... }: {
      hardware.bluetooth = {
        enable = true;
        package = pkgs.bluez5-experimental;
        powerOnBoot = false;
      };

      environment.systemPackages = [pkgs.bluetui];

      systemd.user.services.telephony_client.enable = false;
    };
  };
}

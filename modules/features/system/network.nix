{ den, ... }:
{
  den.aspects.network = {
    nixos = { pkgs, ... }: {
      networking = {
        nameservers = [
          "1.1.1.1"
          "1.0.0.1"
          "2606:4700:4700::1111"
          "2606:4700:4700::1001"
        ];

        networkmanager = {
          enable = true;
          dns = "systemd-resolved";
          wifi.powersave = true;
        };

        enableIPv6 = true;
      };

      services = {
        openssh = {
          enable = true;
          settings.UseDns = true;
        };

        resolved = {
          enable = true;
          settings.Resolve.DNSOverTLS = "opportunistic";
        };

        tailscale.enable = true;
      };

      systemd.services.NetworkManager-wait-online.enable = false;
    };
  };
}

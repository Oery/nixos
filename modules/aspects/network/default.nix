{ den, ... }:
{
  den.aspects.network = {
    nixos = { pkgs, ... }: {
      networking = {
        nameservers = [ "9.9.9.9#dns.quad9.net" ];

        networkmanager = {
          enable = true;
          dns = "systemd-resolved";
          wifi.powersave = true;
        };

        enableIPv6 = false;
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

{ inputs, den, lib, ... }:
{
  den.aspects.Fate = {
    includes = [ den.aspects.core den.aspects.desktop den.aspects.nix den.aspects.network den.aspects.games.minecraft ];

    nixos = { pkgs, ... }: {
      imports = [
        ../../../host-hardware/hardware-fate.nix
      ];

      # Make the local store available to the other machines in the tailnet.
      # The signing key is generated once on Fate and deliberately kept outside
      # the Nix store so it survives rebuilds without being published.
      services.nix-serve = {
        enable = true;
        bindAddress = "0.0.0.0";
        secretKeyFile = "/var/lib/nix-serve/cache-priv-key.pem";
      };

      # nix-serve listens on all interfaces because the Tailscale address is
      # assigned dynamically. Only admit cache traffic over the tailnet.
      networking.firewall = {
        enable = true;
        allowedTCPPorts = [ 22 ];
        interfaces.tailscale0.allowedTCPPorts = [ 5000 ];
      };

      boot.loader.systemd-boot = {
        enable = true;
        configurationLimit = 5;
      };
    };
  };
}

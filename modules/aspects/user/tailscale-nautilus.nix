{ inputs, den, ... }:
{
  den.aspects.user.tailscale-nautilus = {
    homeManager = { ... }: {
      imports = [ inputs.tailscale-nautilus.homeManagerModules.default ];

      services.tailscale-nautilus-sidebar = {
        enable = true;

        # Tailscale SSH logs into a local account on the target. Hosts where
        # your username differs (e.g. shared servers) need an entry here, or
        # their bookmark will fail to connect:
        #   userMap = { eden = "admin"; };
      };
    };
  };
}

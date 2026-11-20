# How the homelab is reached. Every service is available on the LAN
# (192.168.1.0/24) and on the tailnet.
#
# - Tailnet: tailscale0 is trusted, so every port is open to tailnet peers.
# - LAN: each service opens its own ports next to its config:
#
#   service          port(s)                         where
#   Jellyfin         8096, 8920, udp 1900/7359       media-server.nix (openFirewall)
#   Immich           2283                            media-server.nix (openFirewall)
#   Home Assistant   8123, udp 5353 (mDNS), 5540     home-automation/
#   dawarich         3000 (nginx → 3002)             dawarich.nix
#   Radarr           7878                            arr-stack.nix (openFirewall)
#   Sonarr           8989                            arr-stack.nix (openFirewall)
#   Lidarr           8686                            arr-stack.nix (openFirewall)
#   Prowlarr         9696                            arr-stack.nix (openFirewall)
#   Bazarr           6767                            arr-stack.nix (openFirewall)
#   Transmission     9091 (VPN namespace)            arr-stack.nix (openFirewall)
#   SSH              22                              hosts/fate
_: {
  den.aspects.homelab-network.nixos.networking.firewall = {
    enable = true;
    trustedInterfaces = [ "tailscale0" ];
  };
}

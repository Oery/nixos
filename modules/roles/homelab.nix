# Self-hosted services. Expects /mnt/media. Network access: homelab/network.nix.
{ den, ... }:
{
  den.aspects.roles.homelab.includes = [
    den.aspects.homelab-network
    den.aspects.homelab-secrets
    den.aspects.homelab-backup
    den.aspects.media-server
    den.aspects.arr-stack
    den.aspects.dawarich
    den.aspects.home-automation
    den.aspects.discord-bot
    den.aspects.shade
  ];
}

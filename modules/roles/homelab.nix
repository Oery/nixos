# Self-hosted services. Expects /mnt/media and the tailnet.
{ den, ... }:
{
  den.aspects.roles.homelab.includes = [
    den.aspects.media-server
    den.aspects.arr-stack
    den.aspects.dawarich
    den.aspects.home-automation
    den.aspects.discord-bot
    den.aspects.seafile
    den.aspects.shade
  ];
}

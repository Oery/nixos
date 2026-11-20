{ lib, ... }:
{
  den.aspects.media-server.nixos = {
    services.jellyfin = {
      enable = true;
      openFirewall = true;
      user = "oery";
    };

    # Runs as oery with read-only access to /home so it can import photos
    # from the home directory (external libraries).
    services.immich = {
      enable = true;
      host = "0.0.0.0";
      port = 2283;
      openFirewall = true;
      user = "oery";
    };
    systemd.services.immich-server.serviceConfig.ProtectHome = lib.mkForce "read-only";
  };
}

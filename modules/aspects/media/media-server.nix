{ den, lib, ... }:
{
  den.aspects.media = {
    nixos =
      { pkgs, ... }:
      {
        services.jellyfin = {
          enable = true;
          openFirewall = true;
          user = "oery";
        };

        services.immich = {
          enable = true;
          host = "0.0.0.0";
          port = 2283;
          openFirewall = true;
          user = "oery";
        };

        systemd.services.immich-server.serviceConfig.ProtectHome = lib.mkForce "read-only";

        environment.systemPackages = [
          pkgs.jellyfin
          pkgs.jellyfin-web
          pkgs.jellyfin-ffmpeg
          pkgs.rocmPackages.amdsmi
        ];
      };
  };
}

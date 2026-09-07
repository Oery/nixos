{ den, ... }:
{
  den.aspects.dawarich = {
    nixos = {
      services.dawarich = {
        enable = true;
        configureNginx = false;
        localDomain = "fate";
        webPort = 3002;
        environment.APPLICATION_HOSTS = "127.0.0.1,::1,fate,100.124.121.72";
      };

      services.nginx.virtualHosts."dawarich" = {
        listen = [
          {
            addr = "0.0.0.0";
            port = 3000;
          }
        ];

        locations."/" = {
          proxyPass = "http://127.0.0.1:3002";
          recommendedProxySettings = true;
          proxyWebsockets = true;

          extraConfig = "client_max_body_size 500m;";
        };
      };

      networking.firewall.trustedInterfaces = [ "tailscale0" ];
    };
  };
}

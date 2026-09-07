{ den, ... }:
let
  networkService = "podman-network-seafile-net.service";
  secrets = "/var/lib/seafile/secrets.env";
in
{
  den.aspects.seafile.nixos =
    { pkgs, ... }:
    {
      virtualisation.podman = {
        enable = true;
        autoPrune.enable = true;
      };

      virtualisation.oci-containers = {
        backend = "podman";
        containers = {
          seafile-db = {
            image = "mariadb:11.4";
            autoStart = true;
            networks = [ "seafile-net" ];
            volumes = [ "/var/lib/seafile/mysql:/var/lib/mysql" ];
            environmentFiles = [ secrets ];
            environment = {
              MARIADB_AUTO_UPGRADE = "1";
              MARIADB_LOG_CONSOLE = "true";
            };
          };

          seafile-redis = {
            image = "redis:7.4";
            autoStart = true;
            networks = [ "seafile-net" ];
            volumes = [ "/var/lib/seafile/redis:/data" ];
          };

          seafile = {
            image = "seafileltd/seafile-mc:13.0-latest";
            autoStart = true;
            dependsOn = [ "seafile-db" "seafile-redis" ];
            networks = [ "seafile-net" ];
            ports = [ "80:80" ];
            volumes = [ "/var/lib/seafile/data:/shared" ];
            environmentFiles = [ secrets ];
            environment = {
              TIME_ZONE = "Europe/Paris";
              SEAFILE_SERVER_HOSTNAME = "fate";
              SEAFILE_SERVER_PROTOCOL = "http";
              SEAFILE_MYSQL_DB_HOST = "seafile-db";
              SEAFILE_MYSQL_DB_PORT = "3306";
              SEAFILE_MYSQL_DB_USER = "seafile";
              SEAFILE_MYSQL_DB_CCNET_DB_NAME = "ccnet_db";
              SEAFILE_MYSQL_DB_SEAFILE_DB_NAME = "seafile_db";
              SEAFILE_MYSQL_DB_SEAHUB_DB_NAME = "seahub_db";
              CACHE_PROVIDER = "redis";
              REDIS_HOST = "seafile-redis";
              REDIS_PORT = "6379";
            };
          };
        };
      };

      systemd.tmpfiles.rules = map (path: "d ${path} 0700 root root -") [
        "/var/lib/seafile"
        "/var/lib/seafile/mysql"
        "/var/lib/seafile/redis"
        "/var/lib/seafile/data"
      ];

      systemd.services = {
        podman-network-seafile-net = {
          description = "Create the Seafile Podman network";
          path = [ pkgs.podman ];
          serviceConfig = {
            Type = "oneshot";
            RemainAfterExit = true;
          };
          script = "podman network exists seafile-net || podman network create seafile-net";
          wantedBy = [ "multi-user.target" ];
        };

        podman-seafile-db = {
          after = [ networkService ];
          requires = [ networkService ];
        };
        podman-seafile-redis = {
          after = [ networkService ];
          requires = [ networkService ];
        };
        podman-seafile = {
          after = [ networkService ];
          requires = [ networkService ];
        };
      };

      networking.firewall.allowedTCPPorts = [ 80 ];
    };
}

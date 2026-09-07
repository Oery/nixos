{ den, ... }:
{
  den.aspects.homeAutomation.nixos =
    { pkgs, ... }:
    {
      services.home-assistant = {
        enable = true;
        extraComponents = [
          "default_config"
          "met"
          "radio_browser"
          "mobile_app"
          "esphome"
          "wled"
          "cast"
          "zeroconf"
          "ssdp"
          "matter"
        ];
        config = {
          default_config = { };
          homeassistant = {
            name = "Home";
            unit_system = "metric";
            temperature_unit = "C";
            time_zone = "Europe/Paris";
          };
          http = {
            server_host = "0.0.0.0";
            server_port = 8123;
          };
        };
      };

      # Work around an invalid PAA certificate in the production Matter DCL.
      services.matter-server = {
        enable = true;
        package = pkgs.python-matter-server.overridePythonAttrs (old: {
          patches = (old.patches or [ ]) ++ [
            ../hosts/matter-server-skip-bad-paa-cert.patch
          ];
        });
      };

      networking.firewall = {
        allowedTCPPorts = [ 8123 ];
        allowedUDPPorts = [ 5353 5540 ];
      };
    };
}

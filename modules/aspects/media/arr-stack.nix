{ den, inputs, lib, ... }:
{
  den.aspects.arrStack = {
    nixos = { pkgs, ... }: {
      imports = [ inputs.nixarr.nixosModules.default ];

      # Keep the stack private to the tailnet.
      networking.firewall.trustedInterfaces = [ "tailscale0" ];

      nixarr = {
        enable = true;
        mediaDir = "/mnt/media";
        mediaUsers = [ "oery" ];

        radarr.enable = true;
        sonarr.enable = true;
        lidarr.enable = true;
        prowlarr.enable = true;
        bazarr.enable = true;

        transmission = {
          enable = true;
          extraAllowedIps = [ "100.*" ];
          vpn.enable = true;
          peerPort = 51413;
          extraSettings = {
            download-queue-size = 2;
            rpc-host-whitelist-enabled = false;
          };
        };

        vpn = {
          enable = true;
          wgConf = "/data/.secret/vpn/wg.conf";
          accessibleFrom = [ "100.64.0.0/10" ];
        };

        prowlarr.settings-sync.enable-nixarr-apps = true;
        radarr.settings-sync.transmission.enable = true;
        sonarr.settings-sync.transmission = {
          enable = true;
          # Match nixarr's pre-created torrent directory.
          config.fields.tvCategory = "sonarr";
        };
        bazarr.settings-sync = {
          sonarr.enable = true;
          radarr.enable = true;
        };
      };

      # Override Transmission's /etc bind with the VPN namespace resolver.
      systemd.services.transmission.serviceConfig.BindReadOnlyPaths = lib.mkAfter [
        "/etc/netns/wg/resolv.conf:/etc/resolv.conf:norbind"
      ];

      # Renew Proton's NAT-PMP lease from inside the VPN namespace.
      systemd.services.proton-transmission-port-forward = {
        description = "Renew Proton VPN port forwarding for Transmission";
        bindsTo = [ "wg.service" "transmission.service" ];
        after = [ "wg.service" "transmission.service" ];
        wantedBy = [ "multi-user.target" ];

        path = [ pkgs.coreutils pkgs.libnatpmp pkgs.transmission_4 pkgs.gnused ];

        serviceConfig = {
          NetworkNamespacePath = "/run/netns/wg";
          User = "transmission";
          Group = "media";
          Restart = "always";
          RestartSec = "10s";
        };

        script = ''
          while true; do
            ${pkgs.coreutils}/bin/timeout 15s ${pkgs.libnatpmp}/bin/natpmpc -a 1 0 udp 60 -g 10.2.0.1 >/dev/null 2>&1 || {
              echo "Proton NAT-PMP UDP mapping failed; retrying"
              sleep 10
              continue
            }

            mapping="$(${pkgs.coreutils}/bin/timeout 15s ${pkgs.libnatpmp}/bin/natpmpc -a 1 0 tcp 60 -g 10.2.0.1 2>&1)" || {
              echo "Proton NAT-PMP TCP mapping failed; retrying"
              sleep 10
              continue
            }
            port="$(printf '%s\\n' "$mapping" | ${pkgs.gnused}/bin/sed -n 's/.*Mapped public port \([0-9][0-9]*\).*/\1/p')"

            case "$port" in
              ""|*[!0-9]*) ;;
              *) ${pkgs.transmission_4}/bin/transmission-remote 127.0.0.1:9091 --port "$port" ;;
            esac

            sleep 45
          done
        '';
      };

      # This name sorts before nixarr's duplicate rules (tmpfiles uses first match).
      systemd.tmpfiles.settings."00-arr-stack-torrents-perms" = lib.genAttrs
        (map (app: "/mnt/media/torrents/${app}") [ "radarr" "sonarr" "lidarr" ])
        (_: {
          d = {
          user = "transmission";
          group = "media";
          mode = "0775";
          };
        });

      services = lib.genAttrs [ "radarr" "sonarr" "lidarr" "prowlarr" ] (_: {
        settings.auth.required = "DisabledForLocalAddresses";
      });
    };
  };
}

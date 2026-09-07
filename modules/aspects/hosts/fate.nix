{ den, lib, ... }:
{
  den.aspects.Fate = {
    includes = [
      den.aspects.core
      den.aspects.desktop
      den.aspects.nix
      den.aspects.network
      den.aspects.games.minecraft
      den.aspects.media
      den.aspects.arrStack
      den.aspects.dawarich
      den.aspects.homeAutomation
      den.aspects.hydra
      den.aspects.seafile
    ];

    provides.to-users =
      { user, ... }:
      lib.optionalAttrs (user.userName == "oery") {
        homeManager.wayland.windowManager.hyprland.settings.monitor = [
          "HDMI-A-1, 1920x1080@240, auto, 1"
        ];
      };

    nixos = { pkgs, ... }: {
      imports = [ ../../../host-hardware/hardware-fate.nix ];

      fileSystems."/mnt/media" = {
        device = "/dev/disk/by-uuid/00e8627b-fe44-4c76-9e39-3a26948470f4";
        fsType = "ext4";
      };

      services.nix-serve = {
        enable = true;
        bindAddress = "0.0.0.0";
        secretKeyFile = "/var/lib/nix-serve/cache-priv-key.pem";
      };

      networking.firewall = {
        enable = true;
        allowedTCPPorts = [ 22 ];
        interfaces.tailscale0.allowedTCPPorts = [ 5000 ];
      };

      boot = {
        kernel.sysctl."net.ipv4.ip_forward" = lib.mkDefault 1;
        loader.systemd-boot = {
          enable = true;
          configurationLimit = 5;
        };
      };

      systemd.services.vendorfw = {
        description = "Static file server for Asahi peripheral firmware";
        wantedBy = [ "multi-user.target" ];
        after = [ "network.target" ];
        serviceConfig = {
          ExecStart = "${pkgs.darkhttpd}/bin/darkhttpd /var/lib/vendorfw --port 8482";
          DynamicUser = true;
          ProtectSystem = "strict";
          PrivateTmp = true;
          NoNewPrivileges = true;
        };
      };
    };
  };
}

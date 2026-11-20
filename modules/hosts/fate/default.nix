{ den, lib, ... }:
{
  den.aspects.Fate = {
    includes = [
      den.aspects.roles.base
      den.aspects.roles.workstation
      den.aspects.roles.homelab
    ];

    provides.to-users =
      { user, ... }:
      lib.optionalAttrs (user.userName == "oery") {
        homeManager.wayland.windowManager.hyprland.settings.monitor = {
          output = "HDMI-A-1";
          mode = "1920x1080@240";
          position = "auto";
          scale = 1;
        };
      };

    nixos = {
      imports = [ ./_hardware.nix ];

      # Fate runs the homelab services, so it must never sleep. Disabling the
      # targets blocks every suspend source (hypridle, power key, logind).
      systemd.targets = lib.genAttrs [ "sleep" "suspend" "hibernate" "hybrid-sleep" ] (_: {
        enable = false;
      });

      fileSystems."/mnt/media" = {
        device = "/dev/disk/by-uuid/00e8627b-fe44-4c76-9e39-3a26948470f4";
        fsType = "ext4";
      };

      networking.firewall = {
        enable = true;
        allowedTCPPorts = [ 22 ];
      };

      boot = {
        kernel.sysctl."net.ipv4.ip_forward" = lib.mkDefault 1;
        loader.systemd-boot = {
          enable = true;
          configurationLimit = 5;
        };
      };
    };
  };
}

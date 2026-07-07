{ inputs, den, lib, ... }:
{
  den.aspects.ZenBook = {
    includes = [ den.aspects.core den.aspects.desktop den.aspects.nix den.aspects.network ];

    provides.to-users = { user, ... }: lib.optionalAttrs (user.userName == "oery") {
      homeManager.wayland.windowManager.hyprland.settings = {
        monitor = ",preferred,auto,auto";
        env = [ "WALLPAPER_TYPE,static" ];
        input = {
          kb_layout = "fr";
          touchpad = { natural_scroll = false; };
        };
      };
    };

    nixos = { pkgs, modulesPath, ... }: {
      imports = [
        (modulesPath + "/installer/scan/not-detected.nix")
      ];

      fileSystems."/" = {
        device = "/dev/disk/by-uuid/9fb7be5b-3eaa-4f8d-8835-f80cf5be1544";
        fsType = "ext4";
      };

      swapDevices = [
        { device = "/dev/disk/by-uuid/74f7ad27-a469-407c-84e2-bbae7afff13d"; }
      ];

      boot.loader.systemd-boot.enable = true;

      services = {
        fstrim.enable = true;
        fprintd.enable = true;
      };

      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
      hardware.enableRedistributableFirmware = lib.mkDefault true;
    };
  };
}

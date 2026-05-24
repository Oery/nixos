{ inputs, den, lib, ... }:
{
  den.aspects.l16 = {
    includes = [ den.aspects.core den.aspects.desktop den.aspects.nix den.aspects.network ];

    provides.to-users = { user, ... }: lib.optionalAttrs (user.userName == "oery") {
      homeManager.wayland.windowManager.hyprland.settings = {
        monitor = [
          "DP-3, 1920x1080@279.86, 0x0, 1"
          "HDMI-A-1, 1920x1080@60, 1920x-500, 1, transform, 1"
        ];
        env = [
          "NVD_BACKEND,direct"
          "LIBVA_DRIVER_NAME,nvidia"
          "GBM_BACKEND,nvidia-drm"
          "__GLX_VENDOR_LIBRARY_NAME,nvidia-drm"
          "MOZ_DISABLE_RDD_SANDBOX,1"
          "WALLPAPER_TYPE,static"
        ];
        input = {
          kb_layout = "custom";
          kb_variant = "qwerty-to-azerty";
          accel_profile = "flat";
          touchpad = {
            natural_scroll = false;
          };
        };
        exec-once = [
          "[workspace 4]  \"xdg-open 'obsidian://open?vault=Avalon&file=Todo'\""
        ];
      };
    };

    nixos = { pkgs, modulesPath, ... }: {
      imports = [
        (modulesPath + "/installer/scan/not-detected.nix")
      ];

      fileSystems."/" = {
        device = "/dev/disk/by-label/NIXROOT";
        fsType = "ext4";
      };

      fileSystems."/efi" = {
        device = "/dev/disk/by-label/NIXBOOT";
        fsType = "vfat";
        options = [ "fmask=0022" "dmask=0022" ];
      };

      boot.loader.systemd-boot.enable = true;

      hardware.graphics.enable = true;

      services = {
        fstrim.enable = true;
        fprintd.enable = true;
      };

      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
      hardware.enableRedistributableFirmware = lib.mkDefault true;
    };
  };
}

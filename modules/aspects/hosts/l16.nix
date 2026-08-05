{ inputs, den, lib, ... }:
{
  den.aspects.L16 = {
    includes = [ den.aspects.core den.aspects.desktop den.aspects.nix den.aspects.network den.aspects.games.minecraft ];

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
        ../../../host-hardware/hardware-l16.nix
      ];

      boot.bootspec.enable = true;
      boot.kernelPackages = pkgs.linuxPackages_latest;
      
      boot.consoleLogLevel = 3;
      boot.kernelParams = [
        "quiet"
        "systemd.show_status=auto"
        "rd.udev.log_level=3"
        "plymouth.use-simpledrm"
      ];

      boot.loader = {
        efi = {
          canTouchEfiVariables = true;
          efiSysMountPoint = "/efi";
        };

        grub = {
          enable = true;
          efiSupport = true;
          device = "nodev";
          useOSProber = true;
        };
      };

      boot.plymouth.enable = true;
    };

  };
}

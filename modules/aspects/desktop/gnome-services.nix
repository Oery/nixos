{ den, ... }:
{
  den.aspects.gnome-services = {
    nixos = { pkgs, ... }: {
      programs.dconf.enable = true;

      nixpkgs.overlays = [
        (final: prev: {
          nautilus = prev.nautilus.overrideAttrs (nprev: {
            buildInputs =
              nprev.buildInputs
              ++ (with pkgs.gst_all_1; [
                gst-plugins-good
                gst-plugins-bad
              ]);
            # GTK >= 4.24 binds ext-background-effect-v1 and only asks for blur where a
            # CSS backdrop-filter covers the window, so Hyprland stops blurring it.
            # The backdrop-filter route makes GTK render its own full-window blur every
            # frame (noticeably less smooth), so hide the protocol from Nautilus and let
            # Hyprland apply its native blur instead. No-op on GTK < 4.24.
            preFixup = (nprev.preFixup or "") + ''
              gappsWrapperArgs+=(--set GDK_WAYLAND_DISABLE ext_background_effect_manager_v1)
            '';
          });
        })
      ];

      programs.nautilus-open-any-terminal = {
        enable = true;
        terminal = "alacritty";
      };

      environment.systemPackages = with pkgs; [
        ffmpeg-headless
        ffmpegthumbnailer
      ];

      services = {
        dbus.packages = with pkgs; [
          gcr_4
          gnome-settings-daemon
        ];

        gnome.gnome-keyring.enable = true;
        gnome.sushi.enable = true;

        gvfs.enable = true;
      };
    };
  };
}

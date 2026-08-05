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
          gcr
          gnome-settings-daemon
        ];

        gnome.gnome-keyring.enable = true;
        gnome.sushi.enable = true;

        gvfs.enable = true;
      };
    };
  };
}

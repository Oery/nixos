{ den, ... }:
{
  den.aspects.gnome-services = {
    nixos = { pkgs, ... }: {
      programs.dconf.enable = true;

      programs.nautilus-open-any-terminal = {
        enable = true;
        terminal = "ghostty";
      };

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

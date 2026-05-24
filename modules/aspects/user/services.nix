{ den, ... }:
{
  den.aspects.user.services = {
    homeManager = { pkgs, ... }: {
      services.hypridle = {
        enable = true;

        settings.general = {
          lock_cmd = "hyprlock";
          before_sleep_cmd = "loginctl lock-session";
          after_sleep_cmd = "hyprctl dispatch dpms on";
        };

        settings.listener = [
          {
            timeout = 150;
            on-timeout = "brightnessctl -s set 10";
            on-resume = "brightnessctl -r";
          }
          {
            timeout = 150;
            on-timeout = "brightnessctl -sd tpacpi::kbd_backlight set 0";
            on-resume = "brightnessctl -rd tpacpi::kbd_backlight";
          }
          {
            timeout = 150;
            on-timeout = "brightnessctl -sd kbd_backlight set 0";
            on-resume = "brightnessctl -rd kbd_backlight";
          }
          {
            timeout = 300;
            on-timeout = "loginctl lock-session";
          }
          {
            timeout = 330;
            on-timeout = "hyprctl dispatch dpms off";
            on-resume = "hyprctl dispatch dpms on && brightnessctl -r";
          }
          {
            timeout = 1800;
            on-timeout = "systemctl suspend";
          }
        ];
      };

      systemd.user.services.polkit-gnome-authentication-agent-1 = {
        Unit.Description = "polkit-gnome-authentication-agent-1";

        Install = {
          WantedBy = [ "graphical-session.target" ];
          Wants = [ "graphical-session.target" ];
          After = [ "graphical-session.target" ];
        };

        Service = {
          Type = "simple";
          ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
          Restart = "on-failure";
          RestartSec = 1;
          TimeoutStopSec = 10;
        };
      };

      xdg = {
        enable = true;

        mime.enable = true;
        mimeApps.enable = true;

        portal = {
          enable = true;
          extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
          configPackages = [ pkgs.hyprland ];
        };

        userDirs = {
          enable = true;
          createDirectories = true;
          setSessionVariables = true;
        };
      };
    };
  };
}

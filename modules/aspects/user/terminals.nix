{ den, ... }:
{
  den.aspects.user.terminals = {
    homeManager = { pkgs, ... }: {
      programs.ghostty = {
        enable = true;

        settings = {
          gtk-single-instance = true;
          quit-after-last-window-closed = false;

          font-family = "Iosevka";
          font-size = "14";

          resize-overlay = "never";
          mouse-hide-while-typing = true;

          cursor-style = "underline";
          shell-integration-features = "no-cursor";

          theme = "renoir";
        };

        themes.renoir = {
          background = "#080808";
          background-opacity = 0.90;

          foreground = "#F7F1FF";
          cursor-color = "#F7F1FF";

          selection-foreground = "#121517";
          selection-background = "#F7F1FF";

          palette = [
            "0=#51576d"
            "1=#e78284"
            "2=#a6d189"
            "3=#e5c890"
            "4=#7E7D7E"
            "5=#F7F1FF"
            "6=#F7F1FF"
            "7=#F7F1FF"
            "8=#626880"
            "9=#e67172"
            "10=#8ec772"
            "11=#d9ba73"
            "12=#7b9ef0"
            "13=#f2a4db"
            "14=#5abfb5"
            "15=#b5bfe2"
          ];
        };
      };

      programs.kitty = {
        enable = true;

        font = {
          size = 14;
          name = "Iosevka Nerd Font";
        };

        settings = {
          cursor_shape = "underline";
          hide_mouse_cursor = true;
          background_opacity = "0.90";

          background = "#080808";
          foreground = "#F7F1FF";
          cursor = "#F7F1FF";
          selection_foreground = "#121517";
          selection_background = "#F7F1FF";

          color0 = "#51576d";
          color1 = "#e78284";
          color2 = "#a6d189";
          color3 = "#e5c890";
          color4 = "#7E7D7E";
          color5 = "#F7F1FF";
          color6 = "#F7F1FF";
          color7 = "#F7F1FF";
          color8 = "#626880";
          color9 = "#e67172";
          color10 = "#8ec772";
          color11 = "#d9ba73";
          color12 = "#7b9ef0";
          color13 = "#f2a4db";
          color14 = "#5abfb5";
          color15 = "#b5bfe2";
        };
      };

      programs.alacritty = {
        enable = true;

        settings = {
          env = {
            TERM = "alacritty";
            TERM_PROGRAM = "alacritty";
          };

          font = {
            normal.family = "Iosevka Nerd Font";
            size = 14;
          };

          scrolling.multiplier = 10;

          cursor.style.shape = "Underline";

          mouse.hide_when_typing = true;

          window.opacity = 0.9;

          colors = {
            primary = {
              background = "#080808";
              foreground = "#F7F1FF";
            };

            cursor.cursor = "#F7F1FF";

            selection = {
              text = "#121517";
              background = "#F7F1FF";
            };

            normal = {
              black = "#51576d";
              red = "#e78284";
              green = "#a6d189";
              yellow = "#e5c890";
              blue = "#7E7D7E";
              magenta = "#F7F1FF";
              cyan = "#F7F1FF";
              white = "#F7F1FF";
            };

            bright = {
              black = "#626880";
              red = "#e67172";
              green = "#8ec772";
              yellow = "#d9ba73";
              blue = "#7b9ef0";
              magenta = "#f2a4db";
              cyan = "#5abfb5";
              white = "#b5bfe2";
            };
          };
        };
      };
    };
  };
}

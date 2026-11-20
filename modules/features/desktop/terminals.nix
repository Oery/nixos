# Terminal emulators. Alacritty is the one in use; ghostty and kitty are kept
# configured but disabled. Colours come from theme/_palette.nix.
{ lib, ... }:
let
  p = import ./theme/_palette.nix;
  names = [ "black" "red" "green" "yellow" "blue" "magenta" "cyan" "white" ];
  # [ "#a" "#b" ] -> { black = "#a"; red = "#b"; ... }
  named = colours: lib.listToAttrs (lib.zipListsWith lib.nameValuePair names colours);
in
{
  den.aspects.terminals.provides.to-users = {
    homeManager = {
      programs.ghostty = {
        enable = false;

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
          inherit (p) background foreground;
          background-opacity = 0.90;
          cursor-color = p.cursor;
          selection-foreground = p.selection.foreground;
          selection-background = p.selection.background;
          palette = lib.imap0 (i: c: "${toString i}=${c}") p.ansi;
        };
      };

      programs.kitty = {
        enable = false;

        font = {
          size = 14;
          name = "Iosevka Nerd Font";
        };

        settings = {
          cursor_shape = "underline";
          hide_mouse_cursor = true;
          background_opacity = "0.90";

          inherit (p) background foreground cursor;
          selection_foreground = p.selection.foreground;
          selection_background = p.selection.background;
        }
        // lib.listToAttrs (lib.imap0 (i: c: lib.nameValuePair "color${toString i}" c) p.ansi);
      };

      programs.alacritty = {
        enable = true;

        settings = {
          env = {
            TERM = "alacritty";
            TERM_PROGRAM = "alacritty";
          };

          font = {
            normal.family = "JetBrainsMono Nerd Font";
            size = 12;
          };

          scrolling.multiplier = 10;

          cursor.style.shape = "Underline";

          mouse.hide_when_typing = true;

          window = {
            opacity = 0.85;
            padding = {
              x = 10;
              y = 10;
            };
          };

          colors = {
            primary = { inherit (p) background foreground; };
            cursor.cursor = p.cursor;
            selection = {
              text = p.selection.foreground;
              inherit (p.selection) background;
            };
            normal = named p.normal;
            bright = named p.bright;
          };
        };
      };
    };
  };
}

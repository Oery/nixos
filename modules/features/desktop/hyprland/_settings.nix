# General settings, environment and autostart.
{ lib, ... }:
let
  inherit (import ./_lib.nix lib) env lua;
in
{
  wayland.windowManager.hyprland.settings = {
    config = {
      animations = {
        enabled = true;
      };
      binds = {
        scroll_event_delay = 0;
      };
      cursor = {
        no_hardware_cursors = 2;
      };
      debug = {
        overlay = 0;
      };
      decoration = {
        blur = {
          enabled = true;
          new_optimizations = true;
          passes = 3;
          popups = true;
          size = 6;
        };
        rounding = 4;
        shadow = {
          color = "rgba(1a1a1aee)";
          enabled = true;
          range = 4;
          render_power = 3;
        };
      };
      dwindle = {
        force_split = 2;
        preserve_split = true;
        smart_resizing = false;
        smart_split = false;
      };
      ecosystem = {
        no_update_news = true;
      };
      general = {
        allow_tearing = false;
        border_size = 0;
        gaps_in = 2.5;
        gaps_out = 5;
        gaps_workspaces = 50;
        layout = "dwindle";
        col = {
          active_border = "rgba(080808E6)";
          inactive_border = "rgb(000000)";
        };
      };
      input = {
        kb_options = "caps:swapescape";
        numlock_by_default = true;
        repeat_delay = 250;
        repeat_rate = 35;
        touchpad = {
          disable_while_typing = lib.mkDefault true;
          natural_scroll = true;
          scroll_factor = lib.mkDefault 0.2;
        };
      };
      misc = {
        animate_manual_resizes = true;
        animate_mouse_windowdragging = true;
        disable_hyprland_logo = true;
        enable_anr_dialog = false;
        force_default_wallpaper = 0;
        on_focus_under_fullscreen = 1;
      };
    };
    env = [
      (env "XDG_CURRENT_DESKTOP" "Hyprland")
      (env "XDG_SESSION_TYPE" "wayland")
      (env "XDG_SESSION_DESKTOP" "Hyprland")
      (env "QT_AUTO_SCREEN_SCALE_FACTOR" "1")
      (env "QT_WAYLAND_DISABLE_WINDOWDECORATION" "1")
      (env "QT_QPA_PLATFORM" "wayland")
      (env "ELECTRON_OZONE_PLATFORM_HINT" "auto")
      (env "HYPRLAND_TRACE" "0")
    ];
    on = {
      _args = [
        "hyprland.start"
        (lua ''
          function()
            hl.exec_cmd("hyprlock")
            hl.exec_cmd("qs -c oery")
            hl.exec_cmd("wired")
            hl.exec_cmd("hyprctl setcursor Bibata-Modern-Classic 24")
            hl.exec_cmd("easyeffects --gapplication-service")
          end
        '')
      ];
    };
  };
}

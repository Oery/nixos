{ den, ... }:
{
  den.aspects.user.hyprland = {
    homeManager = {
      wayland.windowManager.hyprland = {
        enable = true;
        configType = "hyprlang";

        settings = {
          env = [
            "XDG_CURRENT_DESKTOP,Hyprland"
            "XDG_SESSION_TYPE,wayland"
            "XDG_SESSION_DESKTOP,Hyprland"
            "QT_AUTO_SCREEN_SCALE_FACTOR,1"
            "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
            "QT_QPA_PLATFORM,wayland"
            "ELECTRON_OZONE_PLATFORM_HINT,auto"
            "HYPRLAND_TRACE,0"
          ];

          exec-once = [
            "qs -c oery"
            "vicinae server"
            "wired"
            "hyprctl setcursor Bibata-Modern-Classic 24"
            "easyeffects --gapplication-service"
          ];

          input = {
            repeat_delay = 250;
            repeat_rate = 35;
          };

          general = {
            "col.active_border" = "rgba(080808E6)";
            "col.inactive_border" = "rgb(000000)";
            allow_tearing = false;
            border_size = 0;
            gaps_in = 2.5;
            gaps_out = 5;
            gaps_workspaces = 50;
            layout = "dwindle";
          };

          decoration = {
            rounding = 4;
            blur = {
              enabled = true;
              popups = true;
              new_optimizations = true;
              size = 6;
              passes = 3;
            };
            shadow = {
              enabled = true;
              range = 4;
              render_power = 3;
              color = "rgba(1a1a1aee)";
            };
          };

          misc = {
            force_default_wallpaper = 0;
            disable_hyprland_logo = true;
            animate_manual_resizes = true;
            animate_mouse_windowdragging = true;
            on_focus_under_fullscreen = 1;
            enable_anr_dialog = false;
          };

          ecosystem.no_update_news = true;

          binds.scroll_event_delay = 0;

          cursor.no_hardware_cursors = 2;

          dwindle = {
            preserve_split = true;
            force_split = 2;
            smart_split = false;
            smart_resizing = false;
          };

          debug.overlay = 0;

          animations = {
            enabled = true;
            bezier = [
              "linear, 0, 0, 1, 1"
              "md3_standard, 0.2, 0, 0, 1"
              "md3_decel, 0.05, 0.7, 0.1, 1"
              "md3_accel, 0.3, 0, 0.8, 0.15"
              "overshot, 0.05, 0.9, 0.1, 1.1"
              "crazyshot, 0.1, 1.5, 0.76, 0.92"
              "hyprnostretch, 0.05, 0.9, 0.1, 1.0"
              "fluent_decel, 0.1, 1, 0, 1"
              "easeInOutCirc, 0.85, 0, 0.15, 1"
              "easeOutCirc, 0, 0.55, 0.45, 1"
              "easeOutExpo, 0.16, 1, 0.3, 1"
              "wind, 0.05, 0.9, 0.1, 1.05"
              "winIn, 0.1, 1.1, 0.1, 1.1"
              "winOut, 0.3, -0.3, 0, 1"
              "liner, 1, 1, 1, 1"
              "smoothOut, 0.5, 0, 0.99, 0.99"
              "smoothIn, 0.5, -0.5, 0.68, 1.5"
            ];
            animation = [
              "border, 1, 10, default"
              "fade, 1, 2.5, md3_decel"
              "workspaces, 1, 3.5, easeOutExpo, slide"
              "specialWorkspace, 1, 3, md3_decel, slidevert"
              "windows, 1, 2, wind, slide"
              "windowsIn, 1, 3, md3_decel, slide bottom"
              "windowsOut, 1, 2, smoothOut, slide"
              "windowsMove, 1, 2, wind, slide"
              "layersIn, 1, 2, md3_decel, slide"
              "layersOut, 1, 2, smoothOut, slide"
              "border, 1, 1, liner"
              "fade, 1, 2, smoothOut"
              "fadeLayersIn, 0, 0, liner"
            ];
          };

          bind = [
            "Super, A, exec, zen"
            "Super, Z, exec, code"
            "Super, E, exec, nautilus --new-window"
            "Super, T, exec, alacritty"
            "Super, S, exec, spotify-launcher"
            "Super, O, exec, obsidian"
            "Ctrl+Super, M, exit"
            "Super, code:49, exec, qs -c oery ipc call leftpanel toggle"
            "Super, Backspace, exec, qs -c oery ipc call rightpanel toggle"
            "Super, R, exec, qs -c oery ipc call launcher toggle"
            ", XF86Search, exec, qs -c oery ipc call launcher toggle"
            "Super, C, killactive,"
            "Super, V, togglefloating,"
            "Super, F, fullscreen, 0"
            "Super+Alt, F, fullscreenstate, 0 3"
            "Ctrl+Super, Backslash, resizeactive, exact 770 520"
            "Super, Tab, cyclenext"
            "Super, 1, workspace, 1"
            "Super, 2, workspace, 2"
            "Super, 3, workspace, 3"
            "Super, 4, workspace, 4"
            "Super, 5, workspace, 5"
            "Super, 6, workspace, 6"
            "Super, 7, workspace, 7"
            "Super, 8, workspace, 8"
            "Super, 9, workspace, 9"
            "Super, 0, workspace, 10"
            "Super+Shift, 1, movetoworkspace, 1"
            "Super+Shift, 2, movetoworkspace, 2"
            "Super+Shift, 3, movetoworkspace, 3"
            "Super+Shift, 4, movetoworkspace, 4"
            "Super+Shift, 5, movetoworkspace, 5"
            "Super+Shift, 6, movetoworkspace, 6"
            "Super+Shift, 7, movetoworkspace, 7"
            "Super+Shift, 8, movetoworkspace, 8"
            "Super+Shift, 9, movetoworkspace, 9"
            "Super+Shift, 0, movetoworkspace, 10"
            "Super, left, movefocus, l"
            "Super, right, movefocus, r"
            "Super, up, movefocus, u"
            "Super, down, movefocus, d"
            "Super+Shift, left, movewindow, l"
            "Super+Shift, right, movewindow, r"
            "Super+Shift, up, movewindow, u"
            "Super+Shift, down, movewindow, d"
            "Super+Shift, C, exec, hyprpicker --autocopy"
            "Super, Space, exec, ~/.config/hypr/scripts/cycle-kbd-backlight.sh"
            "Super+Shift, Space, exec, ~/.config/hypr/scripts/cycle-kbd-backlight.sh reverse"
            "Super+Shift, S, exec, grimblast -n -f copysave area"
            "Super+Shift+Alt, S, exec, grimblast -g \"$(slurp)\" - | swappy -f -"
            "Alt, R, exec, pavucontrol"
            ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
            ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
            "Ctrl+Shift, M, pass, class:^(vesktop)$"
            "Super, L, exec, hyprlock"
            ", XF86Sleep, exec, hyprlock"
            "Super, I, exec, XDG_CURRENT_DESKTOP=\"gnome\" gnome-control-center"
          ];

          binde = [
            "Super, Minus, resizeactive, -100 -100"
            "Super, Equal, resizeactive, 100 100"
          ];

          bindl = [
            ", Print, exec, sh ~/.config/ags/scripts/screenshot-active.sh"
            "Ctrl, Print, exec, mkdir -p ~/Pictures/Screenshots && ~/.config/ags/scripts/grimblast.sh copysave screen ~/Pictures/Screenshots/Screenshot_\"$(date '+%Y-%m-%d_%H.%M.%S')\".png"
            ", XF86AudioPlay, exec, playerctl play-pause"
            ", XF86AudioMicMute, sendshortcut, Ctrl+Shift, M, class:^(vesktop)$"
          ];

          bindle = [
            ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
            ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
            ", XF86MonBrightnessUp, exec, brightnessctl set \"12.75+\""
            ", XF86MonBrightnessDown, exec, brightnessctl set \"12.75-\""
          ];

          bindm = [
            "Super, mouse:272, movewindow"
            "Super, mouse:273, resizewindow"
          ];

          windowrule = [
            {
              name = "bordersize-zero-workspace-wt1";
              "match:workspace" = "w[t1]";
              border_size = 0;
            }
            {
              name = "code-workspace-2";
              "match:class" = "^(code)$";
              workspace = "2";
            }
            {
              name = "cursor-url-workspace-2";
              "match:class" = "^(cursor-url-handler)$";
              workspace = "2";
            }
            {
              name = "cursor-url-opacity";
              "match:class" = "^(cursor-url-handler)$";
              opacity = "0.90";
            }
            {
              name = "zed-workspace-2";
              "match:class" = "^(dev.zed.Zed)$";
              workspace = "2";
            }
            {
              name = "vesktop-workspace-4";
              "match:class" = "^(vesktop)$";
              workspace = "4";
            }
            {
              name = "vesktop-opacity";
              "match:class" = "^(vesktop)$";
              opacity = "0.94";
            }
            {
              name = "discord-popout-opacity";
              "match:initial_title" = "^(Discord Popout)$";
              opacity = "1";
            }
            {
              name = "steam-tile";
              "match:class" = "^(steam)$";
              tile = true;
            }
            {
              name = "steam-float";
              "match:class" = "^(steam)$";
              "match:title" = "^()$";
              float = true;
            }
            {
              name = "pavucontrol-opacity";
              "match:class" = "^(org.pulseaudio.pavucontrol)$";
              opacity = "0.90";
            }
            {
              name = "firefox-workspace-3";
              "match:class" = "^(firefox)$";
              workspace = "3";
            }
            {
              name = "firefox-opacity";
              "match:class" = "^(firefox)$";
              opacity = "0.90";
            }
            {
              name = "firefox-twitch-opacity";
              "match:class" = "^(firefox)$";
              "match:title" = "^(.*)( - Twitch)(.*)$";
              opacity = "1";
            }
            {
              name = "pip-no-initial-focus";
              "match:title" = "^([Pp]icture[-\\s]?[Ii]n[-\\s]?[Pp]icture)(.*)$";
              no_initial_focus = true;
            }
            {
              name = "pip-workspace-3";
              "match:title" = "^([Pp]icture[-\\s]?[Ii]n[-\\s]?[Pp]icture)(.*)$";
              workspace = "3 silent";
            }
            {
              name = "pip-float";
              "match:title" = "^([Pp]icture[-\\s]?[Ii]n[-\\s]?[Pp]icture)(.*)$";
              float = true;
            }
            {
              name = "pip-pin";
              "match:title" = "^([Pp]icture[-\\s]?[Ii]n[-\\s]?[Pp]icture)(.*)$";
              pin = true;
            }
            {
              name = "pip-keep-aspect";
              "match:title" = "^([Pp]icture[-\\s]?[Ii]n[-\\s]?[Pp]icture)(.*)$";
              keep_aspect_ratio = true;
            }
            {
              name = "pip-size";
              "match:title" = "^([Pp]icture[-\\s]?[Ii]n[-\\s]?[Pp]icture)(.*)$";
              size = "345 194";
            }
            {
              name = "pip-move";
              "match:title" = "^([Pp]icture[-\\s]?[Ii]n[-\\s]?[Pp]icture)(.*)$";
              move = "929 43";
            }
            {
              name = "open-file-center";
              "match:title" = "^(Open File)(.*)$";
              center = true;
              float = true;
            }
            {
              name = "select-file-center";
              "match:title" = "^(Select a File)(.*)$";
              center = true;
              float = true;
            }
            {
              name = "choose-wallpaper-center";
              "match:title" = "^(Choose wallpaper)(.*)$";
              center = true;
              float = true;
            }
            {
              name = "open-folder-center";
              "match:title" = "^(Open Folder)(.*)$";
              center = true;
              float = true;
            }
            {
              name = "save-as-center";
              "match:title" = "^(Save As)(.*)$";
              center = true;
              float = true;
            }
            {
              name = "save-image-center";
              "match:title" = "^(Save Image)$";
              center = true;
            }
            {
              name = "library-center";
              "match:title" = "^(Library)(.*)$";
              center = true;
              float = true;
            }
            {
              name = "file-upload-center";
              "match:title" = "^(File Upload)(.*)$";
              center = true;
              float = true;
            }
            {
              name = "zen-workspace-3";
              "match:class" = "^(zen)$";
              workspace = "3";
            }
            {
              name = "zen-twitch-opacity";
              "match:class" = "^(zen)$";
              "match:title" = "^(.*)( - Twitch)(.*)$";
              opacity = "1";
            }
            {
              name = "spotify-workspace-4";
              "match:class" = "^(Spotify)$";
              workspace = "4";
            }
            {
              name = "spotify-opacity";
              "match:class" = "^(Spotify)$";
              opacity = "0.90";
            }
            {
              name = "nautilus-opacity";
              "match:class" = "^(org.gnome.Nautilus)$";
              opacity = "0.9";
            }
            {
              name = "nautilus-previewer-float";
              "match:class" = "^(org.gnome.NautilusPreviewer)$";
              float = true;
            }
            {
              name = "baobab-opacity";
              "match:class" = "^(org.gnome.baobab)$";
              opacity = "0.9";
            }
            {
              name = "yad-opacity";
              "match:class" = "^(yad)$";
              opacity = "0.89";
            }
            {
              name = "kyoko-opacity";
              "match:class" = "^(kyoko)$";
              opacity = "0.85";
            }
            {
              name = "settings-opacity";
              "match:class" = "^(org.gnome.Settings)$";
              opacity = "0.9";
            }
            {
              name = "kitty-size";
              "match:class" = "^(kitty)";
              size = "300 500";
            }
            {
              name = "obsidian-workspace-4";
              "match:class" = "^(obsidian)$";
              workspace = "4";
            }
            {
              name = "obsidian-opacity";
              "match:class" = "^(obsidian)$";
              opacity = "0.70";
            }
            {
              name = "minecraft-tile";
              "match:title" = "^(Sign in to Minecraft)(.*)$";
              tile = true;
            }
            {
              name = "lm-studio-opacity";
              "match:class" = "^(LM Studio)$";
              opacity = "0.88";
            }
            {
              name = "lunacy-opacity";
              "match:class" = "^(Lunacy)$";
              opacity = "0.88";
            }
            {
              name = "steam-app-immediate";
              "match:class" = "(steam_app)";
              immediate = true;
            }
            {
              name = "tiled-no-shadow";
              "match:float" = false;
              no_shadow = true;
            }
          ];

          layerrule = [
            {
              name = "no-anim-walker";
              "match:namespace" = "walker";
              no_anim = true;
            }
            {
              name = "no-anim-selection";
              "match:namespace" = "selection";
              no_anim = true;
            }
            {
              name = "no-anim-overview";
              "match:namespace" = "overview";
              no_anim = true;
            }
            {
              name = "no-anim-anyrun";
              "match:namespace" = "anyrun";
              no_anim = true;
            }
            {
              name = "no-anim-indicator";
              "match:namespace" = "indicator.*";
              no_anim = true;
            }
            {
              name = "no-anim-osk";
              "match:namespace" = "osk";
              no_anim = true;
            }
            {
              name = "no-anim-hyprpicker";
              "match:namespace" = "hyprpicker";
              no_anim = true;
            }
            {
              name = "blur-quickshell";
              "match:namespace" = "quickshell";
              blur = true;
            }
            {
              name = "ignore-alpha-quickshell";
              "match:namespace" = "quickshell";
              ignore_alpha = 0;
            }
            {
              name = "xray-quickshell";
              "match:namespace" = "quickshell";
              xray = true;
            }
            {
              name = "blur-vicinae";
              "match:namespace" = "vicinae";
              blur = true;
            }
            {
              name = "ignore-alpha-vicinae";
              "match:namespace" = "vicinae";
              ignore_alpha = 0;
            }
          ];
        };
      };

      programs.hyprlock = {
        enable = true;
        settings = {
          background = {
            path = "/home/oery/Pictures/Wallpapers/wallhaven-4lo1g2.jpg";
          };
          input-field = {
            monitor = "";
            size = "400, 80";
            outline_thickness = 1;
            dots_size = 0.5;
            dots_spacing = 0.2;
            outer_color = "#FF000000";
            inner_color = "rgba(33333311)";
            font_color = "rgba(FFFFFFFF)";
            dots_text_format = "*";
            font_family = "JetBrainsMono NerdFont";
            placeholder_text = "Locked";
            position = "500, -200";
            halign = "center";
            valign = "center";
          };
          label = [
            {
              monitor = "";
              text = "$TIME";
              font_size = 280;
              font_family = "SF Pro Display Bold";
              color = "rgba(216, 222, 233, .75)";
              position = "500, 200";
              halign = "center";
              valign = "center";
            }
            {
              monitor = "";
              text = "cmd[update:1000] echo -e \"$(date +\"%A, %B %d\")\"";
              color = "rgba(216, 222, 233, .75)";
              font_size = 38;
              font_family = "SF Pro Display Bold";
              position = "500, 400";
              halign = "center";
              valign = "center";
            }
            {
              monitor = "";
              text = "lock";
              shadow_passes = 1;
              shadow_boost = 0.5;
              color = "rgba(FFFFFFFF)";
              font_size = 21;
              font_family = "Material Symbols Rounded";
              position = "0, 65";
              halign = "center";
              valign = "bottom";
            }
            {
              monitor = "";
              text = "locked";
              shadow_passes = 1;
              shadow_boost = 0.5;
              color = "rgba(FFFFFFFF)";
              font_size = 14;
              font_family = "Iosevka";
              position = "0, 45";
              halign = "center";
              valign = "bottom";
            }
            {
              monitor = "";
              text = "cmd[update:5000] " + "$" + "{XDG_CONFIG_HOME:-" + "$" + "HOME/.config}/hypr/hyprlock/status.sh";
              shadow_passes = 1;
              shadow_boost = 0.5;
              color = "rgba(FFFFFFFF)";
              font_size = 14;
              font_family = "Iosevka";
              position = "30, -30";
              halign = "left";
              valign = "top";
            }
          ];
        };
      };

      home.file.".config/hypr/scripts/cycle-kbd-backlight.sh" = {
        source = ./scripts/cycle-kbd-backlight.sh;
        executable = true;
      };
      home.file.".config/hypr/scripts/apply-keyboard-color.sh" = {
        source = ./scripts/apply-keyboard-color.sh;
        executable = true;
      };
      home.file.".config/hypr/scripts/link-virtual-audio-cables.sh" = {
        source = ./scripts/link-virtual-audio-cables.sh;
        executable = true;
      };
      home.file.".config/hypr/scripts/ff-enable-pip.sh.old" = {
        source = ./scripts/ff-enable-pip.sh.old;
        executable = true;
      };
      home.file.".config/hypr/scripts/hypr-workspace-monitor" = {
        source = ./scripts/hypr-workspace-monitor;
        executable = true;
      };
      home.file.".config/hypr/scripts/razer.py" = {
        source = ./scripts/razer.py;
        executable = true;
      };
      home.file.".config/hypr/hyprlock/status.sh" = {
        source = ./scripts/status.sh;
        executable = true;
      };
      home.file.".config/hypr/xdph.conf" = {
        text = ''
          screencopy {
            allow_token_by_default=true,
          }
        '';
      };
    };
  };
}

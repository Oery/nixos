{ den, lib, ... }:
let
  lua = lib.generators.mkLuaInline;
  bind = keys: action: {
    _args = [
      keys
      (lua action)
    ];
  };
  bindWith = flags: keys: action: {
    _args = [
      keys
      (lua action)
      flags
    ];
  };
  exec = keys: command: bind keys "hl.dsp.exec_cmd(${builtins.toJSON command})";
  execWith =
    flags: keys: command:
    bindWith flags keys "hl.dsp.exec_cmd(${builtins.toJSON command})";
  env = name: value: {
    _args = [
      name
      value
    ];
  };
  curve = name: points: {
    _args = [
      name
      {
        type = "bezier";
        inherit points;
      }
    ];
  };
in
{
  den.aspects.user.hyprland = {
    homeManager = {
      wayland.windowManager.hyprland = {
        enable = true;
        systemd.enable = false;
        configType = "lua";

        # Lua API calls rendered by Home Manager (Hyprland 0.57+).
        settings = {
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
          curve = [
            (curve "linear" [
              [
                0.0
                0.0
              ]
              [
                1.0
                1.0
              ]
            ])
            (curve "md3_standard" [
              [
                0.2
                0.0
              ]
              [
                0.0
                1.0
              ]
            ])
            (curve "md3_decel" [
              [
                0.05
                0.7
              ]
              [
                0.1
                1.0
              ]
            ])
            (curve "md3_accel" [
              [
                0.3
                0.0
              ]
              [
                0.8
                0.15
              ]
            ])
            (curve "overshot" [
              [
                0.05
                0.9
              ]
              [
                0.1
                1.1
              ]
            ])
            (curve "crazyshot" [
              [
                0.1
                1.5
              ]
              [
                0.76
                0.92
              ]
            ])
            (curve "hyprnostretch" [
              [
                0.05
                0.9
              ]
              [
                0.1
                1.0
              ]
            ])
            (curve "fluent_decel" [
              [
                0.1
                1.0
              ]
              [
                0.0
                1.0
              ]
            ])
            (curve "easeInOutCirc" [
              [
                0.85
                0.0
              ]
              [
                0.15
                1.0
              ]
            ])
            (curve "easeOutCirc" [
              [
                0.0
                0.55
              ]
              [
                0.45
                1.0
              ]
            ])
            (curve "easeOutExpo" [
              [
                0.16
                1.0
              ]
              [
                0.3
                1.0
              ]
            ])
            (curve "wind" [
              [
                0.05
                0.9
              ]
              [
                0.1
                1.05
              ]
            ])
            (curve "winIn" [
              [
                0.1
                1.1
              ]
              [
                0.1
                1.1
              ]
            ])
            (curve "winOut" [
              [
                0.3
                (-0.3)
              ]
              [
                0.0
                1.0
              ]
            ])
            (curve "liner" [
              [
                1.0
                1.0
              ]
              [
                1.0
                1.0
              ]
            ])
            (curve "smoothOut" [
              [
                0.5
                0.0
              ]
              [
                0.99
                0.99
              ]
            ])
            (curve "smoothIn" [
              [
                0.5
                (-0.5)
              ]
              [
                0.68
                1.5
              ]
            ])
          ];
          animation = [
            {
              leaf = "border";
              enabled = true;
              speed = 10.0;
              bezier = "default";
            }
            {
              leaf = "fade";
              enabled = true;
              speed = 2.5;
              bezier = "md3_decel";
            }
            {
              leaf = "workspaces";
              enabled = true;
              speed = 3.5;
              bezier = "easeOutExpo";
              style = "slide";
            }
            {
              leaf = "specialWorkspace";
              enabled = true;
              speed = 3.0;
              bezier = "md3_decel";
              style = "slidevert";
            }
            {
              leaf = "windows";
              enabled = true;
              speed = 2.0;
              bezier = "wind";
              style = "slide";
            }
            {
              leaf = "windowsIn";
              enabled = true;
              speed = 3.0;
              bezier = "md3_decel";
              style = "slide bottom";
            }
            {
              leaf = "windowsOut";
              enabled = true;
              speed = 2.0;
              bezier = "smoothOut";
              style = "slide";
            }
            {
              leaf = "windowsMove";
              enabled = true;
              speed = 2.0;
              bezier = "wind";
              style = "slide";
            }
            {
              leaf = "layersIn";
              enabled = true;
              speed = 2.0;
              bezier = "md3_decel";
              style = "slide";
            }
            {
              leaf = "layersOut";
              enabled = true;
              speed = 2.0;
              bezier = "smoothOut";
              style = "slide";
            }
            {
              leaf = "border";
              enabled = true;
              speed = 1.0;
              bezier = "liner";
            }
            {
              leaf = "fade";
              enabled = true;
              speed = 2.0;
              bezier = "smoothOut";
            }
            {
              leaf = "fadeLayersIn";
              enabled = false;
              speed = 0.0;
              bezier = "liner";
            }
          ];
          bind = [
            (exec "Super + A" "zen-beta")
            (exec "Super + Z" "code")
            (exec "Super + E" "nautilus --new-window")
            (exec "Super + T" "alacritty")
            (exec "Super + S" "spotify-launcher")
            (exec "Super + O" "obsidian")
            (bind "Ctrl + Super + M" "hl.dsp.exit()")
            (exec "Super + code:49" "qs -c oery ipc call leftpanel toggle")
            (exec "Super + Backspace" "qs -c oery ipc call rightpanel toggle")
            (exec "Super + R" "qs -c oery ipc call launcher toggle")
            (exec "XF86Search" "qs -c oery ipc call launcher toggle")
            (bind "Super + C" "hl.dsp.window.close()")
            (bind "Super + V" "hl.dsp.window.float({ action = \"toggle\" })")
            (bind "Super + F" "hl.dsp.window.fullscreen({ mode = \"fullscreen\" })")
            (bind "Super + Alt + F" "hl.dsp.window.fullscreen_state({ internal = 0, client = 3 })")
            (bind "Ctrl + Super + Backslash" "hl.dsp.window.resize({ x = 770, y = 520, relative = false })")
            (bind "Super + Tab" "hl.dsp.window.cycle_next()")
            (bind "Super + code:10" "hl.dsp.focus({ workspace = 1 })")
            (bind "Super + code:11" "hl.dsp.focus({ workspace = 2 })")
            (bind "Super + code:12" "hl.dsp.focus({ workspace = 3 })")
            (bind "Super + code:13" "hl.dsp.focus({ workspace = 4 })")
            (bind "Super + code:14" "hl.dsp.focus({ workspace = 5 })")
            (bind "Super + code:15" "hl.dsp.focus({ workspace = 6 })")
            (bind "Super + code:16" "hl.dsp.focus({ workspace = 7 })")
            (bind "Super + code:17" "hl.dsp.focus({ workspace = 8 })")
            (bind "Super + code:18" "hl.dsp.focus({ workspace = 9 })")
            (bind "Super + code:19" "hl.dsp.focus({ workspace = 10 })")
            (bind "Super + Shift + code:10" "hl.dsp.window.move({ workspace = 1, follow = true })")
            (bind "Super + Shift + code:11" "hl.dsp.window.move({ workspace = 2, follow = true })")
            (bind "Super + Shift + code:12" "hl.dsp.window.move({ workspace = 3, follow = true })")
            (bind "Super + Shift + code:13" "hl.dsp.window.move({ workspace = 4, follow = true })")
            (bind "Super + Shift + code:14" "hl.dsp.window.move({ workspace = 5, follow = true })")
            (bind "Super + Shift + code:15" "hl.dsp.window.move({ workspace = 6, follow = true })")
            (bind "Super + Shift + code:16" "hl.dsp.window.move({ workspace = 7, follow = true })")
            (bind "Super + Shift + code:17" "hl.dsp.window.move({ workspace = 8, follow = true })")
            (bind "Super + Shift + code:18" "hl.dsp.window.move({ workspace = 9, follow = true })")
            (bind "Super + Shift + code:19" "hl.dsp.window.move({ workspace = 10, follow = true })")
            (bind "Super + left" "hl.dsp.focus({ direction = \"left\" })")
            (bind "Super + right" "hl.dsp.focus({ direction = \"right\" })")
            (bind "Super + up" "hl.dsp.focus({ direction = \"up\" })")
            (bind "Super + down" "hl.dsp.focus({ direction = \"down\" })")
            (bind "Super + Shift + left" "hl.dsp.window.move({ direction = \"left\" })")
            (bind "Super + Shift + right" "hl.dsp.window.move({ direction = \"right\" })")
            (bind "Super + Shift + up" "hl.dsp.window.move({ direction = \"up\" })")
            (bind "Super + Shift + down" "hl.dsp.window.move({ direction = \"down\" })")
            (exec "Super + Shift + C" "hyprpicker --autocopy")
            (exec "Super + Space" "~/.config/hypr/scripts/cycle-kbd-backlight.sh")
            (exec "Super + Shift + Space" "~/.config/hypr/scripts/cycle-kbd-backlight.sh reverse")
            (exec "Super + Shift + S" "grimblast -n -f copysave area")
            (exec "Super + Shift + Alt + S" "grimblast -g \"$(slurp)\" - | swappy -f -")
            (exec "Alt + R" "pavucontrol")
            (exec "XF86AudioMute" "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle")
            (exec "XF86AudioMicMute" "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle")
            (bind "Ctrl + Shift + M" "hl.dsp.pass({ window = \"class:^(vesktop)$\" })")
            (exec "Super + L" "hyprlock")
            (exec "XF86Sleep" "hyprlock")
            (exec "Super + I" "XDG_CURRENT_DESKTOP=\"gnome\" gnome-control-center")
            (bindWith {
              repeating = true;
            } "Super + Minus" "hl.dsp.window.resize({ x = -100, y = -100, relative = true })")
            (bindWith {
              repeating = true;
            } "Super + Equal" "hl.dsp.window.resize({ x = 100, y = 100, relative = true })")
            (execWith { locked = true; } "Print" "sh ~/.config/ags/scripts/screenshot-active.sh")
            (execWith { locked = true; } "Ctrl + Print"
              "mkdir -p ~/Pictures/Screenshots && ~/.config/ags/scripts/grimblast.sh copysave screen ~/Pictures/Screenshots/Screenshot_\"$(date '+%Y-%m-%d_%H.%M.%S')\".png"
            )
            (execWith { locked = true; } "XF86AudioPlay" "playerctl play-pause")
            (bindWith { locked = true; } "XF86AudioMicMute"
              "hl.dsp.send_shortcut({ mods = \"Ctrl+Shift\", key = \"M\", window = \"class:^(vesktop)$\" })"
            )
            (execWith {
              repeating = true;
              locked = true;
            } "XF86AudioRaiseVolume" "wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+")
            (execWith {
              repeating = true;
              locked = true;
            } "XF86AudioLowerVolume" "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-")
            (execWith {
              repeating = true;
              locked = true;
            } "XF86MonBrightnessUp" "brightnessctl set \"12.75+\" && qs -c oery ipc call brightness display")
            (execWith {
              repeating = true;
              locked = true;
            } "XF86MonBrightnessDown" "brightnessctl set \"12.75-\" && qs -c oery ipc call brightness display")
            (bind "Super + mouse:272" "hl.dsp.window.drag()")
            (bind "Super + mouse:273" "hl.dsp.window.resize()")
          ];
          window_rule = [
            {
              border_size = 0;
              name = "bordersize-zero-workspace-wt1";
              match = {
                workspace = "w[t1]";
              };
            }
            {
              name = "code-workspace-2";
              workspace = "2";
              match = {
                class = "^(code)$";
              };
            }
            {
              name = "zed-workspace-2";
              workspace = "2";
              match = {
                class = "^(dev.zed.Zed)$";
              };
            }
            {
              name = "vesktop-workspace-4";
              workspace = "4";
              match = {
                class = "^(vesktop)$";
              };
            }
            {
              name = "vesktop-opacity";
              opacity = "0.94";
              match = {
                class = "^(vesktop)$";
              };
            }
            {
              name = "discord-popout-opacity";
              opacity = "1";
              match = {
                initial_title = "^(Discord Popout)$";
              };
            }
            {
              name = "steam-tile";
              tile = true;
              match = {
                class = "^(steam)$";
              };
            }
            {
              float = true;
              name = "steam-float";
              match = {
                class = "^(steam)$";
                title = "^()$";
              };
            }
            {
              name = "pavucontrol-opacity";
              opacity = "0.90";
              match = {
                class = "^(org.pulseaudio.pavucontrol)$";
              };
            }
            {
              name = "firefox-workspace-3";
              workspace = "3";
              match = {
                class = "^(firefox)$";
              };
            }
            {
              name = "firefox-opacity";
              opacity = "0.90";
              match = {
                class = "^(firefox)$";
              };
            }
            {
              name = "firefox-twitch-opacity";
              opacity = "1";
              match = {
                class = "^(firefox)$";
                title = "^(.*)( - Twitch)(.*)$";
              };
            }
            {
              name = "pip-no-initial-focus";
              no_initial_focus = true;
              match = {
                title = "^([Pp]icture[-\\s]?[Ii]n[-\\s]?[Pp]icture)(.*)$";
              };
            }
            {
              name = "pip-workspace-3";
              workspace = "3 silent";
              match = {
                title = "^([Pp]icture[-\\s]?[Ii]n[-\\s]?[Pp]icture)(.*)$";
              };
            }
            {
              float = true;
              name = "pip-float";
              match = {
                title = "^([Pp]icture[-\\s]?[Ii]n[-\\s]?[Pp]icture)(.*)$";
              };
            }
            {
              name = "pip-pin";
              pin = true;
              match = {
                title = "^([Pp]icture[-\\s]?[Ii]n[-\\s]?[Pp]icture)(.*)$";
              };
            }
            {
              keep_aspect_ratio = true;
              name = "pip-keep-aspect";
              match = {
                title = "^([Pp]icture[-\\s]?[Ii]n[-\\s]?[Pp]icture)(.*)$";
              };
            }
            {
              name = "pip-size";
              size = "345 194";
              match = {
                title = "^([Pp]icture[-\\s]?[Ii]n[-\\s]?[Pp]icture)(.*)$";
              };
            }
            {
              move = "929 43";
              name = "pip-move";
              match = {
                title = "^([Pp]icture[-\\s]?[Ii]n[-\\s]?[Pp]icture)(.*)$";
              };
            }
            {
              center = true;
              float = true;
              name = "open-file-center";
              match = {
                title = "^(Open File)(.*)$";
              };
            }
            {
              center = true;
              float = true;
              name = "select-file-center";
              match = {
                title = "^(Select a File)(.*)$";
              };
            }
            {
              center = true;
              float = true;
              name = "choose-wallpaper-center";
              match = {
                title = "^(Choose wallpaper)(.*)$";
              };
            }
            {
              center = true;
              float = true;
              name = "open-folder-center";
              match = {
                title = "^(Open Folder)(.*)$";
              };
            }
            {
              center = true;
              float = true;
              name = "save-as-center";
              match = {
                title = "^(Save As)(.*)$";
              };
            }
            {
              center = true;
              name = "save-image-center";
              match = {
                title = "^(Save Image)$";
              };
            }
            {
              center = true;
              float = true;
              name = "library-center";
              match = {
                title = "^(Library)(.*)$";
              };
            }
            {
              center = true;
              float = true;
              name = "file-upload-center";
              match = {
                title = "^(File Upload)(.*)$";
              };
            }
            {
              center = true;
              float = true;
              name = "gtk-file-picker";
              opacity = "0.9";
              match = {
                class = "^(xdg-desktop-portal-gtk)$";
              };
            }
            {
              name = "zen-workspace-3";
              workspace = "3";
              match = {
                class = "^(zen-beta)$";
              };
            }
            {
              name = "zen-twitch-opacity";
              opacity = "1";
              match = {
                class = "^(zen-beta)$";
                title = "^(.*)( - Twitch)(.*)$";
              };
            }
            {
              name = "spotify-workspace-4";
              workspace = "4";
              match = {
                class = "^(Spotify)$";
              };
            }
            {
              name = "spotify-opacity";
              opacity = "0.90";
              match = {
                class = "^(Spotify)$";
              };
            }
            {
              name = "nautilus-opacity";
              opacity = "0.9";
              match = {
                class = "^(org.gnome.Nautilus)$";
              };
            }
            {
              float = true;
              name = "nautilus-previewer-float";
              match = {
                class = "^(org.gnome.NautilusPreviewer)$";
              };
            }
            {
              name = "baobab-opacity";
              opacity = "0.9";
              match = {
                class = "^(org.gnome.baobab)$";
              };
            }
            {
              name = "yad-opacity";
              opacity = "0.89";
              match = {
                class = "^(yad)$";
              };
            }
            {
              name = "kyoko-opacity";
              opacity = "0.85";
              match = {
                class = "^(kyoko)$";
              };
            }
            {
              name = "settings-opacity";
              opacity = "0.9";
              match = {
                class = "^(org.gnome.Settings)$";
              };
            }
            {
              name = "kitty-size";
              size = "300 500";
              match = {
                class = "^(kitty)";
              };
            }
            {
              name = "obsidian-workspace-4";
              workspace = "4";
              match = {
                class = "^(obsidian)$";
              };
            }
            {
              name = "obsidian-opacity";
              opacity = "0.70";
              match = {
                class = "^(obsidian)$";
              };
            }
            {
              name = "minecraft-tile";
              tile = true;
              match = {
                title = "^(Sign in to Minecraft)(.*)$";
              };
            }
            {
              name = "lm-studio-opacity";
              opacity = "0.88";
              match = {
                class = "^(LM Studio)$";
              };
            }
            {
              name = "lunacy-opacity";
              opacity = "0.88";
              match = {
                class = "^(Lunacy)$";
              };
            }
            {
              immediate = true;
              name = "steam-app-immediate";
              match = {
                class = "(steam_app)";
              };
            }
            {
              name = "tiled-no-shadow";
              no_shadow = true;
              match = {
                float = false;
              };
            }
          ];
          layer_rule = [
            {
              name = "no-anim-walker";
              no_anim = true;
              match = {
                namespace = "walker";
              };
            }
            {
              name = "no-anim-selection";
              no_anim = true;
              match = {
                namespace = "selection";
              };
            }
            {
              name = "no-anim-overview";
              no_anim = true;
              match = {
                namespace = "overview";
              };
            }
            {
              name = "no-anim-anyrun";
              no_anim = true;
              match = {
                namespace = "anyrun";
              };
            }
            {
              name = "no-anim-indicator";
              no_anim = true;
              match = {
                namespace = "indicator.*";
              };
            }
            {
              name = "no-anim-osk";
              no_anim = true;
              match = {
                namespace = "osk";
              };
            }
            {
              name = "no-anim-hyprpicker";
              no_anim = true;
              match = {
                namespace = "hyprpicker";
              };
            }
            {
              blur = true;
              name = "blur-quickshell";
              match = {
                namespace = "quickshell";
              };
            }
            {
              ignore_alpha = 0;
              name = "ignore-alpha-quickshell";
              match = {
                namespace = "quickshell";
              };
            }
            {
              name = "xray-quickshell";
              xray = true;
              match = {
                namespace = "quickshell";
              };
            }
            {
              blur = true;
              name = "blur-quickshell-osd";
              match = {
                namespace = "quickshell-osd";
              };
            }
            {
              ignore_alpha = 0.2;
              name = "ignore-alpha-quickshell-osd";
              match = {
                namespace = "quickshell-osd";
              };
            }
            {
              blur = true;
              name = "blur-quickshell-overlays";
              match = {
                namespace = "quickshell-(panel|launcher)";
              };
            }
            {
              ignore_alpha = 0.2;
              name = "ignore-alpha-quickshell-overlays";
              match = {
                namespace = "quickshell-(panel|launcher)";
              };
            }
            {
              blur = true;
              name = "blur-vicinae";
              match = {
                namespace = "vicinae";
              };
            }
            {
              ignore_alpha = 0;
              name = "ignore-alpha-vicinae";
              match = {
                namespace = "vicinae";
              };
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
              text =
                "cmd[update:5000] " + "$" + "{XDG_CONFIG_HOME:-" + "$" + "HOME/.config}/hypr/hyprlock/status.sh";
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

    provides.l16 = {
      homeManager.wayland.windowManager.hyprland.settings = {
        monitor = {
          output = "";
          mode = "preferred";
          position = "auto";
          scale = 1.25;
        };
        config = {
          input = {
            kb_layout = "fr";
            numlock_by_default = true;
            resolve_binds_by_sym = false;
            touchpad = {
              natural_scroll = true;
              disable_while_typing = false;
              scroll_factor = 0.3;
            };
          };
        };
        bind = [
          (bind "Super + ampersand" "hl.dsp.focus({ workspace = 1 })")
          (bind "Super + eacute" "hl.dsp.focus({ workspace = 2 })")
          (bind "Super + quotedbl" "hl.dsp.focus({ workspace = 3 })")
          (bind "Super + apostrophe" "hl.dsp.focus({ workspace = 4 })")
          (bind "Super + parenleft" "hl.dsp.focus({ workspace = 5 })")
          (bind "Super + egrave" "hl.dsp.focus({ workspace = 6 })")
          (bind "Super + minus" "hl.dsp.focus({ workspace = 7 })")
          (bind "Super + underscore" "hl.dsp.focus({ workspace = 8 })")
          (bind "Super + ccedilla" "hl.dsp.focus({ workspace = 9 })")
          (bind "Super + agrave" "hl.dsp.focus({ workspace = 10 })")
          (bind "Super + Shift + ampersand" "hl.dsp.window.move({ workspace = 1, follow = true })")
          (bind "Super + Shift + eacute" "hl.dsp.window.move({ workspace = 2, follow = true })")
          (bind "Super + Shift + quotedbl" "hl.dsp.window.move({ workspace = 3, follow = true })")
          (bind "Super + Shift + apostrophe" "hl.dsp.window.move({ workspace = 4, follow = true })")
          (bind "Super + Shift + parenleft" "hl.dsp.window.move({ workspace = 5, follow = true })")
          (bind "Super + Shift + egrave" "hl.dsp.window.move({ workspace = 6, follow = true })")
          (bind "Super + Shift + minus" "hl.dsp.window.move({ workspace = 7, follow = true })")
          (bind "Super + Shift + underscore" "hl.dsp.window.move({ workspace = 8, follow = true })")
          (bind "Super + Shift + ccedilla" "hl.dsp.window.move({ workspace = 9, follow = true })")
          (bind "Super + Shift + agrave" "hl.dsp.window.move({ workspace = 10, follow = true })")
        ];
      };
    };

  };
}

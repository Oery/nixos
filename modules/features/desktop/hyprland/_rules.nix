# Window and layer rules.
_: {
  wayland.windowManager.hyprland.settings = {
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
          class = "^(md.obsidian.Obsidian)$";
        };
      }
      {
        name = "obsidian-opacity";
        opacity = "0.85";
        match = {
          class = "^(md.obsidian.Obsidian)$";
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
}

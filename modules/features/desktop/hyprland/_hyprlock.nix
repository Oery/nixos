# Lock screen.
{
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
}

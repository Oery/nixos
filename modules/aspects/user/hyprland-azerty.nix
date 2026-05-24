{ den, lib, ... }:
{
  den.aspects.user.hyprland-azerty = {
    homeManager.wayland.windowManager.hyprland.settings = {
      bind = [
        "Super, ampersand, workspace, 1"
        "Super, eacute, workspace, 2"
        "Super, quotedbl, workspace, 3"
        "Super, apostrophe, workspace, 4"
        "Super, parenleft, workspace, 5"
        "Super, egrave, workspace, 6"
        "Super, minus, workspace, 7"
        "Super, underscore, workspace, 8"
        "Super, ccedilla, workspace, 9"
        "Super, agrave, workspace, 10"
        "Super+Shift, ampersand, movetoworkspace, 1"
        "Super+Shift, eacute, movetoworkspace, 2"
        "Super+Shift, quotedbl, movetoworkspace, 3"
        "Super+Shift, apostrophe, movetoworkspace, 4"
        "Super+Shift, parenleft, movetoworkspace, 5"
        "Super+Shift, egrave, movetoworkspace, 6"
        "Super+Shift, minus, movetoworkspace, 7"
        "Super+Shift, underscore, movetoworkspace, 8"
        "Super+Shift, ccedilla, movetoworkspace, 9"
        "Super+Shift, agrave, movetoworkspace, 10"
      ];
    };
  };
}

# Keybindings.
{ lib, ... }:
let
  inherit (import ./_lib.nix lib)
    bind
    bindWith
    exec
    execWith
    ;
in
{
  wayland.windowManager.hyprland.settings = {
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
  };
}

# A machine someone sits in front of: Hyprland desktop and everyday apps.
{ den, ... }:
{
  den.aspects.roles.workstation.includes = [
    den.aspects.hyprland
    den.aspects.desktop-session
    den.aspects.desktop-apps
    den.aspects.theme
    den.aspects.terminals
    den.aspects.audio
    den.aspects.fonts
    den.aspects.gnome-services
    den.aspects.neovim
    den.aspects.system-services
    den.aspects.power
    den.aspects.backlight
    den.aspects.sensors
    den.aspects.bluetooth
    den.aspects.games.steam
    den.aspects.games.minecraft
  ];
}

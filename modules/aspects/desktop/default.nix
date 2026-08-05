{ den, ... }:
{
  den.aspects.desktop = {
    includes = [
      den.aspects.hyprland
      den.aspects.audio
      den.aspects.fonts
      den.aspects.gnome-services
      den.aspects.neovim
      den.aspects.services
      den.aspects.games.steam
      den.aspects.power
      den.aspects.backlight
      den.aspects.sensors
    ];
  };
}

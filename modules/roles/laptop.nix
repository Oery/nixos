# Portable machines: battery, lid, keyboard backlight.
{ den, ... }:
{
  den.aspects.roles.laptop.includes = [
    den.aspects.kbd-backlight
  ];
}

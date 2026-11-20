# Turn the keyboard backlight off with the screen dim (ThinkPad and Apple/ASUS names).
{
  den.aspects.kbd-backlight.provides.to-users.homeManager.services.hypridle.settings.listener = [
    {
      timeout = 150;
      on-timeout = "brightnessctl -sd tpacpi::kbd_backlight set 0";
      on-resume = "brightnessctl -rd tpacpi::kbd_backlight";
    }
    {
      timeout = 150;
      on-timeout = "brightnessctl -sd kbd_backlight set 0";
      on-resume = "brightnessctl -rd kbd_backlight";
    }
  ];
}

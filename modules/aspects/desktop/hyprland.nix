{ den, ... }:
{
  den.aspects.hyprland = {
    nixos = {
      programs.hyprland = {
        enable = true;
        withUWSM = true;
      };

      programs.hyprlock.enable = true;

      environment.variables.NIXOS_OZONE_WL = "1";
    };
  };
}

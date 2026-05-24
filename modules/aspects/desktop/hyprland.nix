{ den, lib, ... }:
{
  den.aspects.hyprland = {
    nixos = { config, pkgs, ... }: {
      programs.hyprland = {
        enable = true;
        withUWSM = true;
      };

      programs.hyprlock.enable = true;

      environment.variables.NIXOS_OZONE_WL = "1";

      services.greetd = let
        session = {
          command = "${lib.getExe config.programs.uwsm.package} start hyprland-uwsm.desktop";
          user = "oery";
        };
      in {
        enable = true;
        settings = {
          terminal.vt = 1;
          default_session = session;
          initial_session = session;
        };
      };
    };
  };
}

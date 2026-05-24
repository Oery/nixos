{ den, ... }:
{
  den.aspects.sensors = {
    nixos = { pkgs, ... }: {
      environment.systemPackages = [ pkgs.lm_sensors ];
    };
  };
}

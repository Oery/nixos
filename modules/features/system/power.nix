{ den, ... }:
{
  den.aspects.power = {
    nixos = { ... }: {
      powerManagement.enable = true;

      services = {
        logind.settings.Login.HandlePowerKey = "suspend";

        power-profiles-daemon.enable = true;

        upower.enable = true;

        tlp = {
          enable = false;

          settings = {
            CPU_SCALING_GOVERNOR_ON_AC = "performance";
            CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

            CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
            CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

            CPU_MIN_PERF_ON_AC = 0;
            CPU_MAX_PERF_ON_AC = 100;
            CPU_MIN_PERF_ON_BAT = 0;
            CPU_MAX_PERF_ON_BAT = 20;
          };
        };
      };
    };
  };
}

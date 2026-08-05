{ den, ... }:
{
  den.aspects.games.minecraft = {
    nixos = { pkgs, ... }: {
      environment.systemPackages = [
        pkgs.prismlauncher
      ];
    };
    darwin = { pkgs, ... }: {
      environment.systemPackages = [
        pkgs.prismlauncher
      ];
    };
  };
}

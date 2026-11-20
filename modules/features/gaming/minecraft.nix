_: {
  den.aspects.games.minecraft = {
    nixos = { pkgs, ... }: {
      environment.systemPackages = [
        pkgs.prismlauncher
      ];
    };
  };
}

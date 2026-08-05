{ den, ... }:
{
  den.aspects.games.hollow-knight = {
    nixos = { pkgs, ... }: {
      environment.systemPackages = [
        pkgs.lumafly # Hollow Knight mod manager (was AUR lumafly-git)
      ];
    };
  };
}

{ config, __findFile ? __findFile, den, ... }:
{
  den.default = {
    darwin.system.stateVersion = 6;
    nixos = {
      system.stateVersion = "24.11";
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
      };
    };
    homeManager.home.stateVersion = "24.11";
  };

  den.default.includes = [
    <den/hostname>
    <den/define-user>
    <den/primary-user>
    (<den/user-shell> "fish")
  ];
}

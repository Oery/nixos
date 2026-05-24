{ den, lib, ... }:
{
  den.aspects.oery = {
    includes = [
      den.aspects.bluetooth
      den.aspects.user.shell
      den.aspects.user.terminals
      den.aspects.user.cli-tools
      den.aspects.user.theme
      den.aspects.user.services
      den.aspects.user.packages
    ];

    nixos = { pkgs, ... }: {
      users.users.oery = {
        packages = [ pkgs.vim ];
        extraGroups = [ "video" "networkmanager" ];
      };
    };

    homeManager = { pkgs, ... }: {
      home.packages = [
        pkgs.vim
      ];
    };
  };
}

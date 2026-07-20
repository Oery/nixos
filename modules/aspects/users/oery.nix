{ den, ... }:
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
      den.aspects.user.hyprland
    ];

    nixos = { pkgs, ... }: {
      users.users.oery = {
        packages = [ pkgs.vim ];
        extraGroups = [ "video" "networkmanager" "render"];
      };
    };

    homeManager = { pkgs, ... }: {
      home.packages = [
        pkgs.vim
      ];

      programs.mpv = {
        enable = true;
        config.hwdec = "auto";
      };
    };
  };
}

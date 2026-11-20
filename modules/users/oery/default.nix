{ den, ... }:
{
  den.aspects.oery = {
    includes = [
      den.aspects.user.shell
      den.aspects.user.cli-tools
      den.aspects.user.packages
    ];

    nixos = { pkgs, ... }: {
      users.users.oery = {
        packages = [ pkgs.vim ];
        extraGroups = [
          "video"
          "networkmanager"
          "render"
        ];
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

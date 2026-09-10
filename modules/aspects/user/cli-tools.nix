{ den, ... }:
{
  den.aspects.user.cli-tools = {
    includes = [ den.aspects.user.fastfetch ];

    homeManager =
      { pkgs, config, ... }:
      let
        cfg = config.programs.git;
      in
      {
        home.packages = with pkgs; [
          wakatime-cli
          lazygit

          zip
          unzip
          unrar

          sshfs

          dust
          duf
          fd
          file
          ripgrep

          wl-clipboard
        ];

        programs.git = {
          enable = true;

          # TODO: setup signing
          signing.format = null;

          settings = {
            user.name = "Oery";
            user.email = "oery.dev@gmail.com";
            init.defaultBranch = "master";
            url = {
              "https://github.com/".insteadOf = [ "gh:" ];
              "https://codeberg.org/".insteadOf = [ "cb:" ];
            };
          };
        };

        programs.gh = {
          enable = true;
          gitCredentialHelper.enable = true;
        };

        programs.difftastic = {
          enable = true;
          git.enable = true;
        };

        programs.ssh = {
          enable = true;
          enableDefaultConfig = false;
        };

        programs.bat.enable = true;

        programs.btop = {
          enable = true;

          settings = {
            color_theme = "greyscale";
            theme_background = false;
          };
        };

        programs.lsd = {
          enable = true;
          enableFishIntegration = true;

          settings = {
            classic = false;
            layout = "oneline";

            sorting = {
              column = "name";
              reverse = false;
              dir-grouping = "first";
            };
          };
        };
      };
  };
}

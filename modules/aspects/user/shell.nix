{ den, lib, ... }:
{
  den.aspects.user.shell = {
    homeManager = { config, pkgs, ... }: {
      home.sessionVariables = {
        WINEPREFIX = "${config.xdg.dataHome}/wine";
        XAUTHORITY = "$XDG_RUNTIME_DIR/Xauthority";
        EDITOR = "nvim";
        DIRENV_LOG_FORMAT = "";
        NIX_AUTO_RUN = "1";
        STARSHIP_CACHE = "${config.xdg.cacheHome}/starship";
      };

      programs.fish = {
        enable = true;

        interactiveShellInit = ''
          set fish_greeting
          source "$__fish_config_dir/functions/space_between_prompts.fish"
        '';

        shellAliases = {
          cls = "clear";
          zed = "zeditor";
          ff = "fastfetch";
          vi = "nvim";
          tree = "lsd --tree";
        };

        functions = {
          fish_title = {
            body = ''
              set -q argv[1]; or set argv fish
              echo (fish_prompt_pwd_dir_length=10 prompt_pwd): $argv;
            '';
          };

          space_between_prompts = {
            description = "Add a new line after each command";
            onEvent = "fish_postexec";

            body = ''
              if test "$argv" = cls
              else if test "$argv" = clear
              else
                echo
              end
            '';
          };

          "42" = {
            description = "Start 42 Dev shell";
            body = ''
              if not string match '*42*' $PWD
                cd /home/oery/Documents/42
              end
            '';
          };
        };
      };

      programs.starship.enable = true;

      programs.zoxide.enable = true;
    };
  };
}

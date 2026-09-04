{ den, lib, ... }:
{
  den.aspects.user.shell = {
    homeManager =
      {
        config,
        lib,
        pkgs,
        ...
      }:
      {
        home.preferXdgDirectories = true;

        home.sessionVariables = {
          WINEPREFIX = "${config.xdg.dataHome}/wine";
          XAUTHORITY = "$XDG_RUNTIME_DIR/Xauthority";
          EDITOR = "nvim";
          DIRENV_LOG_FORMAT = "";
          NIX_AUTO_RUN = "1";
          STARSHIP_CACHE = "${config.xdg.cacheHome}/starship";

          # xdg criminals
          CARGO_HOME = "${config.xdg.dataHome}/cargo";
          RUSTUP_HOME = "${config.xdg.dataHome}/rustup";
          GNUPGHOME = "${config.xdg.dataHome}/gnupg";
          DOTNET_CLI_HOME = "${config.xdg.dataHome}/dotnet";
          CODEX_HOME = "${config.xdg.configHome}/codex";
          WAKATIME_HOME = "${config.xdg.configHome}/wakatime";
          HISTFILE = "${config.xdg.stateHome}/bash/history";
          NPM_CONFIG_INIT_MODULE = "${config.xdg.configHome}/npm/config/npm-init.js";
          NPM_CONFIG_CACHE = "${config.xdg.cacheHome}/npm";
          NPM_CONFIG_TMP = "$XDG_RUNTIME_DIR/npm";
          _JAVA_OPTIONS = "-Djava.util.prefs.userRoot=\"${config.xdg.configHome}\"/java";
          ZDOTDIR = "${config.xdg.configHome}/zsh";
          CLAUDE_CONFIG_DIR = "${config.xdg.configHome}/claude";
        };

        home.activation.xdgNinjaDirs = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
          $DRY_RUN_CMD mkdir -p \
            "${config.xdg.configHome}/codex" \
            "${config.xdg.configHome}/wakatime" \
            "${config.xdg.stateHome}/bash"
        '';

        programs.fish = {
          enable = true;

          interactiveShellInit = ''
            set fish_greeting
            source "$__fish_config_dir/functions/space_between_prompts.fish"

            set fish_cursor_default block
            set fish_cursor_insert underscore
          '';

          shellAliases = {
            cls = "clear";
            zed = "zeditor";
            ff = "fastfetch";
            vi = "nvim";
            tree = "lsd --tree";
          };

          functions = {
            fish_title.body = ''
              set -q argv[1]; or set argv fish
              echo (fish_prompt_pwd_dir_length=10 prompt_pwd): $argv;
            '';

            fish_user_key_bindings.body = ''
              fish_default_key_bindings -M insert
              fish_vi_key_bindings --no-erase insert
            '';

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

        programs.starship = {
          enable = true;
          settings = {
            add_newline = false;

            format = "$directory$nix_shell$line_break$username";

            username = {
              detect_env_vars = [ ];
              format = "[› ](bold white)";
              style_root = "bold red";
              style_user = "bold white";
              show_always = true;
              disabled = false;
            };

            package.disabled = true;

            git_branch = {
              style = "bg: green";
              symbol = "󰘬";
              truncation_length = 4;
              truncation_symbol = "";
              format = "• [](bold fg:green)[$symbol $branch(:$remote_branch)](fg:black bg:green)[ ](bold fg:green)";
            };

            git_commit = {
              commit_hash_length = 4;
              tag_symbol = " ";
            };

            git_state = {
              format = "[\\($state( $progress_current of $progress_total)\\)]($style) ";
              cherry_pick = "[🍒 PICKING](bold red)";
            };

            git_status = {
              conflicted = " 🏳 ";
              ahead = " 🏎💨 ";
              behind = " 😰 ";
              diverged = " 😵 ";
              untracked = " 🤷 ‍";
              stashed = " 📦 ";
              modified = " 📝 ";
              staged = "[++\\($count\\)](green)";
              renamed = " ✍️ ";
              deleted = " 🗑 ";
            };

            hostname = {
              ssh_only = false;
              format = "[•$hostname](bg:cyan bold fg:black)[](bold fg:cyan )";
              trim_at = ".companyname.com";
              disabled = false;
            };

            line_break.disabled = false;

            memory_usage = {
              disabled = true;
              threshold = -1;
              symbol = " ";
              style = "bold dimmed green";
            };

            time = {
              disabled = true;
              format = "🕙[\\[$time\\]]($style) ";
              time_format = "%T";
            };

            directory = {
              home_symbol = "~";
              read_only = "  ";
              truncate_to_repo = true;
              fish_style_pwd_dir_length = 0;
              use_logical_path = true;
              format = "₍^. .^₎⟆ ∣ $path[$read_only]($read_only_style) ";
              repo_root_format = "[$before_root_path]($before_repo_root_style)[$repo_root]($repo_root_style)[$path]($style)[$read_only]($read_only_style) ";
              disabled = false;
              read_only_style = "red";
              truncation_symbol = "";
              use_os_path_sep = true;
            };

            directory.substitutions = {
              "nixos" = "󱄅 ";
            };

            cmd_duration = {
              min_time = 0;
              format = "[](bold fg:yellow)[ $duration](bold bg:yellow fg:black)[](bold fg:yellow) •• ";
            };

            nix_shell = {
              format = "via [❄️$name]($style) ";
              style = "bold blue";
              impure_msg = "impure";
              pure_msg = "pure";
              unknown_msg = "dev";
            };
          };
        };

        programs.zoxide.enable = true;
      };
  };
}

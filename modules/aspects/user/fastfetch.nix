{ den, ... }:
{
  den.aspects.user.fastfetch = {
    homeManager = { config, ... }: {
      programs.fastfetch = {
        enable = true;

        settings = {
          "$schema" = "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json";

          display.separator = " ";

          logo = {
            padding.top = 1;
            source = "${config.xdg.configHome}/fastfetch/kyoko_s.png";
            type = "auto";
            height = 14;
          };

          modules = [
            "break"
            "break"
            "break"
            {
              type = "title";
              keyWidth = 10;
            }
            "break"
            {
              type = "os";
              key = "󱄅 ";
              format = "{3}";
            }
            {
              type = "command";
              key = "󰚄 ";
              text = "printf 'NixOS Gen.' && readlink /nix/var/nix/profiles/system | grep -o '[0-9]\\+'";
            }
            {
              type = "wm";
              key = " ";
              format = "{2}";
            }
            {
              type = "packages";
              key = " ";
            }
            "break"
            {
              type = "custom";
              key = "󰌢 ";
              format = "Apple MacBook Air";
            }
            {
              type = "cpu";
              key = " ";
              format = "{name}";
              showPeCoreCount = false;
              temp = false;
            }
            {
              type = "memory";
              key = " ";
              format = "{used} / {total}";
            }
            "gamepad"
            "break"
            {
              type = "custom";
              format = "₍^. .^₎⟆";
            }
          ];
        };
      };

      xdg.configFile."fastfetch/kyoko_s.png".source = ./assets/fastfetch/kyoko_s.png;
    };
  };
}

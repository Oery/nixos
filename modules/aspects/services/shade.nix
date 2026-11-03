{ inputs, lib, ... }:
{
  perSystem =
    { pkgs, ... }:
    {
      packages.mcp-servers =
        (pkgs.extend inputs.shade.inputs.rust-overlay.overlays.default).callPackage
          ../../../user-packages/my-mcp-servers/package.nix
          { src = inputs.mcp-servers; };
    };

  den.aspects.shade = {
    nixos.users.users.oery.linger = true;

    provides.to-users =
      { user, ... }:
      lib.optionalAttrs (user.userName == "oery") {
        homeManager =
          { pkgs, ... }:
          let
            mcpServers = inputs.self.packages.${pkgs.stdenv.hostPlatform.system}.mcp-servers;
          in
          {
            imports = [ inputs.shade.homeModules.default ];
            home.packages = [ mcpServers ];

            services.shade = {
              enable = true;
              # Secret values belong in ~/.config/shade/.env (mode 0600).
              settings = {
                timezone = "Europe/Paris";

                model = {
                  provider = "openai_compatible";
                  base_url = "https://opencode.ai/inference/go/openai/v1";
                  session_header = "x-opencode-session";
                  id = "deepseek-v4.1-flash";
                  api_key_env = "OPENCODE_GO_API_KEY";
                  context_window = 1000000;
                  max_output_tokens = 384000;
                };

                chat.caps = [
                  "now"
                  "notify"
                  "schedules"
                  "nightbot"
                  "obsidian"
                ];

                discord = {
                  token_env = "DISCORD_BOT_TOKEN";
                  owners = [ 301495911299940354 ];
                  channels.chateau_general = 997262231156826114;
                };

                mcp = {
                  nightbot = {
                    command = [ "${mcpServers}/bin/mcp-nightbot" ];
                    env = [
                      "NIGHTBOT_CLIENT_ID"
                      "NIGHTBOT_CLIENT_SECRET"
                    ];
                    description = "Read and edit the custom chat commands of the Nightbot channel.";
                  };

                  obsidian = {
                    command = [ "${mcpServers}/bin/mcp-obsidian" ];
                    vars.OBSIDIAN_VAULT = "/home/oery/Documents/Obsidian/Shade";
                    description = "Read and edit the owner's notes. Feel free to use it to store memories, projects, owner thoughts";
                  };
                };

                memory = {
                  server = "obsidian";
                  vault = "/home/oery/Documents/Obsidian/Memories";
                };
              };
            };
          };
      };
  };
}

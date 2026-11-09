{ inputs, lib, ... }:
{
  den.aspects.shade = {
    nixos.users.users.oery.linger = true;

    provides.to-users =
      { user, ... }:
      lib.optionalAttrs (user.userName == "oery") {
        homeManager =
          { pkgs, ... }:
          let
            mcpServers = inputs.mcp-servers.packages.${pkgs.stdenv.hostPlatform.system};
            mcpYoutube = mcpServers.mcp-youtube.override { withWhisperModel = true; };
          in
          {
            imports = [ inputs.shade.homeModules.default ];
            home.packages = [
              mcpServers.mcp-42
              mcpServers.mcp-nightbot
              mcpServers.mcp-obsidian
              mcpYoutube
            ];

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

                api.token_env = "SHADE_API_TOKEN";

                chat.caps = [
                  "now"
                  "notify"
                  "schedules"
                  "fortytwo"
                  "nightbot"
                  "youtube"
                  "shell"
                  "shell_network"
                  "documents"
                ];

                discord = {
                  token_env = "DISCORD_BOT_TOKEN";
                  owners = [ 301495911299940354 ];
                  channels.chateau_general = 997262231156826114;
                  guests.caps = ["now" "documents"];
                };

                mcp = {
                  fortytwo = {
                    command = [ "${mcpServers.mcp-42}/bin/mcp-42" ];
                    env = [
                      "FT_CLIENT_ID"
                      "FT_CLIENT_SECRET"
                    ];
                    description = "Read the owner's 42 intranet profile, projects, evaluations, events, and campus locations.";
                  };

                  nightbot = {
                    command = [ "${mcpServers.mcp-nightbot}/bin/mcp-nightbot" ];
                    env = [
                      "NIGHTBOT_CLIENT_ID"
                      "NIGHTBOT_CLIENT_SECRET"
                    ];
                    description = "Read and edit the custom chat commands of the Nightbot channel.";
                  };

                  obsidian = {
                    command = [ "${mcpServers.mcp-obsidian}/bin/mcp-obsidian" ];
                    vars.OBSIDIAN_VAULT = "/home/oery/Documents/Obsidian/Shade";
                    description = "Read and edit the owner's notes. Feel free to use it to store memories, projects, owner thoughts";
                  };

                  youtube = {
                    command = [ "${mcpYoutube}/bin/mcp-youtube" ];
                    # Allow the server's one-hour Whisper deadline plus transport overhead.
                    call_timeout_seconds = 3660;
                    description = "Read public YouTube video transcripts, using local Whisper when captions are unavailable.";
                  };
                };

                sandbox = {
                  workspace = "/home/oery/Documents/shade-workspace";
                  env = [];
                  max_timeout_seconds = 300;
                };
              };
            };
          };
      };
  };
}

{ inputs, lib, ... }:
let
  hermesModule = inputs.hermes-agent.nixosModules.default;
in
{
  den.aspects.ai-agent = {
    nixos = { pkgs, config, ... }: {
      imports = [ hermesModule ];

      services.ollama = {
        enable = true;
        package = pkgs.ollama-rocm;
      };

      services.open-webui.enable = true;

      systemd.services.ollama = {
        environment = {
          OLLAMA_CONTEXT_LENGTH = "8192";
          OLLAMA_IGPU_ENABLE = "1";
        };
      };

      services.hermes-agent = {
        enable = true;
        settings = {
          model = {
            base_url = "http://localhost:11434/v1";
            default = "qwen3:8b";
          };
          display = {
            interim_assistant_messages = true;
          };
          curator = {
            enabled = true;
            interval_hours = 4;
            min_idle_hours = 1;
            stale_after_days = 30;
            archive_after_days = 90;
            prune_builtins = false;
            backup = false;
          };
          toolsets = [ "all" ];
          terminal = {
            backend = "local";
            cwd = "/var/lib/hermes/workspace";
          };
        };
        environment = {
          DASHBOARD_CONFIGURED = "1";
          TERMINAL_CWD = "/var/lib/hermes/workspace";
        };
        addToSystemPackages = true;
      };

      # systemd.services.hermes-dashboard = {
      #   description = "Hermes Agent Web Dashboard";
      #   wantedBy = [ "multi-user.target" ];
      #   after = [ "network-online.target" ];
      #   wants = [ "network-online.target" ];
      #
      #   environment = {
      #     HOME = config.services.hermes-agent.stateDir;
      #     HERMES_HOME = "${config.services.hermes-agent.stateDir}/.hermes";
      #   };
      #
      #   serviceConfig = {
      #     User = config.services.hermes-agent.user;
      #     Group = config.services.hermes-agent.group;
      #     ExecStart = "${lib.getBin config.services.hermes-agent.package}/bin/hermes dashboard --host 0.0.0.0 --port 9119 --no-open --insecure";
      #     Restart = "always";
      #     RestartSec = 5;
      #     NoNewPrivileges = true;
      #     ProtectSystem = "strict";
      #     ProtectHome = false;
      #     ReadWritePaths = [ config.services.hermes-agent.stateDir ];
      #     PrivateTmp = true;
      #   };
      # };

    };
  };
}

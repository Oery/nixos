{ den, ... }:
{
  den.aspects.hydra.nixos = { pkgs, config, ... }: {
    services.hydra = {
      enable = true;
      # URI 5.36 already provides URI::ws and URI::wss. The older URI-ws
      # package duplicates those files and breaks Hydra's Perl buildEnv.
      package = pkgs.hydra.override {
        buildEnv = args: pkgs.buildEnv (args // {
          paths = builtins.filter (path: (path.pname or "") != "URI-ws") args.paths;
        });
      };
      hydraURL = "http://fate:3001";
      notificationSender = "hydra@fate";
      listenHost = "0.0.0.0";
      port = 3001;
      useSubstitutes = true;
      # buildMachinesFiles = [ "/etc/nix/machines" ];
    };

    systemd.services.hydra-notify = {
      environment = {
        PERL5LIB = toString ./hydra-plugins;
        HYDRA_DISCORD_WEBHOOK_FILE = "/var/lib/hydra/discord-webhook";
      };
      serviceConfig = {
        StateDirectory = "hydra/discord-notifications";
        StateDirectoryMode = "0700";
      };
    };

    services.hydra-builder = {
      enable = true;
      queueRunnerAddr = "http://[::1]:${toString config.services.hydra.queueRunner.grpc.port}";
      settings.maxJobs = 8;
    };
    systemd.services.hydra-builder.after = [ "hydra-queue-runner.service" ];

    boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
    networking.firewall.allowedTCPPorts = [ 3001 ];
  };
}

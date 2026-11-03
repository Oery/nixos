{ ... }:
{
  den.aspects.discordBot.nixos =
    { config, pkgs, ... }:
    let
      profile = "/nix/var/nix/profiles/discord-bot";
      buildDirectory = "/var/lib/discord-bot-build";
      environmentFile = "/var/lib/discord-bot/environment";
      deployKeyFile = "/var/lib/discord-bot-deploy-key";
      executable = "${profile}/bin/bot-discord-chateau";
      repository = "git@github.com:oery/bot_discord_chateau.git";
      # GitHub's published Ed25519 host key: https://api.github.com/meta
      githubKnownHosts = pkgs.writeText "discord-bot-github-known-hosts" ''
        github.com ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOMqqnkVzrm0SdG6UOoqKLsabgH5C9okWi0dh2l9GKJl
      '';

      # Only the build recipe and toolchain belong to the host configuration.
      # The bot's source is fetched at deployment time, outside the host flake.
      buildExpression = pkgs.writeText "discord-bot-build.nix" ''
        { source, revision }:
        let
          pkgs = import ${pkgs.path} {
            system = "${pkgs.stdenv.hostPlatform.system}";
          };
        in
        pkgs.callPackage ${../../../user-packages/discord-bot/package.nix} {
          inherit source revision;
        }
      '';

      update = pkgs.writeShellApplication {
        name = "discord-bot-update";
        runtimeInputs = [ config.nix.package pkgs.git pkgs.coreutils pkgs.openssh ];
        text = ''
          export GIT_SSH_COMMAND="ssh -F /dev/null \
            -i \"$CREDENTIALS_DIRECTORY/github-deploy-key\" \
            -o IdentitiesOnly=yes -o IdentityAgent=none -o BatchMode=yes \
            -o StrictHostKeyChecking=yes \
            -o UserKnownHostsFile=${githubKnownHosts} -o GlobalKnownHostsFile=/dev/null"
          cd ${buildDirectory}
          if [[ ! -d source/.git ]]; then
            git clone --single-branch --branch main \
              ${repository} source
          fi
          # Migrate checkouts created before authenticated SSH deployment.
          git -C source remote set-url origin ${repository}
          git -C source fetch --no-tags origin \
            +refs/heads/main:refs/remotes/origin/main
          revision="$(git -C source rev-parse --verify 'origin/main^{commit}')"

          # Compare against the last successful build. Failed revisions are
          # retried, and a reboot does not rebuild an already deployed commit.
          if [[ -x candidate/bin/bot-discord-chateau ]] && \
            [[ "$(cat candidate/share/bot-discord-chateau/revision)" == "$revision" ]]; then
            exit 0
          fi

          git -C source reset --hard "$revision"
          git -C source clean -ffdx
          nix-build ${buildExpression} \
            --argstr source "$PWD/source" \
            --argstr revision "$revision" \
            --out-link "$PWD/candidate"
        '';
      };

      activate = pkgs.writeShellApplication {
        name = "discord-bot-activate";
        runtimeInputs = [ config.nix.package pkgs.coreutils pkgs.systemd ];
        text = ''
          candidate="$(readlink -e ${buildDirectory}/candidate)"
          if [[ ! "$candidate" =~ ^/nix/store/[a-z0-9]{32}-[^/]+$ ]]; then
            echo "Candidate must be a top-level Nix store path" >&2
            exit 1
          fi
          test -x "$candidate/bin/bot-discord-chateau"
          if [[ "$(readlink -e ${profile} || true)" == "$candidate" ]]; then
            exit 0
          fi

          # Profiles retain generations and GC roots, including the executable's
          # runtime dependencies. Only this privileged step can change releases.
          # Do not load user-controlled Nix configuration from the build home
          # when running this step as root.
          env HOME=/var/empty NIX_USER_CONF_FILES=/dev/null \
            nix-env --profile ${profile} --set "$candidate"
          systemctl reset-failed discord-bot.service
          systemctl restart discord-bot.service
        '';
      };
    in
    {
      users.groups.discord-bot = { };
      users.users.discord-bot = {
        isSystemUser = true;
        group = "discord-bot";
      };
      users.groups.discord-bot-build = { };
      users.users.discord-bot-build = {
        isSystemUser = true;
        group = "discord-bot-build";
        home = buildDirectory;
      };

      systemd.tmpfiles.rules = [
        "d /var/lib/discord-bot 0700 discord-bot discord-bot -"
      ];

      systemd.services.discord-bot = {
        description = "Chateau Discord bot";
        wantedBy = [ "multi-user.target" ];
        wants = [ "network-online.target" ];
        after = [ "network-online.target" ];
        unitConfig = {
          ConditionPathExists = environmentFile;
          ConditionFileIsExecutable = executable;
          StartLimitIntervalSec = 0;
        };
        environment.SSL_CERT_FILE = "${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt";
        serviceConfig = {
          Type = "exec";
          User = "discord-bot";
          Group = "discord-bot";
          StateDirectory = "discord-bot";
          StateDirectoryMode = "0700";
          WorkingDirectory = "/var/lib/discord-bot";
          EnvironmentFile = environmentFile;
          ExecStart = executable;
          Restart = "always";
          RestartSec = "10s";
          # The bot handles Ctrl-C to close Discord shards cleanly.
          KillSignal = "SIGINT";
          TimeoutStopSec = "30s";
          NoNewPrivileges = true;
          ProtectSystem = "strict";
          ProtectHome = true;
          PrivateTmp = true;
          PrivateDevices = true;
          ProtectKernelTunables = true;
          ProtectKernelModules = true;
          ProtectControlGroups = true;
          RestrictSUIDSGID = true;
          CapabilityBoundingSet = "";
        };
      };

      systemd.services.discord-bot-update = {
        description = "Build and deploy new Chateau Discord bot commits";
        wants = [ "network-online.target" ];
        after = [ "network-online.target" ];
        unitConfig.ConditionPathExists = [ environmentFile deployKeyFile ];
        environment = {
          HOME = buildDirectory;
          GIT_TERMINAL_PROMPT = "0";
          NIX_SSL_CERT_FILE = "${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt";
        };
        serviceConfig = {
          Type = "oneshot";
          User = "discord-bot-build";
          Group = "discord-bot-build";
          StateDirectory = "discord-bot-build";
          StateDirectoryMode = "0700";
          WorkingDirectory = buildDirectory;
          LoadCredential = "github-deploy-key:${deployKeyFile}";
          ExecStart = "${update}/bin/discord-bot-update";
          # '+' elevates only release activation; fetches and builds run as the
          # build account, which cannot read the bot's environment file.
          ExecStartPost = "+${activate}/bin/discord-bot-activate";
          TimeoutStartSec = "2h";
          UMask = "0077";
          Nice = 10;
          CPUWeight = 20;
          IOWeight = 20;
          NoNewPrivileges = true;
          ProtectSystem = "strict";
          ProtectHome = true;
          PrivateTmp = true;
          ReadWritePaths = [ "/nix/var/nix/profiles" ];
        };
      };

      # A oneshot service cannot overlap itself, so slow builds are serialized.
      systemd.timers.discord-bot-update = {
        wantedBy = [ "timers.target" ];
        timerConfig = {
          OnBootSec = "1min";
          OnUnitInactiveSec = "1min";
          AccuracySec = "5s";
        };
      };
    };
}

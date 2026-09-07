{ den, ... }:
{
  den.aspects.hydra.nixos = {
    services.hydra = {
      enable = true;
      hydraURL = "http://fate:3001";
      notificationSender = "hydra@fate";
      listenHost = "0.0.0.0";
      port = 3001;
      useSubstitutes = true;
      buildMachinesFiles = [ "/etc/nix/machines" ];
    };

    nix.buildMachines = [
      {
        hostName = "localhost";
        protocol = null;
        systems = [
          "x86_64-linux"
          "i686-linux"
          "aarch64-linux"
        ];
        maxJobs = 8;
        supportedFeatures = [
          "benchmark"
          "big-parallel"
          "kvm"
          "nixos-test"
        ];
      }
    ];

    boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
    networking.firewall.allowedTCPPorts = [ 3001 ];
  };
}

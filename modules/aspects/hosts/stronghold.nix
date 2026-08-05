{ inputs, den, lib, ... }:
{
  den.aspects.Stronghold = {
    includes = [
      den.aspects.core
      den.aspects.desktop
      den.aspects.nix
      den.aspects.network
      den.aspects.games.hytale
      den.aspects.games.emulation
      den.aspects.games.hollow-knight
      den.aspects.games.minecraft
    ];

    provides.to-users = { user, ... }: lib.optionalAttrs (user.userName == "oery") {
      homeManager.wayland.windowManager.hyprland.settings = {
        monitor = ",preferred,auto,auto";
        env = [
          "NVD_BACKEND,direct"
          "LIBVA_DRIVER_NAME,nvidia"
          "GBM_BACKEND,nvidia-drm"
          "__GLX_VENDOR_LIBRARY_NAME,nvidia-drm"
          "MOZ_DISABLE_RDD_SANDBOX,1"
          "WALLPAPER_TYPE,static"
        ];
      };
    };

    nixos = { pkgs, config, ... }: {
      imports = [
        ../../../host-hardware/hardware-stronghold.nix
      ];

      boot.loader.systemd-boot = {
        enable = true;
        configurationLimit = 5;
      };
      boot.loader.efi.canTouchEfiVariables = true;

      # NVIDIA (RTX 3060) with the open kernel modules, matching the Arch setup.
      services.xserver.videoDrivers = [ "nvidia" ];
      hardware.graphics.enable = true;
      hardware.nvidia = {
        modesetting.enable = true;
        open = true;
        nvidiaSettings = true;
      };

      # Virtual camera loopback (OBS), matching v4l2loopback-dkms on Arch.
      boot.extraModulePackages = [ config.boot.kernelPackages.v4l2loopback ];
      boot.kernelModules = [ "v4l2loopback" ];

      # Xbox controller driver (xpadneo-dkms on Arch).
      hardware.xpadneo.enable = true;

      # Virtualisation stacks present on the Arch host.
      virtualisation = {
        docker.enable = true;
        libvirtd.enable = true;
        virtualbox.host.enable = true;
      };
      programs.virt-manager.enable = true;

      users.users.oery.extraGroups = [ "docker" "libvirtd" "vboxusers" ];

      # Fonts installed only on this host (not in the common fonts aspect).
      fonts.packages = with pkgs; [
        ibm-plex
        nerd-fonts."m+"
      ];

      # Packages installed on the Arch host that are NOT already provided by
      # the common host config (core / desktop / nix / network aspects) or the
      # oery user aspects.
      environment.systemPackages = with pkgs; [
        # Theming / appearance
        adw-gtk3
        lxappearance
        libsForQt5.qt5ct
        qt6ct
        font-manager

        # Desktop / GNOME utilities
        baobab
        blueman
        dunst
        feh
        file-roller
        gnome-control-center
        gnome-online-accounts
        gnome-system-monitor
        gnome-tweaks
        seahorse
        wofi
        yad
        xfce.thunar
        xfce.thunar-volman

        # Screenshot / screen tools
        grim
        slurp

        # Chat
        dissent
        fluffychat

        # Media / creative
        davinci-resolve
        gimp
        inkscape
        kdePackages.kdenlive
        openshot-qt
        obs-studio
        vlc
        ffmpeg
        ffmpegthumbnailer
        mkvtoolnix-cli
        yt-dlp
        sox
        easyeffects
        calf
        lsp-plugins
        cava
        cameractrls
        guvcview
        gst_all_1.gst-libav
        gst_all_1.gst-plugins-base
        gst_all_1.gst-plugins-good
        gst_all_1.gst-plugins-bad
        gst_all_1.gst-plugins-ugly

        # Gaming / launchers
        gamescope
        lunar-client
        modrinth-app
        spotify
        spicetify-cli

        # Wine
        wineWow64Packages.stable
        winetricks

        # Editors / IDEs
        emacs
        helix
        jetbrains.idea-community

        # Build tools & dev utilities
        cmake
        bear
        bacon
        bats
        entr
        trunk
        valgrind
        scanmem
        evtest

        # Languages / runtimes
        dotnet-sdk
        mono
        jdk21
        jdk8
        zig

        # Language servers / VCS
        lua-language-server
        typescript-language-server
        jujutsu

        # Containers / Android
        docker-compose
        android-tools

        # Shells / multiplexers / TUI
        tmux
        zellij
        nushell
        zsh
        yazi

        # CLI utilities
        glow
        chafa
        cmatrix
        cpufetch
        dysk
        tokei
        rsync
        blueprint-compiler
        pipx

        # System / hardware monitoring
        dmidecode
        ddcutil
        powertop
        sysbench
        nvtopPackages.full
        piper
        polychromatic

        # Networking tools
        bind
        iperf3
        mtr
        traceroute
        tcptraceroute
        speedtest-cli

        # Filesystems
        ntfs3g

        # Task management
        taskwarrior3
        taskwarrior-tui

        # Peripheral sharing
        deskflow

        # Python with the modules used by local scripts
        (python3.withPackages (ps: with ps; [
          matplotlib
          pandas
          pyaudio
          toml
          websockets
          evdev
        ]))
      ];
    };
  };
}

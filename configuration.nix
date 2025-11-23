# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
  # services.xserver.xkb.options = "caps:escape";
  services.tailscale.enable = true;
  imports =
    [ # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
      inputs.home-manager.nixosModules.home-manager
    ]; 
 
  nix.settings = {
    download-buffer-size = 1024288000; # 500Mib
  };
 #flakes enabler
 nix.settings.experimental-features = [ "nix-command" "flakes" ];

 #home-manager importer
 home-manager = {

   	extraSpecialArgs = {inherit inputs;};
	users = {
		big_scroll = {
			imports =  [./home.nix];
		};
	
	 };
	backupFileExtension = "bak";
 };

#allowing a package to be insecurely built cuz there are some security concerns


  nixpkgs.config.permittedInsecurePackages = [
  "qtwebengine-5.15.19"
  ];
            

 #GC collector config
 nix.gc = {
   automatic = true;
   dates = "daily";
   options = "--delete-older-than 3d";
  };

 #for nvidia gpu
   # Enable OpenGL
  hardware.graphics = {
    enable = true;
  };

  # Load nvidia driver for Xorg and Wayland
  # For offloading, `modesetting` is needed additionally,
  # otherwise the X-server will be running permanently on nvidia,
  # thus keeping the GPU always on (see `nvidia-smi`).
  services.xserver.videoDrivers = [
    "modesetting"  # example for Intel iGPU; use "amdgpu" here instead if your iGPU is AMD
    "nvidia"
  ];

  hardware.nvidia = {

    # Modesetting is required.
    modesetting.enable = true;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    # Enable this if you have graphical corruption issues or application crashes after waking
    # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead 
    # of just the bare essentials.
    powerManagement.enable = false;

    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = false;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of 
    # supported GPUs is at: 
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus 
    # Only available from driver 515.43.04+
    open = false;

    # Enable the Nvidia settings menu,
	# accessible via `nvidia-settings`.
    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    };

  hardware.nvidia.prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
      # Make sure to use the correct Bus ID values for your system!
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:14:0:0";
      # amdgpuBusId = "PCI:54:0:0"; For AMD GPU
    };

  #for ntfs filesystem
  boot.supportedFilesystems=["ntfs"];
   
  fileSystems."/mnt/ddrive" =
    { device = "/dev/disk/by-uuid/880611BE0611ADE6";
      fsType = "ntfs-3g"; 
      options = ["defaults" "rw" "uid=1000" "gid=100"];
    };
  #for bluetooth 
   hardware = {
    	 bluetooth = {
         enable = true;
         #Needed this to properly display battery 
         #percentage for my cheap bluetooth earbuds
       	 settings.General.Experimental = true;
         };
   };



   
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;



  networking.hostName = "big_scroll"; # Define your hostname.
  # networking.wireless.enable = false;  # Enables wireless support via wpa_supplicant.

  #installs new backend for wifi which is iwd
  networking.wireless.iwd.enable = true;
  
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager={
    enable = true;
    #changes network manager backend to iwd from wpa_supplicant which is shit
    wifi.backend = "iwd";
    #prevent wifi from turning off
    wifi.powersave = false;
    
  };


 #creating a hotspot
   services.create_ap = {
  	 enable = true;
  	 settings = {
  	  INTERNET_IFACE = "enp0s20f0u2c2";
  	 	WIFI_IFACE = "wlan0";
  	 	SSID = "BigScroll";
  	 	PASSPHRASE = "scroll316";
	   };
   };

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_IN";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm = {
    enable = true;
    theme= "catppuccin-mocha-mauve";
    #package = pkgs.kdePackages.sddm;
    
  };
  services.desktopManager.plasma6.enable = true;

   
# this is for mod/tap behaviour to get
  # capslock to work as esc when tapped and lctrl when help
  services.interception-tools = {
    enable = true;
    plugins = [ pkgs.interception-tools-plugins.caps2esc ];
    udevmonConfig = ''
      - JOB: "${pkgs.interception-tools}/bin/intercept -g $DEVNODE | ${pkgs.interception-tools-plugins.caps2esc}/bin/caps2esc | ${pkgs.interception-tools}/bin/uinput -d $DEVNODE"
        DEVICE:
          EVENTS:
            EV_KEY: [KEY_CAPSLOCK, KEY_ESC]
    '';
  };
  
  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    # jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;


  #to enable unfree packages
  nixpkgs.config.allowUnfree = true;

  
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.big_scroll = {
    isNormalUser = true;
    description = "Chandrashekar M";
    extraGroups = [ "networkmanager" "wheel" "docker"];

    # extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      kdePackages.kate
    #  thunderbird
    ];
  };



  #docker shit, enable the extragroups above fro docker
  virtualisation.docker.enable = true;

  #shells
  environment.shells = with pkgs; [zsh fish bash];
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;


  # Install packages.
  programs.firefox.enable = true;
  
  programs.steam.enable = true;
  
  programs.java = {
	enable = true;
  };


  nixpkgs.overlays = [
    (final: prev:
      let
        pkgs-stable = import inputs.nixpkgs-stable {
          system = pkgs.system;
          config.allowUnfree = true;
        };
      in
      {
        stremio = pkgs-stable.stremio;
      }
      
    )
  ];

  
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [ 
    wl-clipboard
    vicinae
    p7zip
    p7zip-rar
    rar
    file-roller
    gimp
    docker-compose
    lutris
    brave
    localsend
    qbittorrent
    
    kdePackages.kdeconnect-kde    
     starship
    # xsel
    fastfetch
    lazygit
    mangohud
    tailscale
    
    (catppuccin-sddm.override {
      flavor = "mocha";
      font  = "Noto Sans";
      fontSize = "9";
      background = "${./hardcoded/second_dragon_blue.png}";
      loginBackground = true;
    })
    thunderbird
    appimage-run
    #wpsoffice
    onlyoffice-desktopeditors
    libreoffice
    iwd
    btop
    bat
    zapzap
    obsidian
    linux-wifi-hotspot
    neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    # discord
    telegram-desktop
    
    lshw
    tmux	
    
    git
    python310
    obs-studio
    vlc
    stremio
    qbittorrent
    zed-editor
    resonance
    pkgs.syncthing
    pkgs.thunderbird
    nh
    inputs.zen-browser.packages.${pkgs.system}.default

  ];

  fonts.packages = with pkgs; [
	# (nerdfonts.override{fonts = ["JetBrainsMono"];})
	nerd-fonts.jetbrains-mono


  ];

  #enabling flatpaks support
  services.flatpak.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
  #cusotm dns server
    networking.nameservers = ["94.140.14.14" "94.140.15.15"];


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}

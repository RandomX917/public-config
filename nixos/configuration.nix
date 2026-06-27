{inputs, config, lib, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
    ];
  boot.loader = {
  grub = {
  enable = true;
  efiSupport = true;
  device = "nodev";
  useOSProber = true;
  theme = (pkgs.sleek-grub-theme.override {
  withStyle = "dark";
  withBanner = "Welcome to NixOS";
  });
  };
  };
  boot.loader.systemd-boot.enable = false;
  boot.loader.efi.canTouchEfiVariables = true;
   networking.hostName = "nixos"; 
  networking.networkmanager.enable = true;
  time.timeZone = "America/Chicago";
  services.logind.settings.Login.HandleLidSwitchDocked = "ignore";
  services.logind.settings.Login.HandleLidSwitchExternalPower = "ignore";
  services.logind.settings.Login.HandleLidSwitch = "ignore";
  networking.nftables.enable = true;
boot.kernelModules = [ "ip_tables" ]; 
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };
  hardware.bluetooth = {
  enable = true;
  powerOnBoot = false;
};
programs.kdeconnect.enable = true;
services.blueman.enable = true;
  nix.settings.experimental-features = ["nix-command" "flakes"];
  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.displayManager.defaultSession = "hyprland";
  services.desktopManager.plasma6.enable = true;
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
  plasma-browser-integration
  konsole
  oxygen
  elisa
  kate
  khelpcenter
  ];
  programs.mangowc.enable = true;
    programs.hyprland = {
enable = true;
xwayland.enable = true;
};
   services.printing.enable = true;
    swapDevices = [ {
   device = "/swapfile";
   size = 4096;
   } ];
  zramSwap.enable = true;
   services.pipewire = {
     enable = true;
     pulse.enable = true;
   };
   services.flatpak.enable = true;

  fonts.packages = with pkgs; [
	nerd-fonts.jetbrains-mono
  ];
   users.users.random = {
     isNormalUser = true;
     extraGroups = [ "networkmanager" "wheel" "input"  ];
     packages = with pkgs; [
       tree
       vesktop
       discord
     ];
   };
   nixpkgs.config.allowUnfree = true;
environment.shells = with pkgs; [ fish];
virtualisation.waydroid.enable = true;
programs.fish.enable = true;
#programs.steam.enable = true;
programs.neovim.defaultEditor = true;
users.defaultUserShell = pkgs.fish;
programs.firefox.enable = true;
programs.neovim.enable = true;
environment.systemPackages = with pkgs; [
  efibootmgr
  tree-sitter
  gparted
  cmatrix
  obs-studio
  gimp
  proton-authenticator
  gnumake
  rar
  libinput
  btop
  spotify
  cava
  sptlrx
  osu-lazer-bin
  obsidian
  wineWow64Packages.stable
  proton-vpn-cli
  librewolf
  ungoogled-chromium
  swaynotificationcenter
  inputs.zen-browser.packages.${system}.default
  inputs.mangowc.packages.x86_64-linux.mango
  jq
  foot
  wmenu
  swaybg
  quickshell
  st
  kitty
  ratty
  awww
  mpvpaper
  waypaper
  git
  fastfetch
  onefetch
  rofi
  waybar
  hyprsunset
  hyprlock
  swaylock
  wl-clipboard
  brightnessctl
  grim
  slurp
  #code
  nodejs
  pm2
  python3
  gcc
  cargo
  wget
  eza
  zoxide
  bat
   ];

  services.openssh = {
  enable = true;
  settings = {
  PasswordAuthentication = false;
  PermitRootLogin = "no";
  };
  };
  services.tailscale.enable = true;
  system.stateVersion = "26.11";

}


# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

# NixOS-WSL specific options are documented on the NixOS-WSL repository:
# https://github.com/nix-community/NixOS-WSL

{ config, lib, pkgs, ... }:

{
	imports = [
		./hardware.nix
		# <nixos-wsl/modules>
		inputs.nixos-wsl.nixosModules
	];

	# bootloader
	#boot.loader.grub.enable = true;
	#boot.loader.grub.device = "/dev/vda/";
	#boot.loader.grub.useOSProber = true;

	nix.settings.experimental-features = ["nix-command" "flakes" ];

	networking.hostName = "lontra-canadensis-wsl";

	networking.networkmanager.enable = true;
	time.timeZone = "Europe/Paris";

	i18n.defaultLocale = "fr_FR.UTF-8";

	wsl.enable = true;
	wsl.defaultUser = "nixos";

	environment.systemPackages = with pkgs; [
		alacritty
		bemenu
		borgbackup
		curl
		eww
		fastfetch
		firefox-bin
		fzf
		gh
		godot_4
		lazygit
		mprocs
		mpv
		pipes-rs
		ripgrep
		rustup
		starship
		stow
		trash-cli
		tree
		unzip
		w3m
		wiki-tui
		zellij
		zoxide
	];
	
	programs = {
		fzf = {
			fuzzyCompletion = true;
			keybindings = true;
		};
		git.enable = true;
		htop.enable = true;
		neovim = {
			enable = true;
			defaultEditor = true;
			viAlias = true;
			vimAlias = true;
		};
		thefuck.enable = true;
		#starship.enable = true;
		#sway.enable = true;
		#hyprland.enable = true;
	};

	#xdg.portal.wlr.enable = true;

	services.xserver.desktopManager.gnome.enable = true;
	services.xserver.displayManager.gdm.enable = true;


	# This value determines the NixOS release from which the default
	# settings for stateful data, like file locations and database versions
	# on your system were taken. It's perfectly fine and recommended to leave
	# this value at the release version of the first install of this system.
	# Before changing this value read the documentation for this option
	# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
	system.stateVersion = "24.05"; # Did you read the comment?
}
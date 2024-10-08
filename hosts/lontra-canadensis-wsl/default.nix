# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

# NixOS-WSL specific options are documented on the NixOS-WSL repository:
# https://github.com/nix-community/NixOS-WSL

{ config, inputs, outputs, lib, pkgs, ... }:

{
	imports = [
		./hardware.nix
		outputs.nixosModules.audio
		outputs.nixosModules.bash
		outputs.nixosModules.git
		outputs.nixosModules.packages
		outputs.nixosModules.programs
		outputs.nixosModules.timeAndLanguage
	];

	# bootloader
	#boot.loader.grub.enable = true;
	#boot.loader.grub.device = "/dev/vda/";
	#boot.loader.grub.useOSProber = true;

	nix.settings.experimental-features = ["nix-command" "flakes" ];

	networking.hostName = "lontra-canadensis-wsl";

	networking.networkmanager.enable = true;

	wsl.enable = true;
	wsl.defaultUser = "nixos";

	users.users.nixos.extraGroups = [ "audio" ];

	environment = {
		systemPackages = with pkgs; [
			wsl-open
		];
		sessionVariables = rec {
			FLAKE = "/home/nixos/dotfiles";
		};
	};
	
	programs = {
		fzf = {
			fuzzyCompletion = true;
			keybindings = true;
		};
		neovim = {
			enable = true;
			defaultEditor = true;
			viAlias = true;
			vimAlias = true;
		};
		#starship.enable = true;
		#sway.enable = true;
		#hyprland.enable = true;
	};

	# This value determines the NixOS release from which the default
	# settings for stateful data, like file locations and database versions
	# on your system were taken. It's perfectly fine and recommended to leave
	# this value at the release version of the first install of this system.
	# Before changing this value read the documentation for this option
	# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
	system.stateVersion = "24.05"; # Did you read the comment?
}

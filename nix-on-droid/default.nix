# PAPAVER RHOEAS

{ nixpkgs, inputs, outputs, lib, pkgs, ... }:

{
	imports = [
		outputs.nixOnDroidModules.packages
		#outputs.nixOnDroidModules.silly
	];
	
	#nixpkgs = {
	#	overlays = [
	#		outputs.overlays.unstable-packages
	#	];
	#
	#	config = {
	#		allowUnfree = true;
	#	};
	#};

	environment.sessionVariables = {
		FLAKE = "$HOME/dotfiles";
		motd = "this is THATODDSHADE's NIX-ON-DROID configuration! if nothing works, open an issue at either [its repository](https://github.com/thatoddshade/dotfiles) or [NIX-ON-DROID's](https://github.com/nix-community/nix-on-droid/issues) or try the rescue shell.";
	};

	# backup etc files instead of failing to activate generation if a file already exists in /etc
	environment.etcBackupExtension = ".bak";

	# read the changelog before changing this value
	system.stateVersion = "24.05";

	# set up nix for flakes
	nix.extraOptions = ''
		experimental-features = nix-command flakes
	'';

	android-integration = {
		am.enable = true;
		termux-open.enable = true;
		termux-open-url.enable = true;
		termux-reload-settings.enable = true;
		termux-setup-storage.enable = true;
		xdg-open.enable = true;
	};

	terminal.colors = {
		background = "#000000";
		foreground = "#fffcf0";
		cursor = "#fffcf0";
	};
}

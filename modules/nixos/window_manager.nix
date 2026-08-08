{ inputs, pkgs, ... }:
{
	imports = [
		inputs.noctalia.nixosModules.default
	];

	environment.systemPackages = with pkgs; [
		bemenu
	];

	programs.hyprland.enable = true;
	programs.hyprland.withUWSM = true;
	environment.sessionVariables.NIXOS_OZONE_WL = "1"; # Tell Electron applications to use Wayland.
	
	programs.noctalia = {
		enable = true;
		recommendedServices.enable = true;
		systemd.enable = true;
	};

	nix.settings = {
		extra-substituters = [ "https://noctalia.cachix.org" ];
		extra-trusted-public-keys = [ "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4=" ];
	};
}

# basically `packages.nix` but for silly stuff

{ inputs, pkgs, ... }:
{
	environment.systemPackages = with pkgs; [
		gti
		hollywood
		lavat
		pipes-rs
		sl
	];
}

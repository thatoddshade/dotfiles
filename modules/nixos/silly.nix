# basically `packages.nix` but for silly stuff

{ inputs, pkgs, ... }:
{
	environment.systemPackages = with pkgs; [
		cowsay
		gti
		hollywood
		lavat
		pipes-rs
		sl
	];
}

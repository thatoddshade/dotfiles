# basically `packages.nix` but for silly stuff

{ inputs, pkgs, ... }:
{
	environment.packages = with pkgs; [
		hollywood
		lavat
		pipes-rs
	];
}

# basically `packages.nix` but for silly stuff

{ inputs, pkgs, ... }:
{
	environment.systemPackages = with pkgs; import ../package-lists/silly.nix;
}

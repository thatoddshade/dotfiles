# basically `packages.nix` but for silly stuff

{ inputs, pkgs, ... }:
{
	environment.systemPackages = with pkgs; import ../silly-packages.nix
}

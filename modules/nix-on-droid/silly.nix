# basically `packages.nix` but for silly stuff

{ inputs, pkgs, ... }:
{
	environment.packages = with pkgs; import ../silly-packages.nix;
}

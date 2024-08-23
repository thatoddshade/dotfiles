# configuration for any personal computers
{pkgs}:
{
	programs = nixpkgs.lib.genAttrs [
		"htop"
		"lazygit"
		"mtr"
		"nh"
		"nix-ld"
		"thefuck"
	] (program: { enable = true; });
}

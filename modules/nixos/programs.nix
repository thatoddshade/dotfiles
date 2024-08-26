# configuration for any personal computers
{lib, ...}:
{
	programs = lib.genAttrs [
		"htop"
		"lazygit"
		"mtr"
		"nh"
		"nix-ld"
		"thefuck"
	] (program: { enable = true; });
}

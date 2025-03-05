# modules should be pieces of configuration sharable with others, not coupled with one's specific configuration

{
	# module files
	packages = import ./packages.nix;
	silly = import ./silly.nix;
}

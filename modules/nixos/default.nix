# modules should be pieces of configuration sharable with others, not coupled with one's specific configuration

{
	# module files
	audio = import ./audio.nix;
	autoUpgrade = import ./autoupgrade.nix;
	bash = import ./bash.nix;
	git = import ./git.nix;
	packages = import ./packages.nix;
	packagesGraphical = import ./packages_graphical.nix;
	programs = import ./programs.nix;
	style = import ../style.nix;
	silly = import ./silly.nix;
	ssh = import ./ssh.nix;
	timeAndLanguage = import ./time_and_language.nix;
}

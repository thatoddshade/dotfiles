# modules should be pieces of configuration sharable with others, not coupled with one's specific configuration

{
	# module files
	browser = import ./browser.nix;
	git = import ./git.nix;
	programs = import ./programs.nix;
	style = import ../style.nix;
	timeAndLanguage = import ./time_and_language.nix;
}

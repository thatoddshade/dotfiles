# modules should be pieces of configuration sharable with others, not coupled with one's specific configuration

{
	# module files
	style = import ../style.nix;
	browser = import ./browser.nix;
	timeAndLanguage = import ./time_and_language.nix;
}

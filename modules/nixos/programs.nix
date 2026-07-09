# Programs' configuration.
{lib, ...}:
{
	programs.htop.enable = true;
	programs.lazygit.enable = true;
	programs.mtr.enable = true;
	programs.nh.enable = true;
	programs.nix-ld.enable = true;
	programs.fzf = { fuzzyCompletion = true; keybindings = true; }
	programs.neovim = {
		enable = true;
		defaultEditor = true;
		viAlias = true;
		vimAlias = true;
	};
}

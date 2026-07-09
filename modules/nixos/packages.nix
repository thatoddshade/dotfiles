{ inputs, pkgs, ... }:
{
	environment.systemPackages = with pkgs; [
		asciinema
		asciinema-agg
		borgbackup
		curl
		dysk
		evil-helix
		fastfetch
		ffmpeg
		fzf
		haskell-language-server # HSL
		gh
		hello
		#inputs.dmm.packages.x86_64-linux.default
		imagemagick
		jujutsu	# Git-compatible DVCS that is both simple and powerful: `jj`
		kondo
		lazygit
		mprocs
		#newsboat
		nvd	# Diff tool for Nix profiles
		plan9port
		ripgrep	# Grep Rust rewrite
		starship
		tmux
		trash-cli
		tree
		unp
		w3m
		wget
		wiki-tui
		yt-dlp
		zoxide

		
		procps
		killall
		diffutils
		findutils
		utillinux
		tzdata
		hostname
		man
		#gnugrep
		gnupg
		gnused
		gnutar
		bzip2
		gzip
		xz
		zip
		unzip
	];
}

{ inputs, pkgs, ... }:
{
	environment.systemPackages = with pkgs; [
		asciidoctor
		asciinema
		asciinema-agg
		borgbackup
		#clang
		curl
		cmark
		dysk
		evil-helix
		fastfetch
		ffmpeg
		fzf
		#gcc
		ghc # Haskell compiler
		haskell-language-server # HSL
		stack # Alternative to cabal, Haskell build tool
		#haskellPackages.ghcup	# GHC toolchain installer for Haskell development		# one of its dependencies is for some reason marked as broken…
		gh
		#gnumake
		hello
		#inputs.dmm.packages.x86_64-linux.default
		imagemagick
		jujutsu	# Git-compatible DVCS that is both simple and powerful: `jj`
		kondo
		lazygit
		mprocs
		#newsboat
		pandoc
		python3
		plan9port
		rustup
		ripgrep	# Grep Rust rewrite
		dart-sass
		soupault
		haskellPackages.stack
		starship
		tmux
		trash-cli
		tree
		unp
		w3m
		wget
		wiki-tui
		yt-dlp
		zola	# Markdown and TOML frontmatter SSG written in Rust
		zellij
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

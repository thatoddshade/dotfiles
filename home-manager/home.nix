{
	inputs,
	outputs,
	lib,
	config, 
	pkgs,
	...
}: {
	imports = [
		./features/mako.nix
		outputs.homeManagerModules.style
	];

	#colorScheme = inputs.nix-colors.colorSchemes.kanagawa;
	nixpkgs = {
		overlays = [
			#neovim-nightly-overlay.overlays.default

			#(final: prev: {
			#  hi = final.hello.overrideAttrs (oldAttrs: {
			#    patches = [ ./change-hello-to-hi.patch ];
			#  });
			#})
		];

		config = {
			# enable unfree packages
			allowUnfree = true;

			# workaround for https://github.com/nix-community/home-manager/issues/2942
			allowUnfreePredicate = _: true;
		};
	};

	home = {
		username = "demo";
		homeDirectory = "/home/demo";

		# this value determines the Home Manager release that your configuration is
		# compatible with; this helps avoid breakage when a new Home Manager release
		# introduces backwards incompatible changes.
		#
		# you should not change this value, even if you update Home Manager. if you do
		# want to update the value, then make sure to first check the Home Manager
		# release notes.
		stateVersion = "24.05";

		# user-specific packages
		packages = with pkgs; [
			# # It is sometimes useful to fine-tune packages, for example, by applying
			# # overrides. You can do that directly here, just don't forget the
			# # parentheses. Maybe you want to install Nerd Fonts with a limited number of
			# # fonts?
			# (nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

			# # You can also create simple shell scripts directly inside your
			# # configuration. For example, this adds a command 'my-hello' to your
			# # environment:
			# (writeShellScriptBin "my-hello" ''
			#	 echo "Hello, ${config.home.username}!"
			# '')
		];

		# symbolicly link files to home directory
		file = {
			".config/river".source = files/river;
			"Pictures/wallpapers".source = outputs.wallpaperDirectory;

			# # You can also set the file content immediately.
			# ".gradle/gradle.properties".text = ''
			#	 org.gradle.console=verbose
			#	 org.gradle.daemon.idletimeout=3600000
			# '';
			};

		# Home Manager can also manage your environment variables through
		# 'home.sessionVariables'. These will be explicitly sourced when using a
		# shell provided by Home Manager. If you don't want to manage your shell
		# through Home Manager then you have to manually source 'hm-session-vars.sh'
		# located at either
		#
		#	~/.nix-profile/etc/profile.d/hm-session-vars.sh
		#
		# or
		#
		#	~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
		#
		# or
		#
		#	/etc/profiles/per-user/demo/etc/profile.d/hm-session-vars.sh
		#
		sessionVariables = {};
	};

	programs = {
		# let Home Manager install and manage itself
		home-manager.enable = true;

		git = {
			enable = true;

			userName = "thatoddshade";
			userEmail = "thatoddshade+git@proton.me";
		};
	};

	# reload system units when changing configurations
	systemd.user.startServices = "sd-switch";
}

{
	inputs,
	outputs,
	lib,
	config,
	pkgs,
	...
}: {
	imports = [
		./hardware-configuration.nix
		inputs.xremap-flake.nixosModules.default
		outputs.nixosModules.style
	];

	nixpkgs = {
		overlays = [
			outputs.overlays.unstable-packages
		];
	
		config = {
			allowUnfree = true;
		};
	};

	nix = let
		 flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
	in {
		settings = {
			experimental-features = "nix-command flakes";

			# disable flake registry
			flake-registry = "";

			nix-path = config.nix.nixPath;
		 };

		channel.enable = false;

		# make flake registry and nix path match flake inputs
		registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
		nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
	};

	boot.loader = {
		# use the GRUB 2 boot loader
		grub = {
			enable = true;
			#efiSupport = true;
			#efiInstallAsRemovable = true;

			# define on which hard drive Grub should be installed
			device = "/dev/sda";
		};

		#efi.efiSysMountPoint = "/boot/efi";
	};

	# Pick only one of the below networking options.
	networking = {
		#hostName = "nixos";
		hostName = "lontra-canadensis";
		networkmanager.enable = true;	# Easiest to use and most distros use this by default.
		#wireless.enable = true;	# Enables wireless support via wpa_supplicant.
	};

	# Set your time zone.
	time.timeZone = "Europe/Paris";

	# select internationalisation properties
	i18n.defaultLocale = "fr_FR.UTF-8";

	services = {
		# configure keymap in X11
		xserver.xkb.layout = "eu";
		#xserver.xkb.options = "eurosign:e,caps:escape";

		# enable CUPS to allow printing documents
		printing.enable = true;

		# enable sound
		pipewire = {
			enable = true;
			pulse.enable = true;
		};

		# enable touchpad support (enabled default in most desktopManager)
		libinput.enable = true;
	};

	# Define a user account. Don't forget to set a password with ‘passwd’.
	users.users.demo = {
		isNormalUser = true;
		extraGroups = [ "networkmanager" "wheel" ]; # Enable ‘sudo’ for the user.
		password = "demo";
	};

	# list packages to be installed in system profile
	environment = {
		systemPackages = with pkgs; [
			alacritty
			#ags
			asciinema
			asciinema-agg
			bemenu
			#borgbackup
			#blockench
			cpu-x
			curl
			eww
			fastfetch
			fzf
			gcc
			genact
			gh
			#gimp
			gnumake
			#godot_4
			#haskellPackages.game-of-life
			imv
			inputs.dmm.packages.x86_64-linux.default
			lavat
			mako
			morewaita-icon-theme
			mprocs
			mpv
			nvd
			pipes-rs
			ripgrep
			#ristate
			rustup
			sandbar
			starship
			stow
			swaybg
			swayimg
			transmission
			trash-cli
			tree
			unp
			unzip
			w3m
			wezterm
			wget
			wiki-tui
			wl-clipboard
			yt-dlp
			zellij
			zola
			zoxide
		];
		sessionVariables = rec {
			FLAKE = "/home/demo/dotfiles";
		};
	};

	# configure programs
	programs = {
		bash = {
			interactiveShellInit = "set -o vi";
			undistractMe.enable = true;
		};
		firefox = {
			enable = true;
			#package = pkgs.firefox-bin;
			package = pkgs.unstable.firefox-bin;
		};
		fzf = {
			fuzzyCompletion = true;
			keybindings = true;
		}; 
		git = {
			enable = true;
			config = {
				init.defaultBranch = "trunk";
			};
		};
		gnupg.agent = {
			enable = true;
			enableSSHSupport = true;
		};
		htop.enable = true;
		lazygit.enable = true;
		mtr.enable = true;
		neovim = {
			enable = true;
			defaultEditor = true;
			viAlias = true;
			vimAlias = true;
		};
		nh.enable = true;
		thefuck.enable = true;
		river.enable = true;
		#waybar.enable = true;
	};

	# configure services
	services = {
		# Enable the OpenSSH daemon.
		openssh = {
			enable = true;
		};

		upower.enable = true;

		xremap = {
			userName = "demo";
			config = {
				keymap = [
					{
						name = "main-remaps";
						remap = {
							super-b = {
								launch = ["pkill sandbar || sandbar"];
							};
						};
					}
				];
			};
		};
	};

	hardware = {
		opengl = {
			enable = true;
			driSupport = true;
			driSupport32Bit = true;
		};
	};

	# Open ports in the firewall.
	# networking.firewall.allowedTCPPorts = [ ... ];
	# networking.firewall.allowedUDPPorts = [ ... ];
	# Or disable the firewall altogether.
	# networking.firewall.enable = false;
	
	system = {
		# from https://nixos.wiki/wiki/Automatic_system_upgrades
		autoUpgrade = {
			enable = true;
			flake = inputs.self.outPath;
			flags = [
				"--update-input"
				"nixpkgs"
				"-L"  # print build logs
			];
			dates = "12:00";
			randomizedDelaySec = "45min";
		};

		# Copy the NixOS configuration file and link it from the resulting system
		# (/run/current-system/configuration.nix). This is useful in case you
		# accidentally delete configuration.nix.
		#copySystemConfiguration = true;
		
		# This option defines the first version of NixOS you have installed on this particular machine,
		# and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
		#
		# Most users should NEVER change this value after the initial install, for any reason,
		# even if you've upgraded your system to a new NixOS release.
		#
		# This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
		# so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
		# to actually do that.
		#
		# This value being lower than the current NixOS release does NOT mean your system is
		# out of date, out of support, or vulnerable.
		#
		# Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
		# and migrated your data accordingly.
		#
		# For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
		stateVersion = "24.05"; # Did you read the comment?
	};

}


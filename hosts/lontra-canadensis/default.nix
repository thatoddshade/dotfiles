{
	inputs,
	outputs,
	lib,
	config,
	pkgs,
	...
}: {
	imports = [
		./hardware.nix
		inputs.xremap-flake.nixosModules.default
		outputs.nixosModules.audio
		outputs.nixosModules.bash
		outputs.nixosModules.browser
		outputs.nixosModules.git
		outputs.nixosModules.packages
		outputs.nixosModules.programs
		outputs.nixosModules.style
		outputs.nixosModules.timeAndLanguage
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

	services = {
		# configure keymap in X11
		#xserver.xkb.options = "eurosign:e,caps:escape";

		# enable CUPS to allow printing documents
		printing.enable = true;

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
			bemenu
			#blockench
			cpu-x
			eww
			genact
			#gimp
			#godot_4
			#haskellPackages.game-of-life
			imv
			mako
			morewaita-icon-theme
			mpv
			nvd
			#ristate
			sandbar
			swaybg
			swayimg
			transmission
			wezterm
			wl-clipboard
			wlr-randr
		];
		sessionVariables = rec {
			FLAKE = "/home/demo/dotfiles";
		};
	};

	# configure programs
	programs = {
		fzf = {
			fuzzyCompletion = true;
			keybindings = true;
		}; 
		gnupg.agent = {
			enable = true;
			enableSSHSupport = true;
		};
		neovim = {
			enable = true;
			defaultEditor = true;
			viAlias = true;
			vimAlias = true;
		};
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

	xdg.portal.wlr.enable = true;

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


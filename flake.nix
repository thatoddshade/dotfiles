{
	description = "thatoddshade's NIXOS, HOME MANAGER and NIX-ON-DROID flake configuration";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-24.11";
		nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";


		home-manager = {
			url = "github:nix-community/home-manager/release-24.11";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		nixos-cli.url = "github:water-sucks/nixos";
		nixos-wsl.url = "github:nix-community/NixOS-WSL";

		stylix.url = "github:danth/stylix";

		#systems.url = "github:nix-systems/default";

		xremap-flake.url = "github:xremap/nix-flake";

		
		nix-on-droid = {
			url = "github:nix-community/nix-on-droid/release-24.05";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, nixos-cli, nixos-wsl, stylix, nix-on-droid, ... }@inputs: 
	let
		inherit (self) outputs;

		systems = [
			"aarch64-linux"
			"i686-linux"
			"x86_64-linux"
			"aarch64-darwin"
			"x86_64-darwin"
		];

		forAllSystems = nixpkgs.lib.genAttrs systems;

		wallpaperDirectory = ./wallpapers;
	in
	{
		# custom packages accessible through `nix build`, `nix shell` and other nix subcommands
		packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});

		# formatter for nix files available through `nix fmt`
		formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

		overlays = import ./overlays {inherit inputs;};

		# wallpaper files
		inherit wallpaperDirectory;
		wallpaper = wallpaperDirectory + "/3.png";

		nixosModules = import ./modules/nixos;
		nixosConfigurations = import ./hosts {
			inherit nixpkgs inputs outputs nixos-cli nixos-wsl stylix;
		};

		homeManagerModules = import ./modules/home-manager;
		homeConfigurations = {
			"demo" = home-manager.lib.homeManagerConfiguration {
				pkgs = nixpkgs.legacyPackages.x86_64-linux;
				extraSpecialArgs = {
					inherit inputs outputs;
					#inherit pkgs-unstable;
				};
				modules = [
					./home-manager/home.nix
					inputs.stylix.homeManagerModules.stylix
				];
			};
		};

		
		nixOnDroidModules = import ./modules/nix-on-droid;
			nixOnDroidConfigurations.default = nix-on-droid.lib.nixOnDroidConfiguration {
				pkgs = import nixpkgs { system = "aarch64-linux"; };
				modules = [ ./nix-on-droid ];
			extraSpecialArgs = { inherit nixpkgs inputs outputs; };
			};
	};
}

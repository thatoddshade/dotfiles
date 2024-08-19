{
	description = "thatoddshade's NIXOS and HOME MANAGER flake configuration";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-24.05";
		#nixpkgs-unstable.url = "github:nixos/nixpkgs?ref=nixos-unstable";

		home-manager = {
			url = "github:nix-community/home-manager/release-24.05";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		#nix-colors.url = "github:misterio77/nix-colors";
		stylix.url = "github:danth/stylix";

		systems.url = "github:nix-systems/default";
	
		xremap-flake.url = "github:xremap/nix-flake";
	};

	outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, stylix, ... }@inputs: 
	let
		inherit (self) outputs;

		#systems = [
		#	"aarch64-linux"
		#	"i686-linux"
		#	"x86_64-linux"
		#	"aarch64-darwin"
		#	"x86_64-darwin"
		#];


		forAllSystems = nixpkgs.lib.genAttrs systems;

		#pkgs-unstable = nixpkgs-unstable.legacyPackages.${system};

		wallpaperDirectory = ./wallpapers;
	in
	{
		# custom packages accessible through `nix build`, `nix shell` and other nix subcommands
		packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});

		# formatter for nix files available through `nix fmt`
		formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

		overlays = import ./overlays {inherit inputs;};

		# modules
		nixosModules = import ./modules/nixos;
		homeManagerModules = import ./modules/home-manager;

		# wallpaper files
		inherit wallpaperDirectory;
		wallpaper = wallpaperDirectory + "/3.png";

		nixosConfigurations = {
			#nixos = nixpkgs.lib.nixosSystem {
			lontra-canadensis = nixpkgs.lib.nixosSystem {
				#specialArgs = {inherit inputs;};
				specialArgs = {
					inherit inputs outputs;
					#inherit pkgs-unstable;
				};
				modules = [
					./nixos/configuration.nix
					inputs.stylix.nixosModules.stylix
				];
			};
		};

		homeConfigurations = {
			#"demo@nixos" = home-manager.lib.homeManagerConfiguration {
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
	};
}

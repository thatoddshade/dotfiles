{nixpkgs, inputs, outputs, nixos-cli, nixos-wsl, stylix, ...}:
nixpkgs.lib.genAttrs [
		"lontra-canadensis"
		"lontra-canadensis-wsl"
	] (host:
	nixpkgs.lib.nixosSystem {
		specialArgs = {inherit inputs outputs;};
		modules = [
			(./. + "/${host}")
			nixos-cli.nixosModules.nixos-cli
			nixos-wsl.nixosModules.default
			stylix.nixosModules.stylix
		];
	}
)

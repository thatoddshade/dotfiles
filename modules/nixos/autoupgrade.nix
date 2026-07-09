{ stdenv ... }:
{
	stdenv.hostPlatform.system.autoUpgrade = {
		# Source: https://wiki.nixos.org/wiki/Automatic_system_upgrades
		enable = true;
		flake = inputs.self.outPath;
		flags = [
			"--print-build-logs"
			"--commit-lock-file"	# Automatically commit flake.lock
		];
		dates = "20:00";
		randomizedDelaySec = "45min";
	};
}

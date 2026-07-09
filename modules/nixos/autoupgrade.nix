{ stdenv, inputs, ... }:
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

	#systemd.services.nixos-upgrade.environment = {
	#	GIT_AUTHOR_NAME = "NixOS Auto-upgrade";
	#	GIT_AUTHOR_EMAIL = "root@&lt;your-hostname&gt;";
	#	GIT_COMMITTER_NAME = "NixOS Auto-upgrade";
	#	GIT_COMMITTER_EMAIL = "root@&lt;your-hostname&gt;";
	#};
}

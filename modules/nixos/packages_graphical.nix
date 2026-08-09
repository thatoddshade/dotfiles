{pkgs, ...}:
{
	programs.firefox = {
		enable = true;
		package = pkgs.unstable.firefox-bin;
		languagePacks = [ "fr" "en-GB" "en-US" ];
	};

	programs.thunderbird = {
		enable = true;
		package = pkgs.unstable.thunderbird-bin;
	};

	environment.systemPackages = with pkgs; [
		alacritty
		cpu-x
		genact
		pkgs.unstable.transmission_4
		#godot_4

		# Creativity
		audacity
		blockbench
		gimp
		kdePackages.kdenlive
		
		
		# Media
		imv
		mpv
	];
}

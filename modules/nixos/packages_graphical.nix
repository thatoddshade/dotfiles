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
		audacity
		blockbench
		cpu-x
		#eww
		genact
		gimp
		#godot_4
		kdePackages.kdenlive
		pkgs.unstable.transmission_4
		
	];
}

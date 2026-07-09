{pkgs, ...}:
{
	programs.firefox = {
		enable = true;
		package = pkgs.unstable.firefox-bin;
		languagePacks = [ "fr" "en-GB" "en-US" "en" ];
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
		blockbench
		#eww
		genact
		gimp
		#godot_4
		kdePackages.kdenlive
		transmission
		
	];
}

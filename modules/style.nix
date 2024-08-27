{pkgs, outputs, ...}:
{
	stylix = {
		enable = true;
	
		image = outputs.wallpaper;
	#	#base16Scheme = "${pkgs.base16.schemes}/share/themes/kanagawa.yaml";
	
		cursor.package = pkgs.bibata-cursors;
		cursor.name = "Bibata-Modern-Classic";
	
		fonts = {
			monospace = {
				package = pkgs.fira-code;
				name = "FiraCode";
			};

			sansSerif = {
				package = pkgs.jost;
				name = "Jost* Book";
	
			};
			
			serif = {
				package = pkgs.garamond-libre;
				name = "Garamond Libre";
			};
		};

		polarity = "dark";
	};
}

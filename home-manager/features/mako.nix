{ pkgs, config, ... }:

#{
#	services.mako = with config.colorScheme.palette; {
#		enable = true;
#		backgroundColor = "#${base01}";
#		borderColor = "#${base0B}";
#		borderRadius = 5;
#		borderSize = 2;
#		textColor = "#${base04}";
#		layer = "overlay";
#	};
#}
{
	services.mako = {
		enable = true;
		borderRadius = 5;
		borderSize = 2;
		layer = "overlay";
	};
}

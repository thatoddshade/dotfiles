{ ... }:

{
	services.minecraft-server = {
		enable = true;
		eula = true;
		openFirewall = true; # Opens the port the server is running on (by default 25565 but in this case 43000)
		declarative = true;
		#whitelist = {
		#	# This is a mapping of Minecraft usernames to to the players' UUIDs
		#	username1 = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx";
		#	username2 = "yyyyyyyy-yyyy-yyyy-yyyy-yyyyyyyyyyyy";
		#};
		serverProperties = {
			server-port = 43000;
			difficulty = 3;	# Peaceful: 0  Easy: 1  Normal: 2  Hard: 3
			gamemode = 1;	# Survival: 0  Creative: 1  2: Adventure  3: Spectator
			max-players = 9000000000;	# 9 000 000 000—9 billion, the current population on Earth.
			motd = "\u00a7k\ud83d\udf53\u00a7r\u273f\ud83d\udf6a \u00a7ahe\u00a72y\u00a79 hi \u00a75hiya \u00a74h\u00a7cel\u00a76low!!! \u00a7e(\u25cd\u02c3\u0336\u15dc\u02c2\u0336\u25cd)\uff89\u201d \u00a7r\ud83d\udf6a\u273f\u00a7k\ud83d\udf53\u00a7r\n";
			#white-list = true;
			allow-cheats = true;
			accept-transfers = true;
			allow-flight = true;
			chat-spam-threshold-seconds = 0;	# No kicking for spamming in the chat.
			enforce-secure-profile = false;
			online-mode = false;	# Assume there is no Internet connection, allow cracked players.
		};
		jvmOpts = "-Xms2048M -Xmx2048M"; 
	};

}

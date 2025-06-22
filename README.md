# KIT25 PUBLIC RELEASE

## DEVELOPED BY MIHOPB2, MIZMII, V_SUZUKI, ADORE_RAMEN, ZUKO, AND OTHER CONTRIBUTORS FROM THE DARK HORIZON SERVER
(thank you to all contributors btw <3)

░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░▒▓████████▓▒░▒▓███████▓▒░░▒▓████████▓▒░ 
░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░  ░▒▓█▓▒░          ░▒▓█▓▒░▒▓█▓▒░        
░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░  ░▒▓█▓▒░          ░▒▓█▓▒░▒▓█▓▒░        
░▒▓███████▓▒░░▒▓█▓▒░  ░▒▓█▓▒░    ░▒▓██████▓▒░░▒▓███████▓▒░  
░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░  ░▒▓█▓▒░   ░▒▓█▓▒░             ░▒▓█▓▒░ 
░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░  ░▒▓█▓▒░   ░▒▓█▓▒░             ░▒▓█▓▒░ 
░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░  ░▒▓█▓▒░   ░▒▓████████▓▒░▒▓███████▓▒░    

You can contact mizmii_. on the Dark Horizon or ACS server if you need help.

# INFO

What this engine includes:
	- Pretty much all of the gunplay and netcode of Dark Horizon's Kitsune version
	- Extract system
	- Temperature system
	
What this engine does NOT include:
	- Sounds of guns
	- Maps
	- Menu
	- ProfileService netcode
	- Quest system
	- Inventory system



# SETUP
	
All files are completely set up for you, HOWEVER, you wont be able to hear any audio.
	
This is because ROBLOX has limited sound ids, and contrary to the last release of Kitsune, those
limits now apply because its no longer outdated.
	
All of the sounds are uploaded under the DH group, but this is bad for you because you can't hear them!!
	
	
	
# HOW 2 FIX SOUNDS:
	
Download both gun sound packs from the Kitsune dev asset pack. You can find this in the Dark Horizon,
Imperium Interactive, ACS, and Asset Central servers.
	
All of the sounds (yes, ALL of them) need to be re-imported. Your best bet is to either just start with 1 gun
only and build others later, or use the Asset Manager to mass import a bunch of sounds (LIMIT OF 100 A MONTH)
	
Ambience, grenade, etc. sounds also need to be re-imported. These are less important, cause you can just
use toolbox sounds.
	
Anyway. Sorry about that, ROBLOX is stupid.
	
	
	
# HOW 2 FIX FOOD:
	
You may have noticed that food doesn't actually replenish energy or thirst. This is an issue in DH I forgot
to fix a while ago, and I don't want to fix it here.
	
It's simple, though. Just go into the animation files and make it so an event is fired when you eat food
that restores the player's energy/thirst.
	
	
# HOW 2 STOP DROPPING GUNS ON DEATH:
	
Find the server gun model. Add "KeepOnDeath" boolean and set to true. Literally, that's it.

If you want to know how this engine works in-game, just go play Dark Horizon (if we didn't change engines)

Kitsune_Client: Line 7571

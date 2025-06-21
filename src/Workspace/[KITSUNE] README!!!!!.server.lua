-- KIT25 PUBLIC RELEASE

-- DEVELOPED BY MIHOPB2, MIZMII, V_SUZUKI, ADORE_RAMEN, ZUKO, AND OTHER CONTRIBUTORS FROM THE DARK HORIZON SERVER
-- (thank you to all contributors btw <3)

--[[


░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░▒▓████████▓▒░▒▓███████▓▒░░▒▓████████▓▒░ 
░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░  ░▒▓█▓▒░          ░▒▓█▓▒░▒▓█▓▒░        
░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░  ░▒▓█▓▒░          ░▒▓█▓▒░▒▓█▓▒░        
░▒▓███████▓▒░░▒▓█▓▒░  ░▒▓█▓▒░    ░▒▓██████▓▒░░▒▓███████▓▒░  
░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░  ░▒▓█▓▒░   ░▒▓█▓▒░             ░▒▓█▓▒░ 
░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░  ░▒▓█▓▒░   ░▒▓█▓▒░             ░▒▓█▓▒░ 
░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░  ░▒▓█▓▒░   ░▒▓████████▓▒░▒▓███████▓▒░    


]]

-- INCLUDES:

	-- MUCH BETTER RECOIL
	-- A FULL LIMB HEALTH SYSTEM WITH EFFECTS AND UI
	-- REMADE HUD WITH SUPPORT FOR ARM AND LEG STAMINA
	-- VOICELINES, FACTIONS, ETC.
	-- A FULLY WORKING EXTRACT SYSTEM WITH SUPPORT FOR DATASTORE AND PROFILESERVICE
	-- REWRITES OF ALL NETCODE AND MULTIPLE SYSTEM REVAMPS
	-- NEW ANIMATIONS FOR GUN BUMPING
	-- RAGDOLLS WITH KNEES AND SOUNDS FOR AGONY/DEATH

-- You can contact mizmii_. on the Dark Horizon or ACS server if you need help.

-- by the way, this engine is going to get very infrequent but probably large updates.




--[[


 ░▒▓███████▓▒░▒▓████████▓▒░▒▓████████▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓███████▓▒░  
░▒▓█▓▒░      ░▒▓█▓▒░         ░▒▓█▓▒░   ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░ 
░▒▓█▓▒░      ░▒▓█▓▒░         ░▒▓█▓▒░   ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░ 
 ░▒▓██████▓▒░░▒▓██████▓▒░    ░▒▓█▓▒░   ░▒▓█▓▒░░▒▓█▓▒░▒▓███████▓▒░  
       ░▒▓█▓▒░▒▓█▓▒░         ░▒▓█▓▒░   ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░        
       ░▒▓█▓▒░▒▓█▓▒░         ░▒▓█▓▒░   ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░        
░▒▓███████▓▒░░▒▓████████▓▒░  ░▒▓█▓▒░    ░▒▓██████▓▒░░▒▓█▓▒░        
                                                                   
                                                                   
]]
--[[

	SETUP!!! THIS IS VERY IMPORTANT INFO THAT YOU NEED TO KNOW OR ELSE YOU'LL BE PROBABLY
	REALLY MAD THAT SOUND ISNT WORKING AND CONTACT ME, TO WHICH ILL JUST TELL YOU TO READ THIS ANYWAY!!!!!
	
	All files are completely set up for you, HOWEVER, you wont be able to hear any audio.
	
	This is because ROBLOX has limited sound ids, and contrary to the last release of Kitsune, those
	limits now apply because its no longer outdated.
	
	All of the sounds are uploaded under the DH group, but this is bad for you because you can't hear them!!
	
	
	
	HOW 2 FIX SOUNDS:
	
	Download both gun sound packs from the Kitsune dev asset pack. You can find this in the Dark Horizon,
	Imperium Interactive, ACS, and Asset Central servers.
	
	All of the sounds (yes, ALL of them) need to be re-imported. Your best bet is to either just start with 1 gun
	only and build others later, or use the Asset Manager to mass import a bunch of sounds (LIMIT OF 100 A MONTH)
	
	Ambience, grenade, etc. sounds also need to be re-imported. These are less important, cause you can just
	use toolbox sounds.
	
	Anyway. Sorry about that, ROBLOX is stupid.
	
	
	
	HOW 2 FIX FOOD:
	
	You may have noticed that food doesn't actually replenish energy or thirst. This is an issue in DH I forgot
	to fix a while ago, and I don't want to fix it here.
	
	It's simple, though. Just go into the animation files and make it so an event is fired when you eat food
	that restores the player's energy/thirst.
	
	
	HOW 2 STOP DROPPING GUNS ON DEATH:
	
	Find the server gun model. Add "KeepOnDeath" boolean and set to true. Literally, that's it.
]]



--[[                                                      
                                                            
  iiii                      ffffffffffffffff                
 i::::i                    f::::::::::::::::f               
  iiii                    f::::::::::::::::::f              
                          f::::::fffffff:::::f              
iiiiiiinnnn  nnnnnnnn     f:::::f       ffffffooooooooooo   
i:::::in:::nn::::::::nn   f:::::f           oo:::::::::::oo 
 i::::in::::::::::::::nn f:::::::ffffff    o:::::::::::::::o
 i::::inn:::::::::::::::nf::::::::::::f    o:::::ooooo:::::o
 i::::i  n:::::nnnn:::::nf::::::::::::f    o::::o     o::::o
 i::::i  n::::n    n::::nf:::::::ffffff    o::::o     o::::o
 i::::i  n::::n    n::::n f:::::f          o::::o     o::::o
 i::::i  n::::n    n::::n f:::::f          o::::o     o::::o
i::::::i n::::n    n::::nf:::::::f         o:::::ooooo:::::o
i::::::i n::::n    n::::nf:::::::f         o:::::::::::::::o
i::::::i n::::n    n::::nf:::::::f          oo:::::::::::oo 
iiiiiiii nnnnnn    nnnnnnfffffffff            ooooooooooo                                                  

]]


--[[

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


	If you want to know how this engine works in-game, just go play Dark Horizon (if we didn't change engines).
]]




-- Hope you enjoy the engine, etc etc
-- Fun fact: did you know that Kitsune was originally called "KITE" when made public?


-- Kitsune_Client: Line 7571
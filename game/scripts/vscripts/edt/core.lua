-- This is the primary core.
-- It is be used to assist in initializing the game mode.



-- Set this to true if you wants to see a complete debug output of all events/processes done by EDT.
-- You can also change the cvar 'edt_debugPrint' at any time to 1 or 0 for output/no output.
EDT_DEBUG_PRINT = true

if(EDT_Core == nil) then
	DebugPrint('[EDT Core] Creating core game object ...')
	
	_G.EDT_Core = class({})
	EDT_Core.__index = EDT_Core
	
	DebugPrint('[EDT Core] ... done')
end



-- Include all general needed libraries
require('edt/libs/timer')		-- Library for easily delayed/timed actions

-- These internal libraries set up EDT events and processes.
-- Feel free to inspect them/change them if you need to.
require('edt/core/gamemode')
require('edt/core/events')
require('edt/core/player')

-- settings.lua is where you can specify many different properties for your game mode
-- and is one of the core EDT files.
require('edt/settings')
-- events.lua is where you can specify the actions to be taken when any event occurs
-- and is one of the core EDT files.
require('edt/events')



--[[
	This function should be used to set up Async precache calls at the beginning of the gameplay.
	
	
	In this function, place all of your PrecacheItemByNameAsync and PrecacheUnitByNameAsync.
	These calls will be made after all players have loaded in, but before they have selected their heroes.
	PrecacheItemByNameAsync can also be used to precache dynamically-added datadriven abilitiesinstead of items.
	PrecacheUnitByNameAsync will precache the precache{} block statement of the unit
	and all precache{} block statements for every Ability# defined on the unit.
	
	This function should only be called once.
	If you want to/need to precache more items/abilities/units at a later time,
	you can call the functions individually
	(for example if you want to precache units in a new wave of holdout).
	
	This function should generally only be used if the Precache() function in addon_game_mode.lua is not working.
]]--
function EDT_Core:PostLoadPrecache()
	DebugPrint('[EDT Core] Performing Post-Load precache...')
	--PrecacheItemByNameAsync("item_example_item", function(...) end)
	--PrecacheItemByNameAsync("example_ability", function(...) end)
	
	--PrecacheUnitByNameAsync("npc_dota_hero_viper", function(...) end)
	--PrecacheUnitByNameAsync("npc_dota_hero_enigma", function(...) end)
end

--[[
	This function is called once and only once as soon as the first player (almost certain to be the server in local lobbies) loads in.
	It can be used to initialize state that isn't initializeable in InitGameMode() but needs to be done before everyone loads in.
]]--
function EDT_Core:OnFirstPlayerLoaded()
	DebugPrint('[EDT Core] First Player has loaded.')
end

--[[
	This function is called once and only once after all players have loaded into the game, right as the hero selection time begins.
	It can be used to initialize non-hero player state or adjust the hero selection (i.e. force random etc)
]]--
function EDT_Core:OnAllPlayersLoaded()
	DebugPrint('[EDT Core] All Players have loaded into the game.')
end

--[[
	This function is called once and only once for every player when they spawn into the game for the first time.
	It is also called if the player's hero is replaced with a new hero for any reason.
	This function is useful for initializing heroes,
	such as adding levels, changing the starting gold, removing/adding abilities, adding physics, etc.
	
	The hero parameter is the hero entity that just spawned in.
]]--
function EDT_Core:OnHeroInGame(hero)
	DebugPrint('[EDT Core] Hero spawned in game for first time -- '..hero:GetUnitName())
	
	-- This line for example will set the starting gold of every hero to 500 unreliable gold
	hero:SetGold(500, false)
	
	-- These lines will create an item and add it to the player, effectively ensuring they start with the item
	local item = CreateItem("item_example_item", hero, hero)
	hero:AddItem(item)
	
	--[[
		--These lines if uncommented will replace the W ability of any hero that loads into the game
		--with the "example_ability" ability
		
		local abil = hero:GetAbilityByIndex(1)
		hero:RemoveAbility(abil:GetAbilityName())
		hero:AddAbility("example_ability")
	]]--
end

--[[
	This function is called once and only once when the game completely begins (about 0:00 on the clock).
	At this point, gold will begin to go up in ticks if configured, creeps will spawn, towers will become damageable etc.
	This function is useful for starting any game logic timers/thinkers, beginning the first round, etc.
]]--
function EDT_Core:OnGameInProgress()
	DebugPrint('[EDT Core] The game has officially begun.')
	
	-- Start this timer 30 game-time seconds later
	Timer:CreateTimer(30, function()
		DebugPrint('[EDT Core] This function is called 30 seconds after the game begins, and every 30 seconds thereafter.')
		
		-- Rerun this timer every 30 game-time seconds.
		return 30.0
	end)
end



-- This function initializes the game mode and is called before anyone loads into the game.
-- It can be used to pre-initialize any values/tables that will be needed later.
function EDT_Core:InitGameMode()
	DebugPrint('[EDT Core] Initializing EDT core...')
	
	GameMode = self
	
	-- Call the internal function to set up the rules/behaviors specified in settings.lua
	-- This also sets up event hooks for all event handlers in events.lua
	-- Check out core/gamemode to see/modify the exact code
	GameMode:_InitGameMode()
	
	-- Commands can be registered for debugging purposes or as functions that can be called
	-- by the custom Scaleform UI.
	Convars:RegisterCommand('command_example', Dynamic_Wrap(EDT_Core, 'ExampleConsoleCommand'), 'A console command', FCVAR_CHEAT)
	
	DebugPrint('[EDT Core] EDT core successfully initialized.\n\n')
end



-- This is an example console command
function EDT_Core:ExampleConsoleCommand()
	print('******* Example Console Command ***************')
	
	local cmdPlayer = Convars:GetCommandClient()
	if(cmdPlayer) then
		local playerID = cmdPlayer:GetPlayerID()
		if(playerID ~= nil and playerID ~= -1) then
			-- Do something here for the player who called this command
			PlayerResource:ReplaceHeroWith(playerID, "npc_dota_hero_tinker", 0, 0)
		end
	end
	
	print('*********************************************')
end
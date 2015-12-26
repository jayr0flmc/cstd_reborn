-- This function initializes the game mode and is called before anyone loads into the game.
-- It can be used to pre-initialize any values/tables that will be needed later.
function EDT_Core:_InitGameMode()
	Debug('Core', 'Loading game mode ...')
	
	-- Bring in all needed classes
	EDT_Timer = EDT_Timer.new()
	EDT_Wave = EDT_Wave.new()
	
	-- Setup rules
	GameRules:SetHeroRespawnEnabled(ENABLE_HERO_RESPAWN)
	GameRules:SetUseUniversalShopMode(UNIVERSAL_SHOP_MODE)
	GameRules:SetSameHeroSelectionEnabled(ALLOW_SAME_HERO_SELECTION)
	
	GameRules:SetHeroSelectionTime(HERO_SELECTION_TIME)
	GameRules:SetPreGameTime(PRE_GAME_TIME)
	GameRules:SetPostGameTime(POST_GAME_TIME)
	GameRules:SetTreeRegrowTime(TREE_REGROW_TIME)
	
	GameRules:SetGoldPerTick(GOLD_PER_TICK)
	GameRules:SetGoldTickTime(GOLD_TICK_TIME)
	
	GameRules:SetHeroMinimapIconScale(MINIMAP_ICON_SIZE)
	GameRules:SetCreepMinimapIconScale(MINIMAP_CREEP_ICON_SIZE)
	GameRules:SetRuneMinimapIconScale(MINIMAP_RUNE_ICON_SIZE)
	
	GameRules:SetRuneSpawnTime(RUNE_SPAWN_TIME)
	
	GameRules:SetFirstBloodActive(ENABLE_FIRST_BLOOD)
	GameRules:SetHideKillMessageHeaders(HIDE_KILL_BANNERS)
	
	-- Fog of War
	GameRules:GetGameModeEntity():SetFogOfWarDisabled(true)
	
	
	
	-- This is multiteam configuration stuff
	if(USE_AITMATIC_PLAYERS_PER_TEAM) then
		local num = math.floor(10 / MAX_NUMBER_OF_TEAMS)
		local count = 0
		
		for team, number in pairs(TEAM_COLORS) do
			if(count >= MAX_NUMBER_OF_TEAMS) then
				GameRules:SetCustomGameTeamMaxPlayers(team, 0)
			else
				GameRules:SetCustomGameTeamMaxPlayers(team, num)
			end
			
			count = count + 1
		end
	else
		local count = 0
		
		for team, number in pairs(CUSTOM_TEAM_PLAYER_COUNT) do
			if(count >= MAX_NUMBER_OF_TEAMS) then
				GameRules:SetCustomGameTeamMaxPlayers(team, 0)
			else
				GameRules:SetCustomGameTeamMaxPlayers(team, number)
			end
			
			count = count + 1
		end
	end
	
	if(USE_CUSTOM_TEAM_COLORS) then
		for team, color in pairs(TEAM_COLORS) do
			SetTeamCustomHealthbarColor(team, color[1], color[2], color[3])
		end
	end
	Debug('Core', 'GameRules set.')
	
	
	
	-- Event hooks
	-- All of these events can potentially be fired by the game, though only the uncommented ones have had
	-- functions supplied for them.
	-- If you are interested in the other events, you can uncomment the ListenToGameEvent line
	-- and add function to handle the event.
	--ListenToGameEvent('', Dynamic_Wrap(EDT_Core, ''), self)
	
	-- Core team events
	--ListenToGameEvent('team_info', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('team_score', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('team_broadcast_audio', Dynamic_Wrap(EDT_Core, ''), self)
	
	-- Player events
	--[[
	ListenToGameEvent('player_chat', Dynamic_Wrap(EDT_Core, 'OnPlayerChat'), self)
	ListenToGameEvent('player_connect', Dynamic_Wrap(EDT_Core, 'OnPlayerConnect'), self)
	ListenToGameEvent('player_connect_full', Dynamic_Wrap(EDT_Core, 'OnPlayerConnectFull'), self)
	ListenToGameEvent('player_disconnect', Dynamic_Wrap(EDT_Core, 'OnPlayerDisconnect'), self)
	ListenToGameEvent('player_reconnected', Dynamic_Wrap(EDT_Core, 'OnPlayerReconnected'), self)
	ListenToGameEvent('player_changename', Dynamic_Wrap(EDT_Core, 'OnPlayerChangeName'), self)
	]]--
	
	-- Game events
	--[[
	ListenToGameEvent('game_init', Dynamic_Wrap(EDT_Core, 'OnGameInit'), self)
	ListenToGameEvent('npc_spawned', Dynamic_Wrap(EDT_Core, 'OnNPCSpawned'), self)
	]]--
	
	-- Economy events
	--ListenToGameEvent('inventory_updated', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('cart_updated', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('store_pricesheet_updated', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('gc_connected', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('item_schema_initialized', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('drop_rate_modified', Dynamic_Wrap(EDT_Core, ''), self)
	--ListenToGameEvent('event_ticket_modified', Dynamic_Wrap(EDT_Core, ''), self)
	
	-- ModEvents
	--ListenToGameEvent('game_rules_state_change', Dynamic_Wrap(EDT_Core, 'OnGameRulesStateChange'), self)
	
	
	
	--[[
	-- This block is only used for testing events handling in the event that valve adds more in the future
	Convars:RegisterCommand('events_test', function()
		GameMode:StartEventTest()
	end, 'events test', 0)
	]]--
	
	
	
	-- Change random seed
	
	-- Initialize tables for tracking state
	self.bSeenWaitForPlayers = false
	self.vUserIDs = {}
	
	Debug('Core', '... done')
end
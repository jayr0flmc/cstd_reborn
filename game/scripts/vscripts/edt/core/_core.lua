-- This function initializes the game mode and is called before anyone loads into the game.
-- It can be used to pre-initialize any values/tables that will be needed later.
function EDT:_InitGameMode()
	self:Debug('Core', 'Loading game mode ...')
	
	-- Setup rules
	GameRules:EnableCustomGameSetupAutoLaunch(CUSTOM_GAME_SETUP_AUTO_LAUNCH_ENABLED)
	GameRules:LockCustomGameSetupTeamAssignment(CUSTOM_GAME_SETUP_TEAM_ASSIGNMENT_LOCK)
	GameRules:SetCustomGameSetupAutoLaunchDelay(CUSTOM_GAME_SETUP_AUTO_LAUNCH_DELAY)
	GameRules:SetCustomGameSetupRemainingTime(CUSTOM_GAME_SETUP_REMAINING_TIME)
	GameRules:SetCustomGameSetupTimeout(CUSTOM_GAME_SETUP_TIMEOUT)
	GameRules:SetCreepMinimapIconScale(MINIMAP_ICON_SIZE_CREEP)
	GameRules:SetCustomGameDifficulty(CUSTOM_GAME_DIFFICULTY)
	GameRules:SetCustomGameEndDelay(CUSTOM_GAME_END_DELAY)
	GameRules:SetCustomVictoryMessage(CUSTOM_VICTORY_MESSAGE)
	GameRules:SetCustomVictoryMessageDuration(CUSTOM_VICTORY_MESSAGE_DURATION)
	GameRules:SetFirstBloodActive(ENABLE_FIRST_BLOOD)
	GameRules:SetGoldPerTick(GOLD_PER_TICK)
	GameRules:SetGoldTickTime(GOLD_TICK_TIME)
	GameRules:SetHeroMinimapIconScale(MINIMAP_ICON_SIZE_HERO)
	GameRules:SetHeroRespawnEnabled(ENABLE_HERO_RESPAWN)
	GameRules:SetHeroSelectionTime(TIME_HERO_SELECTION)
	GameRules:SetHideKillMessageHeaders(HIDE_KILL_BANNERS)
	GameRules:SetPostGameTime(TIME_POST_GAME)
	GameRules:SetPreGameTime(TIME_PRE_GAME)
	GameRules:SetRuneMinimapIconScale(MINIMAP_ICON_SIZE_RUNE)
	GameRules:SetRuneSpawnTime(TIME_RUNE_SPAWN)
	GameRules:SetSameHeroSelectionEnabled(ENABLE_SAME_HERO_SELECTION)
	GameRules:SetStartingGold(GOLD_STARTING)
	GameRules:SetTreeRegrowTime(TIME_TREE_REGROW)
	GameRules:SetUseBaseGoldBountyOnHeroes(USE_BASE_GOLD_BOUNTY_ON_HEROES)
	GameRules:SetUseCustomHeroXPValues(CUSTOM_HERO_XP_VALUES)
	GameRules:SetUseUniversalShopMode(UNIVERSAL_SHOP_MODE)
	
	-- Fog of War
	
	
	
	-- This is multiteam configuration stuff
	--[[
	if(USE_AUTOMATIC_PLAYERS_PER_TEAM) then
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
	]]--
	self:Debug('Core', 'GameRules set.')
	
	
	
	-- Event Hooks
	-- All of these events can potentially be fired by the game, though only the uncommented ones have had
	-- functions supplied for them.
	-- If you are interested in the other events, you can uncomment the ListenToGameEvent line
	-- and add function to handle the event.
	--ListenToGameEvent('', Dynamic_Wrap(EDT, ''), self)
	
	-- Core team events
	
	-- Player events
	
	-- Game events
	
	-- Economy events
	
	-- ModEvents
	ListenToGameEvent('game_rules_state_change', Dynamic_Wrap(EDT, 'OnGameRulesStateChange'), self)
	
	
	
	-- Change random seed
	local timeText = string.gsub(string.gsub(GetSystemTime(), ':', ''), '0', '')
	math.randomseed(tonumber(timeText))
	
	self:Debug('Core', 'Done loading game mode.')
end

-- This function icalled as the first player loads and sets up the GameMode parameters
function EDT:_CaptureGameMode()
	local mode = nil
	
	if(self._GameMode == nil) then
		-- Set GameMode parameters
		mode = GameRules:GetGameModeEntity()
	end
end
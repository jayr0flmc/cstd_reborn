-- The overall game state has changed
function EDT_Core:_OnGameRulesStateChange(keys)
	local newState = GameRules:State_Get()
	
	if(newState == DOTA_GAMERULES_STATE_WAIT_FOR_PLAYERS_TO_LOAD) then
		self.bSeenWaitForPlayers = true
	elseif(newState == DOTA_GAMERULES_STATE_INIT) then
		
	elseif(newState == DOTA_GAMERULES_STATE_HERO_SELECTION) then
		EDT_Core:PostLoadPrecache()
		EDT_Core:OnAllPlayersLoaded()
		
		if(USE_CUSTOM_TEAM_COLORS_FOR_PLAYERS) then
			for i = 0, 9 do
				if(PlayerResource:IsValidPlayer(i)) then
					local color = TEAM_COLORS[PlayerResource:GetTeam(i)]
					PlayerResource:SetCustomPlayerColor(i, color[1], color[2], color[3])
				end
			end
		end
	elseif(newState == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS) then
		EDT_Core:OnGameInProgress()
	end
end



-- This function is called 1 to 2 times as the player connects initially but before they have completely connected.
function EDT_Core:_OnPlayerConnect(keys)
end

-- This function is called once when the player fully connects and becomes "Ready" during loading.
function EDT_Core:_OnConnectFull(keys)
	--EDT_Core:_CaptureGameMode()
	
	local entIdx = keys.index + 1
	-- The player entity of the joining user
	local player = EntIndexToHScript(entIdx)
	local userID = keys.userid
	
	self.vUserIDs = self.vUserIDs or {}
	self.vUserIDs[userID] = player
end

-- Cleanup a player when they leave
function EDT_Core:_OnPlayerDisconnect(keys)
end

-- A player has reconnected to the game.
-- This function can be used to repaint player-based particles or change state as necessary
function EDT_Core:_OnPlayerReconnected(keys)
end

-- A player changed their name
function EDT_Core:_OnPlayerChangeName(keys)
end



-- An NPC has spawned somewhere in game.
-- This includes heroes.
function EDT_Core:_OnNPCSpawned(keys)
	local npc = EntIndexToHScript(keys.entindex)
	
	if(npc:IsRealHero() and npc.bFirstSpawned == nil) then
		npc.bFirstSpawned = true
		
		EDT_Core:OnHeroInGame(npc)
	end
end
-- This file contains all EDT-registered events and has already set up the passed-in parameters for your use.
-- Do not remove the EDT_Core:_Function calls in these events as it will mess with the internal EDT core.

-- The overall game state has changed
function EDT_Core:OnGameRulesStateChange(keys)
	DebugPrint('[EDT Core] GameRules state changed')
	DebugPrintTable(keys)
	
	-- This internal handling is used to set up main EDT functions
	EDT_Core:_OnGameRulesStateChange(keys)
	
	local newState = GameRules:State_Get()
	
	if(newState == DOTA_GAMERULES_STATE_HERO_SELECTION) then
		-- Create a tinker-builder for every player
		for i = 0, 8 do
			local player = PlayerResource:GetPlayer(i)
			local hero = CreateHeroForPlayer('npc_dota_hero_tinker', player)
			local point = Entities:FindByName(nil, string.format('p%s_spawner', tostring(i))):GetOrigin()
			
			hero:SetOrigin(point)
		end
		
		
		
		--[[
		-- Create tinker for players
		local hero = CreateHeroForPlayer('npc_dota_hero_tinker', player)
		local point = Entities:FindByName(nil, 'p1_spawner'):GetOrigin()
		hero:SetOrigin(point)
		hero:SetControllableByPlayer(playerID, true)
		hero:SetPlayerID(playerID)
		]]--
	end
end



-- This function is called 1 to 2 times as the player connects initially but before they have completely connected.
function EDT_Core:OnPlayerConnect(keys)
	DebugPrint('[EDT Core] OnPlayerConnect')
	DebugPrintTable(keys)
	
	-- This internal handling is used to set up main EDT functions
	EDT_Core:_OnPlayerConnect(keys)
end

-- This function is called once when the player fully connects and becomes "Ready" during loading.
function EDT_Core:OnPlayerConnectFull(keys)
	DebugPrint('[EDT Core] OnPlayerConnectFull')
	DebugPrintTable(keys)
	
	-- This internal handling is used to set up main EDT functions
	EDT_Core:_OnConnectFull(keys)
	
	local entIdx = keys.index + 1
	-- The player entity of the joining user
	local player = EntIndexToHScript(entIdx)
	
	-- The playerID of the joining player
	local playerID = player:GetPlayerID()
end

-- Cleanup a player when they leave
function EDT_Core:OnPlayerDisconnect(keys)
	DebugPrint('[EDT Core] Player disconnected: '..tostring(keys.userid))
	DebugPrintTable(keys)
	
	-- This internal handling is used to set up main EDT functions
	EDT_Core:_OnPlayerDisconnect(keys)
	
	local name = keys.name
	local networkID = keys.networkid
	local reason = keys.reason
	local userID = keys.userid
end

-- A player has reconnected to the game.
-- This function can be used to repaint player-based particles or change state as necessary
function EDT_Core:OnPlayerReconnected(keys)
	DebugPrint('[EDT Core] OnPlayerReconnected')
	DebugPrintTable(keys)
	
	-- This internal handling is used to set up main EDT functions
	EDT_Core:_OnPlayerReconnected(keys)
end

-- A player changed their name
function EDT_Core:OnPlayerChangeName(keys)
	DebugPrint('[EDT Core] OnPlayerChangedName')
	DebugPrintTable(keys)
	
	-- This internal handling is used to set up main EDT functions
	EDT_Core:_OnPlayerChangeName(keys)
	
	local newName = keys.newname
	local oldName = keys.oldName
end



-- An NPC has spawned somewhere in game.
-- This includes heroes.
function EDT_Core:OnNPCSpawned(keys)
	DebugPrint('[EDT Core] NPC spawned')
	DebugPrintTable(keys)
	
	-- This internal handling is used to set up main EDT functions
	EDT_Core:_OnNPCSpawned(keys)
	
	local npc = EntIndexToHScript(keys.entindex)
end
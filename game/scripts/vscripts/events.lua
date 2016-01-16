-- This file contains all EDT-registered events and has already set up the passed-in parameters for your use.
-- Do not remove the EDT:_Function calls in these events as it will mess with the internal EDT core.

-- The overall game state has changed
function EDT:OnGameRulesStateChange(keys)
	self:Debug('Core', 'GameRules state changed.')
	self:DebugTable(keys)
	
	-- This internal handling is used to set up main EDT functions
	self:_OnGameRulesStateChangedkeys)
	
	local newState = GameRules:State_Get()
	if(newState == DOTA_GAMERULES_STATE_INIT) then
		
	elseif(newState == DOTA_GAMERULES_STATE_WAIT_FOR_PLAYERS_TO_LOAD) then
		
	elseif(newState == DOTA_GAMERULES_STATE_CUSTOM_GAME_SETUP) then
		
	elseif(newState == DOTA_GAMERULES_STATE_HERO_SELECTION) then
		
	elseif(newState == DOTA_GAMERULES_STATE_STRATEGY_TIME) then
		
	elseif(newState == DOTA_GAMERULES_STATE_TEAM_SHOWCASE) then
		
	elseif(newState == DOTA_GAMERULES_STATE_PRE_GAME) then
		
	elseif(newState == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS) then
		
	elseif(newState == DOTA_GAMERULES_STATE_POST_GAME) then
		
	elseif(newState == DOTA_GAMERULES_STATE_DISCONNECT) then
		
	end
end



function EDT:OnAllPlayersLoaded()
end

function EDT:OnGameInProgress()
end
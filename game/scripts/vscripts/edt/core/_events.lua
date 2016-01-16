-- The overall game state has changed
function EDT:_OnGameRulesStateChange(keys)
	local newState = GameRules:State_Get()
	if(newState == DOTA_GAMERULES_STATE_INIT) then
		
	elseif(newState == DOTA_GAMERULES_STATE_WAIT_FOR_PLAYERS_TO_LOAD) then
		self.bSeenWaitForPlayers = true
	elseif(newState == DOTA_GAMERULES_STATE_CUSTOM_GAME_SETUP) then
		
	elseif(newState == DOTA_GAMERULES_STATE_HERO_SELECTION) then
		self:PostLoadPrecache()
		self:OnAllPlayersLoaded()
	elseif(newState == DOTA_GAMERULES_STATE_STRATEGY_TIME) then
		
	elseif(newState == DOTA_GAMERULES_STATE_TEAM_SHOWCASE) then
		
	elseif(newState == DOTA_GAMERULES_STATE_PRE_GAME) then
		
	elseif(newState == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS) then
		self:OnGameInProgress()
	elseif(newState == DOTA_GAMERULES_STATE_POST_GAME) then
		
	elseif(newState == DOTA_GAMERULES_STATE_DISCONNECT) then
		
	end
end
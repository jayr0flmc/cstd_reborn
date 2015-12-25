-- Includes



-- Constants
GAME_STATE = {
	PREPARATION	= 0,
	FIGHTING	= 1,
	END			= 2
}
STARTING_ROUND	= 1
CHECK_INTERVAL	= 1



-- Variables



-- Create object.
if GameHandler == nil then
	_G.GameHandler = class({})
	GameHandler.__index = GameHandler
end

-- Constructor
function GameHandler:New()
	local self = GameHandler()
	GameHandler = self
	
	
	
	self.players		= {}
	self.sendRadiant	= {}
	self.sendDire		= {}
	
	Convars:RegisterCommand('start_next_round', Dynamic_Wrap(self, 'CMD_StartNextRound'), '', 0)
	Convars:RegisterCommand('start_prev_round', Dynamic_Wrap(self, 'CMD_StartPrevRound'), '', 0)
	Convars:RegisterCommand('restart_round', Dynamic_Wrap(self, 'CMD_RestartRound'), '', 0)
	Convars:RegisterCommand('reset', Dynamic_Wrap(self, 'CMD_Reset'), '', 0)
	
	return self
end

-- 
function GameHandler:Initialize()
	print('[EDT]: GameHandler:Initialize()')
	
	Timer:CreateTimer(0, function()
		local time		= GameRules:GetGameTime()
		local minutes	= math.floor(time / 60)
		local seconds	= math.floor(time % 60)
		local strMin	= ''
		local strSec	= ''
		if(minutes >= 10) then strMin = minutes else strMin = '0'..minutes end
		if(seconds >= 10) then strSec = seconds else strSec = '0'..seconds end
		
		data = {
			tMinute = strMin,
			tSecond = strSec
		}
		CustomGameEventManager:Send_ServerToAllClients('update_time', data)
		
		return 1
	end)
	
	self.woodCheckingTimer = Timer:CreateTimer(0, function()
		for _, player in pairs(self.players) do
			--player:CreateWoodTicker()
		end
		
		return CHECK_INTERVAL
	end)
end

function GameHandler:ReadConfiguration()
	local kv = LoadKeyValues('scripts/maps/'..GetMapName()..'.cfg')
	
	if(not kv) then
		print('[EDT]: Can\'t load map-config file!')
		
		return
	end
	
	self.timeBetweenRounds = kv.PrepTimeBetweenRounds
	self:ReadLanes(kv["Lane"])
	
	print('[EDT]: Config successfully loaded.')
end

function GameHandler:ReadLanes(kvSpawns)
	self.lanes = {}
	if(type(kvSpawns) ~= "table") then return end
	for idx, sp in pairs(kvSpawns) do
		local spawner	= Entities:FindByName(nil, sp.Spawner)
		local waypoint	= Entities:FindByName(nil, sp.Waypoint)
		
		if(spawner and waypoint) then
			print("[EDT]: Lane "..idx.." found.")
			
			self.lanes[idx] = {
				spawner		= spawner,
				waypoint	= waypoint
			}
		end
	end
end



-- CommandHandlers
function GameHandler:CMD_StartNextRound()
end

function GameHandler:CMD_StartPrevRound()
end

function GameHandler:CMD_RestartRound()
end

function GameHandler:CMD_Reset()
	GameHandler.gameRound = 1
	
end



function GameHandler:Start()
	print('[EDT]: GameHandler:Start()')
	
	self.gameState	= GAME_STATE.PREPARATION
	self.gameRound	= STARTING_ROUND
	self.isRunning	= true
	
	Timer:CreateTimer(0, function()
		for _, player in pairs(self.players) do
			player:RefreshPlayerInfo()
		end
	end)
	
	self:CreateGameTimer()
	--GameRules:GetGameModeEntity():SetThink('OnThink', self, 'Check', 0)
	self:Initialize()
end

function GameHandler:CreateGameTimer()
	if(not self.gameTimer) then
		self.gameTimer = Timer:CreateTimer(0, function() return self:OnThink() end)
	end
end

function GameHandler:SetWaitTime()
end



function GameHandler:OnThink()
	if(self.gameState == GAME_STATE.PREPARATION) then
		if(not self.nextRoundTime) then
			if(not self.finishedWaves) then
				self:SetWaitTime()
			else
				self:ResetUnitPositions()
				self:StartNextRound()
			end
		elseif(self.nextRoundTime <= GameRules:GetGameTime()) then self:StartNextRound() end
	end
	
	if(self.gameState == GAME_STATE.FIGHTING) then
		self.rounds[self.gameRound]:CheckEnd()
	end
	
	if(self.gameState == GAME_STATE.END) then
		
	end
	
	return 0.25
end
-- Create the class object
if(EDT_Wave == nil) then
	Debug('Wave', 'Creating class object ...')
	
	_G.EDT_Wave = class({})
	EDT_Wave.__index = EDT_Wave
	
	Debug('Wave', '... done')
end

-- Constructor
function EDT_Wave.new()
	local self = setmetatable({}, EDT_Wave)
	
	return self
end



function EDT_Wave:SpawnWave(playerID)
	Debug('Wave', 'Spawning wave #1 for player #'..(playerID + 1)..' ...')
	
	local spawner = Entities:FindByName(nil, string.format('p%s_spawner', (playerID + 1)))
	local initialWP = Entities:FindByName(nil, string.format('p%s_pc1', (playerID + 1)))
	local count = 10
	
	for i = 1, 10 do
		Debug('Wave', 'i: '..tostring(i))
		local creep = CreateUnitByName('npc_dota_courier', spawner:GetAbsOrigin(), true, nil, nil, DOTA_TEAM_BADGUYS)
		
		creep:Stop()
		creep:SetInitialGoalEntity(initialWP)
		
		EDT_Timer:CreateTimer(0.1, function() print('TEST') end)
	end
	
	
	
	--[[
	-- A timer running every second that starts 5 seconds in the future, respects pauses
	EDT_Timer:CreateTimer(5, function()
		print('Hello. I'm running 5 seconds after you called me and then every second thereafter.')
		
		return 1.0
	end)
	
	
	
	EDT_Timer:CreateTimer({
		callback = function()
			count = count - 1
			print('Hello world')
			print('Count: '..count)
		end
	})
	
	
	
	EDT_Timer:CreateTimer(5, function()
		print('Hello. I'm running 5 seconds after you called me and then every second thereafter.')
		
		return 1.0
	end)
	]]--
	
	--[[
	for i = 1, 10 do
		Debug('Wave', 'i: '..tostring(i))
		local creep = CreateUnitByName('npc_dota_courier', spawner:GetAbsOrigin(), true, nil, nil, DOTA_TEAM_BADGUYS)
		
		creep:Stop()
		creep:SetInitialGoalEntity(initialWP)
	end
	]]--
end

function EDT_Wave:SpawnWaves()
	Debug('Wave', 'Spawning waves for round #')
	
	for i = 0, 7 do
		local player = PlayerResource:GetPlayer(i)
		
		if(player) then EDT_Wave:SpawnWave(i) end
	end
end



--[[
-- Create the class object
if(EDT_Core == nil) then
	Debug('Core', 'Creating class object ...')
	
	_G.EDT_Core = class({})
	EDT_Core.__index = EDT_Core
	
	Debug('Core', '... done')
end

-- Constructor
function EDT_Core.new()
	local self = setmetatable({}, EDT_Core)
	
	return self
end
]]--
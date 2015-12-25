-- Includes



-- Constants



-- Variables
ai_standard		= require('ai/ai_core')



-- Create object.
if GameSpawner == nil then
	_G.GameSpawner = class({})
	GameSpawner.__index = GameSpawner
end

-- Constructor
function GameSpawner:New(object)
	local object = object or {}
	
	setmetatable(object, GameSpawner)
	
	return object
end



function GameSpawner:Spawn()
	local spawners = GameHandler.lanes
end
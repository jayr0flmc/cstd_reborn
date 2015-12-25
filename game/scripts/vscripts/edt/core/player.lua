if(EDT_Player == nil) then
	DebugPrint('[EDT Player] Creating player game object ...')
	
	_G.EDT_Player = class({})
	EDT_Player.__index = EDT_Player
	
	DebugPrint('[EDT Player] ... done')
end



function EDT_Player:AutoAssignPlayer(player, index)
	local playerID = player:GetPlayerID()
	
	--[[
	Timer:CreateTimer('assign_player_'..index, {
		endTime = Time(),
		callback = function(EDT_Player, args)
	})
	]]--
end
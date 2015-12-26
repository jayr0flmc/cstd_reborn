build_tower_usp45_scripted = class({})

function build_tower_usp45_scripted:OnSpellStart()
	Debug('BuildTowerUSP45', 'OnSpellStart ...')
	
	local hCaster = self:GetCaster()
	local vPos = self:GetCursorPosition()
	if(hCaster == nil or vPos == nil) then return end
	
	local vPos = GetGridCenterToWorld(vPos)
	
	local blocked = CheckBlocked(vPos)
	
	if(not blocked) then
		PlaceTower('npc_cstd_tower_usp45', vPos, hCaster)
	else
		Debug('BuildTowerUSP45', 'Grid is blocked!')
		Say(hCaster, 'Can\'t build here!', false)
	end
	
	Debug('BuildTowerUSP45', '... done')
end
--[[
function build_tower_usp45_scripted:OnChannelFinish(interrupted)
	Debug('BuildTowerUSP45', 'OnChannelFinish ...')
	
	if(not interrupted) then
		local hCaster = self:GetCaster()
		local hTarget = self:GetCursorCastTarget()
		Debug('BuildTowerUSP45', 'hCaster: '..tostring(hCaster))
		Debug('BuildTowerUSP45', 'hTarget: '..tostring(hTarget))
		if(hCaster == nil or hTarget == nil) then return end
		
		local vPos1 = hCaster:GetOrigin()
		local vPos2 = hTarget:GetOrigin()
		
		CreateUnitByName('unit_donkey', vPos2, true, nil, hCaster, hCaster:GetTeamNumber())
	end
	
	Debug('BuildTowerUSP45', '... done')
end
]]--



--[[
-- Create the class object
if(build_tower_usp45 == nil) then
	Debug('BuildTowerUSP45', 'Creating class object ...')
	
	_G.build_tower_usp45 = class({})
	build_tower_usp45.__index = build_tower_usp45
	
	Debug('BuildTowerUSP45', '... done')
end

-- Constructor
function build_tower_usp45.new()
	local self = setmetatable({}, build_tower_usp45)
	
	return self
end
]]--
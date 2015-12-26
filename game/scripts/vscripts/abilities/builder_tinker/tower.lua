function GetGridCenterToWorld(pos)
	local gridX = GridNav:WorldToGridPosX(pos[1])
	local gridY = GridNav:WorldToGridPosY(pos[2])
	pos[1] = GridNav:GridPosToWorldCenterX(gridX)
	pos[2] = GridNav:GridPosToWorldCenterY(gridY)
	--Debug('BuildTowerUSP45', 'pos: '..tostring(pos))
	
	return pos
end

function CheckBlocked(pos)
	local blocked = false
	local ents = Entities:FindInSphere(nil, pos, 4)
	if(Entities:FindInSphere(nil, pos, 4)) then blocked = true end
	
	return blocked
end

function PlaceTower(name, pos, caster)
	CreateUnitByName(name, pos, false, nil, caster, caster:GetTeamNumber())
end
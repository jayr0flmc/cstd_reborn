function PlaceTower(event)
	local unit = Unit.new(Game.GetUnitNameByID(event.ability:GetSpecialValueFor('unitID')),
		event.unit:GetCursorPosition(), event.caster, event.ability:GetSpecialValueFor('cost_food'),
		event.ability:GetGoldColst(event.ability:GetLevel()))
	event.caster.player:RefreshPlayerInfo()
end
-- Includes



-- Constants
TIMER_THINK		= 0.01



-- Variables



-- Create object.
if Timer == nil then
	_G.Timer = class({})
	Timer.__index = Timer
end

-- Constructor
function Timer:New(object)
	local object = object or {}
	
	setmetatable(object, Timer)
	
	return object
end



function Timer:Start()
	Timer = self
	self.timers = {}
	local entity = Entities:CreateByClassname('info_target')
	
	entity:SetThink('Think', self, 'timers', TIMER_THINK)
end

function Timer:Think()
	if(GameRules:State_Get() >= DOTA_GAMERULES_STATE_POST_GAME) then return end
	
	-- Track game time, since the dt passed in to think is actually wall-clock time not simulation time.
	local now = GameRules:GetGameTime()
	
	-- Process timers
	for k, v in pairs(Timer.timers) do
		local bUseGameTime	= true
		local bOldStyle		= false
		local now			= GameRules:GetGameTime()
		
		if(v.useGameTime ~= nil and v.useGameTime == false) then bUseGameTime = false end
		if(v.useOldStyle ~= nil and v.useOldStyle == true) then bOldStyle = true end
		if(not bUseGameTime) then now = Time() end
		if(v.endTime == nil) then v.endTime = now end
		
		-- Check if the timer has finished
		if(now >= v.endTime) then
			-- Run the callback
			local status, nextCall = pcall(v.callback, GameRules:GetGameModeEntity(), v)
			
			-- Make sure it worked
			if(status) then
				-- Check if it needs to loop
				if(nextCall) then
					-- Change its end time
					if(bOldStyle) then
						v.endTime = v.endTime + nextCall - now
					else
						v.endTime = v.endTime + nextCall
					end
				else
					-- Remove from timers list
					Timer.timers[k] = nil
				end
				
				-- Update timer data
				--self:UpdateTimerData()
			else
				-- Nope, handle the error
				Timer:HandleEventError('Timer', k, nextCall)
			end
		end
	end
	
	return TIMER_THINK
end

function Timer:CreateTimer(name, args)
	if(type(name) == 'function') then
		args = {callback = name}
		name = DoUniqueString('timer')
	elseif(type(name) == 'table') then
		args = name
		name = DoUniqueString('timer')
	elseif(type(name) == 'number') then
		args = {endTime = name, callback = args}
		name = DoUniqueString('timer')
	end
	
	if(not args.callback) then
		print('Invalid timer created: '..name)
		
		return
	end
	
	local now = GameRules:GetGameTime()
	if(args.useGameTime ~= nil and args.useGameTime == false) then now = Time() end
	if(args.endTime == nil) then
		args.endTime = now
	elseif(args.useOldStyle == nil or args.useOldStyle == false) then
		args.endTime = now + args.endTime
	end
	
	Timer.timers[name] = args
	
	return name
end

function Timer:RemoveTimer(name)
	Timer.timers[name] = nil
end

function Timer:RemoveTimers(killAll)
	local timers = {}
	
	if(not killAll) then
		for k, v in pairs(Timer.timers) do
			if v.persist then timers[k] = v end
		end
	end
	
	Timer.timers = timers
end



function Timer:HandleEventError(name, event, err)
	print('[EDT]: '..err)
	
	-- Ensure we have data
	local name	= tostring(name or 'unknown')
	local event	= tostring(event or 'unknown')
	local err	= tostring(err or 'unknow')
	
	-- Tell everyone there was an error
	Say(nil, name..' threw an error on event '..event, false)
	Say(nil, err, false)
	
	-- Prevent loop arounds
	if(not self.errorHandled) then
		-- Store that we handled an error
		self.errorHandled = true
	end
end

Timer:Start()
--[[
	-- A timer running every second that starts immediately on the next frame, respects pauses
	EDT_Timer:CreateTimer(function()
		print('Hello. I'm running immediately and then every second thereafter.')
		
		return 1.0
	end)
	
	-- A timer which calls a function with a table context
	EDT_Timer:CreateTimer(GameMode.someFunction, GameMode)
	
	-- A timer running every second that starts 5 seconds in the future, respects pauses
	EDT_Timer:CreateTimer(5, function()
		print('Hello. I'm running 5 seconds after you called me and then every second thereafter.')
		
		return 1.0
	end)
	
	-- 10 second delayed, run once using gametime (respect pauses)
	EDT_Timer:CreateTimer({
		endTime = 10, -- when this timer should first execute, you can omit this if you want it to run first on the next frame
		callback = function()
			print('Hello. I'm running 10 seconds after when I was started.')
		end
	})
	
	-- 10 second delayed, run once regardless of pauses
	EDT_Timer:CreateTimer({
		useGameTime = false,
		endTime = 10, -- when this timer should first execute, you can omit this if you want it to run first on the next frame
		callback = function()
			print('Hello. I'm running 10 seconds after I was started even if someone paused the game.')
		end
	})
	
	-- A timer running every second that starts after 2 minutes regardless of pauses
	EDT_Timer:CreateTimer("uniqueTimerString3", {
		useGameTime = false,
		endTime = 120,
		callback = function()
			print('Hello. I'm running after 2 minutes and then every second thereafter.')
			
			return 1
		end
	})
	
	-- A timer using the old style to repeat every second starting 5 seconds ahead
	EDT_Timer:CreateTimer("uniqueTimerString3", {
		useOldStyle = true,
		endTime = GameRules:GetGameTime() + 5,
		callback = function()
			print('Hello. I'm running after 5 seconds and then every second thereafter.')
			
			return GameRules:GetGameTime() + 1
		end
	})
]]--

-- Create the class object
if(EDT_Timer == nil) then
	Debug('Timer', 'Creating class object ...')
	
	_G.EDT_Timer = class({})
	EDT_Timer.__index = EDT_Timer
	
	Debug('Timer', '... done')
end

-- Constructor
function EDT_Timer.new()
	local self = setmetatable({}, EDT_Timer)
	
	self.sVersion = '1.03'
	self.fThink = 0.01
	self.tTimers = {}
	self.bErrorHandled = false
	
	local ent = Entities:CreateByClassname('info_target')	-- Entities:FindByClassname(nil, 'CWorld')
	ent:SetThink('Think', self, 'tTimers', self.fThink)
	
	return self
end

function EDT_Timer:Think()
	if(GameRules:State_Get() >= DOTA_GAMERULES_STATE_POST_GAME) then return end
	
	-- Track game time, since the dt passed in to.
	-- Think is actually wall-clock time, not simulation time.
	local now = GameRules:GetGameTime()
	
	-- Process timers
	for key, val in pairs(self.tTimers) do
		local bUseGameTime = true
		local bUseOldStyle = false
		if(val.useGameTime ~= nil and val.useGameTime == false) then bUseGameTime = false end
		if(val.useOldStyle ~= nil and val.useOldStyle == false) then bUseOldStyle = false end
		
		local now = GameRules:GetGameTime()
		if(not bUseGameTime) then now = Time() end
		if(val.endTime == nil) then val.endTime = now end
		
		-- Check if the timer has finished
		if(now >= val.endTime) then
			-- Remove from list
			self.tTimers[key] = nil
			
			-- Run the callback
			local status, nextCall
			if(val.context) then
				status, nextcall = xpcall(function() return val.callback(val.context, val) end, function(msg)
											return msg..'\n'..debug.traceback()..'\n'
										end)
			else
				status, nextcall = xpcall(function() return val.callback(val, val) end, function(msg)
											return msg..'\n'..debug.traceback()..'\n'
										end)
			end
			
			-- Make sure it worked
			if(status) then
				-- Check if it needs to loop
				if(nextCall) then
					-- Change its end time
					if(bUseOldStyle) then
						val.endTime = val.endTime + nextCall - now
					else
						val.endTime = val.endTime + nextCall
					end
					
					self.tTimers[key] = val
				end
				
				-- Update timer data
				--self:UpdateTimerData()
			else
				-- Nope, handle the error
				self:HandleEventError('Timer', key, nextCall)
			end
		end
	end
	
	return self.fThink
end

function EDT_Timer:HandleEventError(name, event, err)
	Debug('Timer', err)
	
	-- Ensure we have data
	name = tostring(name or 'unknown')
	event = tostring(event or 'unknown')
	err = tostring(err or 'unknown')
	
	-- Tell everyone there was an error
	Say(nil, name..' threw an error on event '..event, false)
	Say(nil, err, false)
	
	-- Prevent loop arounds
	if(not self.bErrorHandled) then
		-- Store that we handled an error
		self.bErrorHandled = true
	end
end



function EDT_Timer:CreateTimer(name, args, context)
	if(type(name) == 'function') then
		if(args ~= nil) then context = args end
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
		Debug('Timer', 'Invalid timer created: '..tostring(name))
		
		return
	end
	
	local now = GameRules:GetGameTime()
	if(args.useGameTime ~= nil and args.useGameTime == false) then now = Time() end
	if(args.endTime == nil) then
		args.endTime = now
	elseif(args.useOldStyle == nil or args.useOldStyle == false) then
		args.endTime = now + args.endTime
	end
	
	args.context = context
	self.tTimers[name] = args
	
	return name
end

function EDT_Timer:RemoveTimer(name)
	self.tTimers[name] = nil
end

function EDT_Timer:RemoveAllTimers(persistent)
	local timers = {}
	
	if(not persistent) then
		for key, val in pairs(self.tTimers) do
			if(val.persist) then self.tTimers[key] = val end
		end
	end
	
	self.tTimers = timers
end
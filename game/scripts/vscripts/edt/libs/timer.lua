TIMER_VERSION = "1.03"

--[[

  -- A timer running every second that starts immediately on the next frame, respects pauses
  Timers:CreateTimer(function()
      print ("Hello. I'm running immediately and then every second thereafter.")
      return 1.0
    end
  )

  -- A timer which calls a function with a table context
  Timers:CreateTimer(GameMode.someFunction, GameMode)

  -- A timer running every second that starts 5 seconds in the future, respects pauses
  Timers:CreateTimer(5, function()
      print ("Hello. I'm running 5 seconds after you called me and then every second thereafter.")
      return 1.0
    end
  )

  -- 10 second delayed, run once using gametime (respect pauses)
  Timers:CreateTimer({
    endTime = 10, -- when this timer should first execute, you can omit this if you want it to run first on the next frame
    callback = function()
      print ("Hello. I'm running 10 seconds after when I was started.")
    end
  })

  -- 10 second delayed, run once regardless of pauses
  Timers:CreateTimer({
    useGameTime = false,
    endTime = 10, -- when this timer should first execute, you can omit this if you want it to run first on the next frame
    callback = function()
      print ("Hello. I'm running 10 seconds after I was started even if someone paused the game.")
    end
  })


  -- A timer running every second that starts after 2 minutes regardless of pauses
  Timers:CreateTimer("uniqueTimerString3", {
    useGameTime = false,
    endTime = 120,
    callback = function()
      print ("Hello. I'm running after 2 minutes and then every second thereafter.")
      return 1
    end
  })


  -- A timer using the old style to repeat every second starting 5 seconds ahead
  Timers:CreateTimer("uniqueTimerString3", {
    useOldStyle = true,
    endTime = GameRules:GetGameTime() + 5,
    callback = function()
      print ("Hello. I'm running after 5 seconds and then every second thereafter.")
      return GameRules:GetGameTime() + 1
    end
  })

]]

TIMER_THINK = 0.01

if(Timer == nil) then
	print('[EDT Timer] creating Timer object ...')
	
	Timer = {}
	Timer.__index = Timer
	
	print('[EDT Timer] ... done')
end

function Timer:new(o)
	o = o or {}
	setmetatable(o, Timer)
	
	return o
end

function Timer:start()
	Timer = self
	self.timers = {}
	
	local ent = Entities:CreateByClassname('info_target')	-- Entities:FindByClassname(nil, 'CWorld')
	ent:SetThink('Think', self, 'timers', TIMER_THINK)
end



function Timer:CreateTimer(name, args, context)
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
		print('[EDT Timer] Invalid timer created: '..name)
		
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
	Timer.timers[name] = args
	
	return name
end

function Timer:KillTimer(name)
	Timer.timers[name] = nil
end
function Timer:KillTimers(all)
	local timers = {}
	
	if(not all) then
		for k, v in pairs(Timer.timers) do
			if(v.persist) then timers[k] = v end
		end
	end
	
	Timer.timers = timers
end

function Timer:Think()
	if(GameRules:State_Get() >= DOTA_GAMERULES_STATE_POST_GAME) then return end
	
	-- Track game time, since the dt passed in to think is actually wall-clock time not simulation time.
	local now = GameRules:GetGameTime()
	
	-- Process timers
	for k, v in pairs(Timer.timers) do
		local bUseGameTime = true
		local bOldStyle = false
		if(v.useGameTime ~= nil and v.useGameTime == false) then bUseGameTime = false end
		if(v.useOldStyle ~= nil and v.useOldStyle == true) then bOldStyle = true end
		
		local now = GameRules:GetGameTime()
		if(not bUseGameTime) then now = Time() end
		if(v.endTime == nil) then v.endTime = now end
		
		-- Check if the timer has finished
		if(now >= v.endTime) then
			-- Remove from timers list
			Timer.timers[k] = nil
			
			-- Run the callback
			local status, nextCall
			if(v.context) then
				status, nextCall = xpcall(function() return v.callback(v.context, v) end, function(msg)
											return msg..'\n'..debug.traceback()..'\n'
										  end)
			else
				status, nextCall = xpcall(function() return v.callback(v, v) end, function(msg)
											return msg..'\n'..debug.traceback()..'\n'
										  end)
			end
			
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
					
					Timer.timers[k] = v
				end
				
				-- Update timer data
				--self:UpdateTimerData()
			else
				-- Nope, handle the error
				--Timer:HandleEventError('Timer', k, nextCall)
			end
		end
	end
	
	return TIMER_THINK
end



if(not Timer.timers) then Timer:start() end
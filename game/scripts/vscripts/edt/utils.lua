-- Colors
COLOR = {
	NONE	= '\x06',
	GRAY	= '\x06',
	GREY	= '\x06',
	GREEN	= '\x0C',
	DPURPLE	= '\x0D',
	SPINK	= '\x0E',
	DYELLOW	= '\x10',
	PINK	= '\x11',
	RED		= '\x12',
	LGREEN	= '\x15',
	BLUE	= '\x16',
	DGREEN	= '\x18',
	SBLUE	= '\x19',
	PURPLE	= '\x1A',
	ORANGE	= '\x1B',
	LRED	= '\x1C',
	GOLD	= '\x1D'
}



function EDT:Debug(prefix, message)
	local output = Convars:GetInt('edt_debug_output') or -1
	if(output == -1 and EDT_DEBUG_OUTPUT) then output = 1 end
	
	prefix = tostring(prefix)
	message = tostring(message)
	
	if(message == nil or message == '') then return end
	
	if(prefix ~= '') then prefix = string.format('[EDT %s]', prefix) else prefix = '[EDT]' end
	message = string.format('%s %s', prefix, message)
	
	if(output == 1) then print(message) end
end

function EDT:DebugTable(...)
	local output = Convars:GetInt('edt_debug_output') or -1
	if(output == -1 and EDT_DEBUG_OUTPUT) then output = 1 end
	
	if(output == 1) then self:PrintTable(...) end
end
function EDT:PrintTable(t, ident, done)
	print(string.format('PrintTable type %s', type(t)))
	if(type(t) ~= 'table') then return end
	
	done = done or {}
	done[t] = true
	ident = ident or 0
	
	local l = {}
	for key, val in pairs(t) do
		table.insert(l, key)
	end
	table.sort(l)
	
	for key, val in ipairs(l) do
		-- Ignore FDesc
		if(v ~= 'FDesc') then
			local value = t[val]
			
			if(type(value) == 'table' and not done[value]) then
				done[value] = true
				
				print(string.rep('\t', ident)..tostring(val)..':')
				self:PrintTable(value, ident + 2, done)
			elseif(type(value) == 'userdata' and not done[value]) then
				done[value] = true
				
				print(string.rep('\t', ident)..tostring(val)..':')
				self:PrintTable((getmetatable(value) and getmetatable(value).__index) or getmetatable(value), ident + 2, done)
			else
				if(t.FDesc and tFDesc[val]) then
					print(string.rep('\t', ident)..tostring(t.FDesc[val]))
				else
					print(string.rep('\t', ident)..tostring(val)..': '..tostring(value))
				end
			end
		end
	end
end
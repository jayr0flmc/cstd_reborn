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



function Debug(prefix, message)
	local output = Convars:GetInt('edt_debug_output') or -1
	if(output == -1 and EDT_DEBUG_OUTPUT) then output = 1 end
	
	if(prefix ~= '') then prefix = '[EDT '..prefix..']' else prefix = '[EDT]' end
	message = prefix..' '..message
	
	if(output == 1) then print(message) end
end

function DebugTable(...)
	local output = Convars:GetInt('edt_debug_output') or -1
	if(output == -1 and EDT_DEBUG_OUTPUT) then output = 1 end
	
	if(output == 1) then PrintTable(...) end
end
function PrintTable(t, ident, done)
	--print(string.format('PrintTable type %s', type(t)))
	if(type(t) ~= 'table') then return end
	
	done = done or {}
	done[t] = true
	indent = indent or 0
	
	local l = {}
	for k, v in pairs(t) do
		table.insert(l, k)
	end
	table.sort(l)
	
	for k, v in ipairs(l) do
		-- Ignore FDesc
		if(v ~= 'FDesc') then
			local value = t[v]
			
			if(type(value) == 'table' and not done[value]) then
				done[value] = true
				
				print(string.rep('\t', indent)..tostring(v)..':')
				PrintTable(value, indent + 2, done)
			elseif(type(value) == 'userdata' and not done[value]) then
				done[value] = true
				
				print(string.rep('\t', indent)..tostring(v)..': '..tostring(value))
				PrintTable((getmetatable(value) and getmetatable(value).__index) or getmetatable(value), indent + 2, done)
			else
				if(t.FDesc and tFDesc[v]) then
					print(string.rep('\t', indent)..tostring(t.FDesc[v]))
				else
					print(string.rep('\t', indent)..tostring(v)..': '..tostring(value))
				end
			end
		end
	end
end
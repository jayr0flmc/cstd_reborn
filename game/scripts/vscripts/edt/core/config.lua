-- Create the class object
if(EDT_Config == nil) then
	_G.EDT_Config = class({})
	EDT_Config.__index = EDT_Config
end

-- Constructor
function EDT_Config.new()
	local self = setmetatable({}, EDT_Config)
	
	return self
end



function EDT_Config:ReadConfigs()
	EDT:Debug('Config', 'Reading in configs ...')
	
	local kv = LoadKeyValues('scripts/maps/'..GetMapName()..'.cfg')
	
	EDT:Debug('Config', '... done.')
end
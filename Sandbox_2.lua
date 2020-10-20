local __script_name__ = "Sandbox_2"
local __version__     = "1.0"

return {
	on = {
		devices = { 124 },
		timer = {},
		variables = {},
		scenes = {},
		groups = {},
		security = {},
		httpResponses = {},
		customEvents = {},
		system = {},
	},
	
	data = {},
	
    logging = {
	    level = domoticz.LOG_INFO,
		marker = '['.. __script_name__ .. '-' .. __version__ .. ']' 
	},
	
	execute = function(dz, device)
        local telegramKey = dz.variables('telegramKey').value
        local telegramRoom = dz.variables('telegramRoom').value
        
        
	end
}

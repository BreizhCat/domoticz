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
        if dz.devices(75).state == dz.SECURITY_ARMEDAWAY then
            dz.helpers.sendTelegramPicture(dz, "ploufette", "https://test.psychologies.com/var/tests/storage/images/2/8/4/0/480482-2-fre-FR/Ce_que_revele_votre_facon_de_parler_thumb_434_265.jpg")    
        end
	end
}

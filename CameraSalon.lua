--[[
author   = BreizhCat
create   = 04.07.2020
update   = 05.07.2020
filename = CameraSalon.lua

description = Utilisation des positions de la caméra DLink5020L
change      = 
    05.07.2020: Ajout varibles utilisateurs pour accès caméra
    
--]]

local __script_name__ = "CameraSalon"
local __version__     = "1.1"

return {
	on = {
		devices = { 114 }
	},
    logging = {
	    level = domoticz.LOG_INFO,
		marker = '['.. __script_name__ .. '-' .. __version__ .. ']' 
	},
	execute = function(dz, device)
	    local cam_user = dz.variables('cam_salon_user').value
	    local cam_pass = dz.variables('cam_salon_pass').value
	    local cam_ip   = dz.variables('cam_salon_ip').value
		local baseURL = 'http://'..cam_user..':'..cam_pass..'@'..cam_ip..'/pantiltcontrol.cgi?PanTiltPresetPositionMove='
		
		local tiltPosition = device.level / 10
		
		os.execute('curl '.. baseURL .. tiltPosition)
	end
}
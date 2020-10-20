--[[ 
author   = BreizhCat
create   = 02.01.2020
update   = 13.05.2020
filename = homeDoors.lua
repo     = https://github.com/BreizhCat/domoticz/blob/master/homeDoors.lua 

description = When the alarm is set on, the notification is send to telegram 
change      =
    13.05.2020: changement du message avec temps plus parlant que des secondes
    24.06.2020: ajout Congélateur
--]]

local __script_name__ = "homeDoors"
local __version__     = "1.2"

return {
	on = {
		devices = {
		    44, -- Porte Jardin
		    45, -- Porte Garage
            46, -- Porte d'entrée
            82, -- Dummy
            89, -- Salle de jeu
            91, -- Garage
            90, -- Congélateur
            113, -- Chambre Parents
            123, -- Cuisine
		},
	},
	logging = {
	    level = domoticz.LOG_INFO,
		marker = '['.. __script_name__ .. '-' .. __version__ .. ']' 
    },

	execute = function(dz, device)
	    local function sendStatusNotification(device, group)
            local message = ''
	        local doorIcon = '\xF0\x9F\x9A\xAA '
	        local device_found = false
	        
	        dz.log('Prepare Message', dz.LOG_DEBUG)
	        
	        for i, id in ipairs(group) do
	            if id == device.id then
	                device_found = true
                end
	        end
	        
	        if device_found then
    	        if device._state == 'Open' then
                    -- Previous state = Closed
                    message = doorIcon..device.name..' is opened!'
                end
                    
                if device._state == 'Closed' then
                    local seconds = device.lastUpdate.secondsAgo
                    if seconds     >= 86400 then
                    
                    elseif seconds >= 3600  then
                    
                    elseif seconds >= 60    then
                    
                    else
                        secoutput = seconds
                        unit      = 'seconds'
                    end
                    -- Previous state = Open
                    message = doorIcon..device.name..' is closed after '..device.lastUpdate.secondsAgo..' seconds'
                end
                dz.log(message, dz.LOG_DEBUG)
                dz.helpers.notif_telegram(dz, message) 
            end
	    end
	    
	    -- Device group
	    local device_away = { 44, 45, 46, 82, 89, 91, 113, 90, 123 }
	    local device_home = { 44, 46, 82, 89, 91, 113, 90, 123 }
	    local device_none = { 82, 90 }

        if device.changed then
            local isAlarmed = dz.devices(75).state
                
            dz.log('Door: '..device.name .. ' is '..device._state, dz.LOG_DEBUG)
            dz.log('Alarm is '..isAlarmed..'/'..dz.SECURITY_ARMEDAWAY, dz.LOG_DEBUG)
           
            if isAlarmed == dz.SECURITY_DISARMED then
                sendStatusNotification(device, device_none)
            end
            
            if isAlarmed == dz.SECURITY_ARMEDAWAY  then
                sendStatusNotification(device, device_away)
            end
        
            if isAlarmed == dz.SECURITY_ARMEDHOME then
                sendStatusNotification(device, device_home)    
            end
        end -- device.changed ?
        
	end -- function execute
}
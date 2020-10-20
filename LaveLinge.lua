--[[
author   = BreizhCat
create   = 14.05.2020
update   = 
filename = LaveLinge.lua

description = Notification lorsque la lessive est finie
change      =
    
--]]

local __script_name__ = "LaveLinge"
local __version__     = "1.0"

return {
    on = {
        --devices =  { 96,98 }, 
        timer = { 'every minute' }
    },
    logging = {
	    level = domoticz.LOG_INFO,
		marker = '['.. __script_name__ .. '-' .. __version__ .. ']' 
	},
    execute = function(dz, device)
        local seuil = 2
        
        local lastValue = dz.variables('LaveLingeLastUpdateValue').value
        local lastDate = dz.variables('LaveLingeLastUpdateDate').value
        local lastSent = dz.variables('LaveLingeLastUpdateSent').value
        
        local currentDate = dz.time.minutesSinceMidnight
        
        if dz.devices(96).actualWatt < seuil and lastValue < seuil then
           delta = currentDate -  lastDate
           
            if delta > 180 then
              --dz.helpers.notif_telegram(dz, "Machine")
            end
        end
        dz.log(dz.devices(96).actualWatt)
    end
}
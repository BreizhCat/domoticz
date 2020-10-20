--[[
author   = BreizhCat
create   = 27.01.2020
update   = 06.04.2020
filename = openDoorLights.lua

description = Allumage lumière du hall si le soleil est couché ou pas encore levé
change      =
    06.04.2020: nouvelle version de dzEvent (nouvelles fonctions disponibles)
--]]

local __script_name__ = "openDoorLights"
local __version__     = "1.1"

return {
    on = {
        devices =  { 46 }, -- Porte d'entrée
        timer = { 'every minute' }
    },
    logging = {
	    level = domoticz.LOG_INFO,
		marker = '['.. __script_name__ .. '-' .. __version__ .. ']' 
	},
    execute = function(dz, trigger)
        local hallLight = dz.devices(15)
 
        if trigger.isDevice then
            if dz.time.minutesSinceMidnight > dz.time.sunsetInMinutes then
                hallLight.dimTo(100)
            end
            
            if dz.time.minutesSinceMidnight < dz.time.sunriseInMinutes then
               hallLight.dimTo(50) 
            end
        end


        if trigger.isTimer then
            if hallLight.active then
                if hallLight.lastUpdate.secondsAgo > 180 then
                    hallLight.switchOff()
                end
            end
        end
    end
}

--[[
author   = BreizhCat
create   = 15.04.2020
update   = 
filename = garage.lua

description = Allumage lumière du garage si mouvement détecté
change      =
    
--]]

local __script_name__ = "garage"
local __version__     = "1.0"

return {
    on = {
        devices =  { 41 }, -- Mvt Garage
        timer = { 'every minute' }
    },
    logging = {
	    level = domoticz.LOG_INFO,
		marker = '['.. __script_name__ .. '-' .. __version__ .. ']' 
	},
    execute = function(dz, trigger)
        local garageLight = dz.devices(17)
        local garageMotion = dz.devices(41)
        
        if trigger.isDevice then
            dz.log(garageMotion.active)
            if garageMotion.active then
               garageLight.dimTo(100) 
            end
        end


        if trigger.isTimer then
            if garageLight.active then
                if garageLight.lastUpdate.secondsAgo > 60 then
                    garageLight.switchOff()
                end
            end
        end
    end
}
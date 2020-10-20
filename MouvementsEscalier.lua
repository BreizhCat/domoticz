--[[
author   = BreizhCat
create   = 21.04.2020
update   = 13.05.2020
filename = MouvementsEscalier.lua

description = Détection mouvements dans l'escalier à certaines heures
change      = 
    13.05.2020: Changement format date et icône
--]]

local __script_name__ = "MouvementsEscalier"
local __version__     = "1.1"

return {
    on = {
        devices =  { 43 }, -- Porte d'entrée
    },
    logging = {
	    level = domoticz.LOG_INFO,
		marker = '['.. __script_name__ .. '-' .. __version__ .. ']' 
	},
    execute = function(dz, device)
        if device._state == 'On' then
            dz.log('Mouvement détecté')
            if dz.time.minutesSinceMidnight > 1260 then
              dz.helpers.notif_telegram(dz, "\xF0\x9F\x9A\xB8 ".. os.date('[%d/%m %H:%M]') .. " Mouvements")
            else
                dz.log('Ce n\'est pas l\'heure !')
            end
        end
    end
}
--[[ 
author = BreizhCat
create = 02.01.2020
update = 20.10.2020
filename = global_data.lua
repo   = https://github.com/BreizhCat/domoticz/blob/master/global_data.lua
help   = https://www.domoticz.com/wiki/DzVents:_next_generation_LUA_scripting#Shared_helper_functions
description = General include with tools
change      =
    20.10.2020 [1.1] Nouvelle fonction log_dsm
--]]


return {
    helpers = {
        --[[ 
        Function notif_telegram: Shortcut to send notification to telegram
        
        @dz       : self reference to object domoticz in main function
        @message  : your message
        @priority : priority (optional)
        
        Example : domoticz.helpers.notif_telegram(..., ..., [...])
        --]]
        notif_telegram = function (dz, message, priority)
            dz.notify(message, message, priority or dz.PRIORITY_NORMAL, nil, nil, dz.NSS_TELEGRAM)
        end,
        
        --[[
        Function log_dsm: Add entry in DSM Log
        @dz       : self reference to object domoticz in main function
        @message  : your message
        
        ]]--
        log_dsm = function (dz, message)
            os.execute('synologset1 sys info 0x11100000 '.. message)
        end,
        
        sendTelegramPicture = function (dz, message, image)
            local telegramKey = dz.variables('telegramKey').value
            local telegramRoom = dz.variables('telegramRoom').value
            
            local telegramAPI = 'curl -s -X POST "https://api.telegram.org/bot'..telegramKey..'/sendPhoto" -F chat_id="'..telegramRoom..'" -F photo="'..image..'" -F caption="'..message..'"'
            dz.log(telegramAPI)
            os.execute(telegramAPI)
        end,
    }
}


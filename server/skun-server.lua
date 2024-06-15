ESX = exports["es_extended"]:getSharedObject()

RegisterCommand('wezwij', function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer then
        local allowedRoles = {'support', 'mod', 'admin', 'superadmin', 'best'} -- Dodaj tutaj swoje dozwolone role
        local hasPermission = false

        for _, role in ipairs(allowedRoles) do
            if xPlayer.getGroup() == role then
                hasPermission = true
                break
            end
        end

        if not hasPermission then
            TriggerClientEvent('esx:showNotification', source, 'Nie masz uprawnień do użycia tej komendy.')
            return
        end

        local targetId = tonumber(args[1])

        if targetId then
            local targetPlayer = ESX.GetPlayerFromId(targetId)

            if targetPlayer then
                local discordId = GetPlayerIdentifierByType(targetId, "discord")
                
                if discordId then
                    discordId = discordId:gsub("discord:", "")
                    
                    TriggerClientEvent('skun-wezwanie:freezePlayer', targetId, true)
                    TriggerClientEvent('skun-wezwanie:showNotification', targetId, 'Zostałeś wezwany na kanał pomocy, masz 2 minuty aby dołączyć.')
                    TriggerClientEvent('esx:showNotification', source, 'Gracz z ID ' .. targetId .. ' został wezwany i zfreezowany.')

                    local webhookUrl = 'TWOJ_WEBHOOK_KANALU_WEZWANIA' -- zmień to na swoj
                    local message = '<@' .. discordId .. '> - Zostałeś wezwany na kanał <#ID_TWOJEGO_KANALU_POCZEKALNIA>, masz 2 minuty aby wejść.'

                    PerformHttpRequest(webhookUrl, function(statusCode, text, headers)
                    end, 'POST', json.encode({
                        content = message
                    }), {
                        ['Content-Type'] = 'application/json'
                    })

                    SetTimeout(30000, function()
                        TriggerClientEvent('skun-wezwanie:freezePlayer', targetId, false)
                    end)
                else
                    TriggerClientEvent('esx:showNotification', source, 'Gracz nie ma ustawionego Discord ID.')
                end
            else
                TriggerClientEvent('esx:showNotification', source, 'Gracz o takim ID nie istnieje.')
            end
        else
            TriggerClientEvent('esx:showNotification', source, 'Podaj prawidłowe ID gracza.')
        end
    else
        TriggerClientEvent('esx:showNotification', source, 'Nie jesteś zalogowany.')
    end
end, false)

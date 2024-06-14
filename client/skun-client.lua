ESX = exports["es_extended"]:getSharedObject()

RegisterCommand('skun-wezwanie', function(source, args, rawCommand)
    local xPlayer = ESX.GetPlayerFromId(source)

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
            MySQL.Async.fetchScalar('SELECT discordId FROM users WHERE identifier = @identifier', {
                ['@identifier'] = targetPlayer.identifier
            }, function(discordId)
                if discordId then
                    TriggerClientEvent('skun-wezwanie:freezePlayer', targetId, true)
                    TriggerClientEvent('skun-wezwanie:showNotification', targetId,
                        'Zostałeś wezwany na kanał pomocy, masz 2 minuty aby dołączyć.')
                    TriggerClientEvent('esx:showNotification', source,
                        'Gracz z ID ' .. targetId .. ' został wezwany i zfreezowany.')

                    local webhookUrl = 'TWOJ_URL_WEBHOOKA_DISCORD' -- zmień to na swoj
                    local message = '<@' .. discordId .. '> - Zostałeś wezwany na kanał <#1230604422892224615>, masz 2 minuty aby wejść.'

                    PerformHttpRequest(webhookUrl, function(statusCode, text, headers)
                    end, 'POST', json.encode({
                        content = message
                    }), {
                        ['Content-Type'] = 'application/json'
                    })

                    SetTimeout(30000, function() -- 30 sekund możesz se zmienić
                        TriggerClientEvent('skun-wezwanie:freezePlayer', targetId, false)
                    end)
                else
                    TriggerClientEvent('esx:showNotification', source, 'Gracz nie ma ustawionego Discord ID.')
                end
            end)
        else
            TriggerClientEvent('esx:showNotification', source, 'Gracz o takim ID nie istnieje.')
        end
    else
        TriggerClientEvent('esx:showNotification', source, 'Podaj prawidłowe ID gracza.')
    end
end, false)

RegisterNetEvent('skun-wezwanie:freezePlayer')
AddEventHandler('skun-wezwanie:freezePlayer', function(targetId, freeze)
    if freeze then
        freezedPlayers[targetId] = true
        TriggerClientEvent('skun-wezwanie:toggleFreeze', targetId, true)
    else
        freezedPlayers[targetId] = nil
        TriggerClientEvent('skun-wezwanie:toggleFreeze', targetId, false)
    end
end)

RegisterNetEvent('skun-wezwanie:showNotification')
AddEventHandler('skun-wezwanie:showNotification', function(notificationText)
    SendNUIMessage({
        type = "on",
        display = true,
        text = notificationText
    })
    SetTimeout(30000, function() -- 30 sekund możesz se zmienić
        SendNUIMessage({
            type = "off"
        })
    end)
end)

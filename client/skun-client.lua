local isFrozen = false

RegisterNetEvent('skun-wezwanie:freezePlayer')
AddEventHandler('skun-wezwanie:freezePlayer', function(freeze)
    isFrozen = freeze
    if freeze then
        SetEntityCoords(PlayerPedId(), GetEntityCoords(PlayerPedId()))
        FreezeEntityPosition(PlayerPedId(), true)
        DisplayRadar(false)
        TriggerEvent('skun-wezwanie:showFreezeMessage', 'Aktualnie nie możesz się ruszać!')
    else
        FreezeEntityPosition(PlayerPedId(), false)
        DisplayRadar(true)
        TriggerEvent('skun-wezwanie:showFreezeMessage', 'Już możesz się ruszać!')
    end
end)

RegisterNetEvent('skun-wezwanie:showNotification')
AddEventHandler('skun-wezwanie:showNotification', function(notificationText)
    SendNUIMessage({
        type = "on",
        display = true,
        text = notificationText
    })

        -- Usunięcie komunikatu po 30 sekundach
    SetTimeout(30000, function()
        SendNUIMessage({
            type = "off"
        })
    end)
end)

RegisterNetEvent('skun-wezwanie:showFreezeMessage')
AddEventHandler('skun-wezwanie:showFreezeMessage', function(message)
    SendNUIMessage({
        type = "freezeMessage",
        display = true,
        text = message
    })

        -- Usunięcie komunikatu po 30 sekundach
    SetTimeout(30000, function()
        TriggerEvent('skun-wezwanie:hideFreezeMessage')
    end)
end)

RegisterNetEvent('skun-wezwanie:hideFreezeMessage')
AddEventHandler('skun-wezwanie:hideFreezeMessage', function()
    SendNUIMessage({
        type = "freezeMessage",
        display = false
    })
end)

Citizen.CreateThread(function()
    while true do
        local sleep = 0

        if isFrozen then
            DisableAllControlActions(0)
        else
            sleep = 1000
        end
        Citizen.Wait(sleep)
    end
end)

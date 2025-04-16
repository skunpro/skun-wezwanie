local Main = {}
Main.IsFrozen = false
Main.LastFreezeTime = 0

---@param state boolean
Main.FreezePlayer = function(state)
    local playerPed = PlayerPedId()

    if state == Main.IsFrozen then return end

    Main.IsFrozen = state
    Main.LastFreezeTime = GetGameTimer()

    if state then
        SetEntityCoordsNoOffset(playerPed, GetEntityCoords(playerPed), false, false, false)
        FreezeEntityPosition(playerPed, true)
        DisplayRadar(false)
        SetNuiFocus(false, false)
    else
        FreezeEntityPosition(playerPed, false)
        DisplayRadar(true)
    end
end

RegisterNetEvent('skun-wezwanie:freezePlayer', function(state)
    Main.FreezePlayer(state)
end)

CreateThread(function()
    while true do
        if Main.IsFrozen then
            DisableAllControlActions(0)
            Wait(0)
        else
            Wait(1000)
        end
    end
end)
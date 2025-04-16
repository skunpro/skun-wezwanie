local Main = {}

Main.Config = {
    WebhookUrl = 'YOUR_WEBHOOK_URL',
    ChannelId = 'YOUR_CHANNEL_ID',
    AllowedRoles = {'support', 'mod', 'admin', 'superadmin', 'best'},
    FreezeTime = 30 * 1000 -- 30 sekund
}

Main.ESX = exports["es_extended"]:getSharedObject()

---@param xPlayer table
---@return boolean
Main.HasPermission = function(xPlayer)
    local group = xPlayer.getGroup()
    for _, role in ipairs(Main.Config.AllowedRoles) do
        if group == role then
            return true
        end
    end
    return false
end

---@param playerId number
---@return string|nil
Main.GetDiscordId = function(playerId)
    for _, v in ipairs(GetPlayerIdentifiers(playerId)) do
        if v:sub(1, 8) == "discord:" then
            return v:sub(9)
        end
    end
    return nil
end

---@param discordId string
---@param reason string
Main.SendWebhookMessage = function(discordId, reason)
    local message = string.format("<@%s> - Zostałeś wezwany na kanał <#%s>, masz 2 minuty aby wejść.\n**Powód:** %s", discordId, Main.Config.ChannelId, reason)

    PerformHttpRequest(Main.Config.WebhookUrl, function() end, 'POST', json.encode({
        content = message
    }), {
        ['Content-Type'] = 'application/json'
    })
end

---@param source number
---@param args table
Main.Command = function(source, args)
    local xPlayer = Main.ESX.GetPlayerFromId(source)
    if not xPlayer then
        TriggerClientEvent('esx:showNotification', source, 'Nie jesteś zalogowany.')
        return
    end

    if not Main.HasPermission(xPlayer) then
        TriggerClientEvent('esx:showNotification', source, 'Nie masz uprawnień do użycia tej komendy.')
        return
    end

    local targetId = tonumber(args[1])
    if not targetId then
        TriggerClientEvent('esx:showNotification', source, 'Podaj prawidłowe ID gracza.')
        return
    end

    if targetId == source then
        TriggerClientEvent('esx:showNotification', source, 'Nie możesz wezwać samego siebie.')
        return
    end

    local targetPlayer = Main.ESX.GetPlayerFromId(targetId)
    if not targetPlayer then
        TriggerClientEvent('esx:showNotification', source, 'Gracz o takim ID nie istnieje.')
        return
    end

    local discordId = Main.GetDiscordId(targetId)
    if not discordId then
        TriggerClientEvent('esx:showNotification', source, 'Gracz nie ma ustawionego Discord ID.')
        return
    end

    local reason = table.concat(args, " ", 2)
    if reason == "" then reason = "Brak powodu" end

    TriggerClientEvent('skun-wezwanie:freezePlayer', targetId, true)

    TriggerClientEvent("txcl:showWarning", targetId, GetPlayerName(source), "Zostałeś wezwany na poczekalnię. Powód: " .. reason)

    TriggerClientEvent('esx:showNotification', source, string.format('Gracz z ID %d został wezwany i zfreezowany.', targetId))

    Main.SendWebhookMessage(discordId, reason)

    SetTimeout(Main.Config.FreezeTime, function()
        TriggerClientEvent('skun-wezwanie:freezePlayer', targetId, false)
    end)
end

Main.Setup = function()
    RegisterCommand('wezwij', Main.Command, false)

    TriggerEvent('chat:addSuggestion', '/wezwij', 'Wezwij gracza na kanał pomocy', {
        { name = 'id', help = 'ID gracza' },
        { name = 'reason', help = 'Powód wezwania (np. łamanie regulaminu)' }
    })
end

Main.Setup()
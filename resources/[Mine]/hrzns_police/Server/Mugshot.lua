
RegisterNetEvent('hrzns_police:mugshotSV', function(location, id, notes)
    if id == source then 
        TriggerClientEvent('hrzns_police:Notify', source, 'error', 'You cannot mug yourself')
    else
        if Config.Framework == 'QBCore' then
            local response
            local copdata
            local susdata
            local copidentifier = GetPlayerIdentifier(source)
            response = MySQL.query.await('SELECT `charinfo` FROM `players` WHERE `license` = @identifier', {
                ['@identifier'] = copidentifier
            })
            if response then
                copdata = json.encode(response)
                print(copdata)
            end
            local susidentifier = GetPlayerIdentifier(id)
            response = MySQL.query.await('SELECT `charinfo` FROM `players` WHERE `license` = @identifier', {
                ['@identifier'] = susidentifier
            })
            if response then
                susdata = json.encode(response)
                print(susdata)
            end
            TriggerClientEvent('hrzns_police:mugshot', id, location, source, copdata, susdata, notes)
        elseif Config.Framework == 'ESX' then
            local source = source
            local copdata = ESX.GetPlayerFromId(source)
            local susdata = ESX.GetPlayerFromId(id)
            TriggerClientEvent('hrzns_police:mugshot', id, location, source, copdata, susdata, notes)
        end
    end
end)

RegisterNetEvent('hrzns_police:muglog', function(copname, DOB, sex, susname, notes, imageURL)
    local embedData = {
        {
            ['title'] = Config.MugShotOptions.LogTitle,
            ['color'] = 16761035,
            ['footer'] = {
                ['text'] = os.date( "!%a %b %d, %H:%M", os.time() + 6 * 60 * 60 ),
            },
            ['fields'] = {
                {['name'] = "Suspect:", ['value'] = "```" .. susname .. "```", ['inline'] = false},
                {['name'] = "Date Of Birth:", ['value'] = "```" .. DOB .. "```", ['inline'] = false},
                {['name'] = "Officer:", ['value'] = "```" .. copname .. "```", ['inline'] = false},
                {['name'] = "Officer Notes:", ['value'] = "```" .. notes .. "```", ['inline'] = false},
            },
            ['image'] = {
                ['url'] = imageURL,
            },
            ['author'] = {
                ['name'] = Config.MugShotOptions.LogName,
                ['icon_url'] = Config.MugShotOptions.LogIcon,
            },
        }
    }
    PerformHttpRequest(Config.MugShotOptions.MugShotHook, function() end, 'POST', json.encode({ username = Config.MugShotOptions.LogName, embeds = embedData}), { ['Content-Type'] = 'application/json' })
end)

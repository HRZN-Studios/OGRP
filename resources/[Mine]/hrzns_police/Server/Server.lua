
-- #SECTION - Callbacks

lib.callback.register('hrzns_police:GetPlayerData', function()
    local data
end)

-- #SECTION - Prop Logic

RegisterNetEvent('createprop', function(coords, rotation, prop, real)
    obj = CreateObject(prop, coords, real, false, false)
    SetEntityRotation(obj, rotation.x, rotation.y, rotation.z, 5, true)
end)

-- #SECTION - Cuff Logic

RegisterNetEvent('near', function(coords ,source)
    local near = lib.getClosestPlayer(coords, 5, true)
    print(near)
end)

RegisterNetEvent('hrzns_police:CuffPlayer', function(id, heading, loc, coords, item, cuffhard)
	local playerPed = GetPlayerPed(id)
    local _source = source
    lib.callback('hrzns_police:GetCuffs', id, function(data)
        if data ~= 'nocuff' then
            TriggerClientEvent('hrzns_police:Notify', _source, 'error', 'They are already restained')
        else
            local x, y, z   = table.unpack(coords + loc * 1.0)
            SetEntityCoords(playerPed, x, y, z)
            SetEntityHeading(playerPed, heading)
            Wait(100)
            TriggerClientEvent('hrzns_police:Notify', _source, 'success', 'They are restained')
            TriggerClientEvent('hrzns_police:cuffed', id, _source, item, cuffhard)
            TriggerClientEvent('hrzns_police:arrest', _source)
        end
    end)
end)

RegisterNetEvent('hrzns_police:UncuffPlayer', function(id, item)
    local cuffs
    lib.callback('hrzns_police:GetCuffs', id, function(data)
        if data == 'nocuff' then
            TriggerClientEvent('hrzns_police:Notify', source, 'error', 'They are not restained')
            
        else
            cuffs = data
            lib.callback('hrzns_police:GetCuffType', id, function(data)
                if item == 'cutters' and data ~= 'hard' then
                    TriggerClientEvent('hrzns_police:Notify', source, 'error', 'They are not hard cuffed')
                    
                else
                    TriggerClientEvent('hrzns_police:uncufftest', source, id, item)
                end
            end)
        end
    end)
end)

RegisterNetEvent('hrzns_police:UnCuff', function(id, item)
    TriggerClientEvent('hrzns_police:uncuffed', id, item)
    TriggerClientEvent('hrzns_police:arrest', source, 'uncuff')
end)

-- #SECTION - MugShot Logic

RegisterNetEvent('hrzns_police:mugshotSV', function(location, id, notes)
    if id == 7 then 
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
            print('source '..source)
            local copdata = ESX.GetPlayerFromId(source)
            local dumpedTable = ESX.DumpTable(copdata)
            print('cop '..dumpedTable)
            local susdata = ESX.GetPlayerFromId(id)
            dumpedTable = ESX.DumpTable(susdata)
            print('sus '..dumpedTable)
            TriggerClientEvent('hrzns_police:mugshot', id, location, source, copdata, susdata, notes)
        end
    end
end)

RegisterNetEvent('hrzns_police:muglog', function(copname, DOB, sex, susname, notes, imageURL)
    print(copname, DOB, Sex, Name, notes)
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

-- #SECTION - Misc Logic

RegisterNetEvent('hrzns_police:SNotify', function(id, info, title, msg)
    TriggerClientEvent('hrzns_police:Notify', id, info, title, msg)
end)

RegisterNetEvent('near', function(coords)
    print(source, coords)
    local nearid, nearped, nearcoords = lib.getClosestPlayer(coords, 5, false)
    print(nearid, nearped, nearcoords)
    return nearid, nearped, nearcoords
end)

lib.callback.register('hrzns_police:GetPlayerData', function(id)
    local data
    local id
    if Config.Framework == 'ESX' then
        if id == nil then
            id = source
        end
        data = ESX.GetPlayerFromId(id)
    end
    return data
end)

RegisterNetEvent('hrzns_police:SNotify', function(id, info, title, msg)
    TriggerClientEvent('hrzns_police:Notify', id, info, title, msg)
end)

RegisterNetEvent('ec', function(id)
    if id == nil then
        id = source
    end
    local ped = GetPlayerPed(id)
    ClearPedTasks(ped)
end)

RegisterNetEvent('near', function(coords)
    print(source, coords)
    local nearid, nearped, nearcoords = lib.getClosestPlayer(coords, 5, false)
    print(nearid, nearped, nearcoords)
    return nearid, nearped, nearcoords
end)

RegisterCommand('ec', function(source, args, rawCommand)
    local ped = GetPlayerPed(args[1])
    ClearPedTasks(ped)
end, false)

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

lib.callback.register('hrzns_police:GetPlayerMeta', function(source, id)
    local data = {}
    if id == nil then
        id = source
    end
    local xPlayer = ESX.GetPlayerFromId(id)
    print(xPlayer.getMeta('Cuffed', 'is'))
    print(xPlayer.getMeta('Cuffed', 'item'))
    print(xPlayer.getMeta('Cuffed', 'type'))
    print(json.encode(xPlayer.getMeta(),{indent=true}))
    data = xPlayer.getMeta('Cuffed')
    return data
end)

RegisterNetEvent('hrzns_police:setMeta', function(data)
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.setMeta(data.key, data.value)
end)

RegisterNetEvent('hrzns_police:deleteObject', function(object)
    DeleteObject(object)
end)


RegisterNetEvent('hrzns_police:SNotify', function(id, info, title, msg)
    TriggerClientEvent('hrzns_police:Notify', id, info, title, msg)
end)

RegisterNetEvent('hrzns_police:CreateObject', function(Model, coords)
    RequestModel(GetHashKey(model))
    while not HasModelLoaded(GetHashKey(model)) do
        Wait(0)
    end
    local obj = CreateObject(GetHashKey(model), GetEntityCoords(PlayerPedId()), true, false, true)
end)

RegisterNetEvent('ec', function(id)
    if id == nil then
        id = source
    end
    local ped = GetPlayerPed(id)
    ClearPedTasks(ped)
end)



RegisterNetEvent('hrzns_police:clearcuffs', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.setMeta('Cuffed', {is = false, item = 'nocuff', type = 'soft'})
end)


RegisterNetEvent('hrzns_police:capturePlayer', function(id, item, hard, count, heading, loc, coords)
    local susPed = GetPlayerPed(id)
    local _source = source
    local playerPed = GetPlayerPed(_source)
    local x, y, z   = table.unpack(coords + loc * 1.0)

    -- Set Suspect coords
    SetEntityCoords(susPed, x, y, z)
    SetEntityHeading(susPed, heading)
    Wait(100)

    local model
    if item == 'cuffs' then
        model = 'p_cs_cuffs_02_s'
    elseif item == 'zip' then
        model = 'ba_prop_battle_cuffs'
    end

    lib.callback('hrzns_police:hasPropLoaded', id, function(data)
        if data == true then
            local ped = GetPlayerPed(id)
            local obj = CreateObject(model, x, y, z, true, true, false)
            TriggerClientEvent('hrzns_police:getArrested', id, _source, item, hard, count, obj)
            TriggerClientEvent('hrzns_police:ArrestSuspect', _source)
        end
    end, model)
end)

RegisterNetEvent('hrzns_police:UnCuffPlayer', function(id, heading, loc, coords, item, remaincuffed, count, deletecuffs, obj)
    local _source = source
    local playerPed = GetPlayerPed(_source)
    local susPed = GetPlayerPed(id)
    local x, y, z   = table.unpack(coords + loc * 1.0)

    -- Set Suspect coords
    SetEntityCoords(susPed, x, y, z)
    SetEntityHeading(susPed, heading)
    Wait(100)

    if count > 0 then
        TriggerEvent('hrzns_police:AddItems', _source, item, count)
    end

    TriggerClientEvent('hrzns_police:UncuffSuspect', _source)
    TriggerClientEvent('hrzns_police:getUncuffed', id, item, remaincuffed)

    if deletecuffs then
        DeleteObject(obj)
    end
end)





-- RegisterNetEvent('hrzns_police:oldCuffPlayer', function(id, heading, loc, coords, item, cuffhard)
-- 	local playerPed = GetPlayerPed(id)
--     local _source = source
--     print(_source, id)
--     lib.callback('hrzns_police:GetCuffs', id, function(data)
--         print(data)
--         if data ~= 'nocuff' then
--             lib.callback('hrzns_police:GetCuffType', id, function(data)
--                 if data ~= 'hard' then
--                     local x, y, z   = table.unpack(coords + loc * 1.0)
--                     SetEntityCoords(playerPed, x, y, z)
--                     SetEntityHeading(playerPed, heading)
--                     Wait(100)
--                     TriggerClientEvent('hrzns_police:Notify', _source, 'success', 'They are restained')
--                     TriggerClientEvent('hrzns_police:cuffed', id, _source, item, 'hard')
--                     print(_source, id)
--                     TriggerClientEvent('hrzns_police:arrest', _source)
--                 else
--                     TriggerClientEvent('hrzns_police:Notify', _source, 'error', 'They are hard cuffed')
--                 end
--             end)
--         else
--             local x, y, z   = table.unpack(coords + loc * 1.0)
--             SetEntityCoords(playerPed, x, y, z)
--             SetEntityHeading(playerPed, heading)
--             Wait(100)
--             TriggerClientEvent('hrzns_police:Notify', _source, 'success', 'They are restained')
--             TriggerClientEvent('hrzns_police:cuffed', id, _source, item, cuffhard)
--             print(_source, id)
--             TriggerClientEvent('hrzns_police:arrest', _source)
--         end
--     end)
-- end)

-- RegisterNetEvent('hrzns_police:UncuffPlayer', function(id, item)
--     local cuffs
--     local _source = source
--     lib.callback('hrzns_police:GetCuffs', id, function(data)
--         if data == 'nocuff' then
--             TriggerClientEvent('hrzns_police:Notify', source, 'error', 'They are not restained')
            
--         else
--             cuffs = data
--             lib.callback('hrzns_police:GetCuffType', id, function(data)
--                 if item == 'cutters' and data ~= 'hard' then
--                     TriggerClientEvent('hrzns_police:Notify', _source, 'error', 'They are not hard cuffed')
                    
--                 else
--                     TriggerClientEvent('hrzns_police:uncufftest', _source, id, item)
--                 end
--             end)
--         end
--     end)
-- end)

-- RegisterNetEvent('hrzns_police:UnCuff', function(id, item)
--     print(source, id)
--     TriggerClientEvent('hrzns_police:uncuffed', id, item)
--     TriggerClientEvent('hrzns_police:arrest', source, 'uncuff')
-- end)

-- RegisterNetEvent('hrzns_police:GetCuffs', function(id)
--     local cuffs
--     local _source = source
--     lib.callback('hrzns_police:GetCuffs', id, function(data)
--         if data == 'nocuff' then
--             print('data is '..data)
--             TriggerClientEvent('hrzns_police:Notify', source, 'error', 'Police', 'They are not restained')
--         else
--             return data
--         end
--     end)
--     print(cuffs)
--     return cuffs
-- end)
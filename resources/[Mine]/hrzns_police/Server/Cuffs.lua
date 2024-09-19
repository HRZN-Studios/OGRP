
RegisterNetEvent('near', function(coords ,source)
    local near = lib.getClosestPlayer(coords, 5, true)
    print(near)
end)

RegisterNetEvent('hrzns_police:CuffPlayer', function(id, heading, loc, coords, item, cuffhard)
	local playerPed = GetPlayerPed(id)
    local _source = source
    print(_source, id)
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
            print(_source, id)
            TriggerClientEvent('hrzns_police:arrest', _source)
        end
    end)
end)

RegisterNetEvent('hrzns_police:UncuffPlayer', function(id, item)
    local cuffs
    local _source = source
    lib.callback('hrzns_police:GetCuffs', id, function(data)
        if data == 'nocuff' then
            TriggerClientEvent('hrzns_police:Notify', source, 'error', 'They are not restained')
            
        else
            cuffs = data
            lib.callback('hrzns_police:GetCuffType', id, function(data)
                if item == 'cutters' and data ~= 'hard' then
                    TriggerClientEvent('hrzns_police:Notify', _source, 'error', 'They are not hard cuffed')
                    
                else
                    TriggerClientEvent('hrzns_police:uncufftest', _source, id, item)
                end
            end)
        end
    end)
end)

RegisterNetEvent('hrzns_police:UnCuff', function(id, item)
    print(source, id)
    TriggerClientEvent('hrzns_police:uncuffed', id, item)
    TriggerClientEvent('hrzns_police:arrest', source, 'uncuff')
end)

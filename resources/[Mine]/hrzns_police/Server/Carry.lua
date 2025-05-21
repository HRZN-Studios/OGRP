
RegisterNetEvent('hrzns_police:Carry', function(id, ped, kind)
    TriggerClientEvent('hrzns_police:Carrier', source, id, kind)
    TriggerClientEvent('hrzns_police:GetCarried', id, ped, kind, source)
end)

RegisterNetEvent('hrzns_police:TacklePlayer', function(id, kind)
    if kind == 'carried' then
        TriggerClientEvent('hrzns_police:GetTackled', id)
    else
        TriggerClientEvent('hrzns_police:Tackle', source)
        TriggerClientEvent('hrzns_police:GetTackled', id)
    end
end)

RegisterNetEvent('hrzns_police:Detach', function(id, thing)
    if thing == 'carrier' then
        TriggerClientEvent('hrzns_police:Detach', id)
    else
        TriggerClientEvent('hrzns_police:Drop', id)
    end
end)

RegisterNetEvent('hrzns_police:piv', function(id, vehicle, seat)
    TriggerClientEvent('hrzns_police:giv', id, vehicle, seat)
end)

RegisterNetEvent('hrzns_police:tov', function(id, vehicle)
    print(id..' '..vehicle)
    TriggerClientEvent('hrzns_police:gov', id, vehicle)
end)
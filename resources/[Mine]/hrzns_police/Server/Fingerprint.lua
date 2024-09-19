
RegisterNetEvent('hrzns_police:fingerPrint', function(id)
    if Config.Framework == 'QBCore' then

    elseif Config.Framework == 'ESX' then
        local xPlayer = ESX.GetPlayerFromId(id)
        TriggerClientEvent('hrzns_police:Notify', source , 'success', 'Police', 'Suspect is '..xPlayer.getName())
    end
end)

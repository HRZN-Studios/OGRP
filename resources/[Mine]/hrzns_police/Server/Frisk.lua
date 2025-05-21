
RegisterNetEvent('hrzns_police:FriskPlayer', function(id)
    local _source = source
    TriggerClientEvent('hrzns_police:Notify', id, 'info', 'Police', 'You are being frisked!')
    lib.callback('hrzns_police:GetItems', id, function(guns)
        if guns == true then
            TriggerClientEvent('hrzns_police:Notify', _source, 'success', 'Police', 'You feel something suspicious!')
        else
            TriggerClientEvent('hrzns_police:Notify', _source, 'error', 'Police', 'You feel nothing suspicious.')
        end
    end)

end)


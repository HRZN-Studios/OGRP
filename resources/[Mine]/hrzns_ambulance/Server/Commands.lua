
lib.addCommand('revive', {
    help = 'Revives a player',
    params = {
        {
            name = 'id',
            help = 'Player ID',
            optional = true,
        },
    },
    restricted = false
}, function(source, args, raw)
    local id = args.id
    if id == nil then
        id = source
    end
    TriggerClientEvent('hrzns_ambulance:revive', id)
end)

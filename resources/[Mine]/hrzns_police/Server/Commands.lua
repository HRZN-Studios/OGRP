
local carrycmd = lib.addCommand('carry', {
    help = 'Carry a Player',
    params = {
        {
            name = 'kind',
            type = 'string',
            help = 'The kind of carrying (carry or escort)',
            optional = true,
        },
    },
}, function(source, args, raw)
    print('carry command')
    if args.kind == nil then
        var = 'carry'
    else
        var = args.kind
    end
    TriggerEvent('hrzns_police:Carry', nil, var)
end)


lib.addCommand('cuff', {
    help = 'Cuff a player',
    params = {
        {
            name = 'id',
            type = 'number',
            help = 'The Player ID',
            optional = true,
        },
        {
            name = 'cuff',
            type = 'string',
            help = 'Item for cuffing (cuffs or zip)',
            optional = true,
        },
        {
            name = 'hard',
            type = 'sting',
            help = 'Type of cuffing (hard or soft)',
            optional = true,
        },
    },
    restricted = Config.CuffJob
}, function(source, args, raw)
    print('cuff command')
    if args.cuff == nil then
        item = 'cuffs'
    else
        item = args.cuff
    end
    if args.hard == nil then
        hard = Config.CuffItemBehavior
    else
        hard = args.hard
    end
    CuffPlayer(args.id, item, hard)
end)

lib.addCommand('uncuff', {
    help = 'Cuff a player',
    params = {
        {
            name = 'id',
            type = 'number',
            help = 'The Player ID',
            optional = true,
        },
        {
            name = 'hard',
            type = 'sting',
            help = 'Type of uncuffing (hard or soft)',
            optional = true,
        },
    },
}, function(source, args, raw)
    print('uncuff command')
    if args.hard == nil then
        hard = 'hard'
    else
        hard = args.hard
    end
    UncuffPlayer(args.id, item, hard)
end)


-- old code


-- RegisterCommand('carry', function(source, args, rawCommand)
--     if InAnim then
--         TriggerEvent('hrzns_police:Carry', CarriedId)
--     else
--         if args[1] == nil then
--             var = 'carry'
--         else
--             var = args[1]
--         end
--         TriggerEvent('hrzns_police:Carry', args[2], var)
--     end
-- end, false)


-- debug


RegisterCommand('ecdebug', function(source, args, rawCommand)
    local ped = GetPlayerPed(args[1])
    ClearPedTasks(ped)
end, false)


RegisterCommand('friskdebug', function()
    TriggerEvent('hrzns_police:frisk', 1)
end)


RegisterCommand('clearcuffs', function(raw)
    TriggerServerEvent('hrzns_police:clearcuffs')
end)


RegisterCommand('prop', function()
    createProp('prop_mp_cone_02')
end)
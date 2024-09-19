
exports('handcuffs', function(data, slot)
    local cuffs
    if Config.CuffItemBehavior == 'hard' then
        cuffs = true
    else
        cuffs = false
    end
    CuffPlayer(nil, 'cuffs', cuffs)
end)


exports('zipties', function(data, slot)
    local cuffs
    if Config.CuffItemBehavior == 'hard' then
        cuffs = true
    else
        cuffs = false
    end
    CuffPlayer(nil, 'zip', cuffs)
end)


exports('cuffkey', function(data, slot)
    UnCuff(nil, 'cuffkey')
end)

exports('pliers', function(data, slot)
    CuffPlayer(nil, 'zip', 'pliers')
end)

exports('hmkey', function(data, slot)
    CuffPlayer(nil, 'zip', 'hmkey')
end)

exports('cutters', function(data, slot)
    CuffPlayer(nil, 'zip', 'cutters')
end)
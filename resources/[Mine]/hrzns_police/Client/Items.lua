
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

exports('fingerkit', function(data, slot)
    Fingerprint()
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

exports('cone', function(data, slot)
    createProp('prop_mp_cone_02')
end)

exports('pd_barrier', function(data, slot)
    createProp('prop_barrier_work05')
end)

exports('barrier', function(data, slot)
    createProp('prop_barrier_work06a')
end)
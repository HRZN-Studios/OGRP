local show = false

lib.callback.register('hrzns_police:GetItems', function()
    local guns
    for _,v in pairs(Config.Guns) do
        local count = exports.ox_inventory:Search('count', v)
        if count > 0 then
            guns = true
            return guns
        end
    end

    guns = false
    return guns
end)


RegisterNetEvent('hrzns_police:frisk', function(id)
    lib.callback('hrzns_police:GetPlayerData', false, function(data)
        for _, v in pairs(Config.FriskJob) do
            if data.job.name == v or Config.FriskJob == 'any' then
                if id == nil then
                    local coords = GetEntityCoords(PlayerPedId())
                    local closestPlayer = GetPlayerServerId(lib.getClosestPlayer(coords))
                    print(closestPlayer)
                    if closestPlayer == nil then
                        lib.notify({
                            title = 'General',
                            description = 'No player nearby',
                            type = 'error'
                        })
                    else
                        local id = closestPlayer
                        TriggerServerEvent('hrzns_police:FriskPlayer', id)
                    end
                else
                    TriggerServerEvent('hrzns_police:FriskPlayer', id)
                end
            else
                lib.notify({
                    title = 'Police',
                    description = 'Not allowed to frisk',
                    type = 'error'
                })
            end
        end
    end)
end)

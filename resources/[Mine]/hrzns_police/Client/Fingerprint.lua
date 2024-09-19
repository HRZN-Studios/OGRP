function Fingerprint()
    local player = lib.getClosestPlayer(GetEntityCoords(PlayerPedId()), 3, false)
    if player == nil then
        lib.notify({
            title = 'Police',
            description = 'No player nearby',
            type = 'error'
        })
    else
        local id = GetPlayerServerId(player)
        TriggerServerEvent('hrzns_police:fingerPrint', id)
    end
end

for _, v in pairs(Config.Fingerprints.locs) do
    if Config.Fingerprints.enabled == true then
        exports.ox_target:addBoxZone({
            coords = v.coords,
            size = v.size,
            rotation = v.rotation,
            debug = v.debug,
            groups = {
                v.groups,
            },
            options = {
                {
                    icon = "fa-solid fa-user",
                    label = 'Take Fingerprint',
                    distance = 2,
                    onSelect = function()
                        Fingerprint()
                    end
                },
            }
        })
    end
end
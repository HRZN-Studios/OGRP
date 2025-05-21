RegisterNetEvent('hrzns_police:fingerPrint', function(id)
    Fingerprint(id)
end)

function Fingerprint(id)
    lib.callback('hrzns_police:GetPlayerData', false, function(data)
        for _, v in pairs(Config.FingerJob) do
            if data.job.name == v or Config.FingerJob == 'any' then
                if id == nil then
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
                else
                    if Config.FingerprintAnywhere == false then
                        for _, v in pairs(Config.Fingerprints.locs) do
                            local suscoords = GetEntityCoords(GetPlayerPed(player))
                            local distance = Vdist(suscoords, Config.Fingerprints.locs[_].coords)
                            if distance <= Config.Fingerprints.distance then
                                TriggerServerEvent('hrzns_police:fingerPrint', id)                            
                            end
                        end
                    else
                        TriggerServerEvent('hrzns_police:fingerPrint', id)
                    end
                end
            else
                lib.notify({
                    title = 'Police',
                    description = 'Not allowed to search',
                    type = 'error'
                })
            end
        end
    end)
end

for _, v in pairs(Config.Fingerprints.locs) do
    if Config.Fingerprints.enabled == true then
        exports.ox_target:addBoxZone({
            coords = v.coords,
            size = v.size,
            rotation = v.rotation,
            debug = v.debug,
            groups = Config.FingerJob,
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
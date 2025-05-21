IsCuffed = false
IsHardcuffed = false

cuffitem = nil
cuffObject = nil

local mycount = 0




function CuffPlayer(id, item, hard)
    if id == nil then
        local coords = GetEntityCoords(PlayerPedId())
        local closestPlayer = GetPlayerServerId(lib.getClosestPlayer(coords))
        id = closestPlayer
        print(closestPlayer)
        print(id)
        if closestPlayer == nil then
            lib.notify({
                title = 'General',
                description = 'No player nearby',
                type = 'error'
            })
        else
            local id = closestPlayer
            print(id)
            lib.callback('hrzns_police:GetPlayerMeta', false, function(data)
                print(json.encode(data))
                if data.cuffs == 'nocuff' then
                    if item == 'Cuffs' then
                        PlaceCuffs(id, hard, data)
                    else
                        PlaceZip(id, hard, data)
                    end
                elseif item == 'zip' and data.item == 'cuffs' then
                    TriggerEvent('hrzns_police:Notify', 'error', 'Police', 'Suspect is already Cuffed')
                elseif item == 'cuffs' and data.item == 'zip' then
                    TriggerEvent('hrzns_police:Notify', 'error', 'Police', 'Suspect is already Ziptied')
                else
                    if item == 'Cuffs' then
                        PlaceCuffs(id, hard, data)
                    else
                        PlaceZip(id, hard, data)
                    end
                end
            end, id)
        end
    else
        lib.callback('hrzns_police:GetPlayerMeta', false, function(data)
            print(json.encode(data))
            if data.cuffs == 'nocuff' then
                if item == 'Cuffs' then
                    PlaceCuffs(id, hard, data)
                else
                    PlaceZip(id, hard, data)
                end
            elseif item == 'zip' and data.item == 'cuffs' then
                TriggerEvent('hrzns_police:Notify', 'error', 'Police', 'Suspect is already Cuffed')
            elseif item == 'cuffs' and data.item == 'zip' then
                TriggerEvent('hrzns_police:Notify', 'error', 'Police', 'Suspect is already Ziptied')
            else
                if item == 'Cuffs' then
                    PlaceCuffs(id, hard, data)
                else
                    PlaceZip(id, hard, data)
                end
            end
        end, id)
    end
end

function PlaceCuffs(id, hard, data)
    if hard == 'hard' then
        if data.type == 'hard' and data.item ~= 'nocuff' then
            TriggerEvent('hrzns_police:Notify', 'error', 'Police', 'Suspect is already Cuffed')
        elseif data.type == 'soft' and data.item ~= 'nocuff' then
            if Config.CuffsAsItems then
                local count = exports.ox_inventory:Search('count', 'cuffs')
                if count >= 1 then
                    CapturePlayer(id, 'cuffs', hard, 1)
                else
                    lib.notify({
                        title = 'Police',
                        description = 'Need the tools lol',
                        type = 'error'
                    })
                end
            else
                CapturePlayer(id, 'cuffs', hard)
            end
        else
            if Config.CuffsAsItems then
                local count = exports.ox_inventory:Search('count', 'cuffs')
                if count >= 2 then
                    CapturePlayer(id, 'cuffs', hard, 2)
                else
                    lib.notify({
                        title = 'Police',
                        description = 'Need the tools lol',
                        type = 'error'
                    })
                end
            else
                CapturePlayer(id, 'cuffs', hard)
            end
        end
    elseif hard == 'soft' then
        if data.type == 'hard' and data.item ~= 'nocuff' then
            TriggerEvent('hrzns_police:Notify', 'error', 'Police', 'Suspect is already Hardcuffed')
        elseif data.type == 'soft' and data.item ~= 'nocuff' then
            if Config.twoCuffed then
                if Config.CuffsAsItems then
                    local count = exports.ox_inventory:Search('count', 'cuffs')
                    if count >= 1 then
                        hard = 'hard'
                        CapturePlayer(id, 'cuffs', hard, 1)
                    else
                        lib.notify({
                            title = 'Police',
                            description = 'Need the tools lol',
                            type = 'error'
                        })
                    end
                else
                    hard = 'hard'
                    CapturePlayer(id, 'cuffs', hard)
                end
            else
                TriggerEvent('hrzns_police:Notify', 'error', 'Police', 'Suspect is already Cuffed')
            end
        else
            if Config.CuffsAsItems then
                local count = exports.ox_inventory:Search('count', 'cuffs')
                if count >= 1 then
                    CapturePlayer(id, 'cuffs', hard, 1)
                else
                    lib.notify({
                        title = 'Police',
                        description = 'Need the tools lol',
                        type = 'error'
                    })
                end
            else
                CapturePlayer(id, 'cuffs', hard)
            end
        end
    end
end


function PlaceZip(id, hard, data)
    if hard == 'hard' then
        if data.type == 'hard' and data.item ~= 'nocuff' then
            -- Is already HardCuffed
        elseif data.type == 'soft' and data.item ~= 'nocuff' then
            if Config.CuffsAsItems then
                local count = exports.ox_inventory:Search('count', 'zip')
                if count >= 1 then
                    CapturePlayer(id, 'zip', hard, 1)
                else
                    lib.notify({
                        title = 'Police',
                        description = 'Need the tools lol',
                        type = 'error'
                    })
                end
            else
                CapturePlayer(id, 'zip', hard)
            end
        else
            if Config.CuffsAsItems then
                local count = exports.ox_inventory:Search('count', 'cuffs')
                if count >= 2 then
                    CapturePlayer(id, 'zip', hard, 2)
                else
                    lib.notify({
                        title = 'Police',
                        description = 'Need the tools lol',
                        type = 'error'
                    })
                end
            else
                CapturePlayer(id, 'zip', hard)
            end
        end
    elseif hard == 'soft' then
        if data.type == 'hard' and data.item ~= 'nocuff' then
            TriggerEvent('hrzns_police:Notify', 'error', 'Police', 'Suspect is already Hardziptied')
        elseif data.type == 'soft' and data.item ~= 'nocuff' then
            if Config.twoCuffed then
                if Config.CuffsAsItems then
                    local count = exports.ox_inventory:Search('count', 'zip')
                    if count >= 1 then
                        hard = 'hard'
                        CapturePlayer(id, 'zip', hard, 1)
                    else
                        lib.notify({
                            title = 'Police',
                            description = 'Need the tools lol',
                            type = 'error'
                        })
                    end
                else
                    hard = 'hard'
                    CapturePlayer(id, 'zip', hard)
                end
            else
                TriggerEvent('hrzns_police:Notify', 'error', 'Police', 'Suspect is already Ziptied')
            end
        else
            if Config.CuffsAsItems then
                local count = exports.ox_inventory:Search('count', 'zip')
                if count >= 1 then
                    CapturePlayer(id, 'zip', hard, 1)
                else
                    lib.notify({
                        title = 'Police',
                        description = 'Need the tools lol',
                        type = 'error'
                    })
                end
            else
                CapturePlayer(id, 'zip', hard)
            end
        end
    end
end

function CapturePlayer(id, item, hard, count)
    local heading = GetEntityHeading(PlayerPedId())
    local loc = GetEntityForwardVector(PlayerPedId())
    local coords = GetEntityCoords(PlayerPedId())
    if count == nil then
        count = 0
    end
    TriggerServerEvent('hrzns_police:capturePlayer', id, item, hard, count, heading, loc, coords)
end

RegisterNetEvent('hrzns_police:getArrested', function(cufferid, item, hard, count, obj)
    Animation('mp_arrest_paired', 'crook_p2_back_right', 8.0, -8, 3750 , 2)
    -- Wait(1000)
    if mycount >= Config.MaxCuffs then
        mycount = 0
        Wait(1000)
        if Config.CuffsAsItems then
            if item == 'cuffs' then
                TriggerServerEvent('hrzns_police:RemoveItems', cufferid, 'cuffs', count)
            elseif item == 'zip' then
                TriggerServerEvent('hrzns_police:RemoveItems', cufferid, 'zip', count)
            else
                print('Error: No item sent to Event: hrzns_police:getArrested Line 224')
            end
        end
        local data = {key = 'Cuffed', value = {is = true, item = item, type = hard}}
        TriggerServerEvent('hrzns_police:setMeta', data)
        ImCuffed(obj, item, hard)
    else
        local success = lib.skillCheck({'hard'}, {'e'})
        if success then
            mycount = mycount + 1
            Wait(500)
            TriggerServerEvent('ec')
            TriggerServerEvent('hrzns_police:SNotify', cufferid, 'error', 'Police', 'Suspect broke Cuffs!')
        else
            mycount = 0
            if Config.CuffsAsItems then
                if item == 'cuffs' then
                    TriggerServerEvent('hrzns_police:RemoveItems', cufferid, 'cuffs', count)
                elseif item == 'zip' then
                    TriggerServerEvent('hrzns_police:RemoveItems', cufferid, 'zip', count)
                else
                    print('Error: No item sent to Event: hrzns_police:getArrested Line 224')
                end
            end
            ImCuffed(obj, item, hard)
        end
    end 
end)

RegisterNetEvent('hrzns_police:ArrestSuspect', function()
    Animation('mp_arrest_paired', 'cop_p2_back_right', 8.0, -8, 3750 , 2)
end)

function ImCuffed(object, item, hard)
    IsCuffed = true
    if hard == 'hard' then
        IsHardCuffed = true
    end
    cuffObject = object
    AttachEntityToEntity(object, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 60309), -0.055, 0.06, 0.04, 265.0, 155.0, 80.0, true, false, false, false, 0, true)
    invstatus(true)
    CreateThread(function()
        while IsCuffed do
            Wait(1)
            DisableControlAction(0, 24, true) -- Attack
            DisableControlAction(0, 257, true) -- Attack 2
            DisableControlAction(0, 25, true) -- Aim
            DisableControlAction(0, 263, true) -- Melee Attack 1
            DisableControlAction(0, 45, true) -- Reload
            DisableControlAction(0, 22, true) -- Jump
            DisableControlAction(0, 44, true) -- Cover
            DisableControlAction(0, 37, true) -- Select Weapon
            DisableControlAction(0, 288, true) -- Phone
            DisableControlAction(0, 170, true) -- Animations
            DisableControlAction(0, 167, true) -- Job
            DisableControlAction(0, 73, true) -- Clearing animation
            DisableControlAction(2, 199, true) -- Pause screen
            DisableControlAction(0, 59, true) -- Steering in vehicle
            DisableControlAction(2, 36, true) -- Stealth
            DisableControlAction(0, 47, true)  -- Weapon
            DisableControlAction(0, 257, true) -- Melee
            DisableControlAction(0, 140, true) -- Melee
            DisableControlAction(0, 264, true) -- Melee
            DisableControlAction(0, 141, true) -- Melee
            DisableControlAction(0, 142, true) -- Melee
            DisableControlAction(0, 143, true) -- Melee
            if IsHardcuffed then
                DisableControlAction(0, 32, true) -- W
                DisableControlAction(0, 34, true) -- A
                DisableControlAction(0, 31, true) -- S 
                DisableControlAction(0, 30, true) -- D 
            end
            if IsEntityPlayingAnim(PlayerPedId(), 'mp_arresting', 'idle', 3) ~= 1 then
                if isDead == true then
                    ClearPedSecondaryTask(PlayerPedId())
                else
                    loadAnimDict('mp_arresting')
                    TaskPlayAnim(PlayerPedId(), 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0.0, false, false, false)
                end
            end
        end
    end)
end

function UncuffPlayer(id, item, hard)
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
            lib.callback('hrzns_police:GetPlayerMeta', false, function(data)
                if Config.CuffsAsItems then
                    if data.cuffs == 'nocuff' then
                        TriggerEvent('hrzns_police:Notify', 'error', 'Police', 'Suspect is not Cuffed')
                    elseif data.type == 'hard' and data.cuffs == 'cuffs' then
                        if hard == 'hard' and Config.Unshacklefirst then
                            if item == 'cuffkey' then
                                UnCuff(id, item, 'soft', data, false)
                            elseif item == 'hmkey' then
                                UnCuff(id, item, 'soft', data, true)
                            elseif item == 'pliers' then
                                TriggerEvent('hrzns_police:Notify', 'error', 'Police', 'Cant use pliers on cuffs')
                            elseif item == 'cutters' then
                                UnCuff(id, item, 'soft', data, true)
                            end
                        elseif hard == 'hard' and Config.Unshackle == false then
                            if item == 'cuffkey' then
                                UnCuff(id, item, hard, data, false)
                            elseif item == 'hmkey' then
                                UnCuff(id, item, hard, data, true)
                            elseif item == 'pliers' then
                                TriggerEvent('hrzns_police:Notify', 'error', 'Police', 'Cant use pliers on cuffs')
                            elseif item == 'cutters' then
                                UnCuff(id, item, 'soft', data, true)
                            end
                        elseif hard == 'soft' then
                            if item == 'cuffkey' then
                                UnCuff(id, item, hard, data, false)
                            elseif item == 'hmkey' then
                                UnCuff(id, item, hard, data, true)
                            elseif item == 'pliers' then
                                TriggerEvent('hrzns_police:Notify', 'error', 'Police', 'Cant use pliers on cuffs')
                            elseif item == 'cutters' then
                                UnCuff(id, item, 'soft', data, true)
                            end
                        end
                    elseif data.type == 'soft' and data.cuffs == 'cuffs' then
                        if item == 'cuffkey' then
                            UnCuff(id, item, hard, data, false)
                        elseif item == 'hmkey' then
                            UnCuff(id, item, hard, data, true)
                        elseif item == 'pliers' then
                            TriggerEvent('hrzns_police:Notify', 'error', 'Police', 'Cant use pliers on cuffs')
                        elseif item == 'cutters' then
                            UnCuff(id, item, 'soft', data, true)
                        end
                    elseif data.type == 'hard' and data.cuffs == 'zip' then
                        if hard == 'hard' and Config.Unshacklefirst then
                            if item == 'cuffkey' then
                                TriggerEvent('hrzns_police:Notify', 'error', 'Police', 'Cant use cuffkey on zipties')
                            elseif item == 'hmkey' then
                                TriggerEvent('hrzns_police:Notify', 'error', 'Police', 'Cant use handmade key on zipties')
                            elseif item == 'pliers' then
                                UnCuff(id, item, 'soft', data, false)
                            elseif item == 'cutters' then
                                UnCuff(id, item, 'soft', data, true)
                            end
                        elseif hard == 'hard' and Config.Unshackle == false then
                            if item == 'cuffkey' then
                                TriggerEvent('hrzns_police:Notify', 'error', 'Police', 'Cant use cuffkey on zipties')
                            elseif item == 'hmkey' then
                                TriggerEvent('hrzns_police:Notify', 'error', 'Police', 'Cant use handmade key on zipties')
                            elseif item == 'pliers' then
                                UnCuff(id, item, hard, data, false)
                            elseif item == 'cutters' then
                                UnCuff(id, item, 'soft', data, true)
                            end
                        elseif hard == 'soft' then
                            if item == 'cuffkey' then
                                TriggerEvent('hrzns_police:Notify', 'error', 'Police', 'Cant use cuffkey on zipties')
                            elseif item == 'hmkey' then
                                TriggerEvent('hrzns_police:Notify', 'error', 'Police', 'Cant use handmade key on zipties')
                            elseif item == 'pliers' then
                                UnCuff(id, item, hard, data, false)
                            elseif item == 'cutters' then
                                UnCuff(id, item, 'soft', data, true)
                            end
                        end
                    elseif data.type == 'soft' and data.cuffs == 'zip' then
                        if item == 'cuffkey' then
                            TriggerEvent('hrzns_police:Notify', 'error', 'Police', 'Cant use cuffkey on zipties')
                        elseif item == 'hmkey' then
                            TriggerEvent('hrzns_police:Notify', 'error', 'Police', 'Cant use handmade key on zipties')
                        elseif item == 'pliers' then
                            UnCuff(id, item, hard, data, false)
                        elseif item == 'cutters' then
                            UnCuff(id, item, 'soft', data, true)
                        end
                    end
                else
                    if data.cuffs == 'nocuff' then
                        TriggerEvent('hrzns_police:Notify', 'error', 'Police', 'Suspect is not Cuffed')
                    elseif data.type == 'hard' and data.cuffs == 'cuffs' then
                        if hard == 'hard' and Config.Unshacklefirst then
                            UnCuff(id, item, 'soft', data, false)
                        elseif hard == 'hard' and Config.Unshackle == false then
                            UnCuff(id, item, hard, data, false)
                        elseif hard == 'soft' then
                            UnCuff(id, item, hard, data, false)
                        end
                    elseif data.type == 'soft' and data.cuffs == 'cuffs' then
                        UnCuff(id, item, hard, data, false)
                    elseif data.type == 'hard' and data.cuffs == 'zip' then
                        if hard == 'hard' and Config.Unshacklefirst then
                            UnCuff(id, item, 'soft', data, false)
                        elseif hard == 'hard' and Config.Unshackle == false then
                            UnCuff(id, item, hard, data, false)
                        elseif hard == 'soft' then
                            UnCuff(id, item, hard, data, false)
                        end
                    elseif data.type == 'soft' and data.cuffs == 'zip' then
                        UnCuff(id, item, hard, data, false)
                    end
                end
            end)
        end
    else
        lib.callback('hrzns_police:GetPlayerMeta', false, function(data)
            if Config.CuffsAsItems then
                if data.cuffs == 'nocuff' then
                    TriggerEvent('hrzns_police:Notify', 'error', 'Police', 'Suspect is not Cuffed')
                elseif data.type == 'hard' and data.cuffs == 'cuffs' then
                    if hard == 'hard' and Config.Unshacklefirst then
                        if item == 'cuffkey' then
                            UnCuff(id, item, 'soft', data, false)
                        elseif item == 'hmkey' then
                            UnCuff(id, item, 'soft', data, true)
                        elseif item == 'pliers' then
                            TriggerEvent('hrzns_police:Notify', 'error', 'Police', 'Cant use pliers on cuffs')
                        elseif item == 'cutters' then
                            UnCuff(id, item, 'soft', data, true)
                        end
                    elseif hard == 'hard' and Config.Unshackle == false then
                        if item == 'cuffkey' then
                            UnCuff(id, item, hard, data, false)
                        elseif item == 'hmkey' then
                            UnCuff(id, item, hard, data, true)
                        elseif item == 'pliers' then
                            TriggerEvent('hrzns_police:Notify', 'error', 'Police', 'Cant use pliers on cuffs')
                        elseif item == 'cutters' then
                            UnCuff(id, item, 'soft', data, true)
                        end
                    elseif hard == 'soft' then
                        if item == 'cuffkey' then
                            UnCuff(id, item, hard, data, false)
                        elseif item == 'hmkey' then
                            UnCuff(id, item, hard, data, true)
                        elseif item == 'pliers' then
                            TriggerEvent('hrzns_police:Notify', 'error', 'Police', 'Cant use pliers on cuffs')
                        elseif item == 'cutters' then
                            UnCuff(id, item, 'soft', data, true)
                        end
                    end
                elseif data.type == 'soft' and data.cuffs == 'cuffs' then
                    if item == 'cuffkey' then
                        UnCuff(id, item, hard, data, false)
                    elseif item == 'hmkey' then
                        UnCuff(id, item, hard, data, true)
                    elseif item == 'pliers' then
                        TriggerEvent('hrzns_police:Notify', 'error', 'Police', 'Cant use pliers on cuffs')
                    elseif item == 'cutters' then
                        UnCuff(id, item, 'soft', data, true)
                    end
                elseif data.type == 'hard' and data.cuffs == 'zip' then
                    if hard == 'hard' and Config.Unshacklefirst then
                        if item == 'cuffkey' then
                            TriggerEvent('hrzns_police:Notify', 'error', 'Police', 'Cant use cuffkey on zipties')
                        elseif item == 'hmkey' then
                            TriggerEvent('hrzns_police:Notify', 'error', 'Police', 'Cant use handmade key on zipties')
                        elseif item == 'pliers' then
                            UnCuff(id, item, 'soft', data, false)
                        elseif item == 'cutters' then
                            UnCuff(id, item, 'soft', data, true)
                        end
                    elseif hard == 'hard' and Config.Unshackle == false then
                        if item == 'cuffkey' then
                            TriggerEvent('hrzns_police:Notify', 'error', 'Police', 'Cant use cuffkey on zipties')
                        elseif item == 'hmkey' then
                            TriggerEvent('hrzns_police:Notify', 'error', 'Police', 'Cant use handmade key on zipties')
                        elseif item == 'pliers' then
                            UnCuff(id, item, hard, data, false)
                        elseif item == 'cutters' then
                            UnCuff(id, item, 'soft', data, true)
                        end
                    elseif hard == 'soft' then
                        if item == 'cuffkey' then
                            TriggerEvent('hrzns_police:Notify', 'error', 'Police', 'Cant use cuffkey on zipties')
                        elseif item == 'hmkey' then
                            TriggerEvent('hrzns_police:Notify', 'error', 'Police', 'Cant use handmade key on zipties')
                        elseif item == 'pliers' then
                            UnCuff(id, item, hard, data, false)
                        elseif item == 'cutters' then
                            UnCuff(id, item, 'soft', data, true)
                        end
                    end
                elseif data.type == 'soft' and data.cuffs == 'zip' then
                    if item == 'cuffkey' then
                        TriggerEvent('hrzns_police:Notify', 'error', 'Police', 'Cant use cuffkey on zipties')
                    elseif item == 'hmkey' then
                        TriggerEvent('hrzns_police:Notify', 'error', 'Police', 'Cant use handmade key on zipties')
                    elseif item == 'pliers' then
                        UnCuff(id, item, hard, data, false)
                    elseif item == 'cutters' then
                        UnCuff(id, item, 'soft', data, true)
                    end
                end
            else
                if data.cuffs == 'nocuff' then
                    TriggerEvent('hrzns_police:Notify', 'error', 'Police', 'Suspect is not Cuffed')
                elseif data.type == 'hard' and data.cuffs == 'cuffs' then
                    if hard == 'hard' and Config.Unshacklefirst then
                        UnCuff(id, item, 'soft', data, false)
                    elseif hard == 'hard' and Config.Unshackle == false then
                        UnCuff(id, item, hard, data, false)
                    elseif hard == 'soft' then
                        UnCuff(id, item, hard, data, false)
                    end
                elseif data.type == 'soft' and data.cuffs == 'cuffs' then
                    UnCuff(id, item, hard, data, false)
                elseif data.type == 'hard' and data.cuffs == 'zip' then
                    if hard == 'hard' and Config.Unshacklefirst then
                        UnCuff(id, item, 'soft', data, false)
                    elseif hard == 'hard' and Config.Unshackle == false then
                        UnCuff(id, item, hard, data, false)
                    elseif hard == 'soft' then
                        UnCuff(id, item, hard, data, false)
                    end
                elseif data.type == 'soft' and data.cuffs == 'zip' then
                    UnCuff(id, item, hard, data, false)
                end
            end
        end)
    end
end

function UnCuff(id, item, hard, data, game)
    local heading = GetEntityHeading(PlayerPedId())
    local loc = GetEntityForwardVector(PlayerPedId())
    local coords = GetEntityCoords(PlayerPedId())
    local success = lib.skillCheck({'hard'}, {'e'})
    if game then
        if success then
            if hard == 'hard' then
                if data.type == 'hard' and data.cuff == 'cuffs' then
                    TriggerServerEvent('hrzns_police:UnCuffPlayer', id, heading, loc, coords, 'cuffs', false, 2, true, cuffObject)
                elseif data.type == 'soft' and data.cuff == 'cuffs' then
                    TriggerServerEvent('hrzns_police:UnCuffPlayer', id, heading, loc, coords, 'cuffs', false, 1, true, cuffObject)
                elseif data.cuff == 'zip' then
                    TriggerServerEvent('hrzns_police:UnCuffPlayer', id, heading, loc, coords, 'zip', false, 0, true, cuffObject)
                end
            elseif hard == 'soft' then
                if data.type == 'hard' and data.cuff == 'cuffs' then
                    TriggerServerEvent('hrzns_police:UnCuffPlayer', id, heading, loc, coords, 'cuffs', true, 1, false)
                elseif data.type == 'soft' and data.cuff == 'cuffs' then
                    TriggerServerEvent('hrzns_police:UnCuffPlayer', id, heading, loc, coords, 'cuffs', false, 1, true, cuffObject)
                elseif data.type == 'hard' and data.cuff == 'zip' then
                    TriggerServerEvent('hrzns_police:UnCuffPlayer', id, heading, loc, coords, 'zip', true, 0, false)
                elseif data.type == 'soft' and data.cuff == 'zip' then
                    TriggerServerEvent('hrzns_police:UnCuffPlayer', id, heading, loc, coords, 'zip', false, 0, true, cuffObject)
                end
            end
        else
            TriggerEvent('hrzns_police:Notify', id, 'error', 'Police', 'Failed to uncuff')
        end
    else
        if hard == 'hard' then
            if data.type == 'hard' and data.cuff == 'cuffs' then
                TriggerServerEvent('hrzns_police:UnCuffPlayer', id, heading, loc, coords, 'cuffs', false, 2, true, cuffObject)
            elseif data.type == 'soft' and data.cuff == 'cuffs' then
                TriggerServerEvent('hrzns_police:UnCuffPlayer', id, heading, loc, coords, 'cuffs', false, 1, true, cuffObject)
            elseif data.cuff == 'zip' then
                TriggerServerEvent('hrzns_police:UnCuffPlayer', id, heading, loc, coords, 'zip', false, 0, true, cuffObject)
            end
        elseif hard == 'soft' then
            if data.type == 'hard' and data.cuff == 'cuffs' then
                TriggerServerEvent('hrzns_police:UnCuffPlayer', id, heading, loc, coords, 'cuffs', true, 1, false)
            elseif data.type == 'soft' and data.cuff == 'cuffs' then
                TriggerServerEvent('hrzns_police:UnCuffPlayer', id, heading, loc, coords, 'cuffs', false, 1, true, cuffObject)
            elseif data.type == 'hard' and data.cuff == 'zip' then
                TriggerServerEvent('hrzns_police:UnCuffPlayer', id, heading, loc, coords, 'zip', true, 0, false)
            elseif data.type == 'soft' and data.cuff == 'zip' then
                TriggerServerEvent('hrzns_police:UnCuffPlayer', id, heading, loc, coords, 'zip', false, 0, true, cuffObject)
            end
        end
    end
end

RegisterNetEvent('hrzns_police:UncuffSuspect', function()
    Animation('mp_arresting', 'a_uncuff', 8.0, -8, -1, 2)
end)

RegisterNetEvent('hrzns_police:getUncuffed', function(item, remaincuffed)
    if remaincuffed then
        IsHardCuffed = false
        local data = {key = 'Cuffed', value = {is = true, item = item, type = 'soft'}}
        TriggerServerEvent('hrzns_police:setMeta', data)
    else
        IsCuffed = false
        if IsHardCuffed then
            IsHardCuffed = false
        end
        local data = {key = 'Cuffed', value = {is = true, item = 'nocuff', type = 'soft'}}
        TriggerServerEvent('hrzns_police:setMeta', data)
        invstatus(false)
    end
end)

-- RegisterNetEvent('hrzns_police:UnCuffed', function(id, hard, add, count)
--     if add then
--         TriggerServerEvent('hrzns_police:AddItems', id, 'cuffs', count)
--     end
--     if hard then
--         IsHardCuffed = false
--     else
--         TriggerServerEvent('ec')
--         TriggerServerEvent('hrzns_police:deleteObject', cuffObject)
--         cuffObject = nil
--         IsHardCuffed = false
--         IsCuffed = false
--     end
-- end)







-- RegisterCommand('oldcuff', function(raw, args)
--     local item
--     local cuffhard = false
--     if Config.CuffsAsItems then
--         if args[1] == 'cuffs' or args[1] == nil then
--             local count = exports.ox_inventory:Search('count', 'handcuffs')
--             if args[2] == 'hard' then
--                 cuffhard = true
--                 item = 'cuffs'
--                 if count > 1 then
--                     CuffPlayer(nil, item, cuffhard)
--                 else
--                     lib.notify({
--                         title = 'Police',
--                         description = 'Need the tools lol',
--                         type = 'error'
--                     })
--                 end
--             else
--                 item = 'cuffs'
--                 if count > 0 then
--                     CuffPlayer(nil, item, cuffhard)
--                 else
--                     lib.notify({
--                         title = 'Police',
--                         description = 'Need the tools lol',
--                         type = 'error'
--                     })
--                 end
--             end
--         elseif args[1] == 'zip' then
--             local count = exports.ox_inventory:Search('count', 'zipties')
--             if args[2] == 'hard' then
--                 cuffhard = true
--                 item = 'zip'
--                 if count > 1 then
--                     CuffPlayer(nil, item, cuffhard)
--                 else
--                     lib.notify({
--                         title = 'Police',
--                         description = 'Need the tools lol',
--                         type = 'error'
--                     })
--                 end
--             else
--                 item = 'zip'
--                 if count > 0 then
--                     CuffPlayer(nil, item, cuffhard)
--                 else
--                     lib.notify({
--                         title = 'Police',
--                         description = 'Need the tools lol',
--                         type = 'error'
--                     })
--                 end
--             end
--         end
--     else
--         lib.callback('hrzns_police:GetPlayerData', false, function(data)
--             for _, v in pairs(Config.CuffJob) do
--                 if data.job.name == v or Config.CuffJob == 'any' then
--                     if args[1] == nil or 'cuff' then
--                         item = 'cuffs'
--                     elseif args[1] == 'zip' then
--                         item = 'zip'
--                     end
--                     if args[2] == 'hard' then
--                         cuffhard = true
--                     end
--                     CuffPlayer(nil, item, cuffhard)
--                 else
--                     lib.notify({
--                         title = 'Police',
--                         description = 'Not a police officer',
--                         type = 'error'
--                     })
--                 end
--             end
--         end)
--     end
-- end)

-- RegisterNetEvent('hrzns_police:Cuff', function(id, item, cuffhard)
--     CuffPlayer(id, item, cuffhard)
-- end)

-- RegisterCommand('cufftest', function(raw, args)
--     getPlayerforCuff()
-- end)

-- function CuffPlayer(id, item, cuffhard)
--     print(id, item, cuffhard)
--     if id == nil then
--         local coords = GetEntityCoords(PlayerPedId())
--         local closestPlayer = GetPlayerServerId(lib.getClosestPlayer(coords))
--         print(closestPlayer)
--         if closestPlayer == nil then
--             lib.notify({
--                 title = 'General',
--                 description = 'No player nearby',
--                 type = 'error'
--             })
--         else
--             local id = closestPlayer
--             heading = GetEntityHeading(PlayerPedId())
--             loc = GetEntityForwardVector(PlayerPedId())
--             coords = GetEntityCoords(PlayerPedId())
--             if Config.CuffsAsItems then
--                 if cuffhard then
--                     if item == 'cuffs' then
--                         local count = exports.ox_inventory:Search('count', 'handcuffs')
--                         if count > 1 then
--                             TriggerServerEvent('hrzns_police:CuffPlayer', id, heading, loc, coords, item, cuffhard)
--                         end
--                     elseif item == 'zip' then
--                         local count = exports.ox_inventory:Search('count', 'zipties')
--                         if count > 1 then
--                             TriggerServerEvent('hrzns_police:CuffPlayer', id, heading, loc, coords, item, cuffhard)
--                         end
--                     end
--                 else
--                     if item == 'cuffs' then
--                         local count = exports.ox_inventory:Search('count', 'handcuffs')
--                         if count > 0 then
--                             TriggerServerEvent('hrzns_police:CuffPlayer', id, heading, loc, coords, item, cuffhard)
--                         end
--                     elseif item == 'zip' then
--                         local count = exports.ox_inventory:Search('count', 'zipties')
--                         if count > 0 then
--                             TriggerServerEvent('hrzns_police:CuffPlayer', id, heading, loc, coords, item, cuffhard)
--                         end
--                     end
--                 end
--             else
--                 TriggerServerEvent('hrzns_police:CuffPlayer', id, heading, loc, coords, item, cuffhard)
--             end
--         end
--     else
--         if Config.CuffsAsItems then
--             if cuffhard then
--                 if item == 'cuffs' then
--                     local count = exports.ox_inventory:Search('count', 'handcuffs')
--                     if count > 1 then
--                         TriggerServerEvent('hrzns_police:CuffPlayer', id, heading, loc, coords, item, cuffhard)
--                     end
--                 elseif item == 'zip' then
--                     local count = exports.ox_inventory:Search('count', 'zipties')
--                     if count > 1 then
--                         TriggerServerEvent('hrzns_police:CuffPlayer', id, heading, loc, coords, item, cuffhard)
--                     end
--                 end
--             else
--                 if item == 'cuffs' then
--                     local count = exports.ox_inventory:Search('count', 'handcuffs')
--                     if count > 0 then
--                         TriggerServerEvent('hrzns_police:CuffPlayer', id, heading, loc, coords, item, cuffhard)
--                     end
--                 elseif item == 'zip' then
--                     local count = exports.ox_inventory:Search('count', 'zipties')
--                     if count > 0 then
--                         TriggerServerEvent('hrzns_police:CuffPlayer', id, heading, loc, coords, item, cuffhard)
--                     end
--                 end
--             end
--         else
--             TriggerServerEvent('hrzns_police:CuffPlayer', id, heading, loc, coords, item, cuffhard)
--         end
--     end
-- end

-- RegisterNetEvent('hrzns_police:cuffed', function(id, cufftype, cuffhard)
--     Animation('mp_arrest_paired', 'crook_p2_back_right', 8.0, -8, 3750 , 2)
--     Wait(1000)
--     if mycount < Config.MaxCuffs then
--         print('minigame')
--        local success = lib.skillCheck({'hard'}, {'e'})
--        if success then
--             mycount = mycount + 1
--             Wait(500)
--             TriggerServerEvent('ec')
--             TriggerServerEvent('hrzns_police:SNotify', id, 'error', 'Police', 'Suspect broke Cuffs!')
--         else
--             mycount = 0
--             if Config.CuffsAsItems then
--                 if cuffhard then
--                     if cufftype == 'cuffs' then
--                         TriggerServerEvent('hrzns_police:RemoveItems', id, 'cuffs', 2)
--                     elseif cufftype == 'zip' then
--                         TriggerServerEvent('hrzns_police:RemoveItems', id, 'zip', 2)
--                     end
--                 else
--                     if cufftype == 'cuffs' then
--                         TriggerServerEvent('hrzns_police:RemoveItems', id, 'cuffs', 1)
--                     elseif cufftype == 'zip' then
--                         TriggerServerEvent('hrzns_police:RemoveItems', id, 'zip', 1)
--                     end
--                 end
--             end
--             ImCuffed(cufftype, cuffhard)
--         end
--     else
--         mycount = 0
--         Wait(3000)
--         if Config.CuffsAsItems then
--             if cuffhard then
--                 if cufftype == 'cuffs' then
--                     TriggerServerEvent('hrzns_police:RemoveItems', id, 'cuffs', 2)
--                 elseif cufftype == 'zip' then
--                     TriggerServerEvent('hrzns_police:RemoveItems', id, 'zip', 2)
--                 end
--             else
--                 if cufftype == 'cuffs' then
--                     TriggerServerEvent('hrzns_police:RemoveItems', id, 'cuffs', 1)
--                 elseif cufftype == 'zip' then
--                     TriggerServerEvent('hrzns_police:RemoveItems', id, 'zip', 1)
--                 end
--             end
--         end
--         ImCuffed(cufftype, cuffhard)
--     end
-- end)

-- function oldImCuffed(cufftype, cuffhard)
--     print(cufftype, cuffhard)
--     local coords = GetEntityCoords(PlayerPedId())
--     LoadModel('p_cs_cuffs_02_s')
--     LoadModel('ba_prop_battle_cuffs')
--     if cuffhard == 'hard' then
--         IsHardCuffed = true
--     end
--     if cufftype == 'cuffs' then
--         object = CreateObject('p_cs_cuffs_02_s',coords,true,false)
--         AttachEntityToEntity(object, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 60309), -0.055, 0.06, 0.04, 265.0, 155.0, 80.0, true, false, false, false, 0, true)
--         IsHandcuffed = true
--     elseif cufftype == 'zip' then
--         object = CreateObject('ba_prop_battle_cuffs',coords,true,false)
--         AttachEntityToEntity(object, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 60309), -0.055, 0.06, 0.04, 265.0, 155.0, 80.0, true, false, false, false, 0, true)
--         IsZipped = true
--     end
--     print(IsHandcuffed, IsZipped)
--     LocalPlayer.state:set('invBusy', true, false)
--     CreateThread(function()
--         while IsHandcuffed or IsZipped do
--             Wait(0)
--             DisableControlAction(0, 24, true) -- Attack
-- 			DisableControlAction(0, 257, true) -- Attack 2
-- 			DisableControlAction(0, 25, true) -- Aim
-- 			DisableControlAction(0, 263, true) -- Melee Attack 1
-- 			DisableControlAction(0, 45, true) -- Reload
-- 			DisableControlAction(0, 22, true) -- Jump
-- 			DisableControlAction(0, 44, true) -- Cover
-- 			DisableControlAction(0, 37, true) -- Select Weapon
-- 			DisableControlAction(0, 288, true) -- Phone
-- 			DisableControlAction(0, 170, true) -- Animations
-- 			DisableControlAction(0, 167, true) -- Job
-- 			DisableControlAction(0, 73, true) -- Clearing animation
-- 			DisableControlAction(2, 199, true) -- Pause screen
-- 			DisableControlAction(0, 59, true) -- Steering in vehicle
-- 			DisableControlAction(2, 36, true) -- Stealth
-- 			DisableControlAction(0, 47, true)  -- Weapon
-- 			DisableControlAction(0, 257, true) -- Melee
-- 			DisableControlAction(0, 140, true) -- Melee
-- 			DisableControlAction(0, 264, true) -- Melee
-- 			DisableControlAction(0, 141, true) -- Melee
-- 			DisableControlAction(0, 142, true) -- Melee
-- 			DisableControlAction(0, 143, true) -- Melee
--             if IsHardCuffed then
--                 DisableControlAction(0, 32, true) -- W
--                 DisableControlAction(0, 34, true) -- A
--                 DisableControlAction(0, 31, true) -- S 
--                 DisableControlAction(0, 30, true) -- D 
--                 if IsEntityPlayingAnim(PlayerPedId(), 'mp_arresting', 'idle', 3) ~= 1 then
--                     if isDead == true then
--                         ClearPedSecondaryTask(PlayerPedId())
--                     else
--                         loadAnimDict('anim@move_m@prisoner_cuffed')
--                         TaskPlayAnim(PlayerPedId(), 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0.0, false, false, false)
--                     end
--                 end
--             else
--                 if IsEntityPlayingAnim(PlayerPedId(), 'mp_arresting', 'idle', 3) ~= 1 then
--                     if isDead == true then
--                         ClearPedSecondaryTask(PlayerPedId())
--                     else
--                         loadAnimDict('anim@move_m@prisoner_cuffed')
--                         TaskPlayAnim(PlayerPedId(), 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0.0, false, false, false)
--                     end
--                 end
--             end
--         end
--     end)
-- end

-- RegisterCommand('uncuff', function(raw , args)
--     local item
--     if Config.CuffsAsItems then
--         if args[1] == nil or 'cuffs' then
--             item = 'cuffkey'
--             local count = exports.ox_inventory:Search('count', 'cuffkey')
--             if count > 0 then
--                 UnCuff(nil, item)
--             end
--         elseif args[1] == 'pliers' then
--             item = 'pliers'
--             local count = exports.ox_inventory:Search('count', 'pliers')
--             if count > 0 then
--                 UnCuff(nil, item)
--             end
--         elseif args[1] == 'cutters' then
--             item = 'cutters'
--             local count = exports.ox_inventory:Search('count', 'cutters')
--             if count > 0 then
--                 UnCuff(nil, item)
--             end
--         elseif args[1] == 'hmkey' then
--             item = 'hmkey'
--             local count = exports.ox_inventory:Search('count', 'hmkey')
--             if count > 0 then
--                 UnCuff(nil, item)
--             end
--         end
--     else
--         if args[1] == nil then
--             item = 'cuffkey'
--         elseif args[1] == 'pliers' then
--             item = 'pliers'
--         end
--         UnCuff(nil, item)
--     end
-- end)

-- RegisterNetEvent('hrzns_police:UnCuff', function(id, item)
--     UnCuff(id, item)
-- end)

-- function UnCuff(id, item)
--     if id == nil then
--         local coords = GetEntityCoords(PlayerPedId())
--         local closestPlayer = GetPlayerServerId(lib.getClosestPlayer(coords))
--         print(closestPlayer)
--         if closestPlayer == nil then
--             lib.notify({
--                 title = 'General',
--                 description = 'No player nearby',
--                 type = 'error'
--             })
--         else
--             local id = closestPlayer
--             TriggerServerEvent('hrzns_police:UncuffPlayer', id, item)
--         end
--     else
--         TriggerServerEvent('hrzns_police:UncuffPlayer', id, item)
--     end
-- end

-- RegisterNetEvent('hrzns_police:uncufftest', function(id, item, cop)
--     local success
--     if item == 'cutters' then
--         success = lib.skillCheck({'medium'}, {'e'})
--         if success then
--             TriggerServerEvent('hrzns_police:UnCuff', id, item)
--         else
--             lib.notify({
--                 title = 'Police',
--                 description = 'You failed the minigame',
--                 type = 'error'
--             })
--         end
--     elseif item == 'pliers' then
--         success = lib.skillCheck({'easy'}, {'e'})
--         if success then
--             TriggerServerEvent('hrzns_police:UnCuff', id, item)
--         else
--             lib.notify({
--                 title = 'Police',
--                 description = 'You failed the minigame',
--                 type = 'error'
--             })
--         end

--     elseif item == 'cuffkey' then
--         TriggerServerEvent('hrzns_police:UnCuff', id, item)
--     elseif item == 'hmkey' then
--         success = lib.skillCheck({'hard'}, {'e'})
--         if success then
--             TriggerServerEvent('hrzns_police:UnCuff', id, item)
--         else
--             lib.notify({
--                 title = 'Police',
--                 description = 'You failed the minigame',
--                 type = 'error'
--             })
--         end
--     end
-- end)


-- RegisterNetEvent('hrzns_police:uncuffed', function(item)
--     if item == 'cutters' then
--         IsHardCuffed = false
--     else 
--         IsHardCuffed = false
--         IsHandcuffed = false
--         DeleteObject(object)
--         TriggerServerEvent('ec')
--         LocalPlayer.state:set('invBusy', false)
--     end
-- end)

-- RegisterNetEvent('hrzns_police:arrest', function(stuff)
--     if stuff == 'uncuff' then
--         Animation('mp_arresting', 'a_uncuff', 8.0, -8, -1, 2)
--         Wait(5500)
--         TriggerServerEvent('ec')
--     else
--         Animation('mp_arrest_paired', 'cop_p2_back_right', 8.0, -8, 3750 , 2)
--         TriggerServerEvent('ec')
--     end
-- end)

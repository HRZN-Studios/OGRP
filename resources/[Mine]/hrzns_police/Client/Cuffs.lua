
local IsHandcuffed = false
local IsZipped = false
local CuffType = nil
local IsHardCuffed = false
local object = nil
local mycount = 0


RegisterCommand('cuff', function(raw, args)
    local item
    local cuffhard
    if Config.CuffsAsItems then
        if args[1] == 'cuffs' or args[1] == nil then
            local count = exports.ox_inventory:Search('count', 'handcuffs')
            if args[2] == 'hard' then
                cuffhard = true
                if count > 1 then
                    TriggerServerEvent('hrzns_police:CuffPlayer', id, heading, loc, coords, item, cuffhard)
                else
                    lib.notify({
                        title = 'Police',
                        description = 'Need the tools lol',
                        type = 'error'
                    })
                end
            else
                if count > 0 then
                    TriggerServerEvent('hrzns_police:CuffPlayer', id, heading, loc, coords, item, cuffhard)
                else
                    lib.notify({
                        title = 'Police',
                        description = 'Need the tools lol',
                        type = 'error'
                    })
                end
            end
        elseif args[1] == 'zip' then
            local count = exports.ox_inventory:Search('count', 'zipties')
            if args[2] == 'hard' then
                cuffhard = true
                if count > 1 then
                    TriggerServerEvent('hrzns_police:CuffPlayer', id, heading, loc, coords, item, cuffhard)
                else
                    lib.notify({
                        title = 'Police',
                        description = 'Need the tools lol',
                        type = 'error'
                    })
                end
            else
                if count > 0 then
                    TriggerServerEvent('hrzns_police:CuffPlayer', id, heading, loc, coords, item, cuffhard)
                else
                    lib.notify({
                        title = 'Police',
                        description = 'Need the tools lol',
                        type = 'error'
                    })
                end
            end
        end
    else
        lib.callback('hrzns_police:GetPlayerData', false, function(data)
            print(data.job.name)
            print(Config.CuffJob)
            for _, v in pairs(Config.CuffJob) do
                if data.job.name == v then
                    if args[1] == nil or 'cuff' then
                        item = 'cuffs'
                    elseif args[1] == 'zip' then
                        item = 'zip'
                    end
                    if args[2] == 'hard' then
                        cuffhard = true
                    end
                    CuffPlayer(nil, item, cuffhard)
                else
                    lib.notify({
                        title = 'Police',
                        description = 'Not a police officer',
                        type = 'error'
                    })
                end
            end
        end)
    end
end)

function CuffPlayer(id, item, cuffhard)
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
            heading = GetEntityHeading(PlayerPedId())
            loc = GetEntityForwardVector(PlayerPedId())
            coords = GetEntityCoords(PlayerPedId())
            if Config.CuffsAsItems then
                if cuffhard then
                    if item == 'cuffs' then
                        local count = exports.ox_inventory:Search('count', 'handcuffs')
                        if count > 1 then
                            TriggerServerEvent('hrzns_police:CuffPlayer', id, heading, loc, coords, item, cuffhard)
                        end
                    elseif item == 'zip' then
                        local count = exports.ox_inventory:Search('count', 'zipties')
                        if count > 1 then
                            TriggerServerEvent('hrzns_police:CuffPlayer', id, heading, loc, coords, item, cuffhard)
                        end
                    end
                else
                    if item == 'cuffs' then
                        local count = exports.ox_inventory:Search('count', 'handcuffs')
                        if count > 0 then
                            TriggerServerEvent('hrzns_police:CuffPlayer', id, heading, loc, coords, item, cuffhard)
                        end
                    elseif item == 'zip' then
                        local count = exports.ox_inventory:Search('count', 'zipties')
                        if count > 0 then
                            TriggerServerEvent('hrzns_police:CuffPlayer', id, heading, loc, coords, item, cuffhard)
                        end
                    end
                end
            else
                TriggerServerEvent('hrzns_police:CuffPlayer', id, heading, loc, coords, item, cuffhard)
            end
        end
    end
end

RegisterNetEvent('hrzns_police:cuffed', function(id, cufftype, cuffhard)
    Animation('mp_arrest_paired', 'crook_p2_back_right', 8.0, -8, 3750 , 2)
    Wait(1000)
    if mycount < Config.MaxCuffs then
        print('minigame')
       local success = lib.skillCheck({'hard'}, {'e'})
       if success then
            mycount = mycount + 1
            Wait(500)
            TriggerServerEvent('ec')
            TriggerServerEvent('hrzns_police:SNotify', id, 'error', 'Police', 'Suspect broke Cuffs!')
        else
            mycount = 0
            if Config.CuffsAsItems then
                if cuffhard then
                    if cufftype == 'cuffs' then
                        TriggerServerEvent('hrzns_police:RemoveItems', id, 'cuffs', 2)
                    elseif cufftype == 'zip' then
                        TriggerServerEvent('hrzns_police:RemoveItems', id, 'zip', 2)
                    end
                else
                    if cufftype == 'cuffs' then
                        TriggerServerEvent('hrzns_police:RemoveItems', id, 'cuffs', 1)
                    elseif cufftype == 'zip' then
                        TriggerServerEvent('hrzns_police:RemoveItems', id, 'zip', 1)
                    end
                end
            end
            ImCuffed(cufftype, cuffhard)
        end
    else
        mycount = 0
        Wait(3000)
        if Config.CuffsAsItems then
            if cuffhard then
                if cufftype == 'cuffs' then
                    TriggerServerEvent('hrzns_police:RemoveItems', id, 'cuffs', 2)
                elseif cufftype == 'zip' then
                    TriggerServerEvent('hrzns_police:RemoveItems', id, 'zip', 2)
                end
            else
                if cufftype == 'cuffs' then
                    TriggerServerEvent('hrzns_police:RemoveItems', id, 'cuffs', 1)
                elseif cufftype == 'zip' then
                    TriggerServerEvent('hrzns_police:RemoveItems', id, 'zip', 1)
                end
            end
        end
        ImCuffed(cufftype, cuffhard)
    end
end)

function ImCuffed(cufftype, cuffhard)
    local coords = GetEntityCoords(PlayerPedId())
    LoadModel('p_cs_cuffs_02_s')
    LoadModel('ba_prop_battle_cuffs')
    if cuffhard == 'hard' then
        IsHardCuffed = true
    end
    if cufftype == 'cuffs' then
        object = CreateObject('p_cs_cuffs_02_s',coords,true,false)
        AttachEntityToEntity(object, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 60309), -0.055, 0.06, 0.04, 265.0, 155.0, 80.0, true, false, false, false, 0, true)
        IsHandcuffed = true
    elseif cufftype == 'zip' then
        object = CreateObject('ba_prop_battle_cuffs',coords,true,false)
        AttachEntityToEntity(object, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 60309), -0.055, 0.06, 0.04, 265.0, 155.0, 80.0, true, false, false, false, 0, true)
        IsZipped = true
    end
    LocalPlayer.state:set('invBusy', true, false)
    CreateThread(function()
        while IsHandcuffed or IsZipped do
            Wait(0)
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
            if IsHardCuffed then
                DisableControlAction(0, 32, true) -- W
                DisableControlAction(0, 34, true) -- A
                DisableControlAction(0, 31, true) -- S 
                DisableControlAction(0, 30, true) -- D 
                if IsEntityPlayingAnim(PlayerPedId(), 'mp_arresting', 'idle', 3) ~= 1 then
                    if isDead == true then
                        ClearPedSecondaryTask(PlayerPedId())
                    else
                        loadAnimDict('anim@move_m@prisoner_cuffed')
                        TaskPlayAnim(PlayerPedId(), 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0.0, false, false, false)
                    end
                end
            else
                if IsEntityPlayingAnim(PlayerPedId(), 'mp_arresting', 'idle', 3) ~= 1 then
                    if isDead == true then
                        ClearPedSecondaryTask(PlayerPedId())
                    else
                        loadAnimDict('anim@move_m@prisoner_cuffed')
                        TaskPlayAnim(PlayerPedId(), 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0.0, false, false, false)
                    end
                end
            end
        end
    end)
end

RegisterCommand('uncuff', function(raw , args)
    local item
    if Config.CuffsAsItems then
        if args[1] == nil or 'cuffs' then
            item = 'cuffkey'
            local count = exports.ox_inventory:Search('count', 'cuffkey')
            if count > 0 then
                UnCuff(nil, item)
            end
        elseif args[1] == 'pliers' then
            item = 'pliers'
            local count = exports.ox_inventory:Search('count', 'pliers')
            if count > 0 then
                UnCuff(nil, item)
            end
        elseif args[1] == 'cutters' then
            item = 'cutters'
            local count = exports.ox_inventory:Search('count', 'cutters')
            if count > 0 then
                UnCuff(nil, item)
            end
        elseif args[1] == 'hmkey' then
            item = 'hmkey'
            local count = exports.ox_inventory:Search('count', 'hmkey')
            if count > 0 then
                UnCuff(nil, item)
            end
        end
    else
        if args[1] == nil then
            item = 'cuffkey'
        elseif args[1] == 'pliers' then
            item = 'pliers'
        end
        UnCuff(nil, item)
    end
end)

function UnCuff(id, item)
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
            TriggerServerEvent('hrzns_police:UncuffPlayer', id, item)
        end
    else
        TriggerServerEvent('hrzns_police:UncuffPlayer', id, item)
    end
end

RegisterNetEvent('hrzns_police:uncufftest', function(id, item, cop)
    local success
    if item == 'cutters' then
        success = lib.skillCheck({'medium'}, {'e'})
        if success then
            TriggerServerEvent('hrzns_police:UnCuff', id, item)
        else
            lib.notify({
                title = 'Police',
                description = 'You failed the minigame',
                type = 'error'
            })
        end
    elseif item == 'pliers' then
        success = lib.skillCheck({'easy'}, {'e'})
        if success then
            TriggerServerEvent('hrzns_police:UnCuff', id, item)
        else
            lib.notify({
                title = 'Police',
                description = 'You failed the minigame',
                type = 'error'
            })
        end

    elseif item == 'cuffkey' then
        TriggerServerEvent('hrzns_police:UnCuff', id, item)
    elseif item == 'hmkey' then
        success = lib.skillCheck({'hard'}, {'e'})
        if success then
            TriggerServerEvent('hrzns_police:UnCuff', id, item)
        else
            lib.notify({
                title = 'Police',
                description = 'You failed the minigame',
                type = 'error'
            })
        end
    end
end)


RegisterNetEvent('hrzns_police:uncuffed', function(item)
    if item == 'cutters' then
        IsHardCuffed = false
    else 
        IsHardCuffed = false
        IsHandcuffed = false
        DeleteObject(object)
        TriggerServerEvent('ec')
        LocalPlayer.state:set('invBusy', false)
    end
end)

RegisterNetEvent('hrzns_police:arrest', function(stuff)
    if stuff == 'uncuff' then
        Animation('mp_arresting', 'a_uncuff', 8.0, -8, -1, 2)
        Wait(5500)
        TriggerServerEvent('ec')
    else
        Animation('mp_arrest_paired', 'cop_p2_back_right', 8.0, -8, 3750 , 2)
        TriggerServerEvent('ec')
    end
end)

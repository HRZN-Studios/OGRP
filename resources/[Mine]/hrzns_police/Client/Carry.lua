IsAttached = false
InAnim = false
IsCarried = false
CarriedId = nil
HolderId = nil

lib.callback.register('hrzns_police:GetCarried', function(data)
    local id = CarriedId
    return id
end)


RegisterNetEvent('hrzns_police:Carry', function(id, kind)
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
            local ped = PlayerPedId()
            TriggerServerEvent('hrzns_police:Carry', id, ped, kind)
        end
    else
        local ped = PlayerPedId()
        TriggerServerEvent('hrzns_police:Carry', id, ped, kind)
    end
end)

RegisterNetEvent('hrzns_police:Carrier', function(Carried, kind)
    if InAnim then
        CarriedId = nil
        TriggerServerEvent('ec')
        InAnim = false
    elseif kind == 'carry' then
        CarriedId = Carried
        InAnim = true
        loadAnimDict('missfinale_c2mcs_1')
        TaskPlayAnim(PlayerPedId(), 'missfinale_c2mcs_1', "fin_c2_mcs_1_camman", 8.0, -8.0, 100000, 49, 0, false, false, false)
        isCarrying()
    elseif kind == 'escort' then
        CarriedId = Carried
        InAnim = true
        loadAnimDict('amb@world_human_drinking@coffee@male@base')
        if IsEntityPlayingAnim(PlayerPedId(), 'amb@world_human_drinking@coffee@male@base','base', 3) ~= 1 then
            TaskPlayAnim(PlayerPedId(), 'amb@world_human_drinking@coffee@male@base','base' ,8.0, -8, -1, 51, 0, false, false, false)
        end
    end
    isCarrying()
end)

RegisterNetEvent('hrzns_police:GetCarried', function(carrierped, kind, id)
    local playerIdx = GetPlayerFromServerId(id)
    local playerPed = GetPlayerPed(playerIdx)
    if IsAttached then
        HolderId = nil
        IsAttached = false
        if IsCarried then
            IsCarried = false
        end
        DetachEntity(PlayerPedId())
        TriggerServerEvent('ec')
    else
        SetPedCanRagdoll(PlayerPedId(), false);
        HolderId = id
        IsAttached = true
        SetPedCanRagdoll(PlayerPedId(), true);
        if kind == 'escort' then
            TriggerServerEvent('ec')
            Wait(100)
            loadAnimDict('mp_arresting')
            loadAnimDict('move_m@generic_variations@walk')
            TaskPlayAnim(PlayerPedId(), 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0.0, false, false, false)
            AttachEntityToEntity(PlayerPedId(), playerPed, 1816,0.25, 0.49, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
            BeingEscorted(id)
        elseif kind == 'carry' then
            TriggerServerEvent('ec')
            Wait(100)
            loadAnimDict('nm')
            TaskPlayAnim(PlayerPedId(), 'nm', 'firemans_carry', 8.0, -8.0, 100000, 33, 0, false, false, false)
            AttachEntityToEntity(PlayerPedId(), playerPed, 0, 0.27, 0.15, 0.63, 0.5, 0.5, 180, false, false, false, true, 2, true)
            IsCarried = true
            isCarried()
        end
    end
end)

RegisterNetEvent('hrzns_police:Detach', function()
    print('detached')
    if IsAttached then
        HolderId = nil
        IsAttached = false
        DetachEntity(PlayerPedId())
        TriggerServerEvent('ec')
    end
end)

function BeingEscorted()
    CreateThread(function()
        print('escorting '..tostring(IsAttached))
        while IsAttached do
            Wait(0)
            local speed = GetEntitySpeed(GetEntityAttachedTo(PlayerPedId()))
            if speed > 1 then
                print('walking at '..speed)
                if IsEntityPlayingAnim(PlayerPedId(), 'move_m@generic_variations@walk', 'walk_b', 3) ~= 1 then
                    TaskPlayAnim(PlayerPedId(), 'move_m@generic_variations@walk','walk_b' ,8.0, -8, -1, 0, 0, false, false, false)
                end
            end
        end
    end)
end

RegisterNetEvent('hrzns_police:Drop', function()
    if CarriedId ~= nil then
        TriggerServerEvent('hrzns_police:Detach', CarriedId, 'carrier')
        TriggerServerEvent('ec', CarriedId)
        TriggerServerEvent('ec')
        CarriedId = nil
        InAnim = false
        IsCarried = false
    end
end)

function isCarried()
    while IsCarried do
        Wait(1)
        if IsControlJustReleased(0 , 73) then
            TriggerServerEvent('hrzns_police:Detach', HolderId, 'carr')
            DetachEntity(PlayerPedId())
            HolderId = nil
            IsAttached = false
        end
    end
end

function isCarrying()
    while InAnim do
        Wait(1)
        DisableControlAction(0, 24, true) -- Attack
        DisableControlAction(0, 257, true) -- Attack 2
        DisableControlAction(0, 25, true) -- Aim
        DisableControlAction(0, 263, true) -- Melee Attack 1
        if IsControlJustReleased(0 , 73) then
            TriggerEvent('hrzns_police:Drop')
        end
    end
end

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(5)
            local speed = GetEntitySpeed(PlayerPedId())
            if IsAttached and speed > 3 and IsControlJustReleased(1, Config.TackleKeybind) then
                TriggerEvent('hrzns_police:Notify', "error", "General", "Cant tackle while being carried.")
            elseif InAnim and speed > 3 and IsControlJustReleased(1, Config.TackleKeybind) then
                TriggerEvent('hrzns_police:Notify', "error", "General", "Cant tackle while carring.")
            else
                if speed > 3 and IsControlJustReleased(1, Config.TackleKeybind) then
                    if IsPedInAnyVehicle(PlayerPedId(), false) then

                    else
                        local coords = GetEntityCoords(PlayerPedId())
                        local closestPlayer = GetPlayerServerId(lib.getClosestPlayer(coords))
                        local id = closestPlayer
                        if closestPlayer == nil then
                            lib.notify({
                                title = 'General',
                                description = 'No player nearby',
                                type = 'error'
                            })
                        else
                            TriggerServerEvent('hrzns_police:TacklePlayer', id)
                        end                    
                    end
                end
            end
        end
    end
)

RegisterNetEvent('hrzns_police:Tackle', function()
    ClearPedTasks(PlayerPedId())
    SetPedToRagdoll(PlayerPedId(), Config.TackleCopTime, Config.TackleCopTime, 0, 0, 0, 0)
end)

RegisterNetEvent('hrzns_police:GetTackled', function()
    if IsAttached then
        TriggerServerEvent('hrzns_police:Detach', HolderId)
        DetachEntity(PlayerPedId())
        TriggerServerEvent('hrzns_police:TacklePlayer', HolderId, 'carried')
        HolderId = nil
        IsAttached = false
    elseif InAnim then
        TriggerServerEvent('hrzns_police:Detach', CarriedId)
        DetachEntity(PlayerPedId())
        TriggerServerEvent('hrzns_police:TacklePlayer', CarriedId, 'carried')
        CarriedId = nil
        InAnim = false
    end
    ClearPedTasks(PlayerPedId())
    SetPedToRagdoll(PlayerPedId(), Config.TackleSusTime, Config.TackleSusTime, 0, 0, 0, 0)
end)
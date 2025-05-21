isDead = false

AddEventHandler('esx:onPlayerDeath', function(data)
    isDead = true
    local data = ESX.GetPlayerData()
    local dumpedTable = ESX.DumpTable(data)
    print(dumpedTable)
    died()
    ESX.SetPlayerData('dead', true)
end)

RegisterNetEvent('hrzns_ambulance:revive', function()
    local ped = PlayerPedId()
    SetPlayerInvincible(ped, false)
    isDead = false
    ESX.SetPlayerData('dead', false)
    TriggerEvent('esx_basicneeds:healPlayer')
    Wait(20)
    print('revived')
    ClearPedSecondaryTask(ped)
    ClearPedBloodDamage(ped)
    local data = ESX.GetPlayerData()
    local dumpedTable = ESX.DumpTable(data)
    print(dumpedTable)
    print(IsPedFatallyInjured(PlayerPedId()))
end)

function died()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    local heading = GetEntityHeading(ped)
    NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, heading, true, false)
    ClearPedSecondaryTask(ped)
    SetPlayerInvincible(ped, false)
    while isDead do
        Wait(10)
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
        DisableControlAction(0, 32, true) -- W
        DisableControlAction(0, 34, true) -- A
        DisableControlAction(0, 31, true) -- S 
        DisableControlAction(0, 30, true) -- D 
        if IsPedInVehicle(ped) == true then
            loadAnimDict('veh@van@ps@enter_exit')
            TaskPlayAnim(PlayerPedId(), 'veh@van@ps@enter_exit', 'dead_fall_out', 8.0, -8, -1, 49, 0.0, false, false, false)
        elseif IsAttached then
            
        else
            SetPedToRagdoll(ped, 1000, 1000, 0, 0, 0, 0)
        end
    end
end


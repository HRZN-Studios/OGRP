AddEventHandler('gameEventTriggered', function(event, args)
    if event ~= "CEventNetworkEntityDamage" or GetEntityType(args[1]) ~= 1 or NetworkGetPlayerIndexFromPed(args[1]) ~= PlayerId() then return end
    if not IsEntityDead(PlayerPedId()) then return end

    ClearPedTasks(PlayerPedId())
    SetNuiFocus(false, false)

    SendNUIMessage({
        action = 'setVisible',
        data = false
    })
    
    CLIENT.open = false
end)
AddEventHandler('onResourceStop', function(resourceName)
    local playerPed = PlayerPedId()

    ClearPedTasks(playerPed)
    DeleteEntity(CLIENT.TabletEntity)
end)
Citizen.CreateThread(function() 
    if Config.Framework == "qb" then
        QBCore = exports[Config.FrameworkPseudo]:GetCoreObject()
    end
end)

exports['qb-target']:AddTargetModel(Config.TableProp, {
    options = {
        {
            type    = 'client',
            event   = 'zat-crafting:client:OpenCraftMenu',
            label   = 'Craft',
            icon    = 'fas fa-screwdriver-wrench',
        },
        {
            type    = 'client',
            event   = 'zat-crafting:client:OpenBpInventory',
            icon    = 'fas fa-newspaper',
            label   = 'Blueprints',
        },
        {
            type    = 'client',
            event   = 'zat-crafting:client:OpenCraftingInventory',
            icon    = 'fas fa-box',
            label   = 'Storage',
            canInteract = function(entity)
                local CanOpen = true
                
                TriggerServerCallback('zat-crafting:server:CanOpenThisInventory', function(result)
                    CanOpen = result 
                end, NetworkGetNetworkIdFromEntity(entity))     

                Citizen.Wait(100)
                return CanOpen
            end,
        },
        {
            type    = 'client',
            event   = 'zat-crafting:client:TakeBackTable',
            icon    = 'fas fa-hammer',
            label   = 'Store the Table',
            canInteract = function(entity)
                local CanOpen = true

                TriggerServerCallback('zat-crafting:server:CanStoreTable', function(result)
                    CanOpen = result 
                end, NetworkGetNetworkIdFromEntity(entity))    

                Citizen.Wait(200)
                return CanOpen
            end,
        },
        {
            type    = 'client',
            event   = 'zat-crafting:client:MoveTable',
            icon    = 'fas fa-up-down-left-right',
            label   = 'Move the Table',
            canInteract = function(entity)
                local CanOpen = true

                TriggerServerCallback('zat-crafting:server:CanStoreTable', function(result)
                    CanOpen = result 
                end, NetworkGetNetworkIdFromEntity(entity))   

                Citizen.Wait(200)
                return CanOpen
            end,
        },
    },
    distance = 1.5, 
})

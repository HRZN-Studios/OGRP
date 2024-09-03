local QBCore = nil

Citizen.CreateThread(function() 
    if Config.Framework == "qb" then
        QBCore = exports[Config.FrameworkPseudo]:GetCoreObject()
    end
end)

function OpenCraftingStash(stashId)
    if Config.Inventory == 'qb' or Config.Inventory == 'ps' then
        if Config.QBInventory == "old" then
            TriggerServerEvent("inventory:server:OpenInventory", "stash", stashId, {
                maxweight = 4000000,
                slots = Config.Slots,
            })
            TriggerEvent("inventory:client:SetCurrentStash", stashId)
        else
            TriggerServerEvent('zat-crafting:server:OpenNewQbInventory', stashId, 4000000, Config.Slots)
        end
    elseif Config.Inventory == 'ox' then
        if not exports.ox_inventory:openInventory('stash', stashId) then
            TriggerServerEvent("zat-crafting:server:CreateStash", stashId, stashId, Config.Slots, 4000000, false, false, false)
            exports.ox_inventory:openInventory('stash', stashId)
        end
    elseif Config.Inventory == 'qs' then
        exports['qs-inventory']:RegisterStash(stashId, Config.Slots, 4000000) 
    end
end
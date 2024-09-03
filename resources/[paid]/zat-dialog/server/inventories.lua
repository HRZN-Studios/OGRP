local QBCore = nil

Citizen.CreateThread(function() 
    if Config.Framework == "qb" then
        QBCore = exports[Config.FrameworkPseudo]:GetCoreObject()
    end
end)

function GiveItem(src, item, amount, info)
    if Config.Inventory == 'qb' or Config.Inventory == 'ps' then
        local Player = QBCore.Functions.GetPlayer(src)
        Player.Functions.AddItem(item, amount, false, info)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[item], 'add')
    elseif Config.Inventory == 'ox' then
        exports.ox_inventory:AddItem(src, item, amount, info)
    elseif Config.Inventory == 'qs' then
        exports['qs-inventory']:AddItem(src, item, amount, nil, info)
    end
end

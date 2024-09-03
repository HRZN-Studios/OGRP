local QBCore = nil

Citizen.CreateThread(function() 
    if Config.Framework == "qb" then
        QBCore = exports[Config.FrameworkPseudo]:GetCoreObject()
    end
end)

function GetStashItems(stashId)
    local items = {}
    if Config.Inventory == 'qb' or Config.Inventory == 'ps' then
        local result = nil 
        if Config.QBInventory == "old" then
            result = MySQL.scalar.await('SELECT items FROM stashitems WHERE stash = ?', {stashId})
        else
            result = MySQL.scalar.await('SELECT items FROM inventories WHERE identifier = ?', {stashId})
        end
        if not result then return items end

        local stashItems = json.decode(result)
        if not stashItems then return items end

        for _, item in pairs(stashItems) do
            local itemInfo = QBCore.Shared.Items[item.name:lower()]
            if itemInfo then
                items[item.slot] = {
                    name = itemInfo["name"],
                    amount = tonumber(item.amount),
                    info = item.info or "",
                    label = itemInfo["label"],
                    description = itemInfo["description"] or "",
                    weight = itemInfo["weight"],
                    type = itemInfo["type"],
                    unique = itemInfo["unique"],
                    useable = itemInfo["useable"],
                    image = itemInfo["image"],
                    created = item.created,
                    slot = item.slot,
                }
            end
        end
    elseif Config.Inventory == 'ox' then
        items = exports.ox_inventory:GetInventoryItems(stashId)
        if not items then
            items = {}
            local result = MySQL.scalar.await('SELECT data FROM ox_inventory WHERE name = ?', {stashId})
            if not result then return items end
            local stashItems = json.decode(result)
            if not stashItems then return items end
            for _, item in pairs(stashItems) do
                items[item.slot] = {
                    name        = item.name,
                    amount      = item.count,
                    metadata    = item.metadata,
                    slot        = item.slot,
                }
            end
        end
    elseif Config.Inventory == 'qs' then
        items = exports['qs-inventory']:GetStashItems('Stash_'..stashId)
    end
	return items
end


function AddItemsIntoStash(stash, Items)
    if Config.Framework == "qb" then
        if Config.Inventory == "qb" or  Config.Inventory == "origen" or  Config.Inventory == "ps" then
            local items = GetStashItems(stash)
            for k, v in pairs(Items) do
                local itemInfo = QBCore.Shared.Items[v.name:lower()]
                items[#items + 1] = {
                    name = itemInfo["name"],
                    amount = v.amount,
                    info = v.info,
                    label = itemInfo["label"],
                    description = itemInfo["description"] ~= nil and itemInfo["description"] or "",
                    weight = itemInfo["weight"],
                    type = itemInfo["type"],
                    unique = itemInfo["unique"],
                    useable = itemInfo["useable"],
                    image = itemInfo["image"],
                    slot = #items + 1,
                }
            end
            Citizen.Wait(1000)
            if Config.Inventory == "qb" or  Config.Inventory == "ps" then
                if Config.QBInventory == "old" then
                    MySQL.Async.insert('INSERT INTO stashitems (stash, items) VALUES (:stash, :items) ON DUPLICATE KEY UPDATE items = :items'
                        , {
                        ['stash'] = stash,
                        ['items'] = json.encode(items)
                    })
                else

                    local oldItems = GetStashItems(stash)
                    for k, v in pairs(oldItems) do
                        exports['qb-inventory']:RemoveItem(stash, v.name,  v.amount, v.slot)
                    end
                    MySQL.Async.insert('INSERT INTO inventories (identifier, items) VALUES (:identifier, :items) ON DUPLICATE KEY UPDATE items = :items'
                        , {
                        ['identifier'] = stash,
                        ['items'] = json.encode(items)
                    })
                    -- It was working fine ! just we need to add them into the temp inv in the qb-inv by doing this :
        
                    -- if the inventory does not exist we need to create it here otherwise it will not be able to add items into it . 
                    -- stupid but true
                    
                    -----------------------------------------------------------------------------------------------------------------
                    -----------------------------------------------------------------------------------------------------------------
                    for k, v in pairs(items) do
                        exports['qb-inventory']:AddItem(stash, v.name,  v.amount, false, v.info)
                    end
                    
                end
            elseif Config.Inventory == "origen" then
                TriggerEvent('origen_inventory:server:SaveStashItems', stash, items)
            end
        elseif Config.Inventory == "ox" then
            for k, v in pairs(Items) do
                exports.ox_inventory:AddItem(stash, v.name, v.amount, v.info)
            end
        elseif Config.Inventory == "qs" then
            for k, v in pairs(Items) do
                exports['qs-inventory']:AddItemIntoStash('Stash_'..stash, v.name, v.amount, nil, v.info)
            end
        end
    elseif Config.Framework == "esx" then
        if Config.Inventory == 'ox' then
            for k, v in pairs(Items) do
                exports.ox_inventory:AddItem(stash, v.name, v.amount, v.info)
            end
        elseif Config.Inventory == "qs" then
            for k, v in pairs(Items) do
                exports['qs-inventory']:AddItemIntoStash('Stash_'..stash, v.name, v.amount, nil, v.info)
            end
        end
    end
end

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


RegisterNetEvent("zat-crafting:server:CreateStash", function(id, label, slots, maxWeight, owner, groups, coords)
    exports.ox_inventory:RegisterStash(id, label, slots, maxWeight, owner, groups, coords)
end)

RegisterNetEvent('zat-crafting:server:OpenNewQbInventory', function(stashId, weight, slots)
    local src = source
    local data = { label = stashId, maxweight = weight, slots = slots }
    exports['qb-inventory']:OpenInventory(src, stashId, data)
end)



local QBCore = nil
local Queue     =  {}
local itemNames = {}
local Tables = {}

Citizen.CreateThread(function() 
    if Config.Framework == "qb" then
        QBCore = exports[Config.FrameworkPseudo]:GetCoreObject()
    end
end)

Citizen.CreateThread(function()
    if Config.Inventory == "ox" then         
        for item, data in pairs(exports.ox_inventory:Items()) do
            itemNames[item] = data.label
        end
    elseif Config.Inventory == "qs" then  
        for item, data in pairs(exports['qs-inventory']:GetItemList()) do
            itemNames[item] = data.label
        end
    end
end)

local function HasAttachment(component, attachments)
    local retval = false
    local key = nil
    for k, v in pairs(attachments) do
        if v.component == component then
            key = k
            retval = true
        end
    end
    return retval, key
end

local setupModels = function()
    local result = MySQL.Sync.fetchAll('SELECT * FROM craftingtables')
    for k, v in pairs(result) do
        local coords = json.decode(v.coords)
        local rot    = json.decode(v.rot)
        local model  = v.model
        print (coords)
        local prop   = CreateObjectNoOffset(GetHashKey(model), coords.x, coords.y, coords.z, true, true, false)
        SetEntityRoutingBucket(prop, v.bucket)
        SetEntityRotation(prop, vector3(rot.x, rot.y, rot.z))
        FreezeEntityPosition(prop, true)
        Tables[prop] = {
            id     = v.id,
            coords = vector3(coords.x, coords.y, coords.z),
            rot    = vector3(rot.x, rot.y, rot.z),
            model  = model,
            bucket = v.bucket
        }
    end
end

AddEventHandler('onResourceStart', function(resource)
    if resource ~= GetCurrentResourceName() then return end
    setupModels()
end)

Citizen.CreateThread(function()   
    if Config.Framework == "qb" then  
        RegisterServerCallback("zat-crafting:server:GetCurrentCraftingTableData", function(source, cb, netId)
            local entity = NetworkGetEntityFromNetworkId(netId)
            cb(Tables[entity])
        end)

        RegisterServerCallback('zat-crafting:server:GetAvailableAttachmentsForSelectedWeapon', function(source, cb, weaponName)
            local src = source
            local Player = QBCore.Functions.GetPlayer(src)
            if Config.qbVersion == "old" then
                local myAttachmentsList = {
                    ['defaultclip']     = {name = "",label = "", image = ""},
                    ['extendedclip']    = {name = "",label = "", image = ""},
                    ['flashlight']      = {name = "",label = "", image = ""},
                    ['scope']           = {name = "",label = "", image = ""},
                    ['suppressor']      = {name = "",label = "", image = ""},
                    ['luxuryfinish']    = {name = "",label = "", image = ""},
                    ['drum']            = {name = "",label = "", image = ""},
                    ['grip']            = {name = "",label = "", image = ""},
                }
                for k, v in pairs(Config.Attachments[weaponName]) do
                    if (k=="luxuryfinish") then
                        for i, j in pairs(v) do
                            if (Player.Functions.GetItemByName(j.item) ~= nil) then
                                myAttachmentsList[k].name = j.item
                                myAttachmentsList[k].image = QBCore.Shared.Items[j.item].image
                                myAttachmentsList[k].label = QBCore.Shared.Items[j.item].label
                            end
                        end
                    else
                        if (Player.Functions.GetItemByName(v.item) ~= nil) then
                            myAttachmentsList[k].name = v.item
                            myAttachmentsList[k].image = QBCore.Shared.Items[v.item].image
                            myAttachmentsList[k].label = QBCore.Shared.Items[v.item].label
                        end
                    end
                end
                cb(myAttachmentsList)
            else
                local myAttachmentsList = {}
                for k, v in pairs(Config.NewAttachments) do
                    for i, j in pairs(v) do
                        if (string.lower(weaponName) == i) then
                            if (Player.Functions.GetItemByName(k) ~= nil) then
                                table.insert(myAttachmentsList, {k, QBCore.Shared.Items[k].image, QBCore.Shared.Items[k].label})  
                            end
                        end
                    end
                end
                cb(myAttachmentsList)
            end
            
        end)

        RegisterServerCallback('zat-crafting:server:GetCutomizablesList', function(source, cb)
            local src = source
            local Player = QBCore.Functions.GetPlayer(src)
            local myCustomizables = {}
            local foundit = {}
            for k, v in pairs(Config.Weapons) do
                if (Player.Functions.GetItemByName(k) ~= nil) then
                    local foundit = Player.Functions.GetItemsByName(k)
                    for _, j in pairs(foundit) do
                        table.insert(myCustomizables,{string.lower(j.name), QBCore.Shared.Items[string.lower(j.name)].image,QBCore.Shared.Items[string.lower(j.name)].label, j.slot})
                    end
                end
            end
            cb(myCustomizables)
        end)

        RegisterServerCallback('zat-crafting:server:GetAttachedComponents', function(source, cb, slot)
            local src = source
            local Player = QBCore.Functions.GetPlayer(src)
            local Inventory = Player.PlayerData.items
            local Components = {}
            if Config.Inventory == "qb" or  Config.Inventory == "origen" or  Config.Inventory == "ps" or  Config.Inventory == "qs" then
                if Inventory[slot] then
                    if Inventory[slot].info.attachments and next(Inventory[slot].info.attachments) then
                        for k, v in pairs(Inventory[slot].info.attachments) do
                            table.insert(Components,v.component)
                        end
                        cb(Components)
                    else
                        cb(nil)           
                    end
                else
                    cb(nil)
                end
            end
        end)


        RegisterServerCallback('zat-crafting:server:CanOpenThisInventory', function(source, cb, netId)
            local entity  = NetworkGetEntityFromNetworkId(netId)
            local canOpen = true
            if Tables[entity] ~= nil then
                local id = Tables[entity].id
                
                if Queue[id] ~= nil then
                    if (#Queue[id] > 0) then
                        canOpen = false
                    end
                end
            end
            cb(canOpen)
        end)

        RegisterServerCallback('zat-crafting:server:CanStoreTable', function(source, cb, netId)
            local entity  = NetworkGetEntityFromNetworkId(netId)
            local canOpen = true
            if Tables[entity] ~= nil then
                local id      = Tables[entity].id
                local bpItems = GetStashItems("CraftingBP_"..id)
                if bpItems or #bpItems>0 then
                    for k, v in pairs(bpItems) do  
                        if v.name ~= nil then
                            canOpen = false
                            break
                        end
                    end
                end
                local stItems= GetStashItems("CraftingStorage_"..id)
                if stItems or #stItems>0 then
                    for k, v in pairs(stItems) do  
                        if v.name ~= nil then
                            canOpen = false
                            break
                        end
                    end
                end
                
                if Queue[id] ~= nil then
                    if (#Queue[id] > 0) then
                        canOpen = false
                    end
                end
            end
            cb(canOpen)
       end)

        RegisterServerCallback('zat-crafting:server:GetStashItems', function(source, cb, stashid)
            if Config.Inventory == "ox" then
                cb(exports.ox_inventory:GetInventoryItems(stashid, false))
            elseif Config.Inventory == "qs" then
                cb(GetStashItems(stashid))
            elseif Config.Inventory == "qb" then
                cb(GetStashItems(stashid))
            end
        end)

        RegisterServerCallback('zat-crafting:server:GetTint', function(source, cb, slot)
            local src = source
            local Player = QBCore.Functions.GetPlayer(src)
            local Inventory = Player.PlayerData.items
            if Config.Inventory == "qb" or  Config.Inventory == "origen" or  Config.Inventory == "ps" or  Config.Inventory == "qs" then
                if Inventory[slot] then
                    if Inventory[slot].info.tint then
                        cb(Inventory[slot].info.tint)
                    else
                        cb(nil)           
                    end
                else
                    cb(nil)
                end
            elseif Config.Inventory == "ox" then
                if Inventory[slot] then
                    if Inventory[slot].metadata.tint then
                        cb(Inventory[slot].metadata.tint)
                    else
                        cb(nil)           
                    end
                else
                    cb(nil)
                end
            end
        end)

        RegisterServerCallback('zat-crafting:server:GetTables', function(source, cb)
            local Tables = {}
            local result = MySQL.query.await('SELECT * FROM craftingtables', {})
        
            if result[1] then
                for _, v in pairs(result) do
                    table.insert(Tables,{id = v.id, coords = json.decode(v.coords), model = v.model})
                end
                cb(Tables)
            else
                cb(nil)
            end
            
        end)
        
        RegisterServerCallback('zat-crafting:server:GetCraftingQueue', function(source, cb, tableid)
            cb(Queue[tableid])
        end)
        
    elseif Config.Framework == "esx" then
        RegisterServerCallback("zat-crafting:server:GetCurrentCraftingTableData", function(source, cb, netId)
            local entity = NetworkGetEntityFromNetworkId(netId)
            cb(Tables[entity])
        end)

        RegisterServerCallback('zat-crafting:server:GetCutomizablesList', function(source, cb)
            local src = source
            local Player = ESX.GetPlayerFromId(src)
            local myCustomizables = {}
            local foundit = {}
            if Config.Inventory == 'ox' then
                local Items = exports.ox_inventory:GetInventoryItems(src)
                for k, v in pairs(Config.Weapons) do 
                    for i, j in pairs (Items) do
                        if  string.lower(j.name)==  string.lower(k) then
                            table.insert(myCustomizables,{string.lower(j.name), j.name..".png",itemNames[j.name], j.slot})
                        end
                    end
                end
            elseif Config.Inventory == 'qs' then
                local Items = exports['qs-inventory']:GetInventory(src)
                for k, v in pairs(Config.Weapons) do 
                    for i, j in pairs (Items) do
                        if  string.lower(j.name)==  string.lower(k) then
                            table.insert(myCustomizables,{string.lower(j.name), j.name..".png",itemNames[j.name], j.slot})
                        end
                    end
                end
            end
            cb(myCustomizables)
        end)
        RegisterServerCallback('zat-crafting:server:CanOpenThisInventory', function(source, cb, netId)
            local entity  = NetworkGetEntityFromNetworkId(netId)
            local canOpen = true
            if Tables[entity] ~= nil then
                local id = Tables[entity].id
                if Queue[id] ~= nil then
                    if (#Queue[id] > 0) then
                        canOpen = false
                    end
                end
            end
            cb(canOpen)
        end)
        RegisterServerCallback('zat-crafting:server:GetAttachedComponents', function(source, cb, slot)
            local src = source
            local Inventory = exports['qs-inventory']:GetInventory(src)
            local Components = {}
            if Inventory[slot] then
                if Inventory[slot].info.attachments and next(Inventory[slot].info.attachments) then
                    for k, v in pairs(Inventory[slot].info.attachments) do
                        table.insert(Components,v.component)
                    end
                    cb(Components)
                else
                    cb(nil)           
                end
            else
                cb(nil)
            end
        end)
        RegisterServerCallback('zat-crafting:server:GetStashItems', function(source, cb, stashid)
            if Config.Inventory == "ox" then
                cb(exports.ox_inventory:GetInventoryItems(stashid, false))
            elseif Config.Inventory == "qs" then
                cb(GetStashItems(stashid))
            elseif Config.Inventory == "qb" then
                cb(GetStashItems(stashid))
            end
        end)

        RegisterServerCallback('zat-crafting:server:GetTables', function(source, cb)
            local Tables = {}
            local result = MySQL.query.await('SELECT * FROM craftingtables', {})
        
            if result[1] then
                for _, v in pairs(result) do
                    table.insert(Tables,{id = v.id, coords = json.decode(v.coords), model = v.model})
                end
                cb(Tables)
            else
                cb(nil)
            end
            
        end)
        RegisterServerCallback('zat-crafting:server:CanStoreTable', function(source, cb, netId)
            local entity  = NetworkGetEntityFromNetworkId(netId)
            local canOpen = true
            if Tables[entity] ~= nil then
                local id      = Tables[entity].id
                local bpItems = GetStashItems("CraftingBP_"..id)
                if bpItems or #bpItems>0 then
                    for k, v in pairs(bpItems) do  
                        if v.name ~= nil then
                            canOpen = false
                            break
                        end
                    end
                end
                local stItems= GetStashItems("CraftingStorage_"..id)
                if stItems or #stItems>0 then
                    for k, v in pairs(stItems) do  
                        if v.name ~= nil then
                            canOpen = false
                            break
                        end
                    end
                end
                
                if Queue[id] ~= nil then
                    if (#Queue[id] > 0) then
                        canOpen = false
                    end
                end
            end
            cb(canOpen)
        end)
        RegisterServerCallback('zat-crafting:server:GetCraftingQueue', function(source, cb, tableid)
            cb(Queue[tableid])
        end)
        
        RegisterServerCallback('zat-crafting:server:GetAvailableAttachmentsForSelectedWeapon', function(source, cb, weaponName)
            local src = source
            local myAttachmentsList = {
                ['defaultclip']     = {name = "",label = "", image = ""},
                ['extendedclip']    = {name = "",label = "", image = ""},
                ['flashlight']      = {name = "",label = "", image = ""},
                ['scope']           = {name = "",label = "", image = ""},
                ['suppressor']      = {name = "",label = "", image = ""},
                ['luxuryfinish']    = {name = "",label = "", image = ""},
                ['drum']            = {name = "",label = "", image = ""},
                ['grip']            = {name = "",label = "", image = ""},
            }
            for k, v in pairs(Config.Attachments[weaponName]) do
                if (k=="luxuryfinish") then
                    for i, j in pairs(v) do
                        if exports['qs-inventory']:GetItemTotalAmount(src, j.item) > 0 then
                            myAttachmentsList[k].name = j.item
                            myAttachmentsList[k].image = j.item..'.png'
                            myAttachmentsList[k].label = itemNames[j.item]
                        end
                    end
                else
                    if exports['qs-inventory']:GetItemTotalAmount(src, v.item) > 0 then
                        myAttachmentsList[k].name = v.item
                        myAttachmentsList[k].image = v.item..'.png'
                        myAttachmentsList[k].label = itemNames[v.item]
                    end
                end
            end
            cb(myAttachmentsList)
            
        end)
    end
end)

RegisterNetEvent("zat-crafting:server:RemoveStashItems", function(stash, item, count)
    if Config.Inventory == "ox" then
        exports.ox_inventory:RemoveItem(stash, item, count)
    elseif Config.Inventory == "qs" then
        exports['qs-inventory']:RemoveItemIntoStash('Stash_'..stash, item, count)
    end
end)

RegisterNetEvent("zat-crafting:server:equipAttachment", function(AttachmentData, weaponslot)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local Inventory = Player.PlayerData.items
    if Config.Inventory == "qb" or  Config.Inventory == "origen" or  Config.Inventory == "ps" or  Config.Inventory == "qs" then
        if Inventory[weaponslot].info.attachments then
            -- do nothing
        else
            Inventory[weaponslot].info.attachments = {}
        end
    end
    if Config.qbVersion == "old" then
        if Config.Inventory == "qb" or  Config.Inventory == "origen" or  Config.Inventory == "ps" or  Config.Inventory == "qs" then
            Inventory[weaponslot].info.attachments[#Inventory[weaponslot].info.attachments+1] = {
                component = AttachmentData.component,
                label = QBCore.Shared.Items[AttachmentData.item].label,
                item = AttachmentData.item,
                type = AttachmentData.type,
            }
            Player.Functions.SetInventory(Player.PlayerData.items, true)
            Player.Functions.RemoveItem(AttachmentData.item, 1)
        end
    else
        if Config.Inventory == "qb" or  Config.Inventory == "origen" or  Config.Inventory == "ps" or  Config.Inventory == "qs" then
            local hasAttach, attachIndex = HasAttachment(AttachmentData.component, Inventory[weaponslot].info.attachments)
            if hasAttach then
                table.remove(Inventory[weaponslot].info.attachments, attachIndex)
            end
            Inventory[weaponslot].info.attachments[#Inventory[weaponslot].info.attachments+1] = {
                component = AttachmentData.component,
            }
            Player.Functions.SetInventory(Player.PlayerData.items, true)
            Player.Functions.RemoveItem(AttachmentData.item, 1)
        end
    end
end)

RegisterNetEvent("zat-crafting:server:equipAttachmentQS", function(AttachmentData, weaponslot)
    local src = source
    local Inventory = exports['qs-inventory']:GetInventory(src)

    for _, v in pairs(Inventory) do 
        if v.slot  == weaponslot then
            if v.info.attachments then
                -- do nothing
            else
                v.info.attachments = {}
            end
            v.info.attachments[#v.info.attachments+1] = {
                component = AttachmentData.component,
                label = itemNames[AttachmentData.item],
                item = AttachmentData.item,
                type = AttachmentData.type,
            }

            exports['qs-inventory']:SetItemMetadata(src, weaponslot, v.info)
        end
    end
    exports['qs-inventory']:RemoveItem(src, AttachmentData.item, 1)
end)

RegisterNetEvent("zat-crafting:server:equipTint", function(tintindex, weaponslot, item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local Inventory = Player.PlayerData.items
    if Config.Inventory == "qb" or  Config.Inventory == "origen" or  Config.Inventory == "ps" or  Config.Inventory == "qs" then
        Inventory[weaponslot].info.tint = tintindex
        Player.Functions.SetInventory(Player.PlayerData.items, true)
        Player.Functions.RemoveItem(item, 1)
    elseif Config.Inventory == "ox" then
        Inventory[weaponslot].metadata.tint = tintindex
        --Player.Functions.SetInventory(Player.PlayerData.items, true)
        TriggerClientEvent('ox_inventory:updateInventory', src, Player.PlayerData.items)
        Player.Functions.RemoveItem(item, 1)
    end
end)

RegisterNetEvent("zat-crafting:server:equipTintQS", function(tintindex, weaponslot, item)
    local src = source
    local Inventory = exports['qs-inventory']:GetInventory(src)
    for _, v in pairs(Inventory) do 
        if v.slot  == weaponslot then
            v.info.tint = tintindex
            exports['qs-inventory']:SetItemMetadata(src, weaponslot, v.info)
            exports['qs-inventory']:RemoveItem(src, item, 1)
        end
    end
end)

RegisterNetEvent("zat-crafting:server:removeAttachmentQS", function(AttachmentData, weaponslot)
    local src = source
    local Inventory = exports['qs-inventory']:GetInventory(src)
    local GiveBackItem = nil
    for _, v in pairs(Inventory) do 
        if v.slot  == weaponslot then
            if v.info.attachments and next(v.info.attachments) then
                local HasAttach, key = HasAttachment(AttachmentData.component, v.info.attachments)
                for _, j in pairs(v.info.attachments) do
                    if j.item and j.item == AttachmentData.item then
                        GiveBackItem = tostring(AttachmentData.item):lower()
                        table.remove(v.info.attachments, key)
                    end
                end
                exports['qs-inventory']:SetItemMetadata(src, v.slot, v.info)
            end
        end
    end

    if GiveBackItem then
        exports['qs-inventory']:AddItem(src, GiveBackItem, 1)
    end    
end)
RegisterNetEvent("zat-crafting:server:removeAttachment", function(AttachmentData, weaponslot)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local Inventory = Player.PlayerData.items
    local GiveBackItem = nil
    if Config.qbVersion == "old" then
        if Config.Inventory == "qb" or  Config.Inventory == "origen" or  Config.Inventory == "ps" or  Config.Inventory == "qs" then
            if Inventory[weaponslot] then
                if Inventory[weaponslot].info.attachments and next(Inventory[weaponslot].info.attachments) then
                    local HasAttach, key = HasAttachment(AttachmentData.component, Inventory[weaponslot].info.attachments)
                    for _, v in pairs(Inventory[weaponslot].info.attachments) do
                        if v.item and v.item == AttachmentData.item then
                            GiveBackItem = tostring(AttachmentData.item):lower()
                            table.remove(Inventory[weaponslot].info.attachments, key)
                        end
                    end
                    Player.Functions.SetInventory(Player.PlayerData.items, true)
                end
            end
        end
    else
        if Config.Inventory == "qb" or  Config.Inventory == "origen" or  Config.Inventory == "ps" or  Config.Inventory == "qs" then
            if Inventory[weaponslot] then
                if Inventory[weaponslot].info.attachments and next(Inventory[weaponslot].info.attachments) then
                    local HasAttach, key = HasAttachment(AttachmentData.component, Inventory[weaponslot].info.attachments)
                    for _, v in pairs(Inventory[weaponslot].info.attachments) do
                        if v.component and v.component == AttachmentData.component then
                            GiveBackItem = tostring(AttachmentData.item):lower()
                            table.remove(Inventory[weaponslot].info.attachments, key)
                        end
                    end
                    Player.Functions.SetInventory(Player.PlayerData.items, true)
                end
            end
        end
    end
    if GiveBackItem then
        Player.Functions.AddItem(GiveBackItem, 1, false)
    end
end)

RegisterNetEvent("zat-crafting:server:StartCrafting", function(itemData, tableid)
    local src = source 
    local item = {}
    for k, v in pairs(Config.craftables) do
        if v.name == itemData.name then
            item = v
        end
    end
    if item.requireBlueprint then
        if Config.RemoveBlueprint then
            local items = {}
            items = GetStashItems("CraftingBP_"..tableid)
            local temp = {}
            for k, v in pairs(items) do  
                if v ~= nil then
                    table.insert(temp,v)
                end
            end
            
            for k, v in pairs(temp) do         
                if v.name == "blueprint" then
                    if v.info ~= nil then
                        if v.info.type == itemData.name then
                            table.remove(temp,k)
                            if(Queue[tableid] == nil)then
                                Queue[tableid] = {}
                            end
                            table.insert(Queue[tableid],{itemData = itemData })
                            break
                        elseif v.info.type == itemData.info.type then
                            table.remove(temp,k)
                            if(Queue[tableid] == nil)then
                                Queue[tableid] = {}
                            end
                            table.insert(Queue[tableid],{itemData = itemData })
                            break
                        end
                    end
                    if v.metadata ~= nil then
                        if v.metadata.type == itemData.name then
                            table.remove(temp,k)
                            if(Queue[tableid] == nil)then
                                Queue[tableid] = {}
                            end
                            table.insert(Queue[tableid],{itemData = itemData })
                            break
                        elseif v.metadata.type == itemData.info.type then
                            table.remove(temp,k)
                            if(Queue[tableid] == nil)then
                                Queue[tableid] = {}
                            end
                            table.insert(Queue[tableid],{itemData = itemData })
                            break
                        end
                    end
                end
            end
            if Config.Inventory == "qb" or  Config.Inventory == "origen" or  Config.Inventory == "ps" then
                if Config.QBInventory == "old" then
                    MySQL.Async.insert('INSERT INTO stashitems (stash, items) VALUES (:stash, :items) ON DUPLICATE KEY UPDATE items = :items'
                        , {
                        ['stash'] = "CraftingBP_"..tableid,
                        ['items'] = json.encode(temp)
                    })
                else
                    -----------------------------------------------------------------------------------------------------------------
                    -----------------------------------------------------------------------------------------------------------------
                    local oldItems = GetStashItems("CraftingBP_"..tableid)
                    for k, v in pairs(oldItems) do
                        exports['qb-inventory']:RemoveItem("CraftingBP_"..tableid, v.name,  v.amount, v.slot)
                    end
                    MySQL.Async.insert('INSERT INTO inventories (identifier, items) VALUES (:identifier, :items) ON DUPLICATE KEY UPDATE items = :items'
                        , {
                        ['identifier'] = "CraftingBP_"..tableid,
                        ['items'] = json.encode(temp)
                    })
                    -- It was working fine ! just we need to add them into the temp inv in the qb-inv by doing this :
        
                    -- if the inventory does not exist we need to create it here otherwise it will not be able to add items into it . 
                    -- stupid but true
                    for k, v in pairs(temp) do
                        exports['qb-inventory']:AddItem("CraftingBP_"..tableid, v.name,  v.amount, false, v.info)
                    end
                end
            elseif Config.Inventory == "ox" then
                exports.ox_inventory:ClearInventory("CraftingBP_"..tableid)
                for k, v in pairs(temp) do
                    exports.ox_inventory:AddItem("CraftingBP_"..tableid, v.name, v.count, v.metadata)
                end
            elseif Config.Inventory == "qs" then
                if Config.Framework == 'qb' then
                    MySQL.Async.insert('INSERT INTO inventory_stash (stash, items) VALUES (:stash, :items) ON DUPLICATE KEY UPDATE items = :items'
                        , {
                        ['stash'] = "CraftingBP_"..tableid,
                        ['items'] = json.encode(temp)
                    })
                elseif Config.Framework == 'esx' then
                    MySQL.Async.insert('INSERT INTO inventory_stash (stash, items) VALUES (:stash, :items) ON DUPLICATE KEY UPDATE items = :items'
                        , {
                        ['stash'] = "Stash_CraftingBP_"..tableid,
                        ['items'] = json.encode(temp)
                    })
                end
            end
            TriggerClientEvent("zat-crafting:client:CheckBluePrintsAndStuff", src, "CraftingBP_"..tableid)
            if Config.IncreaseRep then 
                TriggerClientEvent("zat-crafting:client:IncreaseRep", src, item.earnedrep)
            end
        else
            if(Queue[tableid] == nil)then
                Queue[tableid] = {}
            end
            table.insert(Queue[tableid],{itemData = itemData })
            if Config.IncreaseRep then
                TriggerClientEvent("zat-crafting:client:IncreaseRep", src, item.earnedrep)
            end
        end
    else
        if(Queue[tableid] == nil)then
            Queue[tableid] = {}
        end
        table.insert(Queue[tableid],{itemData = itemData })
        if Config.IncreaseRep then
            TriggerClientEvent("zat-crafting:client:IncreaseRep", src, item.earnedrep)
        end
    end
end)

RegisterNetEvent("zat-crafting:server:PlaceTable", function(model, coords, rot, id, moving) 
    local src = source
    local bucket = GetPlayerRoutingBucket(src)
    local prop = CreateObjectNoOffset(GetHashKey(model), vector3(coords.x,coords.y,coords.z-0.05) , true, true, false)
    SetEntityRoutingBucket(prop, bucket)
    SetEntityRotation(prop, rot)
    FreezeEntityPosition(prop, true)
    local time = os.time()
    MySQL.insert('INSERT into craftingtables (`id`, `coords`, `rot`, `model`, `bucket`) VALUES (:id, :coords, :rot, :model, :bucket)', {
        ['id'] = id,
        ['coords'] = json.encode(coords),
        ['rot'] = json.encode(rot),
        ['model'] = model,
        ['bucket'] = bucket
    }, function(data)
        Tables[prop] = {
            id = id,
            coords = coords,
            rot = rot,
            model = model,
            bucket = bucket
        }
    end)

    if not moving then
        if Config.Framework == "qb" then
            local src = source
            local Player = QBCore.Functions.GetPlayer(src)
            if Config.Inventory == "qb" or  Config.Inventory == "origen" or  Config.Inventory == "ps" or  Config.Inventory == "qs" then
                Player.Functions.RemoveItem("craftingtable", 1)
                TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['craftingtable'], "remove")
            elseif Config.Inventory == "ox" then
                exports.ox_inventory:RemoveItem(src, "craftingtable", 1)
            end
        elseif Config.Framework == "esx" then
            local src = source
            if Config.Inventory == 'ox' then
                exports.ox_inventory:RemoveItem(src, "craftingtable", 1)
            elseif Config.Inventory == 'qs' then
                exports['qs-inventory']:RemoveItem(src, "craftingtable", 1)
            end
        end 
    end
end)

RegisterNetEvent("zat-crafting:server:SaveStashItems", function(stashId, items)
    local src = source
    if Config.Inventory == "qs" then
        MySQL.insert('INSERT INTO inventory_stash (stash, items) VALUES (:stash, :items) ON DUPLICATE KEY UPDATE items = :items', {
            ['stash'] = stashId,
            ['items'] = json.encode(items)
        })
    else
        if Config.QBInventory == "old" then
            MySQL.insert('INSERT INTO stashitems (stash, items) VALUES (:stash, :items) ON DUPLICATE KEY UPDATE items = :items', {
                ['stash'] = stashId,
                ['items'] = json.encode(items)
            })
        else
            MySQL.Async.insert('INSERT INTO inventories (identifier, items) VALUES (:identifier, :items) ON DUPLICATE KEY UPDATE items = :items'
                , {
                ['identifier'] = stashId,
                ['items'] = json.encode(items)
            })
            -- It was working fine ! just we need to add them into the temp inv in the qb-inv by doing this :

            -- if the inventory does not exist we need to create it here otherwise it will not be able to add items into it . 
            -- stupid but true
            
            -----------------------------------------------------------------------------------------------------------------
            -----------------------------------------------------------------------------------------------------------------
            local oldItems = GetStashItems(stashId)
            for k, v in pairs(oldItems) do
                exports['qb-inventory']:RemoveItem(stashId, v.name,  v.amount, v.slot)
                Citizen.Wait(20)
            end
        end
    end
end)

RegisterNetEvent("zat-crafting:server:CheckBluePrintsAndStuff", function(stashid)
    if Config.Framework == "qb" then    
        local Data = {}
        local src = source
        local Player = QBCore.Functions.GetPlayer(src)
        local cid = Player.PlayerData.citizenid
        local myrep = MySQL.scalar.await('SELECT rep FROM craftingrep WHERE cid = ?', { cid })
        if myrep == nil then
            myrep = 0
        end
        if Config.Inventory == "qb" or  Config.Inventory == "origen" or  Config.Inventory == "ps" then
            for k, v in pairs(Config.craftables) do
                if v.requireBlueprint then
                    local items = GetStashItems(stashid)
                    for i, j in pairs(items) do
                        if j.name == "blueprint" then
                            if j.info.type == v.name then
                                if v.rep <=  myrep then
                                    local exists = false
                                    for x, y in pairs(Data) do
                                        if y[1].type == v.name then
                                            exists = true
                                        end
                                    end
                                    if not exists then
                                        table.insert(Data,{v.name, QBCore.Shared.Items[string.lower(v.name)].image,QBCore.Shared.Items[string.lower(v.name)].label, v.description, v.amount, v.time, v.info, v.costs})
                                    end
                                end
                            elseif j.info.type == v.info.type then
                                if v.rep <=  myrep then
                                    local exists = false
                                    for x, y in pairs(Data) do
                                        if y[7].type == v.info.type then
                                            exists = true
                                        end
                                    end
                                    if not exists then
                                        table.insert(Data,{v.name, QBCore.Shared.Items[string.lower(v.name)].image,QBCore.Shared.Items[string.lower(v.name)].label, v.description, v.amount, v.time, v.info, v.costs})
                                    end                           
                                end
                            end
                        end
                    end
                else
                    if v.rep <=  myrep then
                        table.insert(Data,{v.name, QBCore.Shared.Items[string.lower(v.name)].image,QBCore.Shared.Items[string.lower(v.name)].label, v.description, v.amount, v.time, v.info, v.costs})
                    end
                end
            end
        elseif Config.Inventory == "qs" then
            for k, v in pairs(Config.craftables) do
                if v.requireBlueprint then
                    local items = exports['qs-inventory']:GetStashItems(stashid)
                    if Config.Framework == 'esx' then
                        items = {}
                        items = exports['qs-inventory']:GetStashItems('Stash_'..stashid)
                    end
                    if items then
                        for i, j in pairs(items) do
                            if j.name == "blueprint" then
                                if j.info.type == v.name then
                                    if v.rep <=  myrep then
                                        local exists = false
                                        for x, y in pairs(Data) do
                                            if y[1].type == v.name then
                                                exists = true
                                            end
                                        end
                                        if not exists then
                                            table.insert(Data,{v.name, QBCore.Shared.Items[string.lower(v.name)].image,QBCore.Shared.Items[string.lower(v.name)].label, v.description, v.amount, v.time, v.info, v.costs})
                                        end
                                    end
                                elseif j.info.type == v.info.type then
                                    if v.rep <=  myrep then
                                        local exists = false
                                        for x, y in pairs(Data) do
                                            if y[7].type == v.info.type then
                                                exists = true
                                            end
                                        end
                                        if not exists then
                                            table.insert(Data,{v.name, QBCore.Shared.Items[string.lower(v.name)].image,QBCore.Shared.Items[string.lower(v.name)].label, v.description, v.amount, v.time, v.info, v.costs})
                                        end                           
                                    end
                                end
                            end
                        end
                    end
                else
                    if v.rep <=  myrep then
                        table.insert(Data,{v.name, QBCore.Shared.Items[string.lower(v.name)].image,QBCore.Shared.Items[string.lower(v.name)].label, v.description, v.amount, v.time, v.info, v.costs})               
                    end
                end
            end
        elseif Config.Inventory == "ox" then
            for k, v in pairs(Config.craftables) do
                if v.requireBlueprint then
                    local items = exports.ox_inventory:GetInventoryItems(stashid, false)
                    if items then
                        for i, j in pairs(items) do
                            if j.name == "blueprint" then
                                if j.metadata.type == v.name then
                                    if v.rep <=  myrep then
                                        local exists = false
                                        for x, y in pairs(Data) do
                                            if y[1].type == v.name then
                                                exists = true
                                            end
                                        end
                                        if not exists then
                                            table.insert(Data,{v.name, v.name..".png",itemNames[v.name], v.description, v.amount, v.time, v.info, v.costs})
                                        end
                                    end
                                elseif j.metadata.type == v.info.type then
                                    if v.rep <=  myrep then
                                        local exists = false
                                        for x, y in pairs(Data) do
                                            if y[7].type == v.info.type then
                                                exists = true
                                            end
                                        end
                                        if not exists then
                                            table.insert(Data,{v.name, v.name..".png",itemNames[v.name], v.description, v.amount, v.time, v.info, v.costs}) 
                                        end
                                    end
                                end
                            end
                        end
                    end
                else
                    if v.rep <=  myrep then
                        table.insert(Data,{v.name, v.name..".png",itemNames[v.name], v.description, v.amount, v.time, v.info, v.costs})               
                    end
                end
            end
        end
        TriggerClientEvent("zat-crafting:client:ShowTheseCraftables", src, myrep, Data)
    elseif Config.Framework == "esx" then  
        local Data = {}
        local src = source
        local Player = ESX.GetPlayerFromId(src)
        local cid = Player.getIdentifier()
        local myrep = MySQL.scalar.await('SELECT rep FROM craftingrep WHERE cid = ?', { cid })
        local items = exports.ox_inventory:GetInventoryItems(stashid, false)
        if myrep == nil then
            myrep = 0
        end
        for k, v in pairs(Config.craftables) do
            if v.requireBlueprint then
                if items then
                    for i, j in pairs(items) do
                        if j.name == "blueprint" then
                            if j.metadata.type == v.name then
                                if v.rep <=  myrep then
                                    local exists = false
                                    for x, y in pairs(Data) do
                                        if y[1].type == v.name then
                                            exists = true
                                        end
                                    end
                                    if not exists then
                                        table.insert(Data,{v.name, v.name..".png",itemNames[v.name], v.description, v.amount, v.time, v.info, v.costs})
                                
                                    end
                                end
                            elseif j.metadata.type == v.info.type then
                                if v.rep <=  myrep then
                                    local exists = false
                                    for x, y in pairs(Data) do
                                        if y[7].type == v.info.type then
                                            exists = true
                                        end
                                    end
                                    if not exists then
                                        table.insert(Data,{v.name, v.name..".png",itemNames[v.name], v.description, v.amount, v.time, v.info, v.costs})
                                    end
                                end
                            end
                        end
                    end
                end
            else
                if v.rep <=  myrep then
                    table.insert(Data,{v.name, v.name..".png",itemNames[v.name], v.description, v.amount, v.time, v.info, v.costs})               
                end
            end
        end
        TriggerClientEvent("zat-crafting:client:ShowTheseCraftables", src, myrep, Data)
    end
end)

RegisterNetEvent("zat-crafting:server:AddReputationBy", function(amount)
    if Config.Framework == "qb" then  
        local src = source
        local Player = QBCore.Functions.GetPlayer(src)
        local cid = Player.PlayerData.citizenid
        local result = MySQL.scalar.await('SELECT rep FROM craftingrep WHERE cid = ?', { cid })
    
        if result ~= nil then
            local rep = result + amount
            MySQL.update('UPDATE `craftingrep` SET `rep` = ? WHERE `cid` = ?', { rep, cid })
        else
            MySQL.insert('INSERT INTO craftingrep (`cid`, `rep`) VALUES (?, ?)', {
                cid, 
                amount
            })
        end
    elseif Config.Framework == "esx" then 
        local src = source
        local xPlayer = ESX.GetPlayerFromId(src)
        local cid = xPlayer.getIdentifier()
        local result = MySQL.scalar.await('SELECT rep FROM craftingrep WHERE cid = ?', { cid })

        if result ~= nil then
            local rep = result + amount
            MySQL.update('UPDATE `craftingrep` SET `rep` = ? WHERE `cid` = ?', { rep, cid })
        else
            MySQL.insert('INSERT INTO craftingrep (`cid`, `rep`) VALUES (?, ?)', {
                cid, 
                amount
            })
        end
    end
end)

RegisterNetEvent("zat-crafting:server:GiveBluePrint", function(item)
    if Config.Framework == "qb" then 
        local src = source
        local Player = QBCore.Functions.GetPlayer(src)
        local info = {
            type = item
        }
        Player.Functions.AddItem("blueprint", 1, false, info)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['blueprint'], "add")
    elseif Config.Framework == "esx" then 
        local src = source
        local Player = ESX.GetPlayerFromId(src)
        local info = {
            type = item
        }
        if Config.Inventory == 'ox' then
            exports.ox_inventory:AddItem(src, "blueprint", 1, info)
        elseif Config.Inventory == 'qs' then
            exports['qs-inventory']:AddItem(src, "blueprint", 1, nil, info)
        end
    end
end)

CreateThread(function()
    while true do
        Wait(1000)
        for k, v in pairs(Queue) do
            if v[1] ~= nil then
                v[1].itemData.time = v[1].itemData.time - 1
                if v[1].itemData.time <= 0 then
                    local items = {}
                    items [1] = v[1].itemData
                    AddItemsIntoStash("CraftingStorage_"..k, items)
                    table.remove(Queue[k],1)
                end
            end
        end
    end
end)


RegisterNetEvent('zat-crafting:server:Destroy', function(netId, what)
    local src = source
    local entity = NetworkGetEntityFromNetworkId(netId)
    if DoesEntityExist(entity) then
        DeleteEntity(entity)
        MySQL.query('DELETE FROM craftingtables WHERE id = ?', {Tables[entity].id})
        GiveItem(src, 'craftingtable', 1, nil)
    end
    Tables[entity] = nil
end)

RegisterNetEvent('zat-crafting:server:UpdateAfterMove', function(coords, rot, netId)
    local entity = NetworkGetEntityFromNetworkId(netId)
    Tables[entity].coords = coords
    Tables[entity].rot = rot
    MySQL.update('UPDATE craftingtables SET coords = ?, rot = ? WHERE id = ?', {json.encode(Tables[entity].coords), json.encode(Tables[entity].rot), Tables[entity].id})
end)

AddEventHandler('onResourceStop', function(resource)
    if resource ~= GetCurrentResourceName() then return end
    for k in pairs(Tables) do
        if DoesEntityExist(k) then
            DeleteEntity(k)
        end
    end
end)

-- OPTIMISATION

CreateThread(function()
    while true do
        Wait(Config.RefreshProps * 1000)
        local players = GetPlayers()
        for k, v in pairs(Tables) do
            local nearbyplayers = 0
            local coords = v.coords
            for _, j in pairs(players) do
                local pos = GetEntityCoords(GetPlayerPed(j))
                if pos ~= nil and coords ~= nil then
                    if #(vector3(pos.x, pos.y, pos.z) - vector3(coords.x, coords.y, coords.z)) <= Config.Radius then
                        nearbyplayers = nearbyplayers + 1
                    end
                end
            end
            if nearbyplayers == 0 then
                if DoesEntityExist(k) then
                    DeleteEntity(k)
                end
            else
                if DoesEntityExist(k) then
                    -- do nothing
                else
                    local prop   = CreateObjectNoOffset(GetHashKey(v.model), v.coords.x, v.coords.y, v.coords.z, true, true, false)
                    SetEntityRoutingBucket(prop, v.bucket)
                    SetEntityRotation(prop, vector3(v.rot.x, v.rot.y, v.rot.z))
                    FreezeEntityPosition(prop, true)
                    SetEntityDistanceCullingRadius(prop, 15.0)
                    Tables[prop]= v
                    Tables[k] = nil
                end
            end 
        end
    end
end)
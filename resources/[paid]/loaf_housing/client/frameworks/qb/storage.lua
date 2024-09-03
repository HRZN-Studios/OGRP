CreateThread(function()
    if Config.Framework ~= "qb" then return end
    while not loaded do Wait(500) end

    function OpenWardrobe()
        TriggerServerEvent("InteractSound_SV:PlayOnSource", "Clothes1", 0.4)
        TriggerEvent("qb-clothing:client:openOutfitMenu")
    end

    local function OpenStorage(propertyId, uniqueId, furnitureId, owner)
        local inventoryId = propertyId .. "_" .. uniqueId .. "_" .. furnitureId

        local slots, maxWeight = Config.DefaultSlots or 50, Config.DefaultWeight or 25000
        if cache.inInstance then
            local _, _, furnitureData = FindFurniture(cache.currentInstance.furniture[furnitureId]?.item)
            if furnitureData then
                slots, maxWeight = furnitureData.storageSlots or slots, furnitureData.storageWeight or maxWeight
            end
        end

        if Config.Inventory == "qs" or Config.Inventory == "qb-old" then
            inventoryId = inventoryId:gsub("-", "_")
            TriggerServerEvent("inventory:server:OpenInventory", "stash", inventoryId, {
                maxweight = maxWeight,
                slots = slots
            })
            TriggerEvent("inventory:client:SetCurrentStash", inventoryId)
            TriggerEvent("InteractSound_CL:PlayOnOne", "StashOpen", 0.4)
        elseif Config.Inventory == "ox" then
            exports.ox_inventory:openInventory("stash", {id = inventoryId, owner = owner})
        elseif Config.Inventory == "default" then
            TriggerServerEvent("loaf_housing:openQbStorage", inventoryId)
        end
    end

    function ChooseStorageMenu(propertyId, uniqueId, furnitureId, owner)
        if Config.RequireKeyStorage then
            if not exports.loaf_keysystem:HasKey(GetKeyName(propertyId, uniqueId)) then
                return Notify(Strings["need_key_storage"])
            end
        end

        local houseData = Houses[propertyId]

        local hasWardrobe, hasStorage
        local locations = houseData.locations

        if not locations and houseData.interior and Config.Interiors[houseData.interior] and Config.Interiors[houseData.interior].locations then
            locations = Config.Interiors[houseData.interior].locations
        end

        if not locations or not locations[furnitureId] then
            hasWardrobe = Config.Wardrobe
            hasStorage = true
        else
            hasWardrobe = locations[furnitureId].wardrobe
            hasStorage = locations[furnitureId].storage
        end

        local inventoryId = propertyId .. "_" .. uniqueId .. "_" .. furnitureId
        inventoryId = inventoryId:gsub("-", "_")

        if not hasWardrobe then
            OpenStorage(propertyId, uniqueId, furnitureId, owner)
            return
        elseif not hasStorage then
            OpenWardrobe()
            return
        end

        exports["qb-menu"]:openMenu({
            {
                header = Strings["choose_storage"],
                isMenuHeader = true
            },
            {
                header = Strings["storage"],
                params = {
                    event = function()
                        OpenStorage(propertyId, uniqueId, furnitureId, owner)
                    end,
                    isAction = true
                }
            },
            {
                header = Strings["wardrobe"],
                params = {
                    event = OpenWardrobe,
                    isAction = true
                }
            }
        })
    end
end)
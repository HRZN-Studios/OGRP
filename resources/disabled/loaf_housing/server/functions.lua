lib = exports.loaf_lib:GetLib()

boughtHouses = {}
rent = {}

if Config.SpawnRestart or Config.SpawnDisconnect then
    lib.RegisterCallback("loaf_housing:get_last_house", function(source, cb)
        MySQL.Async.fetchAll("SELECT `propertyid`, `id` FROM `loaf_current_property` WHERE `identifier`=@identifier", {["@identifier"] = GetIdentifier(source)}, function(res)
            cb(res and res[1])
        end)
    end)
end

lib.RegisterCallback("loaf_housing:fetch_houses", function(source, cb)
    while not Houses do
        Wait(500)
    end
    Wait(750)

    cb(boughtHouses)
end)

lib.RegisterCallback("loaf_housing:get_identifier", function(source, cb)
    cb(GetIdentifier(source))
end)

function GetAmountProperties(source)
    return MySQL.Sync.fetchScalar("SELECT COUNT(`owner`) FROM `loaf_properties` WHERE `owner`=@identifier", {
        ["@identifier"] = GetIdentifier(source)
    })
end

-- DOOR LOCKING
local unlocked = {}

function SetDoorLocked(propertyId, uniqueId, locked)
    local houseData = Houses[propertyId]
    if houseData.interiortype == "walkin" then
        GlobalState["loaf_housing_"..propertyId.."_1"] = not locked
        return
    end
    unlocked[tostring(propertyId.."_"..uniqueId)] = locked == false
end
exports("SetDoorLocked", SetDoorLocked)

function IsDoorLocked(propertyId, uniqueId)
    local houseData = Houses[propertyId]
    if houseData.interiortype == "walkin" then
        return not GlobalState["loaf_housing_"..propertyId.."_1"]
    end
    return not unlocked[tostring(propertyId.."_"..uniqueId)]
end
exports("IsDoorLocked", IsDoorLocked)

lib.RegisterCallback("loaf_housing:get_locked", function(source, cb, propertyId, uniqueId)
    if type(propertyId) == "number" and type(uniqueId) == "string" then
        cb(IsDoorLocked(propertyId, uniqueId))
    else
        cb(true)
    end
end)

-- GET PROPERTY
function GetPropertyData(propertyId, id)
    local data = MySQL.Sync.fetchAll("SELECT * FROM `loaf_properties` WHERE `propertyid`=@propertyid AND `id`=@id", {
        ["@propertyid"] = propertyId,
        ["@id"] = id
    })
    if data and data[1] then
        return data[1]
    end
    return false
end

function DoesPlayerOwnProperty(source, propertyid)
    local identifier = GetIdentifier(source)
    for i, data in pairs(boughtHouses) do
        if data.propertyid == propertyid and data.owner == identifier then
            return true, i
        end
    end
end

function BackupHouse(owner, propertyid, cb)
    if not Config.BackupRemovedHouse then
        if cb then cb() end
        return
    end

    MySQL.Async.fetchAll("SELECT * FROM loaf_properties WHERE `owner`=@owner AND `propertyid`=@propertyid", {
        ["@owner"] = owner,
        ["@propertyid"] = propertyid
    }, function(res)
        if not res or not res[1] then return end

        local insert, values = "", ""
        for k, v in pairs(res[1]) do
            insert = insert .. "`"..k.."`"
            if type(v) == "string" then
                values = values .. "\"".. v:gsub('"', '""') .. "\""
            elseif type(v) == "number" then
                values = values .. v
            end
            if next(res[1], k) then
                insert = insert .. ", "
                values = values .. ", "
            end
        end

        local backup = ("-- BACKUP FOR IDENTIFIER %s, PROPERTY #%i, UNIQUE PROPERTY ID %s\n"):format(owner, propertyid, res[1].id)
        backup = backup .. ("INSERT INTO `loaf_properties` (%s) VALUES (%s);"):format(insert, values)
        if res[1].rent then
            backup = backup .. "\n" .. ('INSERT INTO `loaf_rent` (`rent_wallet`, `owner`, `propertyid`, `balance`, `rent_due`) VALUES ("%s", "%s", %i, 0, 0);'):format(res[1].rent, res[1].owner, res[1].propertyid)
        end

        local backupId = lib.GenerateString(50)
        SaveResourceFile(GetCurrentResourceName(), ("RemovedHousesBackup/%s.sql"):format(backupId), backup, -1)
        local fileLocation = GetResourcePath(GetCurrentResourceName()) .. "/RemovedHousesBackup/" .. backupId .. ".sql"
        lib.Log({
            webhook = Webhooks.Backup,
            category = "Housing",
            type = "success",
            title = "Backup",
            text = Strings["LOG_backed_up"]:format(owner, propertyid, res[1].id, fileLocation)
        })
        if cb then cb() end
    end)
end

function RemoveProperty(identifier, propertyId, cb)
    local houseExists
    for i, data in pairs(boughtHouses) do
        if data.propertyid == propertyId and data.owner == identifier then
            houseExists = true
            table.remove(boughtHouses, i)
            break
        end
    end

    if not houseExists then
        if cb then cb(false) end
        return
    end

    local houseData = Houses[propertyId]
    if houseData and houseData.doors then
        for door, doorData in pairs(houseData.doors) do
            GlobalState["loaf_housing_"..propertyId.."_"..door] = nil
        end
    end

    TriggerClientEvent("loaf_housing:update_houses", -1, boughtHouses)

    BackupHouse(identifier, propertyId, function()
        MySQL.Async.fetchScalar("SELECT `id` FROM `loaf_properties` WHERE `owner`=@owner AND `propertyid`=@propertyid", {
            ["@owner"] = identifier,
            ["@propertyid"] = propertyId
        }, function(id)
            if not id then return cb(false) end

            local instanceid = GetInstance(propertyId, id)
            if instanceid then DeleteInstance(instanceid) end

            exports.loaf_keysystem:RemoveAllKeys(GetKeyName(propertyId, id))
            MySQL.Async.execute("DELETE FROM `loaf_properties` WHERE `owner`=@owner AND `propertyid`=@propertyid", {
                ["@owner"] = identifier,
                ["@propertyid"] = propertyId
            }, function()
                if cb then cb(true) end
            end)
            MySQL.Async.execute("DELETE FROM `loaf_rent` WHERE `owner`=@owner AND `propertyid`=@propertyid", {
                ["@owner"] = identifier,
                ["@propertyid"] = propertyId
            })
        end)
    end)
end

lib.RegisterCallback("loaf_housing:preview_property", function(source, cb, propertyId)
    if IsInInstance(source) then
        return cb(false)
    end

    Player(source).state.instance = "preview:"..propertyId
    cb(true)
end)

RegisterNetEvent("loaf_housing:stop_previewing", function()
    if not IsInInstance(source) then
        Player(source).state.instance = nil
    end
end)

-- fetch houses
MySQL.ready(function()
    Wait(500)

    while not Houses do
        Wait(500)
    end

    MySQL.Async.fetchAll("SELECT `owner`, `propertyid`, `id`, `rent` FROM `loaf_properties`", {}, function(res)
        boughtHouses = res
        for _, boughtHouse in pairs(res) do
            local houseData = Houses[boughtHouse.propertyid]
            if not houseData then
                print("^1[FATAL ERROR]^0 Someone owns house " .. boughtHouse.propertyid .. ", but it doesn't exist in the config. Consider removing it from the database, or adding the house.")
            end
            if houseData?.locations then
                for k, v in pairs(houseData.locations) do
                    if v.storage then
                        RegisterStash(boughtHouse.propertyid, boughtHouse.id, k, Config.DefaultSlots or 50, Config.DefaultWeight or 25000, boughtHouse.owner)
                    end
                end
            end
        end
    end)
end)

local qbStashes = {}

function RegisterStash(propertyId, uniqueId, furnitureId, slots, weight, owner)
    local inventoryId = propertyId .. "_" .. uniqueId .. "_" .. furnitureId

    if Config.Inventory == "ox" then
        exports.ox_inventory:RegisterStash(inventoryId, Strings["inventory"], slots, weight, owner)
    elseif Config.Inventory == "modfreakz" then
        if not exports["mf-inventory"]:getInventory(inventoryId) then
            exports["mf-inventory"]:createInventory(inventoryId, "inventory", "housing", "house_storage", weight/1.0, slots, {})
        end
    elseif Config.Inventory == "default" and Config.Framework == "qb" then
        qbStashes[inventoryId] = { slots = slots, weight = weight }
    end
end

RegisterNetEvent("loaf_housing:openQbStorage", function(inventoryId)
    local src = source
    local stash = qbStashes[inventoryId]

    if not stash then
        return
    end

    exports["qb-inventory"]:OpenInventory(src, inventoryId, {
        maxweight = stash.weight or Config.DefaultWeight,
        slots = stash.slots or Config.DefaultSlots,
        label = Strings["inventory"]
    })
end)

lib.RegisterCallback("loaf_housing:give_key", function(source, cb, propertyId, playerId)
    local owns, i = DoesPlayerOwnProperty(source, propertyId)
    if not owns then
        return cb(false, "dont_own")
    end

    if not GetIdentifier(playerId) then
        return cb(false, "not_online")
    end

    GiveKey(playerId, propertyId, boughtHouses[i].id)
    cb(true)
end)

lib.RegisterCallback("loaf_housing:get_key_holders", function(source, cb, propertyId)
    local owns, i = DoesPlayerOwnProperty(source, propertyId)
    if not owns then
        return cb({})
    end

    local uniqueId = boughtHouses[i].id
    local keyName = GetKeyName(propertyId, uniqueId)
    local result = MySQL.Sync.fetchAll("SELECT `identifier` FROM `loaf_keys` WHERE `key_id`=@keyName", {["@keyName"] = keyName})
    local keyHolders = {}
    local inserted = {}
    for _, v in pairs(result) do
        if not inserted[v.identifier] then
            inserted[v.identifier] = true

            local name = v.identifier
            if Config.Framework == "qb" then
                local result = MySQL.Sync.fetchScalar("SELECT `charinfo` FROM `players` WHERE `citizenid`=@citizenid", {["@citizenid"] = v.identifier})
                if result and json.decode(result) then
                    local charinfo = json.decode(result)
                    name = charinfo.firstname .. " " .. charinfo.lastname
                end
            elseif Config.Framework == "esx" then
                local result = MySQL.Sync.fetchAll("SELECT `firstname`, `lastname` FROM `users` WHERE `identifier`=@identifier", {["@identifier"] = v.identifier})
                if result and result[1] then
                    name = result[1].firstname .. " " .. result[1].lastname
                end
            end

            table.insert(keyHolders, {
                identifier = v.identifier,
                name = name
            })
        end
    end
    cb(keyHolders)
end)

lib.RegisterCallback("loaf_housing:remove_key_holder", function(source, cb, propertyId, identifier)
    local owns, i = DoesPlayerOwnProperty(source, propertyId)
    if not owns then
        return cb(false, "dont_own")
    end

    local uniqueId = boughtHouses[i].id
    local keyName = GetKeyName(propertyId, uniqueId)
    MySQL.Async.fetchAll("SELECT `unique_id` FROM `loaf_keys` WHERE `key_id`=@keyId AND `identifier`=@identifier", {
        ["@keyId"] = keyName,
        ["@identifier"] = identifier
    }, function(keys)
        if keys then
            for _, v in pairs(keys) do
                exports.loaf_keysystem:RemoveKey(v.unique_id)
            end
        end
    end)

    cb(true)
end)

--- VERSION CHECK ---
CreateThread(function()
    PerformHttpRequest("https://loaf-scripts.com/versions/", function(err, text, headers)
        print(text or "^3[WARNING]^0 Error checking script version, the website did not respond. (This is not an error on your end)")
    end, "POST", json.encode({
        resource = "housing",
        version = GetResourceMetadata(GetCurrentResourceName(), "version", 0) or "2.0.0"
    }), {["Content-Type"] = "application/json"})
end)
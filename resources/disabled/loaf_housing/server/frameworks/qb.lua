CreateThread(function()
    if Config.Framework ~= "qb" then return end
    local QBCore = exports["qb-core"]:GetCoreObject()

    function GetPlayerFromIdentifier(citizenid)
        return QBCore.Functions.GetPlayerByCitizenId(citizenid)?.PlayerData.source
    end

    function CanBreach(source)
        if not Config.PoliceRaid.Enabled then
            return false
        end

        local job = QBCore.Functions.GetPlayer(source).PlayerData.job

        for jobName, grade in pairs(Config.PoliceRaid.Jobs) do
            if jobName == job.name and job.grade.level >= grade then
                return true
            end
        end

        return false
    end

    -- lockpick
    lib.RegisterCallback("loaf_housing:get_lockpicks", function(source, cb, remove)
        local qPlayer = QBCore.Functions.GetPlayer(source)
        local lockpick = qPlayer.Functions.GetItemByName("lockpick")
        if remove and lockpick then
            if lockpick.amount > 0 then
                RemoveItem(source, "lockpick", 1)
                lockpick.amount = lockpick.amount - 1
            end
        end
        cb(lockpick?.amount or 0)
    end)

    lib.RegisterCallback("loaf_housing:start_lockpicking", function(source, cb, propertyId, uniqueId)
        if not Config.Lockpicking.Enabled or lockpicking[tostring(source)] then return cb(false) end
        local online = 0
        for _, source in pairs(QBCore.Functions.GetPlayers()) do
            local qPlayer = QBCore.Functions.GetPlayer(source)
            for _, job in pairs(Config.Lockpicking.Police) do
                if qPlayer.PlayerData.job.name == job then
                    online += 1
                end
            end
        end
        local allowed = online >= Config.Lockpicking.MinimumPolice
        if allowed then
            lockpicking[tostring(source)] = true
            NotifyPolice(Houses[propertyId].entrance.xyz, uniqueId)
        end
        cb(allowed)
    end)

    function NotifyPolice(coords, uniqueId)
        for _, source in pairs(QBCore.Functions.GetPlayers()) do
            local qPlayer = QBCore.Functions.GetPlayer(source)
            for _, job in pairs(Config.Lockpicking.Police) do
                if qPlayer.PlayerData.job.name == job then
                    TriggerClientEvent("loaf_housing:lockpick_alert", source, coords, uniqueId)
                end
            end
        end
    end

    -- general functions
    function HasMoney(source, amount)
        local qPlayer = QBCore.Functions.GetPlayer(source)
        if not qPlayer then return false end
        if qPlayer.Functions.GetMoney("cash") >= amount then
            return true, "cash"
        elseif qPlayer.Functions.GetMoney("bank") >= amount then
            return true, "bank"
        end

        return false
    end

    function AddMoney(source, amount)
        local qPlayer = QBCore.Functions.GetPlayer(source)
        if not qPlayer then return false end
        qPlayer.Functions.AddMoney("cash", amount, "loaf-housing")
        return true
    end

    function PayMoney(source, amount)
        local qPlayer = QBCore.Functions.GetPlayer(source)
        if not qPlayer then return false end

        local hasMoney, account = HasMoney(source, amount)
        if not hasMoney then return false end

        qPlayer.Functions.RemoveMoney(account, amount, "loaf-housing")
        return true
    end

    function Notify(source, msg)
        TriggerClientEvent("QBCore:Notify", source, msg)
    end

    function GetIdentifier(source)
        local qPlayer = QBCore.Functions.GetPlayer(source)
        if not qPlayer then return false end
        return qPlayer.PlayerData.citizenid
    end

    function SetPlayerCoordinates(identifier, coords)
        Wait(7500)
        local pos = json.encode({
            x = tonumber(string.format("%.2f", coords.x)),
            y = tonumber(string.format("%.2f", coords.y)),
            z = tonumber(string.format("%.2f", coords.z)),
        })
        MySQL.Async.execute("UPDATE `players` SET `position`=@position WHERE `citizenid`=@identifier", {
            ["@position"] = pos,
            ["@identifier"] = identifier
        }, function()
            print(identifier, pos)
            print("set coordinates due to leaving in instance")
        end)
    end

    -- items
    function RemoveItem(source, item, amount)
        local qPlayer = QBCore.Functions.GetPlayer(source)
        local itemData = qPlayer.Functions.GetItemByName(item)
        if not itemData or itemData.amount <= 0 then return false end
        qPlayer.Functions.RemoveItem(item, amount, false)
        return true
    end

    -- qb-houses functionality
    if not Config.QBExports then
        return
    end

    while not Houses do
        Wait(0)
    end

    local QBHouses
    local function RefreshHouses()
        QBHouses = {}
        for k, v in pairs(Houses) do
            QBHouses[k] = {
                coords = {
                    enter = {
                        x = v.entrance.x,
                        y = v.entrance.y,
                        z = v.entrance.z,
                        h = v.entrance.w
                    },
                    cam = {
                        x = v.entrance.x,
                        y = v.entrance.y,
                        z = v.entrance.z,
                        h = v.entrance.w,
                        yaw = -10.0
                    }
                },
                owned = MySQL.Sync.fetchScalar("SELECT `propertyid` FROM `loaf_properties` WHERE `propertyid`=@id", {["@id"] = k}) ~= nil,
                price = v.price,
                locked = true,
                adress = v.label,
                tier = 1,
                garage = v.garage and {
                    x = v.garage.exit.x,
                    y = v.garage.exit.y,
                    z = v.garage.exit.z,
                    h = v.garage.exit.w
                } or {},
                decorations = {}
            }
        end
        TriggerClientEvent("qb-houses:client:setHouseConfig", -1, QBHouses)
    end

    RegisterNetEvent("loaf_housing:update", RefreshHouses)
    RefreshHouses()

    -- https://github.com/qbcore-framework/qb-houses/blob/b8ff10ebf66e37ae934a993021bcdf364d89121d/server/main.lua#L544
    QBCore.Functions.CreateCallback("qb-phone:server:GetPlayerHouses", function(source, cb)
        local qPlayer = QBCore.Functions.GetPlayer(source)
        local ownedHouses = {}
        local houses = MySQL.Sync.fetchAll("SELECT * FROM `loaf_properties` WHERE `owner`=@citizenid", {["@citizenid"] = qPlayer.PlayerData.citizenid})

        for _, v in pairs(houses) do
            local keyName = GetKeyName(v.propertyid, v.id)
            local keyHolders = {
                {
                    charinfo = {
                        firstname = qPlayer.PlayerData.charinfo.firstname,
                        lastname = qPlayer.PlayerData.charinfo.lastname
                    },
                    citizenid = qPlayer.PlayerData.citizenid,
                    name = qPlayer.PlayerData.name
                }
            }
            local addedHolders = {
                [qPlayer.PlayerData.citizenid] = true
            }
            local owners = MySQL.Sync.fetchAll("SELECT * FROM `loaf_keys` WHERE `key_id`=@keyName", {["@keyName"] = keyName})
            for _, v in pairs(owners) do
                if not addedHolders[v.identifier] then
                    addedHolders[v.identifier] = true
                    local keyHolderData = MySQL.Sync.fetchAll("SELECT * FROM `players` WHERE `citizenid`=@citizenid", {["@citizenid"] = v.identifier})
                    if keyHolderData then
                        keyHolderData[1].charinfo = json.decode(keyHolderData[1].charinfo)
                        table.insert(keyHolders, {
                            charinfo = {
                                firstname = keyHolderData[1].charinfo.firstname,
                                lastname = keyHolderData[1].charinfo.lastname
                            },
                            citizenid = keyHolderData[1].citizenid,
                            name = keyHolderData[1].name
                        })
                    end
                end
            end
            local propertyData = QBHouses[v.propertyid]
            table.insert(ownedHouses, {
                name = v.propertyid,
                keyholders = keyHolders,
                owner = qPlayer.PlayerData.citizenid,
                price = propertyData.price,
                label = propertyData.adress,
                tier = propertyData.tier,
                garage = propertyData.garage
            })
        end

        cb(ownedHouses)
    end)

    -- https://github.com/qbcore-framework/qb-houses/blob/b8ff10ebf66e37ae934a993021bcdf364d89121d/server/main.lua#L612
    QBCore.Functions.CreateCallback("qb-phone:server:GetHouseKeys", function(source, cb)
        local houseKeys = {}
        local allKeys = exports.loaf_keysystem:GetKeys(source)

        for _, v in pairs(allKeys) do
            if string.find(v.key_id, "housing_key_") then
                local key = v.key_id:gsub("housing_key_", "")
                local propertyId, uniqueId = string.gmatch(key, "(.+)_(.+)")()
                propertyId = tonumber(propertyId)

                table.insert(houseKeys, {
                    HouseData = QBHouses[propertyId]
                })
            end
        end

        cb(houseKeys)
    end)

    -- https://github.com/qbcore-framework/qb-houses/blob/b8ff10ebf66e37ae934a993021bcdf364d89121d/server/main.lua#L265
    RegisterNetEvent("qb-houses:server:removeHouseKey", function(propertyId, citizenData)
        local src = source
        local qPlayer = QBCore.Functions.GetPlayer(source)

        local uniqueId = MySQL.Sync.fetchScalar("SELECT `id` FROM `loaf_properties` WHERE `owner`=@owner AND `propertyid`=@propertyid", {
            ["@owner"] = qPlayer.PlayerData.citizenid,
            ["@propertyid"] = propertyId
        })
        if uniqueId then
            local keyName = GetKeyName(propertyId, uniqueId)
            MySQL.Async.fetchAll("SELECT `unique_id` FROM `loaf_keys` WHERE `key_id`=@keyId AND `identifier`=@citizenid", {
                ["@keyId"] = keyName,
                ["@citizenid"] = citizenData.citizenid
            }, function(keys)
                if keys then
                    for _, v in pairs(keys) do
                        exports.loaf_keysystem:RemoveKey(v.unique_id)
                    end
                end
            end)
        end
    end)

    -- https://github.com/qbcore-framework/qb-houses/blob/b8ff10ebf66e37ae934a993021bcdf364d89121d/server/main.lua#L473
    QBCore.Functions.CreateCallback("qb-phone:server:TransferCid", function(source, cb, transferTo, house)
        if transferTo and tonumber(transferTo) then
            TransferProperty(source, cb, house.name, tonumber(transferTo))
        end
    end)

    -- https://github.com/qbcore-framework/qb-spawn/blob/716b376cf1d06a6671cd4c08b7d346acf2d56c8a/server.lua#L3
    Wait(1000) -- wait for qb-spawn to register the callback first

    QBCore.Functions.CreateCallback("qb-spawn:server:getOwnedHouses", function(source, cb, citizenid)
        MySQL.Async.fetchAll("SELECT `propertyid` FROM `loaf_properties` WHERE `owner`=@citizenid", {
            ["@citizenid"] = citizenid
        }, function(ownedHouses)
            local houses = {}
            for _, v in pairs(ownedHouses or {}) do
                table.insert(houses, {
                    house = v.propertyid,
                    adress = Houses[v.propertyid].label
                })
            end

            TriggerClientEvent("qb-houses:client:setHouseConfig", source, QBHouses)
            Wait(300)
            cb(houses)
        end)
    end)

    AddEventHandler("__cfx_export_qb-houses_hasKey", function(setCallback)
        setCallback(function(identifier, citizenid, propertyId)
            local uniqueId = MySQL.Sync.fetchScalar("SELECT `id` FROM `loaf_properties` WHERE `propertyid`=@propertyId AND `owner`=@citizenid", {
                ["@propertyId"] = propertyId,
                ["@citizenid"] = citizenid
            })

            if uniqueId then
                return true
            end

            local source = GetPlayerFromIdentifier(citizenid)
            if not source then
                return false
            end

            local keys = exports.loaf_keysystem:GetKeys(source)
            if not keys then
                return false
            end

            for _, v in pairs(keys) do
                local _, _, id = v.key_id:find("housing_key_(.*)_")
                if id and tonumber(id) == propertyId then
                    return true
                end
            end

            return false
        end)
    end)
end)
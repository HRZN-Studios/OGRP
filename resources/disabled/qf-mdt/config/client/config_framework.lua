FRAMEWORK = {}
ESX = {}
QB = {}
CUSTOM = {}
PlayerData = {}

---@return boolean
FRAMEWORK.IsPlayerLoaded = function()
    if Config.Frameworks.ESX.enabled then
        return ESX.IsPlayerLoaded()
    elseif Config.Frameworks.QB.enabled then
        return LocalPlayer.state.isLoggedIn
    else
        print('[^2INFO] ^0[^5QF-MDT^0] encountered a problem at [^5IsPlayerLoaded^0], if you are using a [^5CUSTOM FRAMEWORK / STANDALONE^0] open a ticket on our discord server and wait for help with configuration!')
        return true -- OR YOUR OWN FRAMEWORK FUNCTION
    end
end

FRAMEWORK.GetPlayerData = function()
    if Config.Frameworks.ESX.enabled then
        return ESX.GetPlayerData()
    elseif Config.Frameworks.QB.enabled then
        return QBCore.Functions.GetPlayerData()
    else
        print('[^2INFO] ^0[^5QF-MDT^0] encountered a problem at [^5GetPlayerData^0], if you are using a [^5CUSTOM FRAMEWORK / STANDALONE^0] open a ticket on our discord server and wait for help with configuration!')
        return -- YOUR OWN FRAMEWORK FUNCTION
    end
end

FRAMEWORK.ShowNotification = function(msg)
    if Config.Frameworks.ESX.enabled then
        return ESX.ShowNotification(msg)
    elseif Config.Frameworks.QB.enabled then
        return QBCore.Functions.Notify(msg)
    else
        SetNotificationTextEntry('STRING')
        AddTextComponentString(msg)
        DrawNotification(0,1)
        print('[^2INFO] ^0[^5QF-MDT^0] encountered a problem at [^5ShowNotification^0], if you are using a [^5CUSTOM FRAMEWORK / STANDALONE^0] open a ticket on our discord server and wait for help with configuration!')
        -- OR YOUR OWN FRAMEWORK FUNCTION
    end
end

RegisterNetEvent('qf_mdt:showNotification', FRAMEWORK.ShowNotification)

FRAMEWORK.GetMdtPlayerData = function()
    local p = promise.new()
    
    CALLBACK.TriggerServerCallback('qf_mdt:getMDTData', function(data, notes, annoucements, officers, lastNotes)
        p:resolve({data, notes, annoucements, officers, lastNotes})
    end)

    return Citizen.Await(p)
end

local function GetPlayers(onlyOtherPlayers, returnKeyValue, returnPeds)
    local players, myPlayer = {}, PlayerId()

    for _, player in ipairs(GetActivePlayers()) do
        local ped = GetPlayerPed(player)

        if DoesEntityExist(ped) and ((onlyOtherPlayers and player ~= myPlayer) or not onlyOtherPlayers) then
            if returnKeyValue then
                players[player] = ped
            else
                players[#players + 1] = returnPeds and ped or player
            end
        end
    end

    return players
end

local function GetClosestEntity(entities, isPlayerEntities, coords, modelFilter)
    local closestEntity, closestEntityDistance, filteredEntities = -1, -1, nil

    if coords then
        coords = vector3(coords.x, coords.y, coords.z)
    else
        local playerPed = PlayerPedId()
        coords = GetEntityCoords(playerPed)
    end

    if modelFilter then
        filteredEntities = {}

        for _, entity in pairs(entities) do
            if modelFilter[GetEntityModel(entity)] then
                filteredEntities[#filteredEntities + 1] = entity
            end
        end
    end

    for k, entity in pairs(filteredEntities or entities) do
        local distance = #(coords - GetEntityCoords(entity))

        if closestEntityDistance == -1 or distance < closestEntityDistance then
            closestEntity, closestEntityDistance = isPlayerEntities and k or entity, distance
        end
    end

    return closestEntity, closestEntityDistance
end

local function GetClosestPlayer(coords)
    return GetClosestEntity(GetPlayers(true, true), true, coords, nil)
end

---@param coords vector3
---@return number | nil, number | nil
FRAMEWORK.GetClosestPlayer = function(coords)
    if Config.Frameworks.ESX.enabled then
        return ESX.Game.GetClosestPlayer(coords)
    elseif Config.Frameworks.QB.enabled then
        return QBCore.Functions.GetClosestPlayer(coords)
    else
        print('[^2INFO] ^0[^5QF-MDT^0] encountered a problem at [^5GetClosestPlayer^0], if you are using a [^5CUSTOM FRAMEWORK / STANDALONE^0] open a ticket on our discord server and wait for help with configuration!')
        GetClosestPlayer(coords)
        -- SCRIPT IT BY OWN
    end
end

---@return number | nil
FRAMEWORK.GetVehicleInDirection = function()
    if Config.Frameworks.ESX.enabled then
        return ESX.Game.GetVehicleInDirection()
    elseif Config.Frameworks.QB.enabled then
        return QBCore.Functions.GetClosestVehicle()
    else
        print('[^2INFO] ^0[^5QF-MDT^0] encountered a problem at [^5GetVehicleInDirection^0], if you are using a [^5CUSTOM FRAMEWORK / STANDALONE^0] open a ticket on our discord server and wait for help with configuration!')
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        local inDirection = GetOffsetFromEntityInWorldCoords(playerPed, 0.0, 5.0, 0.0)
        local rayHandle = StartExpensiveSynchronousShapeTestLosProbe(playerCoords, inDirection, 10, playerPed, 0)
        local _, hit, _, _, entityHit = GetShapeTestResult(rayHandle)

        if hit == 1 and GetEntityType(entityHit) == 2 then
            local entityCoords = GetEntityCoords(entityHit)
            return entityHit, entityCoords
        end

        return nil
        -- OR SCRIPT IT BY OWN
    end
end

if Config.Frameworks.ESX.enabled then

    RegisterNetEvent('esx:playerLoaded', function(xPlayer)
        PlayerData = xPlayer

        if PlayerData then
            TriggerServerEvent('qf_mdt:getHours')
        end
    end)

    RegisterNetEvent('esx:setJob', function(job)
        PlayerData.job = job

        if Config.Jobs.OnDuty[PlayerData.job.name] then
            CLIENT.SetPlayerData()
        end
    end)

    RegisterNetEvent('esx:onPlayerLogout', function()
        PlayerData = {}
    end)

elseif Config.Frameworks.QB.enabled then

    RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
        PlayerData = FRAMEWORK.GetPlayerData()

        if PlayerData then
            TriggerServerEvent('qf_mdt:getHours')
        end
    end)

    RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
        PlayerData.job = JobInfo

        if Config.Jobs.OnDuty[PlayerData.job.name] then
            CLIENT.SetPlayerData()
        end
    end)

    RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
        PlayerData = {}
    end)

else
    print('[^2INFO] ^0[^5QF-MDT^0] encountered a problem at [^5Set framework events^0], if you are using a [^5CUSTOM FRAMEWORK / STANDALONE^0] open a ticket on our discord server and wait for help with configuration!')
    -- YOUR OWN FRAMEWORK EVENTS
end

Citizen.CreateThread(function()
    if Config.Frameworks.ESX.enabled then
        ESX = exports[Config.Frameworks.ESX.frameworkScript][Config.Frameworks.ESX.frameworkExport]()
    elseif Config.Frameworks.QB.enabled then
        QBCore = exports[Config.Frameworks.QB.frameworkScript][Config.Frameworks.QB.frameworkExport]()
    else
        print('[^2INFO] ^0[^5QF-MDT^0] encountered a problem at [^5Client Framework Export^0], if you are using a [^5CUSTOM FRAMEWORK / STANDALONE^0] open a ticket on our discord server and wait for help with configuration!')
        -- CUSTOM = YOUR OWN FRAMEWORK EXPORT
    end

    while not FRAMEWORK.IsPlayerLoaded() do
        Citizen.Wait(150)
    end
    
    PlayerData = FRAMEWORK.GetPlayerData()

    CLIENT.Load()
    CLIENT.SetPlayerData()
end)
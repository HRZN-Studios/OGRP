Core = nil

Config.Framework = "STANDALONE"

local startTime = GetGameTimer()
while Core == nil do
    TriggerEvent("__cfx_export_qb-core_GetCoreObject", function(getCore)
        Core = getCore()
        Config.Framework = "QBCore"
        if GetResourceState("qbx_core") ~= "missing" then
            Config.IsQBX = true
            load(LoadResourceFile("ox_lib", "init.lua"))()
        end
    end)

    TriggerEvent("__cfx_export_es_extended_getSharedObject", function(getCore)
        Core = getCore()
        Config.Framework = "ESX"
    end)

    Citizen.Wait(1000)

    if GetGameTimer() - startTime >= 25000 then
        Functions.Print("Cannot fetch your framework. Please make sure you're using ESX or QBCore, and you're starting Character System after your framework")
    end
end

RegisterNetEvent("17mov_CharacterSystem:SkinMenuOpened", function()
    -- You can add custom code after skin menu open
    TriggerEvent("__cfx_export_qs-inventory_SetInClothing", true)
end)

RegisterNetEvent("17mov_CharacterSystem:SkinMenuClosed", function()
    -- You can add custom code after skin menu open
    TriggerEvent("__cfx_export_qs-inventory_SetInClothing", false)
end)

function Register.OpenCustom(characterId)
    -- Here you can implement your custom register system when using Register.Enable = false
    print("Opened character register for slot:", characterId)
end

function Location.PlayerSpawned(isNew)
    -- Here you can add some custom code after player spawned

    if Config.Framework == "QBCore" then
        local PlayerData = Core?.Functions.GetPlayerData()

        while PlayerData == nil do
            PlayerData = Core?.Functions.GetPlayerData()
        end

        local insideMeta = PlayerData.metadata["inside"]

        if insideMeta.house ~= nil then
            local houseId = insideMeta.house
            TriggerEvent('qb-houses:client:LastLocationHouse', houseId)
        elseif insideMeta.apartment.apartmentType ~= nil or insideMeta.apartment.apartmentId ~= nil then
            local apartmentType = insideMeta.apartment.apartmentType
            local apartmentId = insideMeta.apartment.apartmentId
            TriggerEvent('qb-apartments:client:LastLocationHouse', apartmentType, apartmentId)
        else
            TriggerServerEvent('qb-houses:server:SetInsideMeta', 0, false)
            TriggerServerEvent('qb-apartments:server:SetInsideMeta', 0, 0, false)
        end

        TriggerServerEvent('QBCore:Server:OnPlayerLoaded')
        TriggerEvent('QBCore:Client:OnPlayerLoaded')
    elseif Config.Framework == "ESX" then
        -- Here you can add your custom code
    end

    DisplayRadar(true)

    if isNew then
        TriggerEvent("inventory:client:GiveStarterItems")
    end
end

function ShowHelpNotification(msg)
    if msg == nil then return end
    AddTextEntry('HelpNotification', msg)
    DisplayHelpTextThisFrame('HelpNotification', false)
end

function Notify(msg)
    if Config.Framework == "QBCore" then
        Core?.Functions.Notify(msg)
    elseif Config.Framework == "ESX" then
        Core?.ShowNotification(msg)
    else
        SetNotificationTextEntry('STRING')
        AddTextComponentString(msg)
        DrawNotification(false, true)
    end
end

function GetJob()
    if Config.Framework == "QBCore" then
        local playerData = Core?.Functions.GetPlayerData()
        return playerData.job.name
    elseif Config.Framework == "ESX" then
        local playerData = Core?.GetPlayerData()
        return playerData.job.name
    end

    return nil
end

function GetGang()
    if Config.Framework == "QBCore" then
        local playerData = Core?.Functions.GetPlayerData()
        return playerData.gang.name
    elseif Config.Framework == "ESX" then
        -- No default gang system, need to implement at your own
    end

    return nil
end

function GetIdentifier()
    if Config.Framework == "QBCore" then
        local playerData = Core?.Functions.GetPlayerData()
        return playerData.license
    elseif Config.Framework == "ESX" then
        local playerData = Core?.GetPlayerData()
        return playerData.identifier
    end

    return nil
end

-- Target system
if Config.UseTarget then
    if Config.Framework == "QBCore" then
        Config.TargetSystem = "qb-target"
    else
        Config.TargetSystem = "qtarget"
    end

    if GetResourceState("ox_target") ~= "missing" then
        Config.TargetSystem = "qtarget"    -- OX_Target have a backward compability to qtarget
    end
end

function AddTargetStorePed(ped, shopType, shopIndex)
    exports[Config.TargetSystem]:AddTargetEntity(ped, {
        options = {
            {
                event = "17mov_CharacterSystem:OpenStore",
                icon = "fa-solid fa-shirt",
                label = _L("Store.Use"),
                shopType = shopType,
                shopIndex = shopIndex,
                canInteract = function(entity)
                    return #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(entity)) < 5.0
                end
            },
        },
        distance = 2.5
    })
end

if Skin.EnableRefreshSkinCommand then
    local isCommandBlocked = false
    local lastCommandTime = 0
    local commandCooldown = 5000
    RegisterCommand("refreshSkin", function()
        local currentTime = GetGameTimer()
        if isCommandBlocked or currentTime - lastCommandTime < commandCooldown then
            return Notify(_L("Skin.RefreshSkinCommand.Unavalible"))
        end

        lastCommandTime = currentTime

        local PlayerPed = PlayerPedId()
        local maxhealth = GetEntityMaxHealth(PlayerPed)
        local health = GetEntityHealth(PlayerPed)
        local maxArmor = GetPlayerMaxArmour(PlayerId())
        local armor = GetPedArmour(PlayerPed)
        local startTime = GetGameTimer()
        local skinToSet = nil

        if Config.Framework == "QBCore" then
            Core?.Functions.TriggerCallback("qb-clothing:server:getPlayerSkin", function(data)
                skinToSet = TranslateSkinFromQB(data.skin, data.model)
            end)
        else
            Core?.TriggerServerCallback("esx_skin:getPlayerSkin", function(skin)
                skinToSet = TranslateSkinFromESX(skin)
            end)
        end

        while not skinToSet do
            Citizen.Wait(10)
            if GetGameTimer() - startTime > 3000 then
                return Functions.Debug("CANNOT FETCH SKINDATA")
            end
        end

        if IsModelInCdimage(skinToSet.model) then
            Functions.LoadModel(skinToSet.model)
            SetPlayerModel(PlayerId(), skinToSet.model)
        end

        Skin.SetOnPed(PlayerPedId(), skinToSet)
        local PlayerPed = PlayerPedId()

        SetPedMaxHealth(PlayerPed, maxhealth)
        SetEntityHealth(PlayerPed, health)
        SetPlayerMaxArmour(PlayerId(), maxArmor)
        SetPedArmour(PlayerPed, armor)
    end, false)

    exports("BlockRefreshSkinCommand", function()
        isCommandBlocked = true
    end)

    exports("UnblockRefreshSkinCommand", function()
        isCommandBlocked = false
    end)

    exports("IsRefreshSkinCommandBlocked", function()
        return isCommandBlocked
    end)
end
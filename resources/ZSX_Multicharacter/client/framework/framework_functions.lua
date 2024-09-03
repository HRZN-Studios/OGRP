Framework = {}
Framework.TriggerServerCallback = function(callbackName, cbFunc, ...)
    if ESX and FrameworkSelected == 'ESX' then
        ESX.TriggerServerCallback(callbackName, cbFunc, ...)
    elseif QBCore and FrameworkSelected == 'QBCore' then
        QBCore.Functions.TriggerCallback(callbackName, cbFunc, ...)
    else
        --CUSTOM FRAMEWORK CODE
    end
end

Framework.AppereanceResource = Config.ForceAppereance ~= false and Config.ForceAppereance or (GetResourceState('skinchanger') == 'started' and 'skinchanger' or GetResourceState('skinchanger') == 'fivem-appearance' and 'fivem-appearance' or GetResourceState('illenium-appearance') == 'started' and 'illenium-appearance' or GetResourceState('qb-clothing') == 'started' and 'qb-clothing' or GetResourceState('crm-appearance') == 'started' and 'crm-appearance' or GetResourceState('bl_appearance') == 'started' and 'bl_appearance' or GetResourceState('tgiann-clothing') == 'started' and 'tgiann-clothing')

Framework.SetSkin = function(skinData, isMale, model)
    local ped = PlayerPedId()
    local plyModel
    if (Framework.AppereanceResource == 'illenium-appearance' or Framework.AppereanceResource == 'fivem-appearance' or Framework.AppereanceResource == 'tgiann-clothing') and skinData ~= nil and skinData.model ~= nil then
        plyModel = joaat(skinData.model)
    else
        if not model then
            plyModel = isMale and joaat("mp_m_freemode_01") or joaat("mp_f_freemode_01")
        else
            plyModel = type(model) ~= 'number' and tonumber(model) or model
        end
    end
    RequestModel(plyModel)
    while not HasModelLoaded(plyModel) do
        RequestModel(plyModel)
        Citizen.Wait(0)
    end
    SetPlayerModel(PlayerId(), plyModel)
    SetPedComponentVariation(PlayerPedId(), 0, 0, 0, 2)
    SetPedHeadBlendData(PlayerPedId(), 0, 0, nil, 0, 0, nil, 0.0, 0.0, nil, true)
    SetPedComponentVariation(PlayerPedId(), 2, 1, 0, 0)

    ped = PlayerPedId()
    if skinData == nil then return debugPrint('Could not find a skin for user. Setting default values') end
    if Framework.AppereanceResource == 'skinchanger' then
        TriggerEvent('skinchanger:loadSkin', skinData)
    elseif Framework.AppereanceResource == 'fivem-appearance' then
        exports['fivem-appearance']:setPedAppearance(ped, skinData)
    elseif Framework.AppereanceResource == 'illenium-appearance' then
        exports['illenium-appearance']:setPedAppearance(ped, skinData)
    elseif Framework.AppereanceResource == 'qb-clothing' then
        TriggerEvent('qb-clothing:client:loadPlayerClothing', skinData, ped)
    elseif Framework.AppereanceResource == 'crm-appearance' then
        exports['crm-appearance']:crm_set_ped_appearance(ped, skinData)
    elseif Framework.AppereanceResource == 'bl_appearance' then
        exports.bl_appearance:SetPlayerPedAppearance(skinData)
    elseif Framework.AppereanceResource == 'tgiann-clothing' then
        TriggerEvent("tgiann-clothing:client:loadPedClothing", skinData, ped)
    end
end

Framework.OpenSkinMenu = function()
    if Framework.AppereanceResource == 'skinchanger' then
        TriggerEvent('esx_skin:openSaveableMenu', function()
            if UserInterfaceActive then
                exports[ZSX_UI]:HideUI(false)
            end
            HandleHud(false)
        end)
    elseif Framework.AppereanceResource == 'fivem-appearance' then
        exports['fivem-appearance']:startPlayerCustomization(function (skin)
            if skin then
                TriggerServerEvent('ZSX_Multicharacter:Save:Appereance', skin)
            else
                local data = exports['fivem-appearance']:getPedAppearance(PlayerPedId())
                TriggerServerEvent('ZSX_Multicharacter:Save:Appereance', data)
            end
            if UserInterfaceActive then
                exports[ZSX_UI]:HideUI(false)
            end
            HandleHud(false)
        end, {ped = true, headBlend = true, faceFeatures = true, headOverlays = true, components = true, componentConfig = { masks = true, upperBody = true, lowerBody = true, bags = true, shoes = true, scarfAndChains = true, bodyArmor = true, shirts = true, decals = true, jackets = true }, props = true, propConfig = { hats = true, glasses = true, ear = true, watches = true, bracelets = true }, tattoos = true, enableExit = true})
    elseif Framework.AppereanceResource == 'illenium-appearance' then
        exports['illenium-appearance']:startPlayerCustomization(function (skin)
            if skin then
                TriggerServerEvent('ZSX_Multicharacter:Save:Appereance', skin)
            else
                local data = exports['illenium-appearance']:getPedAppearance(PlayerPedId())
                TriggerServerEvent('ZSX_Multicharacter:Save:Appereance', data)
            end
            if UserInterfaceActive then
                exports[ZSX_UI]:HideUI(false)
            end
            HandleHud(false)
        end, {ped = true, headBlend = true, faceFeatures = true, headOverlays = true, components = true, componentConfig = { masks = true, upperBody = true, lowerBody = true, bags = true, shoes = true, scarfAndChains = true, bodyArmor = true, shirts = true, decals = true, jackets = true }, props = true, propConfig = { hats = true, glasses = true, ear = true, watches = true, bracelets = true }, tattoos = true, enableExit = true})
    elseif Framework.AppereanceResource == 'qb-clothing' then
        if UserInterfaceActive then
            exports[ZSX_UI]:HideUI(false)
        end
        HandleHud(false)
        TriggerEvent('qb-clothes:client:CreateFirstCharacter', false, false)
    elseif Framework.AppereanceResource == 'crm-appearance' then
        TriggerEvent('crm-appearance:init-new-character', 'crm-male', function() 
            if UserInterfaceActive then
                exports[ZSX_UI]:HideUI(false)
            end
            HandleHud(false)
        end) 
    elseif Framework.AppereanceResource == 'bl_appearance' then
        exports.bl_appearance:InitialCreation(function()
            if UserInterfaceActive then
                exports[ZSX_UI]:HideUI(false)
            end
            HandleHud(false)
        end)

    elseif Framework.AppereanceResource == 'tgiann-clothing' then
        exports["tgiann-clothing"]:openMenu({
            allowedMenus = {[0] = true, [1] = true, [2] = true, [3] = true},
            isBerberMenu = false,
        })
        if UserInterfaceActive then
            exports[ZSX_UI]:HideUI(false)
        end
        HandleHud(false)
    end
end

exports('isInMulticharacter', isInMulticharacter)

function isInMulticharacter()
    return LocalPlayer.state['isInMulticharacter']
end
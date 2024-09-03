cache = {}

CreateThread(function()
    while not loaded do Wait(500) end
    cache.menuAlign = Config.MenuAlign or "bottom-right"
    lib = exports.loaf_lib:GetLib()

    for i, v in pairs(Houses) do
        v.id = i
        v.unique = v.unique or (v.unique == nil and v.type == "house" or v.type == "apartment" and false)
    end

    cache.identifier = lib.TriggerCallbackSync("loaf_housing:get_identifier")
    lib.TriggerCallback("loaf_housing:fetch_houses", function(houses)
        local new_ownedHouses = {}
        local new_houses = {}
        for _, house in pairs(houses) do
            local stringId = tostring(house.propertyid)
            if house.owner == cache.identifier then
                new_ownedHouses[stringId] = house
            else
                new_houses[stringId] = house
            end
        end
        cache.ownedHouses = new_ownedHouses
        cache.houses = new_houses

        if Config.Framework == "qb" then
            local toSend = {}
            for k, v in pairs(cache.ownedHouses) do
                toSend[tonumber(k)] = v
                local houseData = Houses[tonumber(k)]
                local houseApart = Houses[tonumber(k)]?.type == "house" and "house" or "apart"
                toSend[tonumber(k)].label = Strings["spawn_"..houseApart]:format(k)
            end
            TriggerEvent("qb-spawn:client:addLoafProperties", Houses, cache.ownedHouses)
        end

        if Config.Realtor.enabled then
            Houses = lib.TriggerCallbackSync("loaf_housing:fetch_houses_cfg")
        end

        ReloadBlips()

        if Config.SpawnRestart or Config.SpawnDisconnect then
            lib.TriggerCallback("loaf_housing:get_last_house", function(res)
                if not res then return end
                local propertyId, uniqueId = res.propertyid, res.id
                local houseData = Houses[propertyId]

                local entered = EnterProperty(propertyId, uniqueId)
                if not entered then
                    SetTimeout(1500, function() -- wait for esx to tp
                        DoScreenFadeOut(0)
                        Teleport(houseData.entrance - vector4(0.0, 0.0, 1.0, 0.0))
                        DoScreenFadeIn(500)
                    end)
                end
            end)
        end

        RefreshHouseDoors()
    end)

    AddTextEntry(GetCurrentResourceName() .. "loading", "~a~")

    if Config.Garage and Config.AllowGarageKey then
        RegisterNetEvent("loaf_keysystem:add_key", function()
            Wait(500)
            RefreshGarageMarkers()
        end)

        RegisterNetEvent("loaf_keysystem:remove_key", function()
            Wait(500)
            RefreshGarageMarkers()
        end)
    end
end)

function LoadDict(dict)
    lib.LoadAnimDict(dict)
    return dict
end

function GetKeyName(propertyId, uniqueId)
    return ("housing_key_%i_%s"):format(propertyId, uniqueId)
end

function EnterProperty(propertyId, uniqueId)
    if not propertyId or not uniqueId then
        return false, "provide propertyId & uniqueId"
    end

    local houseData = Houses[propertyId]
    if not houseData then
        return false, "unknown propertyId"
    end

    if houseData.interiortype == "walkin" then
        DoScreenFadeOut(0)
        Teleport(houseData.entrance)
        Wait(500)
        DoScreenFadeIn(500)
        return
    end

    local houseApart = (houseData.type == "house" and "house" or "apart")

    CloseMenu()
    StartLoading(Strings["entering_"..houseApart])
    local success, errorMessage = lib.TriggerCallbackSync("loaf_housing:enter_property", propertyId, uniqueId)
    StopLoading()
    return success, errorMessage
end
exports("EnterProperty", EnterProperty)

function DrawEntityBox(entity)
    local min, max = GetModelDimensions(GetEntityModel(entity))

    local pad = 0.001
    local box = {
        -- Bottom
        GetOffsetFromEntityInWorldCoords(entity, min.x - pad, min.y - pad, min.z - pad),
        GetOffsetFromEntityInWorldCoords(entity, max.x + pad, min.y - pad, min.z - pad),
        GetOffsetFromEntityInWorldCoords(entity, max.x + pad, max.y + pad, min.z - pad),
        GetOffsetFromEntityInWorldCoords(entity, min.x - pad, max.y + pad, min.z - pad),

        -- Top
        GetOffsetFromEntityInWorldCoords(entity, min.x - pad, min.y - pad, max.z + pad),
        GetOffsetFromEntityInWorldCoords(entity, max.x + pad, min.y - pad, max.z + pad),
        GetOffsetFromEntityInWorldCoords(entity, max.x + pad, max.y + pad, max.z + pad),
        GetOffsetFromEntityInWorldCoords(entity, min.x - pad, max.y + pad, max.z + pad)
    }

    local lines = {
        {box[1], box[2]},
        {box[2], box[3]},
        {box[3], box[4]},
        {box[4], box[1]},
        {box[5], box[6]},
        {box[6], box[7]},
        {box[7], box[8]},
        {box[8], box[5]},
        {box[1], box[5]},
        {box[2], box[6]},
        {box[3], box[7]},
        {box[4], box[8]}
    }

    local polyMatrix = {
        -- BOTTOM
        {box[3], box[2], box[1]},
        {box[4], box[3], box[1]},

        -- TOP
        {box[5], box[6], box[7]},
        {box[5], box[7], box[8]},

        -- LEFT SIDE
        {box[3], box[4], box[7]},
        {box[8], box[7], box[4]},

        -- RIGHT SIDE
        {box[1], box[2], box[5]},
        {box[6], box[5], box[2]},

        -- FRONT SIDE
        {box[2], box[3], box[6]},
        {box[3], box[7], box[6]},

        -- BACK SIDE
        {box[5], box[8], box[4]},
        {box[5], box[4], box[1]}
    }


    for k, v in pairs(lines) do
		DrawLine(v[1].x, v[1].y, v[1].z, v[2].x, v[2].y, v[2].z, 255, 255, 255, 255)
	end

    for _, poly in pairs(polyMatrix) do
        DrawPoly(poly[1], poly[2], poly[3], 250, 92, 92, 75)
    end
end

function GetPlayers()
    local found = {}
    for _, player in pairs(GetActivePlayers()) do
        if player ~= PlayerId() then
            local playerPed = GetPlayerPed(player)
            if #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(playerPed)) <= 5.0 then
                local foundName, startedSearch, name = false, GetGameTimer(), GetPlayerName(player) .. " | " .. GetPlayerServerId(player)

                if Config.UseRPName then
                    name = lib.TriggerCallbackSync("loaf_keysystem:get_name", GetPlayerServerId(player)) or name
                end

                found[#found+1] = {
                    serverId = GetPlayerServerId(player),
                    name = name
                }
            end
        end
    end
    return found
end

function FormatNumber(number)
    -- https://stackoverflow.com/questions/10989788/format-integer-in-lua
    return tostring(number):reverse():gsub("(%d%d%d)", "%1 "):reverse():gsub("^ ", "")
end

function Round(i, x, up)
    i = math.floor(i + 0.5)
    local r = i % x
    if r == 0 then return up and i + x or i - x end
    return up and (i - r + x) or (i - r)
end

function ClearHelpText()
    ClearAllHelpMessages()
    ClearHelp(true)
end

function DisplayHelp(help, sound)
    AddTextEntry(GetCurrentResourceName(), help)
    BeginTextCommandDisplayHelp(GetCurrentResourceName())
    EndTextCommandDisplayHelp(0, 0, (sound == true), -1)
end

function StartLoading(msg)
    cache.busy = true
    BeginTextCommandBusyspinnerOn(GetCurrentResourceName() .. "loading")
    AddTextComponentSubstringPlayerName(msg)
    EndTextCommandBusyspinnerOn(3)
end

function StopLoading()
    BusyspinnerOff()
    cache.busy = false
end

function SetWeather()
    NetworkOverrideClockTime(17, 0, 0)
    ClearOverrideWeather()
    ClearWeatherTypePersist()
    SetWeatherTypePersist("EXTRASUNNY")
    SetWeatherTypeNow("EXTRASUNNY")
    SetWeatherTypeNowPersist("EXTRASUNNY")
    SetWindSpeed(0.0)
end

function Draw3DTextSlow(text, x, y, z)
    local onScreen, x, y = GetScreenCoordFromWorldCoord(x, y, z)

    if not onScreen then
        return
    end

    BeginTextCommandDisplayText("STRING")
    AddTextComponentSubstringPlayerName(text)
    SetTextScale(0.35, 0.35)
    SetTextCentre(true)
    SetTextFont(4)
    EndTextCommandDisplayText(x, y)

    BeginTextCommandGetWidth("STRING")
    AddTextComponentSubstringPlayerName(text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)

    local height = GetRenderedCharacterHeight(0.35, 4) * 1.2

    DrawRect(0.0, height/2, EndTextCommandGetWidth(true) + 0.0015, height, 45, 45, 45, 150)
end

function Draw3DText(text, coords)
    SetDrawOrigin(coords.x, coords.y, coords.z)

    BeginTextCommandDisplayText("STRING")
    AddTextComponentSubstringPlayerName(text)
    SetTextScale(0.35, 0.35)
    SetTextCentre(true)
    SetTextFont(4)
    EndTextCommandDisplayText(0.0, 0.0)

    BeginTextCommandGetWidth("STRING")
    AddTextComponentSubstringPlayerName(text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)

    local height = GetRenderedCharacterHeight(0.35, 4) * 1.2

    DrawRect(0.0, height/2, EndTextCommandGetWidth(true) + 0.0015, height, 45, 45, 45, 150)

    ClearDrawOrigin()
end

-- EXPORTS FOR PHONES ETC
function GetKeyHolders(propertyId)
    local house = cache.ownedHouses[tostring(propertyId)]
    if not house then
        return {}
    end

    return lib.TriggerCallbackSync("loaf_housing:get_key_holders", propertyId)
end
exports("GetKeyHolders", GetKeyHolders)

function GetOwnedHouses()
    local ownedHouses = {}
    for k, v in pairs(cache.ownedHouses or {}) do
        local propertyId = tonumber(k)
        ownedHouses[propertyId] = {
            id = propertyId,
            uniqueId = v.id,
            label = Houses[propertyId].label,
            entrance = Houses[propertyId].entrance,
            keyHolders = GetKeyHolders(propertyId)
        }
    end
    return ownedHouses
end
exports("GetOwnedHouses", GetOwnedHouses)

exports("TransferProperty", function(propertyId, playerId)
    local house = cache.ownedHouses[tostring(propertyId)]
    if not house then
        return false, "dont_own"
    end

    return lib.TriggerCallbackSync("loaf_housing:transfer_property", propertyId, playerId)
end)

function GiveKey(propertyId, playerId)
    local house = cache.ownedHouses[tostring(propertyId)]
    if not house then
        return false, "dont_own"
    end

    return lib.TriggerCallbackSync("loaf_housing:give_key", propertyId, playerId)
end
exports("GiveKey", GiveKey)

function RemoveKeyHolder(propertyId, identifier)
    local house = cache.ownedHouses[tostring(propertyId)]
    if not house then
        return false, "dont_own"
    end

    return lib.TriggerCallbackSync("loaf_housing:remove_key_holder", propertyId, identifier)
end
exports("RemoveKeyHolder", RemoveKeyHolder)

function MarkProperty(propertyId)
    local propertyData = Houses[propertyId]
    if not propertyData then
        return false
    end

    SetNewWaypoint(propertyData.entrance.xy)
end
exports("MarkProperty", MarkProperty)

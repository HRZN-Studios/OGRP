local propertiesWithDoors = {}

local function HandleLocking()
    while true do
        Wait(1000)

        local coords = GetEntityCoords(PlayerPedId())
        for property, propertyData in pairs(propertiesWithDoors) do
            if #(coords - propertyData.entrance.xyz) > 100.0 then
                goto continue1
            end

            for door, doorData in pairs(propertyData.doors) do
                if #(coords - doorData.coords.xyz) > 15.0 then
                    goto continue2
                end

                local doorLocked = GlobalState["loaf_housing_"..property.."_"..door] ~= true
                local doorObj = GetClosestObjectOfType(doorData.coords.xyz, 4.0, doorData.object)
                if DoesEntityExist(doorObj) then
                    FreezeEntityPosition(doorObj, doorLocked)
                    if doorLocked and math.abs(GetEntityHeading(doorObj) - doorData.coords.w) > 5.0 then
                        SetEntityHeading(doorObj, doorData.coords.w)
                    end
                end

                ::continue2::
            end

            ::continue1::
        end
    end
end

local nearbyKey = false
local function DrawLockedState()
    while true do
        Wait(1000)

        local playerPed = PlayerPedId()
        for property, propertyData in pairs(propertiesWithDoors) do
            for door, doorData in pairs(propertyData.doors) do
                if #(GetEntityCoords(PlayerPedId()) - doorData.coords.xyz) <= 10.0 then
                    local doorObj = GetClosestObjectOfType(doorData.coords.xyz, 4.0, doorData.object)
                    local doorCoords = GetEntityCoords(doorObj)

                    if #(GetEntityCoords(playerPed) - doorCoords) <= 3.0 then
                        local stringId = tostring(property)
                        local uniqueId, locked, text, hasKey

                        local function RefreshDoor()
                            uniqueId = cache.ownedHouses[stringId]?.id or cache.houses[stringId]?.id or false

                            locked = GlobalState["loaf_housing_"..property.."_"..door] ~= true
                            text = locked and Strings["locked"] or Strings["unlocked"]

                            hasKey = uniqueId and exports.loaf_keysystem:HasKey(GetKeyName(property, uniqueId))

                            if hasKey then
                                local keyAsText = string.gsub(GetControlInstructionalButton(0, lib.GetKey("secondary").joaat, 1), "t_", "")
                                text = string.format("~b~[~s~%s~b~]~s~ %s", keyAsText, locked and Strings["unlock_door"] or Strings["lock_door"])
                                nearbyKey = GetKeyName(property, uniqueId)
                            else
                                nearbyKey = false
                            end
                        end
                        RefreshDoor()

                        local refresh = GetGameTimer() + 100
                        while #(GetEntityCoords(playerPed) - doorCoords) <= 3.0 do
                            Wait(0)
                            Draw3DText(text, doorCoords)

                            if refresh <= GetGameTimer() then
                                RefreshDoor()
                                refresh = GetGameTimer() + 100
                            end
                        end

                        nearbyKey = false

                        collectgarbage()
                    end
                end
            end
        end
    end
end

RegisterNetEvent("loaf_lib:pressedKey", function(keyName)
    if keyName ~= "secondary" then
        return
    end

    if nearbyKey then
        TriggerServerEvent("loaf_housing:used_key", {
            key_id = nearbyKey
        })
    end
end)

function RefreshHouseDoors()
    for property, propertyData in pairs(propertiesWithDoors) do
        for door, doorData in pairs(propertyData.doors) do
            if not Houses[property] then
                local doorObj = GetClosestObjectOfType(doorData.coords.xyz, 4.0, doorData.object)
                if DoesEntityExist(doorObj) then
                    FreezeEntityPosition(doorObj, false)
                end
            end
        end
    end

    propertiesWithDoors = {}
    for property, propertyData in pairs(Houses) do
        if propertyData.interiortype == "walkin" then
            propertiesWithDoors[property] = propertyData
        end
    end
end

CreateThread(function()
    while not loaded do Wait(500) end
    Wait(500)

    RefreshHouseDoors()

    CreateThread(DrawLockedState)
    CreateThread(HandleLocking)
end)
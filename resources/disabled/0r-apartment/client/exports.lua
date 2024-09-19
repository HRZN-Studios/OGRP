exports("OpenApp", function(apartmentId)
    Client.Functions.OpenTablet(apartmentId)
end)

exports("GetApartmentLabelById", function(id)
    if id ~= -1 then
        return Config.Apartments[id]?.label
    end
    return Config.InteriorMloApart.label
end)

exports("TakeAnEmptyRoom", function(enterNow, rentDay, apartId)
    DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Wait(100) end
    Client.Functions.TriggerServerCallback("0r-apartment:Server:TakeAnEmptyRoom", function(apartmentId, roomId)
        DoScreenFadeIn(500)
        if not roomId then
            Client.Functions.SendNotify(locale("game.no_room_available"), "error", 2500)
            return
        end
        if enterNow then
            Client.Functions.GetIntoApartmentRoom(apartmentId, roomId)
            Client.Functions.SetRoomLights(false, 1000)
        end
    end, apartId, rentDay)
end)

exports("GetPlayerRoom", function()
    return Client.Player?.inRoom
end)

exports("GetPlayerRoomId", function()
    return Client.Player?.inApartment, Client.Player?.inRoom?.room_id
end)

exports("GetPlayerOwnedRooms", function()
    return Client.Player.rooms
end)

exports("GetPlayerRoomPlacedFurnitures", function()
    if Client?.Player?.inApartment and Client?.Player?.inRoom then
        return Client?.Player?.Furniture?.createdFurnitures
    end
    return {}
end)

-- Updates the specified indicator for a given room by adding or subtracting the provided value.
-- The `apartmentId` parameter specifies the ID of the apartment.
-- The `roomId` parameter specifies the ID of the room.
-- The `indicator` parameter specifies which indicator to update (e.g., "electricity", "power", "gas", or "water").
-- The `value` parameter specifies the amount to add to (positive value) or subtract from (negative value) the current indicator value.
-- The function returns the updated indicator value.
---@param apartmentId number
---@param roomId number
---@param indicator "electricity"|"power"|"gas"|"water"
---@param value number
---@return number
local function UpdateRoomIndicator(indicator, value)
    if Client?.Player?.inApartment and Client?.Player?.inRoom then
        local response = Client.Functions.TriggerServerCallback(_e("Server:UpdateIndicator"),
            indicator, value, Client.Player.inApartment, Client.Player.inRoom.room_id)
        if response.error then
            Client.Functions.SendNotify(locale("game.error", response.error), "error")
            return false
        end
        return true
    end
end
exports("UpdateRoomIndicator", UpdateRoomIndicator)

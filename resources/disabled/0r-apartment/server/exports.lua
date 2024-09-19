local function GetRoomById(apartmentId, roomId)
    return Server.Functions.GetSoldRoom(apartmentId, roomId)
end

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
local function UpdateRoomIndicator(apartmentId, roomId, indicator, value)
    if not Config.Indicators[indicator] then
        return false
    end
    if apartmentId == "Mlo" then
        apartmentId = -1
    end
    apartmentId = tonumber(apartmentId)
    roomId = tonumber(roomId)
    local room = Server.Functions.GetSoldRoom(apartmentId, roomId)
    if not room or not room?.indicators[indicator] or (room.indicators[indicator] + value < 0) then
        return false
    end
    return Server.Functions.UpdateRoomIndicator(indicator, value, apartmentId, roomId)
end

---@param apartmentId number
---@param roomId number
---@param indicator "electricity"|"power"|"gas"|"water"
---@return number
local function GetRoomIndicatorValue(apartmentId, roomId, indicator)
    local room = Server.Functions.GetSoldRoom(apartmentId, roomId)
    if room then
        local indicator = room.indicators?[indicator]
        if indicator then
            return indicator
        end
    end
    return 0
end

exports("GetRoomById", GetRoomById)
exports("UpdateRoomIndicator", UpdateRoomIndicator)

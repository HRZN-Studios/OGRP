--[[ Utils ]]
Utils = {}
Utils.Framework = nil ---@type "esx" | "qb"
Utils.Functions = {}
Utils.Functions.CustomInventory = {}

function Utils.Functions.GetFrameworkType()
    if Utils.Functions.HasResource("qb-core") then
        return "qb"
    end
    if Utils.Functions.HasResource("es_extended") then
        return "esx"
    end
end

---@param name string resource name
---@return boolean
function Utils.Functions.HasResource(name)
    return GetResourceState(name):find("start") ~= nil
end

function Utils.Functions.deepCopy(tbl)
    return lib.table.deepclone(tbl)
end

function Utils.Functions.GetFramework()
    if Utils.Functions.HasResource("qb-core") then
        return exports["qb-core"]:GetCoreObject()
    end
    if Utils.Functions.HasResource("es_extended") then
        return exports["es_extended"]:getSharedObject()
    end
end

---@param point vector3
---@param min vector3
---@param max vector3
---@return boolean
function Utils.Functions.IsPointInBoundingBox(point, min, max)
    return point.x >= min.x and point.x <= max.x and
        point.y >= min.y and point.y <= max.y and
        point.z >= min.z and point.z <= max.z
end

---@return string > 0r-weed:{event}
function _e(event)
    local scriptName = "0r-weed"
    return scriptName .. ":" .. event
end

function table.contains(table, element)
    for _, value in pairs(table) do
        if value == element then
            return true
        end
    end
    return false
end

function isPlanterModel(hashKey)
    for key, _ in pairs(Config.PlanterProps) do
        if GetHashKey(key) == hashKey then
            return true
        end
    end
    return false
end

function isLightModel(hashKey)
    for key, v in pairs(Config.LightProps) do
        if GetHashKey(key) == hashKey then
            return v.effect
        end
    end
    return -1
end

function isDryModel(hashKey)
    for key, v in pairs(Config.DryerProps) do
        if GetHashKey(key) == hashKey then
            return v.slot
        end
    end
    return -1
end

function isTableModel(hashKey)
    for key, v in pairs(Config.TableProps) do
        if GetHashKey(key) == hashKey then
            return true
        end
    end
    return false
end

function isExtraDryModel(hashKey)
    for key, v in pairs(Config.HeaterProps) do
        if GetHashKey(key) == hashKey then
            return v.effect
        end
    end
    for key, v in pairs(Config.FanProps) do
        if GetHashKey(key) == hashKey then
            return v.effect
        end
    end
    return -1
end

--[[ Core Thread]]
Utils.Framework = Utils.Functions.GetFrameworkType()

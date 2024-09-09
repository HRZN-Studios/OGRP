Resmon = exports["0r_lib"]:GetCoreObject()
Utils = {}
Utils.Framework = nil
Utils.Functions = {}
Utils.Functions.CustomInventory = {}
Utils.Functions.CustomTarget = {}
Utils.Functions.CustomPhone = {}

function Utils.Functions.GetFrameworkType()
    local framework = Resmon.Lib.GetFramework()
    if string.lower(framework) == "qbcore" then
        return "qb"
    elseif string.lower(framework) == "esx" then
        return "esx"
    end
end

function Utils.Functions.GetResmonLib()
    if Utils.Functions.HasResource("0r_lib") then
        local Core = exports["0r_lib"]:GetCoreObject()
        return Core
    else
        CreateThread(function()
            Wait(30000)
            Utils.Functions.printTable(
                "^1!!! The installation could not be done because the 0r_lib could not be found !!!"
            )
        end)
        return false
    end
end

--[[ Utils ]]
function Utils.Functions.printTable(table, indent)
    indent = indent or 0
    if type(table) == "table" then
        for k, v in pairs(table) do
            local tblType = type(v)
            local formatting = ("%s ^3%s:^0"):format(string.rep("  ", indent), k)
            if tblType == "table" then
                print(formatting)
                Utils.Functions.printTable(v, indent + 1)
            else
                print(("%s^2 %s ^0"):format(formatting, v))
            end
        end
    else
        print(("%s ^0%s"):format(string.rep("  ", indent), table))
    end
end

---@param name string resource name
---@return boolean
function Utils.Functions.HasResource(name)
    return GetResourceState(name):find("start") ~= nil
end

function Utils.Functions.deepCopy(value)
    return Resmon.Lib._deepCopy(value)
end

function Utils.Functions.degToRad(degs)
    return degs * 3.141592653589793 / 180
end

function Utils.Functions.GetFramework()
    if Utils.Functions.HasResource("qb-core") then
        return exports["qb-core"]:GetCoreObject()
    end
    if Utils.Functions.HasResource("es_extended") then
        return exports["es_extended"]:getSharedObject()
    end
end

function _e(event)
    local scriptName = "0r-apartment"
    return scriptName .. ":" .. event
end

function generateRandomString(length)
    local chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
    local numbers = "0123456789"
    local randomString = ""
    math.randomseed(os.time())

    for i = 1, length do
        if math.random(1, 2) == 1 then
            local index = math.random(1, #chars)
            randomString = randomString .. chars:sub(index, index)
        else
            local index = math.random(1, #numbers)
            randomString = randomString .. numbers:sub(index, index)
        end
    end

    return randomString
end

function isModelStash(model)
    for _, item in pairs(Config.FurnitureItems["stashes"]?.items or {}) do
        if item.model == model then
            return true
        end
    end
    return false
end

function isModelWeedDry(model)
    for _, item in pairs(Config.FurnitureItems["weed_dryer"].items or {}) do
        if item.model == model then
            return true
        end
    end
    return false
end

--[[ Core Thread]]
CreateThread(function()
    lib.locale()
    while Resmon == nil do
        Resmon = Utils.Functions.GetResmonLib()
        Wait(100)
    end
    if not Resmon then return end
    Utils.Framework = Utils.Functions.GetFrameworkType()
end)

function Utils.Functions.HideHud()
    if Utils.Functions.HasResource("0r-hud") then
        exports["0r-hud"]:ToggleVisible(false)
    end
end

function Utils.Functions.VisibleHud()
    if Utils.Functions.HasResource("0r-hud") then
        exports["0r-hud"]:ToggleVisible(true)
    end
end

---You can adapt it to your own weather system.
-- If `stop` is true, you should disable the weather.
-- If false, you have to enable it again.
---@param stop boolean
function Utils.Functions.CustomWeatherSync(stop)
    -- #
end

function Utils.Functions.LockPickGame(cb)
    if Utils.Functions.HasResource("qb-lockpick") then
        TriggerEvent("qb-lockpick:client:openLockpick", function(result)
            cb(result)
        end)
    elseif Utils.Functions.HasResource("2na_lockpick") then
        cb(exports["2na_lockpick"]:createGame(3, 2))
    elseif Utils.Functions.HasResource("qb-minigames") then
        cb(exports["qb-minigames"]:Lockpick(2))
    else
        --[[ Custom lockpick script ]]
        cb(nil)
    end
end

---@param title string
---@param type "error" | "success" | "info" | any
---@param text string
---@param duration number miliseconds
---@param icon string
function Utils.Functions.CustomNotify(title, type, text, duration, icon)
    -- #
end

function Utils.Functions.CustomInventory.OpenInventory(type, id, options)
    local maxWeight = options.maxWeight
    local slots = options.slots
    --[[
        If you have set up your own "notify" system. don't forget to set return true !
    ]]
    return false -- If you use this function, do it true !
end

function Utils.Functions.CustomTarget.AddTargetCoords(coords, size, options, func)
    --[[
        If you have set up your own "notify" system. don't forget to set return true !
    ]]
    return false -- If you use this function, do it true !
end

function Utils.Functions.CustomTarget.AddTargetModel(models, options, onSelect)
    --[[
        If you have set up your own "notify" system. don't forget to set return true !
    ]]
    return false -- If you use this function, do it true !
end

function Utils.Functions.CustomTarget.AddTargetEntity(entities, options)
    --[[
        If you have set up your own "target" system. don't forget to set return true !
    ]]
    return false -- If you use this function, do it true !
end

---@param entities any
---@param type "model"|"entity"|string
function Utils.Functions.CustomTarget.RemoveTarget(entities, type)
    --[[
        If you have set up your own "target" system. don't forget to set return true !
    ]]
    return false -- If you use this function, do it true !
end

-- @ --
function Utils.Functions.DrawMarker(coords, sizeType)
    local size = vec3(0.15, 0.1, 0.08)
    if sizeType == 2 then
        size = vec3(0.25, 0.2, 0.15)
    elseif sizeType == 3 then
        size = vec3(0.5, 0.4, 0.25)
    end

    DrawMarker(21,
        coords.x, coords.y, coords.z - 0.5,
        0.0, 0.0, 0.0,
        0.0, 0.0, 0.0,
        size,
        255, 255, 255, 200,
        false, false, false, true, false, false, false
    )
end

function Utils.Functions.RequestModel(model)
    return lib.requestModel(model, 500)
end

function Utils.Functions.LoadAnimDict(dict)
    return lib.requestAnimDict(dict, 500)
end

function Utils.Functions.DrawTextUI(text)
    if Utils.Functions.HasResource("ox_lib") then
        lib.hideTextUI()
        lib.showTextUI(text, { icon = "building" })
    elseif Utils.Framework == "qb" then
        exports["qb-core"]:DrawText(text, "right")
    end
end

function Utils.Functions.HideTextUI()
    if Utils.Functions.HasResource("ox_lib") then
        lib.hideTextUI()
    elseif Utils.Framework == "qb" then
        exports["qb-core"]:HideText()
    end
end

function Utils.Functions.showUI(message)
    Utils.Functions.DrawTextUI(message)
end

Utils.Functions.CustomTarget = {}

---@param source serverId
---@param title string
---@param type "error" | "success" | "info" | any
---@param text string
---@param duration number miliseconds
---@param icon string
function Utils.Functions.CustomNotify(title, type, text, duration, icon)
    --[[
        If you have set up your own "notify" system. don't forget to set return true !
    ]]
    return false -- If you use this function, do it true !
end

function Utils.Functions.CustomTarget.AddTargetModel(models, options)
    --[[
        If you have set up your own "target" system. don't forget to set return true !
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

function Utils.Functions.DrawTextUI(text)
    if Utils.Functions.HasResource("ox_lib") then
        lib.hideTextUI()
        lib.showTextUI(text, { icon = "cannabis" })
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

function Utils.Functions.LoadAnimDict(dict)
    return lib.requestAnimDict(dict, 500)
end

---@param message string
---@param coords vector3
function Utils.Functions.showUI(message)
    Utils.Functions.DrawTextUI(message)
end

function Utils.Functions.PlayAnim(ped, dict, name, duration)
    if not lib.requestAnimDict(dict, 500) then
        return false
    end
    TaskPlayAnim(ped, dict, name, 8.0, 8.0, duration, 1, 1.0, false, false, false)
end

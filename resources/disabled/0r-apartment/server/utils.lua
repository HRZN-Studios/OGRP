---@param source serverId
---@param title string
---@param type "error" | "success" | "info" | any
---@param text string
---@param duration number miliseconds
---@param icon string
function Utils.Functions.CustomNotify(source, title, type, text, duration, icon)
    -- #
end

function Utils.Functions.CustomInventory.OpenInventory(type, stashId, options, source)
    local maxWeight = options.maxWeight
    local slots = options.slots
    --[[
        If you have set up your own "notify" system. don't forget to set return true !
    ]]
    return false -- If you use this function, do it true !
end

function Utils.Functions.CustomInventory.RegisterStash(source, stashId, options)
    local maxWeight = options.maxWeight
    local slots = options.slots
    --[[
        If you have set up your own "notify" system. don't forget to set return true !
    ]]
    return false -- If you use this function, do it true !
end

function Utils.Functions.CustomInventory.ClearStash(src, stashId)
    -- ?
end

function Utils.Functions.CustomPhone.SendMailToPhone(source, citizenId, text)
    local mailData = {
        sender = locale("game.rentalPeriodWarningMail.title"),
        subject = locale("game.rentalPeriodWarningMail.subject"),
        message = locale("game.rentalPeriodWarningMail.message", text),
    }
    -- > Use your own phone export
end

---@return boolean
function Utils.Functions.PlayerHasItem(xPlayer, item)
    if Utils.Framework == "esx" then
        local item = xPlayer.hasItem(item)
        return item and (item.count or 0) > 0 or false
    elseif Utils.Framework == "qb" then
        return #xPlayer.Functions.GetItemsByName(item) > 0
    end
    return false
end

---@return boolean
function Utils.Functions.PlayerRemoveItem(xPlayer, item, amount)
    if Utils.Framework == "esx" then
        return xPlayer.removeInventoryItem(item, amount)
    elseif Utils.Framework == "qb" then
        return xPlayer.Functions.RemoveItem(item, amount)
    end
    return false
end

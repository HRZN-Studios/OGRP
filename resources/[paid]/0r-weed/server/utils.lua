---@param source serverId
---@param title string
---@param type "error" | "success" | "info" | any
---@param text string
---@param duration number miliseconds
---@param icon string
---@return boolean
function Utils.Functions.CustomNotify(source, title, type, text, duration, icon)
    --[[
        If you have set up your own "notify" system. don't forget to set return true !
    ]]
    return false -- If you use this function, do it true !
end

--[[ Inventory ]]

---@param inv string
---@param itemName string
---@param amount number
---@param metadata table<string, any>
---@return boolean
function Utils.Functions.CustomInventory.RemoveItem(inv, itemName, amount, slot)
    return false
end

---@param inv string
---@param itemName string
---@param amount number
---@param metadata table<string, any>
---@return boolean
function Utils.Functions.CustomInventory.GiveItem(inv, itemName, amount, metadata)
    return false
end

---@param inv string
---@param itemName string
---@return number | boolean
function Utils.Functions.CustomInventory.GetItemsByName(inv, itemName)
    return false
end

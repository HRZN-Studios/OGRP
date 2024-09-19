if Utils.Framework == "qb" then
    if Utils.Functions.HasResource("qb-inventory") then
        local items = Config.UsableItems
        for key, v in pairs(items) do
            if key ~= "weed_plant" or
                key ~= "weed_brick"
            then
                Server.Framework.Functions.CreateUseableItem(v.itemName, function(source, item)
                    TriggerClientEvent(_e("Client:UseItem"), source, item.name, item.slot, item.info)
                end)
            end
        end
    end
end

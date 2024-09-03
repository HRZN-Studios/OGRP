Citizen.CreateThread(function() 
    if Config.Framework == "qb" then
        QBCore = exports[Config.FrameworkPseudo]:GetCoreObject()
    end
end)

Citizen.CreateThread(function() 
    if Config.Framework == "qb" then
        QBCore.Functions.CreateUseableItem("craftingtable", function(source)
            local src = source
            local Player = QBCore.Functions.GetPlayer(src)
            local model = Config.TableProp
            if not Player or not Player.Functions.GetItemByName('craftingtable') then return end
            if Player.Functions.GetItemByName('craftingtable') then
                local id = ""..Player.PlayerData.citizenid..""..math.random(111111,999999)
                print (id)
                TriggerClientEvent("zat-crafting:client:PlaceTable", src, id, model)
            else
                TriggerClientEvent('QBCore:Notify', "Missing Item...", "error")
            end
        end)
    end
end)
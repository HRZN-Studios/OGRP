--[[ Events ]]
RegisterNetEvent("apartments:server:CreateApartment", function(apId)
    local src = source
    Server.Functions.TriggerCallback("0r-apartment:Server:TakeAnEmptyRoom", src, function(apartmentId, roomId)
        if apartmentId and roomId then
            Server.Functions.GetIntoApartmentRoom(src, apartmentId, roomId)
        end
        SetTimeout(1000, function()
            TriggerClientEvent("qb-clothes:client:CreateFirstCharacter", src)
        end)
    end, apId, 2)
end)

RegisterNetEvent("qb-apartments:server:SetInsideMeta", function(house, insideId, bool, isVisiting)
    local src = source
    local Player = Server.Functions.GetPlayerBySource(src)
    local insideMeta = Player.PlayerData.metadata.inside
    if bool then
        if not isVisiting then
            insideMeta.apartment.apartmentType = house
            insideMeta.apartment.apartmentId = insideId
            insideMeta.house = nil
            Player.Functions.SetMetaData("inside", insideMeta)
        end
    else
        insideMeta.apartment.apartmentType = nil
        insideMeta.apartment.apartmentId = nil
        insideMeta.house = nil
        Player.Functions.SetMetaData("inside", insideMeta)
    end
end)

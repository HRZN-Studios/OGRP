--[[ Events ]]
AddStateBagChangeHandler("isLoggedIn", nil, function(_, _, value)
    if value then
        Client.Functions.StartCore()
    else
        Client.Functions.OnPlayerLogout()
        Client.Functions.StopCore()
    end
end)

RegisterNetEvent("qb-apartments:client:LastLocationHouse", function()
    local apartmentId, roomId = Client.Functions.GetPlayerApartMeta()
    if apartmentId and apartmentId ~= -1 then
        Client.Player.inApartment = apartmentId
        if roomId then
            Client.Functions.GetIntoApartmentRoom(apartmentId, roomId)
        else
            local coords = Config.Apartments[apartmentId].coords.enter
            TriggerServerEvent("0r-apartment:Server:SetPlayerRoutingBucket", apartmentId, coords)
        end
    end
end)

RegisterNetEvent("apartments:client:setupSpawnUI", function(cData, firstSpawn, isNew)
    Client.Functions.TriggerServerCallback("0r-apartment:Server:GetPlayerRooms", function(result)
        if #result > 0 then
            TriggerEvent("qb-spawn:client:setupSpawns", cData, false, nil)
            TriggerEvent("qb-spawn:client:openUI", true)
        else
            if isNew and Config.ApartmentStarting then
                local Locations = Config.Apartments
                TriggerEvent("qb-spawn:client:setupSpawns", cData, true, Locations)
                TriggerEvent("qb-spawn:client:openUI", true)
            else
                TriggerEvent("qb-spawn:client:setupSpawns", cData, false, nil)
                TriggerEvent("qb-spawn:client:openUI", true)
            end
        end
    end, cData.citizenid or cData.cid)
end)

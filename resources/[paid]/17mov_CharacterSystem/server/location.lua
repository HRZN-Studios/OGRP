if Config.Framework ~= "QBCore" then return end
local configContent = LoadResourceFile("qb-apartments", "config.lua")
if configContent then
    local ApartmentsConfig = load(configContent)
    if ApartmentsConfig then
        ApartmentsConfig()
    end
end

Functions.RegisterServerCallback("17mov_CharacterSystem:getApartmentsConfiguration", function(_)
    ---@diagnostic disable-next-line: undefined-global
    return Apartments?.Locations
end)

RegisterNetEvent("apartments:server:setCurrentApartment", function()
    TriggerClientEvent("17mov_CharacterSystem:PlayerEnteredApartment", source)
end)
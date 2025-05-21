

for _,v in pairs(Config.CloakRoomLocs.locs) do
    exports.ox_target:addBoxZone({
        coords = v.coords,
        size = v.size,
        rotation = v.rotation,
        debug = v.debug,
        groups = Config.ClothesJob,
        options = {
            {
                icon = "fa-solid fa-vest",
                label = 'Oufits',
                distance = 2,
                onSelect = function()
                    TriggerEvent(Config.Outfitsexport)
                end
            },
            {
                icon = "fa-solid fa-cash-register",
                label = 'Clothes Shop',
                distance = 2,
                onSelect = function()
                    TriggerEvent(Config.Clothingexport)
                end
            },
        }
    })
end
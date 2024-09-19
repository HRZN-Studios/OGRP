Location = {}
Location.Enable = true
Location.EnableOnlyForNewCharacters = false

-- Supported only on QBCore
Location.EnableApartments = false                  -- Let players choose a starting apartment on first spawn. This only works with qb-apartments
Location.EnableSpawningInHouses = false            -- Let players spawn in their houses

Location.DefaultSpawnLocation = vector3(-1037.58, -2737.48, 20.17)  -- Used if Location.Enable is false, this is coordinates where player spawns

Location.Spawns = {
    {
        name = "legion",
        coords = vector4(195.17, -933.77, 29.7, 144.5),
        label = "Legion Square",
        type = "location",
    },
    {
        name = "policedp",
        coords = vector4(-602.140, -930.119, 23.864, 88.948),
        label = "Police Department",
        type = "location",
    },
    {
        name = "paleto",
        coords = vector4(80.35, 6424.12, 31.67, 45.5),
        label = "Paleto Bay",
        type = "location",
    },
    {
        name = "motel",
        coords = vector4(-773.649, 310.362, 85.698, 177.295),
        label = "Motels",
        type = "location",
    },
}
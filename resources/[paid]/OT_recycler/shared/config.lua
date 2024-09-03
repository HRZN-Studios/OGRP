Config = {}

Config.Target = true
Config.Sound = true

--Config.Framework = 'OX' -- ESX | QBCORE dont touch unless you know what you are doing, the script will attempt to automatically config these options
-- Config.inventory = 'OX' -- ESX | QBCORE | OX dont touch unless you know what you are doing, the script will attempt to automatically config these options


Config.Items = {
    ['phone'] = {
        rewards = {
            plastic = {durationPerItem = 1000,  min = 3, max = 6, chance = 100},
            metalscrap = {durationPerItem = 3000, max = 1, chance = 100}
        },
    },
    ['laptop'] = {
        rewards = {
            plastic = {durationPerItem = 1000, max = 4, chance = 100},
            metalscrap = {durationPerItem = 3000, max = 1, chance = 100}
        },
    },
}

Config.Recyclers = {
    {
        id = 'scrapyard',
        coords = vector3(2410.07, 3030.69, 47.15),
        heading = 270.0,
        model = `recycler_model`
    }
}
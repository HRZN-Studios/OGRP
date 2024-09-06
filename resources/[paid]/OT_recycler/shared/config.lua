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
        id = 'bcgdrecycle',
        coords = vector3(2038.6409912109, 3192.8120117188, 44.177951812744),
        heading = 150.3,
        model = `recycler_model`
    },
    {
        id = 'lsgdrecycle',
        coords = vector3(-359.01400756836, -1533.98828125, 26.711999893188),
        heading = -89.9,
        model = `recycler_model`
    }
}
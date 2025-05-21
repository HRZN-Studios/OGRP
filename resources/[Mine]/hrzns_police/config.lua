Config = {}

Config.Framework = 'ESX' -- ESX |

Config.Inventory = 'ox'

Config.MugShotOptions = {
    enabled = true,
    LogTitle = 'MugShot',
    LogName = 'MugShot',
    LogIcon = 'https://cdn.discordapp.com/attachments/1185571707474427905/1185571709317202688/unknown.png',
    ScreenShotHook = 'https://discord.com/api/webhooks/1366368409264324608/1pS-HjihgW5374scpgJc8xChonNsh-j23y7e2XvI56uOUtWSVEDFWqCJ-GqYbAlp9c1I',
    MugShotHook = 'https://discord.com/api/webhooks/1366368199410716733/KGF6Y8cKID3Gx3j4MkCMef3X4EcCT45J69s76TrwCbyyWvyXQChMxileH28XST38iRsD',
}

Config.MugShotLocs = {
    LSPD = {
        Target = {coords = vec3(-583.75, -943.0, 19.2), size = vec3(0.65, 0.9, 0.55), rotation = 0.0, debug = true},
        Suspectloc = {pos = vector3(-587.985, -942.404, 18.024), heading= 273.171, MaxDist = 5},
        Camera = {hash = "DEFAULT_SCRIPTED_CAMERA", posx = -586.19287109375, posy = -942.35559082031, posz = 19.322774887085, rotx = -4.1999106407166, roty = -2.2178102881298e-05, rotz = 90.152450561523, fov = 60.0, active = true, rotOrder = 2},
        BoardHeader = 'Bogger Bill is awsome',
    },
}

Config.Fingerprints = {
    enabled = true,
    distance = 2.0,
    locs = {
        {coords = vec3(-577.0, -931.35, 19.1), size = vec3(0.7, 0.35, 0.4), rotation = 0.0, debug = true},
    }
}

Config.CloakRoomLocs = {
    locs = {
        -- weazel cloaks
        {coords = vec3(-568.1, -911.35, 23.85), size = vec3(2.2, 1, 1.95), rotation = 0.0, debug = true},
        {coords = vec3(-566.4, -913.5, 23.85), size = vec3(0.85, 2.25, 2.0), rotation = 0.0, debug = true},
        {coords = vec3(-568.15, -917.4, 23.85), size = vec3(2.25, 0.85, 2.0), rotation = 0.0, debug = true},
    }
}

Config.Clothingexport = "illenium-appearance:client:openClothingShop"

Config.Outfitsexport = "illenium-appearance:client:openOutfitMenu"

Config.TackleKeybind = 19 -- Left Alt | https://docs.fivem.net/docs/game-references/controls/ 

Config.TackleCopTime = 5000

Config.TackleSusTime = 7000

Config.PdMenu = true

Config.PropMenu = true

Config.CuffsAsItems = true

Config.CuffItemBehavior = 'soft' -- soft for softcuffs | hard for hard cuffs

Config.twoCuffed = true -- if is already cuffed and you try to cuff again, it will be hard cuffed

Config.Unshacklefirst = true -- if you are already cuffed and you try to uncuff, it will first unshackle the cuffs

Config.MaxCuffs = 3 -- Max amount of times a player can break cuffs

Config.CopforUnCuff = false -- true == uncuff only for cops | false == anyone can uncuff .. ignored if CuffsAsItems is true

Config.FingerprintAnywhere = true -- Fingerprint Kit Ignores this

-- For Jobs put any for everyone to be able to use functions

Config.CuffJob = {
    'police',
}

Config.SearchJob = {
    'police',
}

Config.MugJob = {
    'police',
}

Config.FingerJob = {
    'police',
}

Config.FriskJob = {
    'police',
}

Config.ClothesJob = {
    'police',
}

Config.Guns = {
    "WEAPON_PISTOL_MK2",
    "WEAPON_ASSAULTSMG",
    "WEAPON_MOLOTOV",
    "WEAPON_SMG_MK2",
    "WEAPON_POOLCUE",
    "WEAPON_GRENADE",
    "WEAPON_MARKSMANPISTOL",
    "WEAPON_BULLPUPSHOTGUN",
    "WEAPON_BOTTLE",
    "WEAPON_COMBATMG",
    "WEAPON_MINISMG",
    "WEAPON_SWEEPERSHOTGUN",
    "WEAPON_ASSAULTRIFLE_MK2",
    "WEAPON_CARBINERIFLE_MK2",
    "WEAPON_BAT",
    "WEAPON_HEAVYSNIPER_MK2",
    "WEAPON_PUMPSHOTGUN_MK2",
    "WEAPON_FLASHLIGHT",
    "WEAPON_COMBATPDW",
    "WEAPON_COMBATPISTOL",
    "WEAPON_SNSPISTOL_MK2",
    "WEAPON_FIREWORK",
    "WEAPON_COMPACTRIFLE",
    "WEAPON_MACHINEPISTOL",
    "WEAPON_MARKSMANRIFLE",
    "WEAPON_AUTOSHOTGUN",
    "WEAPON_PROXMINE",
    "WEAPON_REVOLVER",
    "WEAPON_COMBATSHOTGUN",
    "WEAPON_MILITARYRIFLE",
    "WEAPON_RAYCARBINE",
    "WEAPON_BULLPUPRIFLE",
    "WEAPON_GUSENBERG",
    "WEAPON_HEAVYSHOTGUN",
    "WEAPON_FLARE",
    "WEAPON_KNIFE",
    "WEAPON_STONE_HATCHET",
    "WEAPON_GRENADELAUNCHER_SMOKE",
    "WEAPON_CERAMICPISTOL",
    "WEAPON_ASSAULTRIFLE",
    "WEAPON_PIPEBOMB",
    "WEAPON_MICROSMG",
    "WEAPON_DAGGER",
    "WEAPON_MUSKET",
    "WEAPON_RAYMINIGUN",
    "WEAPON_SPECIALCARBINE",
    "WEAPON_GADGETPISTOL",
    "WEAPON_APPISTOL",
    "WEAPON_ASSAULTSHOTGUN",
    "WEAPON_HEAVYPISTOL",
    "WEAPON_HOMINGLAUNCHER",
    "WEAPON_PIPEWRENCH",
    "WEAPON_MARKSMANRIFLE_MK2",
    "WEAPON_RAYPISTOL",
    "WEAPON_FIREEXTINGUISHER",
    "WEAPON_MINIGUN",
    "WEAPON_PETROLCAN",
    "WEAPON_HATCHET",
    "WEAPON_DBSHOTGUN",
    "WEAPON_DOUBLEACTION",
    "WEAPON_REVOLVER_MK2",
    "WEAPON_COMPACTLAUNCHER",
    "WEAPON_STUNGUN",
    "WEAPON_BULLPUPRIFLE_MK2",
    "WEAPON_SWITCHBLADE",
    "WEAPON_SNIPERRIFLE",
    "WEAPON_KNUCKLE",
    "WEAPON_SPECIALCARBINE_MK2",
    "WEAPON_NIGHTSTICK",
    "WEAPON_SAWNOFFSHOTGUN",
    "WEAPON_CROWBAR",
    "WEAPON_RPG",
    "WEAPON_GRENADELAUNCHER",
    "WEAPON_HEAVYSNIPER",
    "WEAPON_RAILGUN",
    "WEAPON_PISTOL50",
    "WEAPON_SMG",
    "WEAPON_HAMMER",
    "WEAPON_PISTOL",
    "WEAPON_GOLFCLUB",
    "WEAPON_SNSPISTOL",
    "WEAPON_CARBINERIFLE",
    "WEAPON_PUMPSHOTGUN",
    "WEAPON_HAZARDCAN",
    "WEAPON_DIGISCANNER",
    "WEAPON_NAVYREVOLVER",
    "WEAPON_SMOKEGRENADE",
    "WEAPON_BZGAS",
    "WEAPON_ADVANCEDRIFLE",
    "WEAPON_MACHETE",
    "WEAPON_STICKYBOMB",
    "WEAPON_COMBATMG_MK2",
    "WEAPON_VINTAGEPISTOL",
    "WEAPON_MG",
    "WEAPON_FLAREGUN",
}
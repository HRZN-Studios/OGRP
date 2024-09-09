Config = {}

Config.Framework = 'ESX' -- ESX | QBCore : Only Used for MugShots atm

Config.MugShotOptions = {
    enabled = true,
    LogTitle = 'MugShot',
    LogName = 'MugShot',
    LogIcon = 'https://cdn.discordapp.com/attachments/1185571707474427905/1185571709317202688/unknown.png',
    ScreenShotHook = 'https://discord.com/api/webhooks/1185571707474427905/PoPWOEhqkO06KGmZFclCUDO6OxUwYkNpnGWaTVKaTDpgoMMBn0wj8H1gT1JLLNgtfsyZ',
    MugShotHook = 'https://discord.com/api/webhooks/1185570647930327131/XZB8-oPkVHbmrd8ry45axFHjA5UaV69qzfpAQRy6QroCMJftjOvYTPz_PzviPZRbNBTN',
}

Config.MugShotLocs = {
    LSPD = {
        Target = {coords = vec3(-583.75, -943.0, 19.2), size = vec3(0.65, 0.9, 0.55), rotation = 0.0, debug = true, groups = {}},
        Suspectloc = {pos = vector3(-587.985, -942.404, 18.024), heading= 273.171, MaxDist = 5},
        Camera = {hash = "DEFAULT_SCRIPTED_CAMERA", posx = -586.19287109375, posy = -942.35559082031, posz = 19.322774887085, rotx = -4.1999106407166, roty = -2.2178102881298e-05, rotz = 90.152450561523, fov = 60.0, active = true, rotOrder = 2},
        BoardHeader = 'Rebel is a Bitch',
    },
}


Config.JailWalk = true

Config.PDWalkMarker = true

Config.PDJailMarkers = {
    LSPD = {
        Marker = vector3(364.37, -1602.72, 24.59),
    },
}

Config.PropsAsItems = true

Config.CuffsAsItems = false

Config.MaxCuffs = 3 -- Max amount of times a player can break cuffs

Config.CopforUnCuff = false -- true == uncuff only for cops | false == anyone can uncuff .. ignored if CuffsAsItems is true

Config.CuffJob = {
    'police',
}

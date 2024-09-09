Config = {}

Config.Framwork = 'ESX' -- ESX | QBCore : Only Used for MugShots atm

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
        Target = {coords = vec3(368.0, -1601.0, 24.0), size = vec3(1, 1, 1), rotation = 0.0, debug = true, groups = {}},
        Suspectloc = {pos = vector3(372.51, -1592.84, 24.44), heading= 141.49, MaxDist = 10},
        Camera = {hash = "DEFAULT_SCRIPTED_CAMERA", posx = 371.52297973633, posy = -1594.1062011719, posz = 25.03999710083, rotx = 0.0, roty = 0.0, rotz = -40.082660675049, fov = 100.0, active = true, rotOrder = 2},
        BoardHeader = 'Los Santos Police Department',
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

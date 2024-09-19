Config = {}

Config.Locale = "en" -- en/cs

Config.MoneyItem = "money" -- Currency item

Config.Blip = { -- false/table
    name = "Apartments", 
    sprite = 475,
    color = 15,
    scale = 0.7
}

Config.Ped = {
	{
		ped = `a_m_y_business_01`, -- Ped model
		coords = vector4(-773.9286, 312.9101, 85.6981, 176.3887), -- Coords
        scenario = "WORLD_HUMAN_DRINKING", -- Scenario
        label = "Real estate agent" -- Label for target
	}
}

Config.PlayerLeaveExit = vec4(-773.649, 310.362, 85.698, 177.295) -- Coords where players spawn if the shut down game inside apartment

Config.Apartments = {
    ["small"] = { -- Uniquie name for apartment type
        title = "Small apartment", -- Title for purchase menu 
        description = "Price: 10.000$", -- Description for purchase menu
        icon = "tag", -- Icon for purchase menu
        price = 10000, -- Price for apartment
        enterCoords = vec4(-777.4781, 317.0354, 175.8037, 271.7080), -- Enter coords to apartment
        exitCoords = vec4(-774.0691, 311.3636, 84.6982, 173.7388), -- Exit coords from apartment
        exitTarget = vec3(-779.3943, 317.2039, 176.8036), -- Exit target coords
        door = vec3(-779.4504, 317.2305, 176.8036), -- Door coords
        doorHash = 330294775, -- door hash, needed for freeze doors
        tablet = { 
            target = vec3(-778.5281, 328.3851, 177.0450), -- Coords for tablet target
            icon = "fas fa-tablet", -- Icon for tablet target
            label = "Tablet", -- Label for tablet target
            safe = {
                label = "Safe", -- Label for stash
                stash = "safe", -- name for stash
                slots = 20, -- slots for stash
                weight = 50000, -- weight for stash
            },
        },
        armory = { -- false/table
            target = vec3(-771.1923, 326.5738, 176.8796), -- Coords for armory target
            icon = "fas fa-gun", -- Icon for armory target
            stash = "armory", -- name for stash
            label = "Armory", -- Label for armory target and stash
            slots = 20, -- slots for stash
            weight = 50000, -- weight for stash
        },
        fridge = { -- false/table
            target = vec3(-766.8932, 331.1528, 176.0224), -- Coords for fridge target
            icon = "fas fa-box-open", -- Icon for fridge target
            stash = "fridge", -- name for stash
            label = "Fridge", -- Label for fridge target and stash
            slots = 20, -- slots for stash
            weight = 50000, -- weight for stash
        },
        closet = { -- false/table
            target = vec3(-760.5590, 325.3960, 170.6071), -- Coords for closet target
            icon = "fas fa-shirt", -- Icon for closet target
            label = "Closet", -- Label for closet target
            trigger = "17mov_CharacterSystem:OpenOutfitsMenu", -- Trigger that opens outfit menu in apartment
        },
    },
    ["medium"] = { -- Uniquie name for apartment type
        title = "Standart apartment", -- Title for purchase menu 
        description = "Price: 15.000$", -- Description for purchase menu
        icon = "tag", -- Icon for purchase menu
        price = 15000, -- Price for apartment
        enterCoords = vec4(-779.4042, 338.7805, 195.6862, 185.7138), -- Enter coords to apartment
        exitCoords = vec4(-774.0691, 311.3636, 84.6982, 173.7388), -- Exit coords from apartment
        exitTarget = vec3(-779.2947, 340.3141, 196.6861), -- Exit target coords
        door = vec3(-779.2947, 340.3141, 196.6861), -- Door coords
        doorHash = 103339342, -- door hash, needed for freeze doors
        tablet = { 
            target = vec3(-763.9972, 336.4669, 196.2354), -- Coords for tablet target
            icon = "fas fa-tablet", -- Icon for tablet target
            label = "Tablet", -- Label for tablet target
            safe = {
                label = "Safe", -- Label for stash
                stash = "safe", -- name for stash
                slots = 20, -- slots for stash
                weight = 50000, -- weight for stash
            },
        },
        armory = { -- false/table
            target = vec3(-764.4493, 328.8567, 196.0259), -- Coords for armory target
            icon = "fas fa-gun", -- Icon for armory target
            stash = "armory", -- name for stash
            label = "Armory", -- Label for armory target and stash
            slots = 20, -- slots for stash
            weight = 50000, -- weight for stash
        },
        fridge = {
            target = vec3(-776.9228, 333.0154, 196.5243), -- Coords for fridge target
            icon = "fas fa-box-open", -- Icon for fridge target
            stash = "fridge", -- name for stash
            label = "Fridge", -- Label for fridge target and stash
            slots = 20, -- slots for stash
            weight = 50000, -- weight for stash
        },
        closet = {
            target = vec3(-762.9790, 328.8285, 199.4863), -- Coords for closet target
            icon = "fas fa-shirt", -- Icon for closet target
            label = "Closet", -- Label for closet target
            trigger = "17mov_CharacterSystem:OpenOutfitsMenu", -- Trigger that opens outfit menu in apartment
        },
    },
    ["big"] = { -- Uniquie name for apartment type 
        title = "Big apartment",-- Title for purchase menu 
        description = "Price: 25.000$", -- Description for purchase menu
        icon = "tag", -- Icon for purchase menu
        price = 25000, -- Price for apartment
        enterCoords = vec4(-776.2130, 323.5548, 211.0325, 271.7021), -- Enter coords to apartment
        exitCoords = vec4(-774.0691, 311.3636, 84.6982, 173.7388), -- Exit coords from apartment
        exitTarget = vec3(-778.0513, 323.6700, 211.9968), -- Exit target coords
        door = vec3(-778.0513, 323.6700, 211.9968), -- Door coords
        doorHash = 34120519, -- door hash, needed for freeze doors
        tablet = {
            target = vec3(-764.7580, 333.6094, 211.4155), -- Coords for tablet target
            icon = "fas fa-tablet", -- Icon for tablet target
            label = "Tablet", -- Label for tablet target
            safe = {
                label = "Safe", -- Label for stash
                stash = "safe", -- name for stash
                slots = 20, -- slots for stash
                weight = 50000, -- weight for stash
            },
        },
        armory = { -- false/table
            target = vec3(-765.3480, 325.9911, 211.5312), -- Coords for armory target
            icon = "fas fa-gun", -- Icon for armory target
            stash = "armory", -- name for stash
            label = "Armory", -- Label for armory target and stash
            slots = 20, -- slots for stash
            weight = 50000, -- weight for stash
        },
        fridge = {
            target = vec3(-771.7690, 334.7635, 211.6696), -- Coords for fridge target
            icon = "fas fa-box-open", -- Icon for fridge target
            stash = "fridge", -- name for stash
            label = "Fridge", -- Label for fridge target and stash
            slots = 20, -- slots for stash
            weight = 50000, -- weight for stash
        },
        closet = {
            target = vec3(-793.3689, 326.8171, 210.7967), -- Coords for closet target
            icon = "fas fa-shirt", -- Icon for closet target
            label = "Closet", -- Label for closet target
            trigger = "17mov_CharacterSystem:OpenOutfitsMenu", -- Trigger that opens outfit menu in apartment
        },
    },
}

function ShowNotify(msg, typ) -- Notify function
    lib.notify({
        title = 'Apartments',
        description = msg,
        type = typ
    })
end
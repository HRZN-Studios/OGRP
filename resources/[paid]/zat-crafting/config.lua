Config = {}

-- Framework : 
--            "qb"  : QBCORE
--            "esx" : ESX
Config.Framework = "esx"
Config.FrameworkPseudo = "ESX"
-- INVENTORY : 
--            "qb"      : qb-inventory (only qb)
--            "ox"      : ox-inventory        (qb + esx)
--            "origen"  : origen_inventory (only qb)
--            "ps"      : ps-inventory (only qb)
--            "qs"      : qs-inventory (only qb)
Config.Inventory = "ox"
Config.QBInventory = "old" -- new
-- IMAGE DIRECTOTY :
--            "qb-inventory/html/images/"       : qb-inventory (only qb)
--            "ox_inventory/web/images/"        : ox-inventory   (qb + esx)                  
--            "origen_inventory/web/images/"    : origen_inventory (only qb)
--            "ps-inventory/html/images/"       : ps-inventory (only qb)
--            "qs-inventory/html/images/"       : qs-inventory (only qb)
Config.img =  "ox_inventory/web/images/"       

-- qb-core and qb-weapons versions:
--            "old" : old version
--            "new" : latest version ***** RECOMMENDED
Config.qbVersion = "new" 

-- Table prop (you can change it)
Config.TableProp        = "gr_prop_gr_bench_04b"
Config.Slots            = 10 -- for blueprint and storage stash
-- qb-core and qb-weapons versions:
--            true  : use crafting tables
--            false : just use ped coords (NOT RECOMMENDED)
Config.UseTables = true
----------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------OPTIMISATION PART --------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------
-- Description  : this part is responsable on deleting the not needed props when no players are nearby
-- refreshprops : is the time to check if there is someone near the props or not
-- radius       : is to check how far is the player from the prop if it is < then the prop will be deleted until someone is nearby...
Config.RefreshProps = 10     -- 15 seconds
Config.Radius       = 100.0  -- if the distance between the player and the prop is < 50 then the prop will be deleted.
----------------------------------------------------------------------------------------------------------------------------------------


-- Craftables List
-- model            : item prop
-- zoffset          : Z value to postion perfectly the prop on the Ui
-- rep              : Reputation needed ("0" if no reputation needed)
-- amount           : Amount to give after craft ("1" is Recommeneded)
-- time             : crafting time
-- description      : Description written in the Ui
-- costs            : Required items to craft

-- LoadWeaponAssets
-- Keep it to false unless you know what you are doing
Config.LoadWeaponAssets = false
Config.RemoveBlueprint = false   -- if true blueprints will be removed after craft.
Config.IncreaseRep = false   -- if true REP will be increased by 'earnedrep' value.
Config.craftables = {
    [1] = {
        name = "thermite", -- !! for ox weapons it must be upper case (weapon_pistol50 will not work) (WEAPON_PISTOL50 will work)
        model = "hei_prop_heist_thermite",
        info = {}, -- item metadata
        zoffset = 0.12,
        rep = 70, 
        amount = 1,
        requireBlueprint = true, 
        time = 10, 
        description = "Thermite is a pyrotechnic composition of metal powder and metal oxide. When ignited by heat or chemical reaction, thermite undergoes an exothermic reduction-oxidation (redox) reaction. Most varieties are not explosive, but can create brief bursts of heat and high temperature in a small area. Its form of action is similar to that of other fuel-oxidizer mixtures, such as black powder.", 
        costs = { 
            ['metalscrap'] = 10,
            ['aluminum'] = 10,
        },
        earnedrep = 1,  -- only if Config.IncreaseRep = true
    },
    [2] = { 
        name ='drill', --- !! for ox weapons it must be upper case (weapon_pistol50 will not work) (WEAPON_PISTOL50 will work)
        model = "prop_tool_drill",
        info = {}, -- item metadata
        zoffset = 0.17,
        rep = 0, 
        amount = 1,
        requireBlueprint = true, 
        time = 10, 
        description = "bla bla bla.", 
        costs = { 
            ['metalscrap'] = 10,
            ['aluminum'] = 10,
        },
        earnedrep = 1,
    },
    [3] = { 
        name = "repairkit", -- !! for ox weapons it must be upper case (weapon_pistol50 will not work) (WEAPON_PISTOL50 will work)
        model = "h4_prop_h4_tool_box_02",
        info = {}, -- item metadata
        description = "bla bla bla.", 
        zoffset = 0.0,
        rep = 0, 
        amount = 1,
        requireBlueprint = false, 
        time = 10, 
        costs = { 
            ['metalscrap'] = 10,
            ['aluminum'] = 10,
        },
        earnedrep = 1,
    },
    ------------------------------------------------------- TEMPLATES IF YOU WANT TO USE METADATA ITEMS ------------------------------------------------------
    -- [4] = { 
    --     name = "zatgpu",
    --     model = "h4_prop_h4_tool_box_02",
    --     info = {
    --         type = "XTR-4070",
    --         performance  = 100,
    --         hz = 2.4
    --     }, -- item metadata
    --     description = "XTR-4070", 
    --     zoffset = 0.0,
    --     rep = 0, 
    --     amount = 1,
    --     requireBlueprint = true, 
    --     time = 1, 
    --     costs = { 
    --         ['metalscrap'] = 1,
    --         ['aluminum'] = 1,
    --     },
    --     earnedrep = 1,
    -- },
    -- [5] = { 
    --     name = "zatgpu",
    --     model = "h4_prop_h4_tool_box_02",
    --     info = {
    --         type = "XTR-3090",
    --         performance  = 100,
    --         hz = 2.4
    --     }, -- item metadata
    --     description = "XTR-3090", 
    --     zoffset = 0.0,
    --     rep = 0, 
    --     amount = 1,
    --     requireBlueprint = true, 
    --     time = 1, 
    --     costs = { 
    --         ['metalscrap'] = 1,
    --         ['aluminum'] = 1,
    --     },
    --     earnedrep = 1,
    -- },
    -- [6] = { 
    --     name = "blueprint",
    --     model = "h4_prop_h4_tool_box_02",
    --     info = {
    --         type = "XTR-3090",
    --     }, -- item metadata
    --     description = "XTR-3090.", 
    --     zoffset = 0.0,
    --     rep = 0, 
    --     amount = 1,
    --     requireBlueprint = false, 
    --     time = 1, 
    --     costs = { 
    --         ['metalscrap'] = 1,
    --         ['aluminum'] = 1,
    --     },
    --     earnedrep = 1,
    -- },
    ------------------------------------------------------------------------------------------------------------------------------------------------------------------
}
-- This is used to add or remove personal supported weapons.
-- name             : Weapon Model
-- model            : Weapon Prop
-- MaxRotationLeft  : Max  Prop Rotation when you move the mouse to the left
-- MaxRotationRight : Rotation when you move the mouse to the right
-- AlphaRx          : Rotation on the screen related to X
-- AlphaRy          : Rotation on the screen related to Y
-- RRMulti          : Rotation Multiplier on the screen related to X
-- AlphaX           : Position  (margin-left)
-- lphaY            : Position  (margin-top)
Config.Weapons = {
    ------------------------------------------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------------------------------------------
    --------------------------------------------------------------------  MELEE   ------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------------------------------------------
    ['weapon_dagger']= { 
        ["name"] = "weapon_dagger",            
        ["model"] = "w_me_dagger",            
        ["MaxRotationLeft"] = 10,               
        ["MaxRotationRight"] = 120,            

        ["SupressorAlphaRx"] = 0,              
        ["SupressorAlphaRy"] = 0,               
        ["SupressorRRMulti"] = 0,              
        ["SupressorAlphaX"] = 0,                
        ["SupressorAlphaY"] = 0,                

        ["ClipAlphaRx"] = 0,
        ["ClipAlphaRy"] = 0,
        ["ClipRRMulti"] = 0,
        ["ClipAlphaX"] = 0,
        ["ClipAlphaY"] = 0,

        ["FlashlightAlphaRx"] = 0,
        ["FlashlightAlphaRy"] = 0,
        ["FlashRRMulti"] = 0,
        ["FlashlightAlphaX"] = 0,
        ["FlashlightAlphaY"] = 0,

        ["ScopeAlphaRx"] = 0,
        ["ScopeAlphaRy"] = 0,
        ["ScopeRRMulti"] = 0,
        ["ScopeAlphaX"] = 0,
        ["ScopeAlphaY"] = 0,

        ["GripAlphaRx"] = 0,
        ["GripAlphaRy"] = 0,
        ["GripRRMulti"] = 0,
        ["GripAlphaX"] = 0,
        ["GripAlphaY"] = 0,

        ["SkinAlphaRx"] = 0.01,
        ["SkinAlphaRy"] = -0.07,
        ["SkinRRMulti"] = 2,
        ["SkinAlphaX"] = 48,                    
        ["SkinAlphaY"] = 55                    
    },
    ['weapon_bat']= { 
        ["name"] = "weapon_bat", 
        ["model"] = "w_me_bat", 
        ["MaxRotationLeft"] = 10,
        ["MaxRotationRight"] = 120,

        ["SupressorAlphaRx"] = 0,
        ["SupressorAlphaRy"] = 0,
        ["SupressorRRMulti"] = 0, 
        ["SupressorAlphaX"] = 0,
        ["SupressorAlphaY"] = 0,  

        ["ClipAlphaRx"] = 0,
        ["ClipAlphaRy"] = 0,
        ["ClipRRMulti"] = 0,
        ["ClipAlphaX"] = 0,
        ["ClipAlphaY"] = 0,

        ["FlashlightAlphaRx"] = 0,
        ["FlashlightAlphaRy"] = 0,
        ["FlashRRMulti"] = 0,
        ["FlashlightAlphaX"] = 0,
        ["FlashlightAlphaY"] = 0,

        ["ScopeAlphaRx"] = 0,
        ["ScopeAlphaRy"] = 0,
        ["ScopeRRMulti"] = 0,
        ["ScopeAlphaX"] = 0,
        ["ScopeAlphaY"] = 0,

        ["GripAlphaRx"] = 0,
        ["GripAlphaRy"] = 0,
        ["GripRRMulti"] = 0,
        ["GripAlphaX"] = 0,
        ["GripAlphaY"] = 0,

        ["SkinAlphaRx"] = 0.01,
        ["SkinAlphaRy"] = -0.07,
        ["SkinRRMulti"] = 2,
        ["SkinAlphaX"] = 48,
        ["SkinAlphaY"] = 55
    },
    ['weapon_bottle']= { 
        ["name"] = "weapon_bottle", 
        ["model"] = "w_me_bottle", 
        ["MaxRotationLeft"] = 10,
        ["MaxRotationRight"] = 120,

        ["SupressorAlphaRx"] = 0,
        ["SupressorAlphaRy"] = 0,
        ["SupressorRRMulti"] = 0, 
        ["SupressorAlphaX"] = 0,
        ["SupressorAlphaY"] = 0,  

        ["ClipAlphaRx"] = 0,
        ["ClipAlphaRy"] = 0,
        ["ClipRRMulti"] = 0,
        ["ClipAlphaX"] = 0,
        ["ClipAlphaY"] = 0,

        ["FlashlightAlphaRx"] = 0,
        ["FlashlightAlphaRy"] = 0,
        ["FlashRRMulti"] = 0,
        ["FlashlightAlphaX"] = 0,
        ["FlashlightAlphaY"] = 0,

        ["ScopeAlphaRx"] = 0,
        ["ScopeAlphaRy"] = 0,
        ["ScopeRRMulti"] = 0,
        ["ScopeAlphaX"] = 0,
        ["ScopeAlphaY"] = 0,

        ["GripAlphaRx"] = 0,
        ["GripAlphaRy"] = 0,
        ["GripRRMulti"] = 0,
        ["GripAlphaX"] = 0,
        ["GripAlphaY"] = 0,

        ["SkinAlphaRx"] = 0.01,
        ["SkinAlphaRy"] = -0.07,
        ["SkinRRMulti"] = 4,
        ["SkinAlphaX"] = 46,
        ["SkinAlphaY"] = 55
    },
    ['weapon_crowbar']= { 
        ["name"] = "weapon_crowbar", 
        ["model"] = "w_me_crowbar", 
        ["MaxRotationLeft"] = 10,
        ["MaxRotationRight"] = 120,

        ["SupressorAlphaRx"] = 0,
        ["SupressorAlphaRy"] = 0,
        ["SupressorRRMulti"] = 0, 
        ["SupressorAlphaX"] = 0,
        ["SupressorAlphaY"] = 0,  

        ["ClipAlphaRx"] = 0,
        ["ClipAlphaRy"] = 0,
        ["ClipRRMulti"] = 0,
        ["ClipAlphaX"] = 0,
        ["ClipAlphaY"] = 0,

        ["FlashlightAlphaRx"] = 0,
        ["FlashlightAlphaRy"] = 0,
        ["FlashRRMulti"] = 0,
        ["FlashlightAlphaX"] = 0,
        ["FlashlightAlphaY"] = 0,

        ["ScopeAlphaRx"] = 0,
        ["ScopeAlphaRy"] = 0,
        ["ScopeRRMulti"] = 0,
        ["ScopeAlphaX"] = 0,
        ["ScopeAlphaY"] = 0,

        ["GripAlphaRx"] = 0,
        ["GripAlphaRy"] = 0,
        ["GripRRMulti"] = 0,
        ["GripAlphaX"] = 0,
        ["GripAlphaY"] = 0,

        ["SkinAlphaRx"] = 0.00,
        ["SkinAlphaRy"] = -0.07,
        ["SkinRRMulti"] = 2,
        ["SkinAlphaX"] = 48,
        ["SkinAlphaY"] = 55
    },
    ['weapon_flashlight']= { 
        ["name"] = "weapon_flashlight", 
        ["model"] = "w_me_flashlight", 
        ["MaxRotationLeft"] = 10,
        ["MaxRotationRight"] = 120,

        ["SupressorAlphaRx"] = 0,
        ["SupressorAlphaRy"] = 0,
        ["SupressorRRMulti"] = 0, 
        ["SupressorAlphaX"] = 0,
        ["SupressorAlphaY"] = 0,  

        ["ClipAlphaRx"] = 0,
        ["ClipAlphaRy"] = 0,
        ["ClipRRMulti"] = 0,
        ["ClipAlphaX"] = 0,
        ["ClipAlphaY"] = 0,

        ["FlashlightAlphaRx"] = 0,
        ["FlashlightAlphaRy"] = 0,
        ["FlashRRMulti"] = 0,
        ["FlashlightAlphaX"] = 0,
        ["FlashlightAlphaY"] = 0,

        ["ScopeAlphaRx"] = 0,
        ["ScopeAlphaRy"] = 0,
        ["ScopeRRMulti"] = 0,
        ["ScopeAlphaX"] = 0,
        ["ScopeAlphaY"] = 0,

        ["GripAlphaRx"] = 0,
        ["GripAlphaRy"] = 0,
        ["GripRRMulti"] = 0,
        ["GripAlphaX"] = 0,
        ["GripAlphaY"] = 0,

        ["SkinAlphaRx"] = 0.00,
        ["SkinAlphaRy"] = -0.07,
        ["SkinRRMulti"] = 2,
        ["SkinAlphaX"] = 48,
        ["SkinAlphaY"] = 55
    },
    ['weapon_golfclub']= { 
        ["name"] = "weapon_golfclub", 
        ["model"] = "w_me_gclub", 
        ["MaxRotationLeft"] = 10,
        ["MaxRotationRight"] = 120,

        ["SupressorAlphaRx"] = 0,
        ["SupressorAlphaRy"] = 0,
        ["SupressorRRMulti"] = 0, 
        ["SupressorAlphaX"] = 0,
        ["SupressorAlphaY"] = 0,  

        ["ClipAlphaRx"] = 0,
        ["ClipAlphaRy"] = 0,
        ["ClipRRMulti"] = 0,
        ["ClipAlphaX"] = 0,
        ["ClipAlphaY"] = 0,

        ["FlashlightAlphaRx"] = 0,
        ["FlashlightAlphaRy"] = 0,
        ["FlashRRMulti"] = 0,
        ["FlashlightAlphaX"] = 0,
        ["FlashlightAlphaY"] = 0,

        ["ScopeAlphaRx"] = 0,
        ["ScopeAlphaRy"] = 0,
        ["ScopeRRMulti"] = 0,
        ["ScopeAlphaX"] = 0,
        ["ScopeAlphaY"] = 0,

        ["GripAlphaRx"] = 0,
        ["GripAlphaRy"] = 0,
        ["GripRRMulti"] = 0,
        ["GripAlphaX"] = 0,
        ["GripAlphaY"] = 0,

        ["SkinAlphaRx"] = 0.00,
        ["SkinAlphaRy"] = -0.07,
        ["SkinRRMulti"] = 2,
        ["SkinAlphaX"] = 48,
        ["SkinAlphaY"] = 55
    },
    ['weapon_hammer']= { 
        ["name"] = "weapon_hammer", 
        ["model"] = "w_me_hammer", 
        ["MaxRotationLeft"] = 10,
        ["MaxRotationRight"] = 120,

        ["SupressorAlphaRx"] = 0,
        ["SupressorAlphaRy"] = 0,
        ["SupressorRRMulti"] = 0, 
        ["SupressorAlphaX"] = 0,
        ["SupressorAlphaY"] = 0,  

        ["ClipAlphaRx"] = 0,
        ["ClipAlphaRy"] = 0,
        ["ClipRRMulti"] = 0,
        ["ClipAlphaX"] = 0,
        ["ClipAlphaY"] = 0,

        ["FlashlightAlphaRx"] = 0,
        ["FlashlightAlphaRy"] = 0,
        ["FlashRRMulti"] = 0,
        ["FlashlightAlphaX"] = 0,
        ["FlashlightAlphaY"] = 0,

        ["ScopeAlphaRx"] = 0,
        ["ScopeAlphaRy"] = 0,
        ["ScopeRRMulti"] = 0,
        ["ScopeAlphaX"] = 0,
        ["ScopeAlphaY"] = 0,

        ["GripAlphaRx"] = 0,
        ["GripAlphaRy"] = 0,
        ["GripRRMulti"] = 0,
        ["GripAlphaX"] = 0,
        ["GripAlphaY"] = 0,

        ["SkinAlphaRx"] = 0.00,
        ["SkinAlphaRy"] = -0.07,
        ["SkinRRMulti"] = 2,
        ["SkinAlphaX"] = 48,
        ["SkinAlphaY"] = 55
    },
    ['weapon_hatchet']= { 
        ["name"] = "weapon_hatchet", 
        ["model"] = "w_me_hatchet", 
        ["MaxRotationLeft"] = 10,
        ["MaxRotationRight"] = 120,

        ["SupressorAlphaRx"] = 0,
        ["SupressorAlphaRy"] = 0,
        ["SupressorRRMulti"] = 0, 
        ["SupressorAlphaX"] = 0,
        ["SupressorAlphaY"] = 0,  

        ["ClipAlphaRx"] = 0,
        ["ClipAlphaRy"] = 0,
        ["ClipRRMulti"] = 0,
        ["ClipAlphaX"] = 0,
        ["ClipAlphaY"] = 0,

        ["FlashlightAlphaRx"] = 0,
        ["FlashlightAlphaRy"] = 0,
        ["FlashRRMulti"] = 0,
        ["FlashlightAlphaX"] = 0,
        ["FlashlightAlphaY"] = 0,

        ["ScopeAlphaRx"] = 0,
        ["ScopeAlphaRy"] = 0,
        ["ScopeRRMulti"] = 0,
        ["ScopeAlphaX"] = 0,
        ["ScopeAlphaY"] = 0,

        ["GripAlphaRx"] = 0,
        ["GripAlphaRy"] = 0,
        ["GripRRMulti"] = 0,
        ["GripAlphaX"] = 0,
        ["GripAlphaY"] = 0,

        ["SkinAlphaRx"] = 0.00,
        ["SkinAlphaRy"] = -0.07,
        ["SkinRRMulti"] = 2,
        ["SkinAlphaX"] = 48,
        ["SkinAlphaY"] = 55
    },
    ['weapon_knuckle']= { 
        ["name"] = "weapon_knuckle", 
        ["model"] = "w_me_knuckle", 
        ["MaxRotationLeft"] = 10,
        ["MaxRotationRight"] = 120,

        ["SupressorAlphaRx"] = 0,
        ["SupressorAlphaRy"] = 0,
        ["SupressorRRMulti"] = 0, 
        ["SupressorAlphaX"] = 0,
        ["SupressorAlphaY"] = 0,  

        ["ClipAlphaRx"] = 0,
        ["ClipAlphaRy"] = 0,
        ["ClipRRMulti"] = 0,
        ["ClipAlphaX"] = 0,
        ["ClipAlphaY"] = 0,

        ["FlashlightAlphaRx"] = 0,
        ["FlashlightAlphaRy"] = 0,
        ["FlashRRMulti"] = 0,
        ["FlashlightAlphaX"] = 0,
        ["FlashlightAlphaY"] = 0,

        ["ScopeAlphaRx"] = 0,
        ["ScopeAlphaRy"] = 0,
        ["ScopeRRMulti"] = 0,
        ["ScopeAlphaX"] = 0,
        ["ScopeAlphaY"] = 0,

        ["GripAlphaRx"] = 0,
        ["GripAlphaRy"] = 0,
        ["GripRRMulti"] = 0,
        ["GripAlphaX"] = 0,
        ["GripAlphaY"] = 0,

        ["SkinAlphaRx"] = 0.00,
        ["SkinAlphaRy"] = -0.07,
        ["SkinRRMulti"] = 2,
        ["SkinAlphaX"] = 47,
        ["SkinAlphaY"] = 55
    },
    ['weapon_knife']= { 
        ["name"] = "weapon_knife", 
        ["model"] = "w_me_knife_01", 
        ["MaxRotationLeft"] = 10,
        ["MaxRotationRight"] = 120,

        ["SupressorAlphaRx"] = 0,
        ["SupressorAlphaRy"] = 0,
        ["SupressorRRMulti"] = 0, 
        ["SupressorAlphaX"] = 0,
        ["SupressorAlphaY"] = 0,  

        ["ClipAlphaRx"] = 0,
        ["ClipAlphaRy"] = 0,
        ["ClipRRMulti"] = 0,
        ["ClipAlphaX"] = 0,
        ["ClipAlphaY"] = 0,

        ["FlashlightAlphaRx"] = 0,
        ["FlashlightAlphaRy"] = 0,
        ["FlashRRMulti"] = 0,
        ["FlashlightAlphaX"] = 0,
        ["FlashlightAlphaY"] = 0,

        ["ScopeAlphaRx"] = 0,
        ["ScopeAlphaRy"] = 0,
        ["ScopeRRMulti"] = 0,
        ["ScopeAlphaX"] = 0,
        ["ScopeAlphaY"] = 0,

        ["GripAlphaRx"] = 0,
        ["GripAlphaRy"] = 0,
        ["GripRRMulti"] = 0,
        ["GripAlphaX"] = 0,
        ["GripAlphaY"] = 0,

        ["SkinAlphaRx"] = 0.00,
        ["SkinAlphaRy"] = -0.07,
        ["SkinRRMulti"] = 2,
        ["SkinAlphaX"] = 48,
        ["SkinAlphaY"] = 55
    },
    ['weapon_machete']= { 
        ["name"] = "weapon_machete", 
        ["model"] = "w_me_machette_lr", 
        ["MaxRotationLeft"] = 10,
        ["MaxRotationRight"] = 120,

        ["SupressorAlphaRx"] = 0,
        ["SupressorAlphaRy"] = 0,
        ["SupressorRRMulti"] = 0, 
        ["SupressorAlphaX"] = 0,
        ["SupressorAlphaY"] = 0,  

        ["ClipAlphaRx"] = 0,
        ["ClipAlphaRy"] = 0,
        ["ClipRRMulti"] = 0,
        ["ClipAlphaX"] = 0,
        ["ClipAlphaY"] = 0,

        ["FlashlightAlphaRx"] = 0,
        ["FlashlightAlphaRy"] = 0,
        ["FlashRRMulti"] = 0,
        ["FlashlightAlphaX"] = 0,
        ["FlashlightAlphaY"] = 0,

        ["ScopeAlphaRx"] = 0,
        ["ScopeAlphaRy"] = 0,
        ["ScopeRRMulti"] = 0,
        ["ScopeAlphaX"] = 0,
        ["ScopeAlphaY"] = 0,

        ["GripAlphaRx"] = 0,
        ["GripAlphaRy"] = 0,
        ["GripRRMulti"] = 0,
        ["GripAlphaX"] = 0,
        ["GripAlphaY"] = 0,

        ["SkinAlphaRx"] = 0.00,
        ["SkinAlphaRy"] = -0.07,
        ["SkinRRMulti"] = 2,
        ["SkinAlphaX"] = 48,
        ["SkinAlphaY"] = 55
    },
    ['weapon_switchblade']= { 
        ["name"] = "weapon_switchblade", 
        ["model"] = "w_me_switchblade", 
        ["MaxRotationLeft"] = 10,
        ["MaxRotationRight"] = 120,

        ["SupressorAlphaRx"] = 0,
        ["SupressorAlphaRy"] = 0,
        ["SupressorRRMulti"] = 0, 
        ["SupressorAlphaX"] = 0,
        ["SupressorAlphaY"] = 0,  

        ["ClipAlphaRx"] = 0,
        ["ClipAlphaRy"] = 0,
        ["ClipRRMulti"] = 0,
        ["ClipAlphaX"] = 0,
        ["ClipAlphaY"] = 0,

        ["FlashlightAlphaRx"] = 0,
        ["FlashlightAlphaRy"] = 0,
        ["FlashRRMulti"] = 0,
        ["FlashlightAlphaX"] = 0,
        ["FlashlightAlphaY"] = 0,

        ["ScopeAlphaRx"] = 0,
        ["ScopeAlphaRy"] = 0,
        ["ScopeRRMulti"] = 0,
        ["ScopeAlphaX"] = 0,
        ["ScopeAlphaY"] = 0,

        ["GripAlphaRx"] = 0,
        ["GripAlphaRy"] = 0,
        ["GripRRMulti"] = 0,
        ["GripAlphaX"] = 0,
        ["GripAlphaY"] = 0,

        ["SkinAlphaRx"] = 0.00,
        ["SkinAlphaRy"] = -0.07,
        ["SkinRRMulti"] = 2,
        ["SkinAlphaX"] = 48,
        ["SkinAlphaY"] = 55
    },
    ['weapon_nightstick']= { 
        ["name"] = "weapon_nightstick", 
        ["model"] = "w_me_nightstick", 
        ["MaxRotationLeft"] = 10,
        ["MaxRotationRight"] = 120,

        ["SupressorAlphaRx"] = 0,
        ["SupressorAlphaRy"] = 0,
        ["SupressorRRMulti"] = 0, 
        ["SupressorAlphaX"] = 0,
        ["SupressorAlphaY"] = 0,  

        ["ClipAlphaRx"] = 0,
        ["ClipAlphaRy"] = 0,
        ["ClipRRMulti"] = 0,
        ["ClipAlphaX"] = 0,
        ["ClipAlphaY"] = 0,

        ["FlashlightAlphaRx"] = 0,
        ["FlashlightAlphaRy"] = 0,
        ["FlashRRMulti"] = 0,
        ["FlashlightAlphaX"] = 0,
        ["FlashlightAlphaY"] = 0,

        ["ScopeAlphaRx"] = 0,
        ["ScopeAlphaRy"] = 0,
        ["ScopeRRMulti"] = 0,
        ["ScopeAlphaX"] = 0,
        ["ScopeAlphaY"] = 0,

        ["GripAlphaRx"] = 0,
        ["GripAlphaRy"] = 0,
        ["GripRRMulti"] = 0,
        ["GripAlphaX"] = 0,
        ["GripAlphaY"] = 0,

        ["SkinAlphaRx"] = 0.00,
        ["SkinAlphaRy"] = -0.07,
        ["SkinRRMulti"] = 2,
        ["SkinAlphaX"] = 48,
        ["SkinAlphaY"] = 55
    },
    ['weapon_wrench']= { 
        ["name"] = "weapon_wrench", 
        ["model"] = "w_me_wrench", 
        ["MaxRotationLeft"] = 10,
        ["MaxRotationRight"] = 120,

        ["SupressorAlphaRx"] = 0,
        ["SupressorAlphaRy"] = 0,
        ["SupressorRRMulti"] = 0, 
        ["SupressorAlphaX"] = 0,
        ["SupressorAlphaY"] = 0,  

        ["ClipAlphaRx"] = 0,
        ["ClipAlphaRy"] = 0,
        ["ClipRRMulti"] = 0,
        ["ClipAlphaX"] = 0,
        ["ClipAlphaY"] = 0,

        ["FlashlightAlphaRx"] = 0,
        ["FlashlightAlphaRy"] = 0,
        ["FlashRRMulti"] = 0,
        ["FlashlightAlphaX"] = 0,
        ["FlashlightAlphaY"] = 0,

        ["ScopeAlphaRx"] = 0,
        ["ScopeAlphaRy"] = 0,
        ["ScopeRRMulti"] = 0,
        ["ScopeAlphaX"] = 0,
        ["ScopeAlphaY"] = 0,

        ["GripAlphaRx"] = 0,
        ["GripAlphaRy"] = 0,
        ["GripRRMulti"] = 0,
        ["GripAlphaX"] = 0,
        ["GripAlphaY"] = 0,

        ["SkinAlphaRx"] = 0.00,
        ["SkinAlphaRy"] = -0.07,
        ["SkinRRMulti"] = 2,
        ["SkinAlphaX"] = 48,
        ["SkinAlphaY"] = 55
    },
    ['weapon_battleaxe']= { 
        ["name"] = "weapon_battleaxe", 
        ["model"] = "w_me_battleaxe", 
        ["MaxRotationLeft"] = 10,
        ["MaxRotationRight"] = 120,

        ["SupressorAlphaRx"] = 0,
        ["SupressorAlphaRy"] = 0,
        ["SupressorRRMulti"] = 0, 
        ["SupressorAlphaX"] = 0,
        ["SupressorAlphaY"] = 0,  

        ["ClipAlphaRx"] = 0,
        ["ClipAlphaRy"] = 0,
        ["ClipRRMulti"] = 0,
        ["ClipAlphaX"] = 0,
        ["ClipAlphaY"] = 0,

        ["FlashlightAlphaRx"] = 0,
        ["FlashlightAlphaRy"] = 0,
        ["FlashRRMulti"] = 0,
        ["FlashlightAlphaX"] = 0,
        ["FlashlightAlphaY"] = 0,

        ["ScopeAlphaRx"] = 0,
        ["ScopeAlphaRy"] = 0,
        ["ScopeRRMulti"] = 0,
        ["ScopeAlphaX"] = 0,
        ["ScopeAlphaY"] = 0,

        ["GripAlphaRx"] = 0,
        ["GripAlphaRy"] = 0,
        ["GripRRMulti"] = 0,
        ["GripAlphaX"] = 0,
        ["GripAlphaY"] = 0,

        ["SkinAlphaRx"] = 0.00,
        ["SkinAlphaRy"] = -0.07,
        ["SkinRRMulti"] = 2,
        ["SkinAlphaX"] = 48,
        ["SkinAlphaY"] = 55
    },
    ['weapon_poolcue']= { 
        ["name"] = "weapon_poolcue", 
        ["model"] = "w_me_poolcue", 
        ["MaxRotationLeft"] = 10,
        ["MaxRotationRight"] = 120,

        ["SupressorAlphaRx"] = 0,
        ["SupressorAlphaRy"] = 0,
        ["SupressorRRMulti"] = 0, 
        ["SupressorAlphaX"] = 0,
        ["SupressorAlphaY"] = 0,  

        ["ClipAlphaRx"] = 0,
        ["ClipAlphaRy"] = 0,
        ["ClipRRMulti"] = 0,
        ["ClipAlphaX"] = 0,
        ["ClipAlphaY"] = 0,

        ["FlashlightAlphaRx"] = 0,
        ["FlashlightAlphaRy"] = 0,
        ["FlashRRMulti"] = 0,
        ["FlashlightAlphaX"] = 0,
        ["FlashlightAlphaY"] = 0,

        ["ScopeAlphaRx"] = 0,
        ["ScopeAlphaRy"] = 0,
        ["ScopeRRMulti"] = 0,
        ["ScopeAlphaX"] = 0,
        ["ScopeAlphaY"] = 0,

        ["GripAlphaRx"] = 0,
        ["GripAlphaRy"] = 0,
        ["GripRRMulti"] = 0,
        ["GripAlphaX"] = 0,
        ["GripAlphaY"] = 0,

        ["SkinAlphaRx"] = 0.00,
        ["SkinAlphaRy"] = -0.07,
        ["SkinRRMulti"] = 2,
        ["SkinAlphaX"] = 48,
        ["SkinAlphaY"] = 55
    },
    ['weapon_stone_hatchet']= { 
        ["name"] = "weapon_stone_hatchet", 
        ["model"] = "w_me_stonehatchet", 
        ["MaxRotationLeft"] = 10,
        ["MaxRotationRight"] = 120,

        ["SupressorAlphaRx"] = 0,
        ["SupressorAlphaRy"] = 0,
        ["SupressorRRMulti"] = 0, 
        ["SupressorAlphaX"] = 0,
        ["SupressorAlphaY"] = 0,  

        ["ClipAlphaRx"] = 0,
        ["ClipAlphaRy"] = 0,
        ["ClipRRMulti"] = 0,
        ["ClipAlphaX"] = 0,
        ["ClipAlphaY"] = 0,

        ["FlashlightAlphaRx"] = 0,
        ["FlashlightAlphaRy"] = 0,
        ["FlashRRMulti"] = 0,
        ["FlashlightAlphaX"] = 0,
        ["FlashlightAlphaY"] = 0,

        ["ScopeAlphaRx"] = 0,
        ["ScopeAlphaRy"] = 0,
        ["ScopeRRMulti"] = 0,
        ["ScopeAlphaX"] = 0,
        ["ScopeAlphaY"] = 0,

        ["GripAlphaRx"] = 0,
        ["GripAlphaRy"] = 0,
        ["GripRRMulti"] = 0,
        ["GripAlphaX"] = 0,
        ["GripAlphaY"] = 0,

        ["SkinAlphaRx"] = 0.00,
        ["SkinAlphaRy"] = -0.07,
        ["SkinRRMulti"] = 2,
        ["SkinAlphaX"] = 48,
        ["SkinAlphaY"] = 55
    },
    ['weapon_candycane']= { 
        ["name"] = "weapon_candycane", 
        ["model"] = "w_me_candy_xm3", 
        ["MaxRotationLeft"] = 10,
        ["MaxRotationRight"] = 120,

        ["SupressorAlphaRx"] = 0,
        ["SupressorAlphaRy"] = 0,
        ["SupressorRRMulti"] = 0, 
        ["SupressorAlphaX"] = 0,
        ["SupressorAlphaY"] = 0,  

        ["ClipAlphaRx"] = 0,
        ["ClipAlphaRy"] = 0,
        ["ClipRRMulti"] = 0,
        ["ClipAlphaX"] = 0,
        ["ClipAlphaY"] = 0,

        ["FlashlightAlphaRx"] = 0,
        ["FlashlightAlphaRy"] = 0,
        ["FlashRRMulti"] = 0,
        ["FlashlightAlphaX"] = 0,
        ["FlashlightAlphaY"] = 0,

        ["ScopeAlphaRx"] = 0,
        ["ScopeAlphaRy"] = 0,
        ["ScopeRRMulti"] = 0,
        ["ScopeAlphaX"] = 0,
        ["ScopeAlphaY"] = 0,

        ["GripAlphaRx"] = 0,
        ["GripAlphaRy"] = 0,
        ["GripRRMulti"] = 0,
        ["GripAlphaX"] = 0,
        ["GripAlphaY"] = 0,

        ["SkinAlphaRx"] = 0.00,
        ["SkinAlphaRy"] = -0.07,
        ["SkinRRMulti"] = 2,
        ["SkinAlphaX"] = 48,
        ["SkinAlphaY"] = 55
    },
    ------------------------------------------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------------------------------------------
    -------------------------------------------------------------------- HANDGUNS ------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------------------------------------------
    ['weapon_pistol']         = { 
        ["name"] = "weapon_pistol", 
        ["model"] = "w_pi_pistol", 
        ["MaxRotationLeft"] = 10,
        ["MaxRotationRight"] = 120,

        ["SupressorAlphaRx"] = 0.03,
        ["SupressorAlphaRy"] = 0.05,
        ["SupressorRRMulti"] = 6, 
        ["SupressorAlphaX"] = 44,
        ["SupressorAlphaY"] = 52,  

        ["ClipAlphaRx"] = -0.03,
        ["ClipAlphaRy"] =  -0.08,
        ["ClipRRMulti"] = 4,
        ["ClipAlphaX"] = 51,
        ["ClipAlphaY"] = 59,

        ["FlashlightAlphaRx"] = 0.03,
        ["FlashlightAlphaRy"] = -0.01,
        ["FlashRRMulti"] = 4,
        ["FlashlightAlphaX"] = 46,
        ["FlashlightAlphaY"] = 54,

        ["ScopeAlphaRx"] = 0,
        ["ScopeAlphaRy"] = 0,
        ["ScopeRRMulti"] = 0,
        ["ScopeAlphaX"] = 0,
        ["ScopeAlphaY"] = 0,

        ["GripAlphaRx"] = 0,
        ["GripAlphaRy"] = 0,
        ["GripRRMulti"] = 0,
        ["GripAlphaX"] = 0,
        ["GripAlphaY"] = 0,

        ["SkinAlphaRx"] = -0.03,
        ["SkinAlphaRy"] = 0.03,
        ["SkinRRMulti"] = 4,
        ["SkinAlphaX"] = 51,
        ["SkinAlphaY"] = 50
    },
    ['weapon_pistol_mk2']         = { 
        ["name"] = "weapon_pistol_mk2", 
        ["model"] = "w_pi_pistolmk2", 
        ["MaxRotationLeft"] = 10,
        ["MaxRotationRight"] = 120,

        ["SupressorAlphaRx"] = 0.03,
        ["SupressorAlphaRy"] = 0.05,
        ["SupressorRRMulti"] = 6, 
        ["SupressorAlphaX"] = 44,
        ["SupressorAlphaY"] = 52,  

        ["ClipAlphaRx"] = -0.03,
        ["ClipAlphaRy"] =  -0.08,
        ["ClipRRMulti"] = 4,
        ["ClipAlphaX"] = 51,
        ["ClipAlphaY"] = 59,

        ["FlashlightAlphaRx"] = 0.03,
        ["FlashlightAlphaRy"] = -0.01,
        ["FlashRRMulti"] = 4,
        ["FlashlightAlphaX"] = 46,
        ["FlashlightAlphaY"] = 54,

        ["ScopeAlphaRx"] = 0,
        ["ScopeAlphaRy"] = 0,
        ["ScopeRRMulti"] = 0,
        ["ScopeAlphaX"] = 0,
        ["ScopeAlphaY"] = 0,

        ["GripAlphaRx"] = 0,
        ["GripAlphaRy"] = 0,
        ["GripRRMulti"] = 0,
        ["GripAlphaX"] = 0,
        ["GripAlphaY"] = 0,

        ["SkinAlphaRx"] = -0.03,
        ["SkinAlphaRy"] = 0.03,
        ["SkinRRMulti"] = 4,
        ["SkinAlphaX"] = 51,
        ["SkinAlphaY"] = 50
    },
    ['weapon_combatpistol']         = { 
        ["name"] = "weapon_combatpistol", 
        ["model"] = "w_pi_combatpistol", 
        ["MaxRotationLeft"] = 10,
        ["MaxRotationRight"] = 120,

        ["SupressorAlphaRx"] = 0.03,
        ["SupressorAlphaRy"] = 0.05,
        ["SupressorRRMulti"] = 6, 
        ["SupressorAlphaX"] = 44,
        ["SupressorAlphaY"] = 52,  

        ["ClipAlphaRx"] = -0.03,
        ["ClipAlphaRy"] =  -0.08,
        ["ClipRRMulti"] = 4,
        ["ClipAlphaX"] = 51,
        ["ClipAlphaY"] = 59,

        ["FlashlightAlphaRx"] = 0.03,
        ["FlashlightAlphaRy"] = -0.01,
        ["FlashRRMulti"] = 4,
        ["FlashlightAlphaX"] = 46,
        ["FlashlightAlphaY"] = 54,

        ["ScopeAlphaRx"] = 0,
        ["ScopeAlphaRy"] = 0,
        ["ScopeRRMulti"] = 0,
        ["ScopeAlphaX"] = 0,
        ["ScopeAlphaY"] = 0,

        ["GripAlphaRx"] = 0,
        ["GripAlphaRy"] = 0,
        ["GripRRMulti"] = 0,
        ["GripAlphaX"] = 0,
        ["GripAlphaY"] = 0,

        ["SkinAlphaRx"] = -0.03,
        ["SkinAlphaRy"] = 0.03,
        ["SkinRRMulti"] = 4,
        ["SkinAlphaX"] = 51,
        ["SkinAlphaY"] = 50
    },
    ['weapon_appistol']         = { 
        ["name"] = "weapon_appistol", 
        ["model"] = "w_pi_appistol", 
        ["MaxRotationLeft"] = 10,
        ["MaxRotationRight"] = 120,

        ["SupressorAlphaRx"] = 0.03,
        ["SupressorAlphaRy"] = 0.05,
        ["SupressorRRMulti"] = 6, 
        ["SupressorAlphaX"] = 44,
        ["SupressorAlphaY"] = 52,  

        ["ClipAlphaRx"] = -0.03,
        ["ClipAlphaRy"] =  -0.08,
        ["ClipRRMulti"] = 4,
        ["ClipAlphaX"] = 51,
        ["ClipAlphaY"] = 59,

        ["FlashlightAlphaRx"] = 0.03,
        ["FlashlightAlphaRy"] = -0.01,
        ["FlashRRMulti"] = 4,
        ["FlashlightAlphaX"] = 46,
        ["FlashlightAlphaY"] = 54,

        ["ScopeAlphaRx"] = 0,
        ["ScopeAlphaRy"] = 0,
        ["ScopeRRMulti"] = 0,
        ["ScopeAlphaX"] = 0,
        ["ScopeAlphaY"] = 0,

        ["GripAlphaRx"] = 0,
        ["GripAlphaRy"] = 0,
        ["GripRRMulti"] = 0,
        ["GripAlphaX"] = 0,
        ["GripAlphaY"] = 0,

        ["SkinAlphaRx"] = -0.03,
        ["SkinAlphaRy"] = 0.03,
        ["SkinRRMulti"] = 4,
        ["SkinAlphaX"] = 51,
        ["SkinAlphaY"] = 50
    },
    ['weapon_stungun']         = { 
        ["name"] = "weapon_stungun", 
        ["model"] = "w_pi_stungun", 
        ["MaxRotationLeft"] = 10,
        ["MaxRotationRight"] = 120,

        ["SupressorAlphaRx"] = 0.03,
        ["SupressorAlphaRy"] = 0.05,
        ["SupressorRRMulti"] = 6, 
        ["SupressorAlphaX"] = 44,
        ["SupressorAlphaY"] = 52,  

        ["ClipAlphaRx"] = -0.03,
        ["ClipAlphaRy"] =  -0.08,
        ["ClipRRMulti"] = 4,
        ["ClipAlphaX"] = 51,
        ["ClipAlphaY"] = 59,

        ["FlashlightAlphaRx"] = 0.03,
        ["FlashlightAlphaRy"] = -0.01,
        ["FlashRRMulti"] = 4,
        ["FlashlightAlphaX"] = 46,
        ["FlashlightAlphaY"] = 54,

        ["ScopeAlphaRx"] = 0,
        ["ScopeAlphaRy"] = 0,
        ["ScopeRRMulti"] = 0,
        ["ScopeAlphaX"] = 0,
        ["ScopeAlphaY"] = 0,

        ["GripAlphaRx"] = 0,
        ["GripAlphaRy"] = 0,
        ["GripRRMulti"] = 0,
        ["GripAlphaX"] = 0,
        ["GripAlphaY"] = 0,

        ["SkinAlphaRx"] = -0.01,
        ["SkinAlphaRy"] = 0.03,
        ["SkinRRMulti"] = 4,
        ["SkinAlphaX"] = 49,
        ["SkinAlphaY"] = 50
    },
    ['weapon_pistol50']         = { 
        ["name"] = "weapon_pistol50", 
        ["model"] = "w_pi_pistol50", 
        ["MaxRotationLeft"] = 10,
        ["MaxRotationRight"] = 120,

        ["SupressorAlphaRx"] = 0.03,
        ["SupressorAlphaRy"] = 0.05,
        ["SupressorRRMulti"] = 6, 
        ["SupressorAlphaX"] = 44,
        ["SupressorAlphaY"] = 52,  

        ["ClipAlphaRx"] = -0.03,
        ["ClipAlphaRy"] =  -0.08,
        ["ClipRRMulti"] = 4,
        ["ClipAlphaX"] = 51,
        ["ClipAlphaY"] = 59,

        ["FlashlightAlphaRx"] = 0.03,
        ["FlashlightAlphaRy"] = -0.01,
        ["FlashRRMulti"] = 4,
        ["FlashlightAlphaX"] = 46,
        ["FlashlightAlphaY"] = 54,

        ["ScopeAlphaRx"] = 0,
        ["ScopeAlphaRy"] = 0,
        ["ScopeRRMulti"] = 0,
        ["ScopeAlphaX"] = 0,
        ["ScopeAlphaY"] = 0,

        ["GripAlphaRx"] = 0,
        ["GripAlphaRy"] = 0,
        ["GripRRMulti"] = 0,
        ["GripAlphaX"] = 0,
        ["GripAlphaY"] = 0,

        ["SkinAlphaRx"] = -0.03,
        ["SkinAlphaRy"] = 0.03,
        ["SkinRRMulti"] = 4,
        ["SkinAlphaX"] = 51,
        ["SkinAlphaY"] = 50
    },
    ['weapon_snspistol']         = { 
        ["name"] = "weapon_snspistol", 
        ["model"] = "w_pi_sns_pistol", 
        ["MaxRotationLeft"] = 10,
        ["MaxRotationRight"] = 120,

        ["SupressorAlphaRx"] = 0.03,
        ["SupressorAlphaRy"] = 0.05,
        ["SupressorRRMulti"] = 6, 
        ["SupressorAlphaX"] = 44,
        ["SupressorAlphaY"] = 52,  

        ["ClipAlphaRx"] = -0.03,
        ["ClipAlphaRy"] =  -0.08,
        ["ClipRRMulti"] = 4,
        ["ClipAlphaX"] = 51,
        ["ClipAlphaY"] = 59,

        ["FlashlightAlphaRx"] = 0.03,
        ["FlashlightAlphaRy"] = -0.01,
        ["FlashRRMulti"] = 4,
        ["FlashlightAlphaX"] = 46,
        ["FlashlightAlphaY"] = 54,

        ["ScopeAlphaRx"] = 0,
        ["ScopeAlphaRy"] = 0,
        ["ScopeRRMulti"] = 0,
        ["ScopeAlphaX"] = 0,
        ["ScopeAlphaY"] = 0,

        ["GripAlphaRx"] = 0,
        ["GripAlphaRy"] = 0,
        ["GripRRMulti"] = 0,
        ["GripAlphaX"] = 0,
        ["GripAlphaY"] = 0,

        ["SkinAlphaRx"] = -0.03,
        ["SkinAlphaRy"] = 0.03,
        ["SkinRRMulti"] = 4,
        ["SkinAlphaX"] = 51,
        ["SkinAlphaY"] = 50
    },
    ['weapon_snspistol_mk2']         = { 
        ["name"] = "weapon_snspistol_mk2", 
        ["model"] = "w_pi_sns_pistolmk2", 
        ["MaxRotationLeft"] = 10,
        ["MaxRotationRight"] = 120,

        ["SupressorAlphaRx"] = 0.03,
        ["SupressorAlphaRy"] = 0.05,
        ["SupressorRRMulti"] = 4, 
        ["SupressorAlphaX"] = 45,
        ["SupressorAlphaY"] = 52,  

        ["ClipAlphaRx"] = -0.03,
        ["ClipAlphaRy"] =  -0.08,
        ["ClipRRMulti"] = 4,
        ["ClipAlphaX"] = 51,
        ["ClipAlphaY"] = 59,

        ["FlashlightAlphaRx"] = 0.03,
        ["FlashlightAlphaRy"] = -0.01,
        ["FlashRRMulti"] = 4,
        ["FlashlightAlphaX"] = 47,
        ["FlashlightAlphaY"] = 54,

        ["ScopeAlphaRx"] = 0,
        ["ScopeAlphaRy"] = 0,
        ["ScopeRRMulti"] = 0,
        ["ScopeAlphaX"] = 0,
        ["ScopeAlphaY"] = 0,

        ["GripAlphaRx"] = 0,
        ["GripAlphaRy"] = 0,
        ["GripRRMulti"] = 0,
        ["GripAlphaX"] = 0,
        ["GripAlphaY"] = 0,

        ["SkinAlphaRx"] = -0.03,
        ["SkinAlphaRy"] = 0.03,
        ["SkinRRMulti"] = 4,
        ["SkinAlphaX"] = 51,
        ["SkinAlphaY"] = 50
    },
    ['weapon_heavypistol']         = { 
        ["name"] = "weapon_heavypistol", 
        ["model"] = "w_pi_heavypistol", 
        ["MaxRotationLeft"] = 10,
        ["MaxRotationRight"] = 120,

        ["SupressorAlphaRx"] = 0.03,
        ["SupressorAlphaRy"] = 0.05,
        ["SupressorRRMulti"] = 6, 
        ["SupressorAlphaX"] = 44,
        ["SupressorAlphaY"] = 52,  

        ["ClipAlphaRx"] = -0.03,
        ["ClipAlphaRy"] =  -0.08,
        ["ClipRRMulti"] = 4,
        ["ClipAlphaX"] = 51,
        ["ClipAlphaY"] = 59,

        ["FlashlightAlphaRx"] = 0.03,
        ["FlashlightAlphaRy"] = -0.01,
        ["FlashRRMulti"] = 4,
        ["FlashlightAlphaX"] = 46,
        ["FlashlightAlphaY"] = 54,

        ["ScopeAlphaRx"] = 0,
        ["ScopeAlphaRy"] = 0,
        ["ScopeRRMulti"] = 0,
        ["ScopeAlphaX"] = 0,
        ["ScopeAlphaY"] = 0,

        ["GripAlphaRx"] = 0,
        ["GripAlphaRy"] = 0,
        ["GripRRMulti"] = 0,
        ["GripAlphaX"] = 0,
        ["GripAlphaY"] = 0,

        ["SkinAlphaRx"] = -0.03,
        ["SkinAlphaRy"] = 0.03,
        ["SkinRRMulti"] = 4,
        ["SkinAlphaX"] = 51,
        ["SkinAlphaY"] = 50
    },
    ['weapon_vintagepistol']         = { 
        ["name"] = "weapon_vintagepistol", 
        ["model"] = "w_pi_vintage_pistol", 
        ["MaxRotationLeft"] = 10,
        ["MaxRotationRight"] = 120,

        ["SupressorAlphaRx"] = 0.03,
        ["SupressorAlphaRy"] = 0.05,
        ["SupressorRRMulti"] = 6, 
        ["SupressorAlphaX"] = 44,
        ["SupressorAlphaY"] = 52,  

        ["ClipAlphaRx"] = -0.03,
        ["ClipAlphaRy"] =  -0.08,
        ["ClipRRMulti"] = 4,
        ["ClipAlphaX"] = 51,
        ["ClipAlphaY"] = 59,

        ["FlashlightAlphaRx"] = 0.03,
        ["FlashlightAlphaRy"] = -0.01,
        ["FlashRRMulti"] = 4,
        ["FlashlightAlphaX"] = 46,
        ["FlashlightAlphaY"] = 54,

        ["ScopeAlphaRx"] = 0,
        ["ScopeAlphaRy"] = 0,
        ["ScopeRRMulti"] = 0,
        ["ScopeAlphaX"] = 0,
        ["ScopeAlphaY"] = 0,

        ["GripAlphaRx"] = 0,
        ["GripAlphaRy"] = 0,
        ["GripRRMulti"] = 0,
        ["GripAlphaX"] = 0,
        ["GripAlphaY"] = 0,

        ["SkinAlphaRx"] = -0.03,
        ["SkinAlphaRy"] = 0.03,
        ["SkinRRMulti"] = 4,
        ["SkinAlphaX"] = 51,
        ["SkinAlphaY"] = 50
    },
    ['weapon_flaregun']         = { 
        ["name"] = "weapon_flaregun", 
        ["model"] = "w_pi_flaregun", 
        ["MaxRotationLeft"] = 10,
        ["MaxRotationRight"] = 120,

        ["SupressorAlphaRx"] = 0.03,
        ["SupressorAlphaRy"] = 0.05,
        ["SupressorRRMulti"] = 6, 
        ["SupressorAlphaX"] = 44,
        ["SupressorAlphaY"] = 52,  

        ["ClipAlphaRx"] = -0.03,
        ["ClipAlphaRy"] =  -0.08,
        ["ClipRRMulti"] = 4,
        ["ClipAlphaX"] = 51,
        ["ClipAlphaY"] = 59,

        ["FlashlightAlphaRx"] = 0.03,
        ["FlashlightAlphaRy"] = -0.01,
        ["FlashRRMulti"] = 4,
        ["FlashlightAlphaX"] = 46,
        ["FlashlightAlphaY"] = 54,

        ["ScopeAlphaRx"] = 0,
        ["ScopeAlphaRy"] = 0,
        ["ScopeRRMulti"] = 0,
        ["ScopeAlphaX"] = 0,
        ["ScopeAlphaY"] = 0,

        ["GripAlphaRx"] = 0,
        ["GripAlphaRy"] = 0,
        ["GripRRMulti"] = 0,
        ["GripAlphaX"] = 0,
        ["GripAlphaY"] = 0,

        ["SkinAlphaRx"] = 0.01,
        ["SkinAlphaRy"] = 0.03,
        ["SkinRRMulti"] = 4,
        ["SkinAlphaX"] = 48,
        ["SkinAlphaY"] = 50
    },
    ['weapon_revolver']         = { 
        ["name"] = "weapon_revolver", 
        ["model"] = "w_pi_revolver", 
        ["MaxRotationLeft"] = 10,
        ["MaxRotationRight"] = 120,

        ["SupressorAlphaRx"] = 0.03,
        ["SupressorAlphaRy"] = 0.05,
        ["SupressorRRMulti"] = 6, 
        ["SupressorAlphaX"] = 44,
        ["SupressorAlphaY"] = 52,  

        ["ClipAlphaRx"] = -0.03,
        ["ClipAlphaRy"] =  -0.08,
        ["ClipRRMulti"] = 4,
        ["ClipAlphaX"] = 51,
        ["ClipAlphaY"] = 59,

        ["FlashlightAlphaRx"] = 0.03,
        ["FlashlightAlphaRy"] = -0.01,
        ["FlashRRMulti"] = 4,
        ["FlashlightAlphaX"] = 46,
        ["FlashlightAlphaY"] = 54,

        ["ScopeAlphaRx"] = 0,
        ["ScopeAlphaRy"] = 0,
        ["ScopeRRMulti"] = 0,
        ["ScopeAlphaX"] = 0,
        ["ScopeAlphaY"] = 0,

        ["GripAlphaRx"] = 0,
        ["GripAlphaRy"] = 0,
        ["GripRRMulti"] = 0,
        ["GripAlphaX"] = 0,
        ["GripAlphaY"] = 0,

        ["SkinAlphaRx"] = -0.01,
        ["SkinAlphaRy"] = 0.03,
        ["SkinRRMulti"] = 4,
        ["SkinAlphaX"] = 49,
        ["SkinAlphaY"] = 50
    },
    ['weapon_revolver_mk2']         = { 
        ["name"] = "weapon_revolver_mk2", 
        ["model"] = "w_pi_revolvermk2", 
        ["MaxRotationLeft"] = 10,
        ["MaxRotationRight"] = 120,

        ["SupressorAlphaRx"] = 0.03,
        ["SupressorAlphaRy"] = 0.05,
        ["SupressorRRMulti"] = 12, 
        ["SupressorAlphaX"] = 40,
        ["SupressorAlphaY"] = 52,  

        ["ClipAlphaRx"] = -0.03,
        ["ClipAlphaRy"] =  -0.08,
        ["ClipRRMulti"] = 4,
        ["ClipAlphaX"] = 51,
        ["ClipAlphaY"] = 59,

        ["FlashlightAlphaRx"] = 0.03,
        ["FlashlightAlphaRy"] = -0.01,
        ["FlashRRMulti"] = 4,
        ["FlashlightAlphaX"] = 46,
        ["FlashlightAlphaY"] = 54,

        ["ScopeAlphaRx"] = 0,
        ["ScopeAlphaRy"] = 0,
        ["ScopeRRMulti"] = 0,
        ["ScopeAlphaX"] = 0,
        ["ScopeAlphaY"] = 0,

        ["GripAlphaRx"] = 0,
        ["GripAlphaRy"] = 0,
        ["GripRRMulti"] = 0,
        ["GripAlphaX"] = 0,
        ["GripAlphaY"] = 0,

        ["SkinAlphaRx"] = -0.03,
        ["SkinAlphaRy"] = 0.03,
        ["SkinRRMulti"] = 4,
        ["SkinAlphaX"] = 51,
        ["SkinAlphaY"] = 50
    },
    ------------------------------------------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------------------------------------------
    --------------------------------------------------------------------   SMGs   ------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------------------------------------------

    ['weapon_microsmg']         = { 
        ["name"] = "weapon_microsmg", 
        ["model"] = "w_sb_microsmg", 
        ["MaxRotationLeft"] = 10,
        ["MaxRotationRight"] = 120,

        ["SupressorAlphaRx"] = 0.03,
        ["SupressorAlphaRy"] = 0.07,
        ["SupressorRRMulti"] = 13, 
        ["SupressorAlphaX"] = 40,
        ["SupressorAlphaY"] = 54,  

        ["ClipAlphaRx"] = -0.01,
        ["ClipAlphaRy"] = -0.05,
        ["ClipRRMulti"] = 4,
        ["ClipAlphaX"] = 49,
        ["ClipAlphaY"] = 60,

        ["FlashlightAlphaRx"] = 0.03,
        ["FlashlightAlphaRy"] = -0.07,
        ["FlashRRMulti"] = 4,
        ["FlashlightAlphaX"] = 45,
        ["FlashlightAlphaY"] = 56,

        ["ScopeAlphaRx"] = 0.02,
        ["ScopeAlphaRy"] = 0.07,
        ["ScopeRRMulti"] = 4,
        ["ScopeAlphaX"] = 48,
        ["ScopeAlphaY"] = 50,

        ["GripAlphaRx"] = 0.02,
        ["GripAlphaRy"] = 0.07,
        ["GripRRMulti"] = 9,
        ["GripAlphaX"] = 43,
        ["GripAlphaY"] = 55,

        ["SkinAlphaRx"] = -0.03,
        ["SkinAlphaRy"] = 0.12,
        ["SkinRRMulti"] = 4,
        ["SkinAlphaX"] = 52,
        ["SkinAlphaY"] = 50
    },
    ['weapon_smg']         = { 
        ["name"] = "weapon_smg", 
        ["model"] = "w_sb_smg", 
        ["MaxRotationLeft"] = 10,
        ["MaxRotationRight"] = 120,

        ["SupressorAlphaRx"] = 0.07,
        ["SupressorAlphaRy"] = 0.07,
        ["SupressorRRMulti"] = 13, 
        ["SupressorAlphaX"] = 35,
        ["SupressorAlphaY"] = 52,  

        ["ClipAlphaRx"] = -0.01,
        ["ClipAlphaRy"] = -0.05,
        ["ClipRRMulti"] = 4,
        ["ClipAlphaX"] = 49,
        ["ClipAlphaY"] = 60,

        ["FlashlightAlphaRx"] = 0.03,
        ["FlashlightAlphaRy"] = -0.07,
        ["FlashRRMulti"] = 6,
        ["FlashlightAlphaX"] = 40,
        ["FlashlightAlphaY"] = 56,

        ["ScopeAlphaRx"] = 0.02,
        ["ScopeAlphaRy"] = 0.07,
        ["ScopeRRMulti"] = 4,
        ["ScopeAlphaX"] = 48,
        ["ScopeAlphaY"] = 50,

        ["GripAlphaRx"] = 0.02,
        ["GripAlphaRy"] = 0.07,
        ["GripRRMulti"] = 9,
        ["GripAlphaX"] = 43,
        ["GripAlphaY"] = 55,

        ["SkinAlphaRx"] = -0.03,
        ["SkinAlphaRy"] = 0.12,
        ["SkinRRMulti"] = 4,
        ["SkinAlphaX"] = 52,
        ["SkinAlphaY"] = 50
    },
    ['weapon_smg_mk2']         = { 
        ["name"] = "weapon_smg_mk2", 
        ["model"] = "w_sb_smgmk2", 
        ["MaxRotationLeft"] = 10,
        ["MaxRotationRight"] = 120,

        ["SupressorAlphaRx"] = 0.04,
        ["SupressorAlphaRy"] = 0.07,
        ["SupressorRRMulti"] = 13, 
        ["SupressorAlphaX"] = 37,
        ["SupressorAlphaY"] = 52,  

        ["ClipAlphaRx"] = -0.01,
        ["ClipAlphaRy"] = -0.05,
        ["ClipRRMulti"] = 4,
        ["ClipAlphaX"] = 49,
        ["ClipAlphaY"] = 60,

        ["FlashlightAlphaRx"] = 0.03,
        ["FlashlightAlphaRy"] = -0.07,
        ["FlashRRMulti"] = 4,
        ["FlashlightAlphaX"] = 45,
        ["FlashlightAlphaY"] = 56,

        ["ScopeAlphaRx"] = 0.02,
        ["ScopeAlphaRy"] = 0.07,
        ["ScopeRRMulti"] = 4,
        ["ScopeAlphaX"] = 48,
        ["ScopeAlphaY"] = 50,

        ["GripAlphaRx"] = 0.02,
        ["GripAlphaRy"] = 0.07,
        ["GripRRMulti"] = 9,
        ["GripAlphaX"] = 43,
        ["GripAlphaY"] = 55,

        ["SkinAlphaRx"] = -0.03,
        ["SkinAlphaRy"] = 0.12,
        ["SkinRRMulti"] = 4,
        ["SkinAlphaX"] = 52,
        ["SkinAlphaY"] = 50
    },
    ['weapon_assaultsmg']         = { 
        ["name"] = "weapon_assaultsmg", 
        ["model"] = "w_sb_assaultsmg", 
        ["MaxRotationLeft"] = 10,
        ["MaxRotationRight"] = 120,

        ["SupressorAlphaRx"] = 0.03,
        ["SupressorAlphaRy"] = 0.07,
        ["SupressorRRMulti"] = 13, 
        ["SupressorAlphaX"] = 40,
        ["SupressorAlphaY"] = 54,  

        ["ClipAlphaRx"] = -0.01,
        ["ClipAlphaRy"] = -0.05,
        ["ClipRRMulti"] = 4,
        ["ClipAlphaX"] = 49,
        ["ClipAlphaY"] = 60,

        ["FlashlightAlphaRx"] = 0.03,
        ["FlashlightAlphaRy"] = -0.07,
        ["FlashRRMulti"] = 4,
        ["FlashlightAlphaX"] = 45,
        ["FlashlightAlphaY"] = 56,

        ["ScopeAlphaRx"] = 0.02,
        ["ScopeAlphaRy"] = 0.07,
        ["ScopeRRMulti"] = 4,
        ["ScopeAlphaX"] = 48,
        ["ScopeAlphaY"] = 50,

        ["GripAlphaRx"] = 0.02,
        ["GripAlphaRy"] = 0.07,
        ["GripRRMulti"] = 9,
        ["GripAlphaX"] = 43,
        ["GripAlphaY"] = 55,

        ["SkinAlphaRx"] = -0.03,
        ["SkinAlphaRy"] = 0.12,
        ["SkinRRMulti"] = 4,
        ["SkinAlphaX"] = 52,
        ["SkinAlphaY"] = 50
    },
    ['weapon_combatpdw']= { 
        ["name"] = "weapon_combatpdw", 
        ["model"] = "w_sb_pdw", 
        ["MaxRotationLeft"] = 10,
        ["MaxRotationRight"] = 120,

        ["SupressorAlphaRx"] = 0.03,
        ["SupressorAlphaRy"] = 0.07,
        ["SupressorRRMulti"] = 13, 
        ["SupressorAlphaX"] = 40,
        ["SupressorAlphaY"] = 55,  

        ["ClipAlphaRx"] = -0.01,
        ["ClipAlphaRy"] = -0.05,
        ["ClipRRMulti"] = 4,
        ["ClipAlphaX"] = 49,
        ["ClipAlphaY"] = 60,

        ["FlashlightAlphaRx"] = 0.03,
        ["FlashlightAlphaRy"] = -0.07,
        ["FlashRRMulti"] = 4,
        ["FlashlightAlphaX"] = 45,
        ["FlashlightAlphaY"] = 57,

        ["ScopeAlphaRx"] = 0.02,
        ["ScopeAlphaRy"] = 0.07,
        ["ScopeRRMulti"] = 4,
        ["ScopeAlphaX"] = 48,
        ["ScopeAlphaY"] = 50,

        ["GripAlphaRx"] = 0.07,
        ["GripAlphaRy"] = 0.07,
        ["GripRRMulti"] = 10,
        ["GripAlphaX"] = 35,
        ["GripAlphaY"] = 55,


        ["SkinAlphaRx"] = -0.03,
        ["SkinAlphaRy"] = 0.12,
        ["SkinRRMulti"] = 4,
        ["SkinAlphaX"] = 53,
        ["SkinAlphaY"] = 55
    },
    ['weapon_minismg']         = { 
        ["name"] = "weapon_minismg", 
        ["model"] = "w_sb_minismg", 
        ["MaxRotationLeft"] = 10,
        ["MaxRotationRight"] = 120,

        ["SupressorAlphaRx"] = 0.03,
        ["SupressorAlphaRy"] = 0.07,
        ["SupressorRRMulti"] = 13, 
        ["SupressorAlphaX"] = 40,
        ["SupressorAlphaY"] = 54,  

        ["ClipAlphaRx"] = -0.03,
        ["ClipAlphaRy"] = -0.05,
        ["ClipRRMulti"] = 4,
        ["ClipAlphaX"] = 51,
        ["ClipAlphaY"] = 60,

        ["FlashlightAlphaRx"] = 0.03,
        ["FlashlightAlphaRy"] = -0.07,
        ["FlashRRMulti"] = 4,
        ["FlashlightAlphaX"] = 45,
        ["FlashlightAlphaY"] = 56,

        ["ScopeAlphaRx"] = 0.02,
        ["ScopeAlphaRy"] = 0.07,
        ["ScopeRRMulti"] = 4,
        ["ScopeAlphaX"] = 48,
        ["ScopeAlphaY"] = 50,

        ["GripAlphaRx"] = 0.02,
        ["GripAlphaRy"] = 0.07,
        ["GripRRMulti"] = 9,
        ["GripAlphaX"] = 43,
        ["GripAlphaY"] = 55,

        ["SkinAlphaRx"] = -0.03,
        ["SkinAlphaRy"] = 0.12,
        ["SkinRRMulti"] = 4,
        ["SkinAlphaX"] = 51,
        ["SkinAlphaY"] = 50
    },
    ------------------------------------------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------------------------------------------
    -------------------------------------------------------------------- SHOTGUNS ------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------------------------------------------
    ['weapon_pumpshotgun']= { 
        ["name"] = "weapon_pumpshotgun", 
        ["model"] = "w_sg_pumpshotgun", 
        ["MaxRotationLeft"] = 10,
        ["MaxRotationRight"] = 120,

        ["SupressorAlphaRx"] = 0.04,
        ["SupressorAlphaRy"] = 0.07,
        ["SupressorRRMulti"] = 16, 
        ["SupressorAlphaX"] = 30,
        ["SupressorAlphaY"] = 54,  

        ["ClipAlphaRx"] = -0.01,
        ["ClipAlphaRy"] = -0.05,
        ["ClipRRMulti"] = 4,
        ["ClipAlphaX"] = 49,
        ["ClipAlphaY"] = 60,

        ["FlashlightAlphaRx"] = 0.03,
        ["FlashlightAlphaRy"] = -0.07,
        ["FlashRRMulti"] = 4,
        ["FlashlightAlphaX"] = 45,
        ["FlashlightAlphaY"] = 57,

        ["ScopeAlphaRx"] = 0.02,
        ["ScopeAlphaRy"] = 0.07,
        ["ScopeRRMulti"] = 4,
        ["ScopeAlphaX"] = 48,
        ["ScopeAlphaY"] = 50,

        ["GripAlphaRx"] = 0.07,
        ["GripAlphaRy"] = 0.07,
        ["GripRRMulti"] = 10,
        ["GripAlphaX"] = 35,
        ["GripAlphaY"] = 55,


        ["SkinAlphaRx"] = -0.03,
        ["SkinAlphaRy"] = 0.12,
        ["SkinRRMulti"] = 4,
        ["SkinAlphaX"] = 53,
        ["SkinAlphaY"] = 55
    },
    ['weapon_pumpshotgun_mk2']= { 
        ["name"] = "weapon_pumpshotgun_mk2", 
        ["model"] = "w_sg_pumpshotgunmk2", 
        ["MaxRotationLeft"] = 10,
        ["MaxRotationRight"] = 120,

        ["SupressorAlphaRx"] = 0.03,
        ["SupressorAlphaRy"] = 0.07,
        ["SupressorRRMulti"] = 16, 
        ["SupressorAlphaX"] = 30,
        ["SupressorAlphaY"] = 54,  

        ["ClipAlphaRx"] = -0.01,
        ["ClipAlphaRy"] = -0.05,
        ["ClipRRMulti"] = 4,
        ["ClipAlphaX"] = 49,
        ["ClipAlphaY"] = 60,

        ["FlashlightAlphaRx"] = 0.03,
        ["FlashlightAlphaRy"] = -0.07,
        ["FlashRRMulti"] = 4,
        ["FlashlightAlphaX"] = 44,
        ["FlashlightAlphaY"] = 57,

        ["ScopeAlphaRx"] = 0.02,
        ["ScopeAlphaRy"] = 0.07,
        ["ScopeRRMulti"] = 4,
        ["ScopeAlphaX"] = 47,
        ["ScopeAlphaY"] = 50,

        ["GripAlphaRx"] = 0.07,
        ["GripAlphaRy"] = 0.07,
        ["GripRRMulti"] = 10,
        ["GripAlphaX"] = 35,
        ["GripAlphaY"] = 55,


        ["SkinAlphaRx"] = -0.03,
        ["SkinAlphaRy"] = 0.12,
        ["SkinRRMulti"] = 4,
        ["SkinAlphaX"] = 53,
        ["SkinAlphaY"] = 54
    },
    ['weapon_sawnoffshotgun']= { 
        ["name"] = "weapon_sawnoffshotgun", 
        ["model"] = "w_sg_sawnoff", 
        ["MaxRotationLeft"] = 10,
        ["MaxRotationRight"] = 120,

        ["SupressorAlphaRx"] = 0.03,
        ["SupressorAlphaRy"] = 0.07,
        ["SupressorRRMulti"] = 13, 
        ["SupressorAlphaX"] = 40,
        ["SupressorAlphaY"] = 55,  

        ["ClipAlphaRx"] = -0.01,
        ["ClipAlphaRy"] = -0.05,
        ["ClipRRMulti"] = 4,
        ["ClipAlphaX"] = 49,
        ["ClipAlphaY"] = 60,

        ["FlashlightAlphaRx"] = 0.03,
        ["FlashlightAlphaRy"] = -0.07,
        ["FlashRRMulti"] = 4,
        ["FlashlightAlphaX"] = 45,
        ["FlashlightAlphaY"] = 57,

        ["ScopeAlphaRx"] = 0.02,
        ["ScopeAlphaRy"] = 0.07,
        ["ScopeRRMulti"] = 4,
        ["ScopeAlphaX"] = 48,
        ["ScopeAlphaY"] = 50,

        ["GripAlphaRx"] = 0.07,
        ["GripAlphaRy"] = 0.07,
        ["GripRRMulti"] = 10,
        ["GripAlphaX"] = 35,
        ["GripAlphaY"] = 55,


        ["SkinAlphaRx"] = -0.03,
        ["SkinAlphaRy"] = 0.12,
        ["SkinRRMulti"] = 4,
        ["SkinAlphaX"] = 49,
        ["SkinAlphaY"] = 55
    },
    ['weapon_assaultshotgun']= { 
        ["name"] = "weapon_assaultshotgun", 
        ["model"] = "w_sg_assaultshotgun", 
        ["MaxRotationLeft"] = 10,
        ["MaxRotationRight"] = 120,

        ["SupressorAlphaRx"] = 0.04,
        ["SupressorAlphaRy"] = 0.07,
        ["SupressorRRMulti"] = 18, 
        ["SupressorAlphaX"] = 30,
        ["SupressorAlphaY"] = 54,  

        ["ClipAlphaRx"] = -0.01,
        ["ClipAlphaRy"] = -0.05,
        ["ClipRRMulti"] = 4,
        ["ClipAlphaX"] = 49,
        ["ClipAlphaY"] = 60,

        ["FlashlightAlphaRx"] = 0.03,
        ["FlashlightAlphaRy"] = -0.07,
        ["FlashRRMulti"] = 6,
        ["FlashlightAlphaX"] = 43,
        ["FlashlightAlphaY"] = 57,

        ["ScopeAlphaRx"] = 0.02,
        ["ScopeAlphaRy"] = 0.07,
        ["ScopeRRMulti"] = 4,
        ["ScopeAlphaX"] = 48,
        ["ScopeAlphaY"] = 50,

        ["GripAlphaRx"] = 0.07,
        ["GripAlphaRy"] = 0.07,
        ["GripRRMulti"] = 10,
        ["GripAlphaX"] = 35,
        ["GripAlphaY"] = 55,


        ["SkinAlphaRx"] = -0.03,
        ["SkinAlphaRy"] = 0.12,
        ["SkinRRMulti"] = 4,
        ["SkinAlphaX"] = 53,
        ["SkinAlphaY"] = 55
    },
    ['weapon_bullpupshotgun']= { 
        ["name"] = "weapon_bullpupshotgun", 
        ["model"] = "w_sg_bullpupshotgun", 
        ["MaxRotationLeft"] = 10,
        ["MaxRotationRight"] = 120,

        ["SupressorAlphaRx"] = 0.03,
        ["SupressorAlphaRy"] = 0.07,
        ["SupressorRRMulti"] = 16, 
        ["SupressorAlphaX"] = 30,
        ["SupressorAlphaY"] = 54,  

        ["ClipAlphaRx"] = -0.01,
        ["ClipAlphaRy"] = -0.05,
        ["ClipRRMulti"] = 4,
        ["ClipAlphaX"] = 49,
        ["ClipAlphaY"] = 60,

        ["FlashlightAlphaRx"] = 0.03,
        ["FlashlightAlphaRy"] = -0.07,
        ["FlashRRMulti"] = 6,
        ["FlashlightAlphaX"] = 43,
        ["FlashlightAlphaY"] = 57,

        ["ScopeAlphaRx"] = 0.02,
        ["ScopeAlphaRy"] = 0.07,
        ["ScopeRRMulti"] = 4,
        ["ScopeAlphaX"] = 48,
        ["ScopeAlphaY"] = 50,

        ["GripAlphaRx"] = 0.07,
        ["GripAlphaRy"] = 0.07,
        ["GripRRMulti"] = 10,
        ["GripAlphaX"] = 35,
        ["GripAlphaY"] = 55,


        ["SkinAlphaRx"] = -0.03,
        ["SkinAlphaRy"] = 0.12,
        ["SkinRRMulti"] = 4,
        ["SkinAlphaX"] = 53,
        ["SkinAlphaY"] = 55
    },
    ['weapon_musket']= { 
        ["name"] = "weapon_musket", 
        ["model"] = "w_ar_musket", 
        ["MaxRotationLeft"] = 10,
        ["MaxRotationRight"] = 120,

        ["SupressorAlphaRx"] = 0.03,
        ["SupressorAlphaRy"] = 0.07,
        ["SupressorRRMulti"] = 13, 
        ["SupressorAlphaX"] = 40,
        ["SupressorAlphaY"] = 55,  

        ["ClipAlphaRx"] = -0.01,
        ["ClipAlphaRy"] = -0.05,
        ["ClipRRMulti"] = 4,
        ["ClipAlphaX"] = 49,
        ["ClipAlphaY"] = 60,

        ["FlashlightAlphaRx"] = 0.03,
        ["FlashlightAlphaRy"] = -0.07,
        ["FlashRRMulti"] = 4,
        ["FlashlightAlphaX"] = 45,
        ["FlashlightAlphaY"] = 57,

        ["ScopeAlphaRx"] = 0.02,
        ["ScopeAlphaRy"] = 0.07,
        ["ScopeRRMulti"] = 4,
        ["ScopeAlphaX"] = 48,
        ["ScopeAlphaY"] = 50,

        ["GripAlphaRx"] = 0.07,
        ["GripAlphaRy"] = 0.07,
        ["GripRRMulti"] = 10,
        ["GripAlphaX"] = 35,
        ["GripAlphaY"] = 55,


        ["SkinAlphaRx"] = -0.03,
        ["SkinAlphaRy"] = 0.12,
        ["SkinRRMulti"] = 8,
        ["SkinAlphaX"] = 53,
        ["SkinAlphaY"] = 55
    },
    ['weapon_heavyshotgun']= { 
        ["name"] = "weapon_heavyshotgun", 
        ["model"] = "w_sg_heavyshotgun", 
        ["MaxRotationLeft"] = 10,
        ["MaxRotationRight"] = 120,

        ["SupressorAlphaRx"] = 0.04,
        ["SupressorAlphaRy"] = 0.07,
        ["SupressorRRMulti"] = 16, 
        ["SupressorAlphaX"] = 25,
        ["SupressorAlphaY"] = 52,  

        ["ClipAlphaRx"] = -0.01,
        ["ClipAlphaRy"] = -0.05,
        ["ClipRRMulti"] = 4,
        ["ClipAlphaX"] = 51,
        ["ClipAlphaY"] = 60,

        ["FlashlightAlphaRx"] = 0.03,
        ["FlashlightAlphaRy"] = -0.07,
        ["FlashRRMulti"] = 4,
        ["FlashlightAlphaX"] = 45,
        ["FlashlightAlphaY"] = 55,

        ["ScopeAlphaRx"] = 0.02,
        ["ScopeAlphaRy"] = 0.07,
        ["ScopeRRMulti"] = 4,
        ["ScopeAlphaX"] = 48,
        ["ScopeAlphaY"] = 50,

        ["GripAlphaRx"] = 0.07,
        ["GripAlphaRy"] = 0.07,
        ["GripRRMulti"] = 10,
        ["GripAlphaX"] = 35,
        ["GripAlphaY"] = 55,


        ["SkinAlphaRx"] = -0.03,
        ["SkinAlphaRy"] = 0.12,
        ["SkinRRMulti"] = 4,
        ["SkinAlphaX"] = 50,
        ["SkinAlphaY"] = 51
    },
    ['weapon_dbshotgun']= { 
        ["name"] = "weapon_dbshotgun", 
        ["model"] = "w_sg_doublebarrel", 
        ["MaxRotationLeft"] = 10,
        ["MaxRotationRight"] = 120,

        ["SupressorAlphaRx"] = 0.03,
        ["SupressorAlphaRy"] = 0.07,
        ["SupressorRRMulti"] = 13, 
        ["SupressorAlphaX"] = 40,
        ["SupressorAlphaY"] = 55,  

        ["ClipAlphaRx"] = -0.01,
        ["ClipAlphaRy"] = -0.05,
        ["ClipRRMulti"] = 4,
        ["ClipAlphaX"] = 49,
        ["ClipAlphaY"] = 60,

        ["FlashlightAlphaRx"] = 0.03,
        ["FlashlightAlphaRy"] = -0.07,
        ["FlashRRMulti"] = 4,
        ["FlashlightAlphaX"] = 45,
        ["FlashlightAlphaY"] = 57,

        ["ScopeAlphaRx"] = 0.02,
        ["ScopeAlphaRy"] = 0.07,
        ["ScopeRRMulti"] = 4,
        ["ScopeAlphaX"] = 48,
        ["ScopeAlphaY"] = 50,

        ["GripAlphaRx"] = 0.07,
        ["GripAlphaRy"] = 0.07,
        ["GripRRMulti"] = 10,
        ["GripAlphaX"] = 35,
        ["GripAlphaY"] = 55,


        ["SkinAlphaRx"] = -0.01,
        ["SkinAlphaRy"] = 0.01,
        ["SkinRRMulti"] = 4,
        ["SkinAlphaX"] = 49,
        ["SkinAlphaY"] = 55
    },

    ------------------------------------------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------------------------------------------
    --------------------------------------------------------------------   ARs   ------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------------------------------------------
    
    ['weapon_assaultrifle']     = { 
        ["name"] = "weapon_assaultrifle", 
        ["model"] = "w_ar_assaultrifle", 

        ["MaxRotationLeft"] = 10,
        ["MaxRotationRight"] = 100,
        
        ["SupressorAlphaRx"] = 0.05,
        ["SupressorAlphaRy"] = 0.07,
        ["SupressorRRMulti"] = 20,
        ["SupressorAlphaX"] = 18,
        ["SupressorAlphaY"] = 53,
 
        
        ["ClipAlphaRx"] = -0.02,
        ["ClipAlphaRy"] = -0.12,
        ["ClipRRMulti"] = 4,
        ["ClipAlphaX"] = 51,
        ["ClipAlphaY"] = 58,

        ["FlashlightAlphaRx"] = 0.02,
        ["FlashlightAlphaRy"] = -0.07,
        ["FlashRRMulti"] = 16,
        ["FlashlightAlphaX"] = 38,
        ["FlashlightAlphaY"] = 57,

        ["ScopeAlphaRx"] = 0.02,
        ["ScopeAlphaRy"] = 0.07,
        ["ScopeRRMulti"] = 16,
        ["ScopeAlphaX"] = 45,
        ["ScopeAlphaY"] = 48,

        ["GripAlphaRx"] = 0.07,
        ["GripAlphaRy"] = 0.07,
        ["GripRRMulti"] = 10,
        ["GripAlphaX"] = 35,
        ["GripAlphaY"] = 55,

        ["SkinAlphaRx"] = -0.02,
        ["SkinAlphaRy"] = 0.12,
        ["SkinRRMulti"] = 8,
        ["SkinAlphaX"] = 53,
        ["SkinAlphaY"] = 53
    },
    ['weapon_assaultrifle_mk2']     = { 
        ["name"] = "weapon_assaultrifle_mk2", 
        ["model"] = "w_ar_assaultriflemk2", 

        ["MaxRotationLeft"] = 10,
        ["MaxRotationRight"] = 100,
        
        ["SupressorAlphaRx"] = 0.05,
        ["SupressorAlphaRy"] = 0.07,
        ["SupressorRRMulti"] = 20,
        ["SupressorAlphaX"] = 18,
        ["SupressorAlphaY"] = 53,
 
        
        ["ClipAlphaRx"] = -0.02,
        ["ClipAlphaRy"] = -0.12,
        ["ClipRRMulti"] = 4,
        ["ClipAlphaX"] = 51,
        ["ClipAlphaY"] = 58,

        ["FlashlightAlphaRx"] = 0.02,
        ["FlashlightAlphaRy"] = -0.07,
        ["FlashRRMulti"] = 16,
        ["FlashlightAlphaX"] = 38,
        ["FlashlightAlphaY"] = 57,

        ["ScopeAlphaRx"] = 0.02,
        ["ScopeAlphaRy"] = 0.07,
        ["ScopeRRMulti"] = 16,
        ["ScopeAlphaX"] = 45,
        ["ScopeAlphaY"] = 48,

        ["GripAlphaRx"] = 0.07,
        ["GripAlphaRy"] = 0.07,
        ["GripRRMulti"] = 10,
        ["GripAlphaX"] = 35,
        ["GripAlphaY"] = 55,
        

        ["SkinAlphaRx"] = -0.02,
        ["SkinAlphaRy"] = 0.12,
        ["SkinRRMulti"] = 8,
        ["SkinAlphaX"] = 53,
        ["SkinAlphaY"] = 53
    },
    ['weapon_carbinerifle']     = { 
        ["name"] = "weapon_carbinerifle", 
        ["model"] = "w_ar_carbinerifle", 

        ["MaxRotationLeft"] = 10,
        ["MaxRotationRight"] = 100,
        
        ["SupressorAlphaRx"] = 0.04,
        ["SupressorAlphaRy"] = 0.07,
        ["SupressorRRMulti"] = 20,
        ["SupressorAlphaX"] = 26,
        ["SupressorAlphaY"] = 54,
 
        
        ["ClipAlphaRx"] = -0.02,
        ["ClipAlphaRy"] = -0.12,
        ["ClipRRMulti"] = 4,
        ["ClipAlphaX"] = 51,
        ["ClipAlphaY"] = 58,

        ["FlashlightAlphaRx"] = 0.02,
        ["FlashlightAlphaRy"] = -0.07,
        ["FlashRRMulti"] = 14,
        ["FlashlightAlphaX"] = 41,
        ["FlashlightAlphaY"] = 56,

        ["ScopeAlphaRx"] = 0.02,
        ["ScopeAlphaRy"] = 0.07,
        ["ScopeRRMulti"] = 16,
        ["ScopeAlphaX"] = 45,
        ["ScopeAlphaY"] = 48,

        ["GripAlphaRx"] = 0.07,
        ["GripAlphaRy"] = 0.07,
        ["GripRRMulti"] = 8,
        ["GripAlphaX"] = 38,
        ["GripAlphaY"] = 55,

        ["SkinAlphaRx"] = -0.02,
        ["SkinAlphaRy"] = 0.12,
        ["SkinRRMulti"] = 8,
        ["SkinAlphaX"] = 53,
        ["SkinAlphaY"] = 53
    },
    ['weapon_carbinerifle_mk2']     = { 
        ["name"] = "weapon_carbinerifle_mk2", 
        ["model"] = "w_ar_carbineriflemk2", 

        ["MaxRotationLeft"] = 10,
        ["MaxRotationRight"] = 100,
        
        ["SupressorAlphaRx"] = 0.04,
        ["SupressorAlphaRy"] = 0.07,
        ["SupressorRRMulti"] = 18,
        ["SupressorAlphaX"] = 30,
        ["SupressorAlphaY"] = 54,
 
        
        ["ClipAlphaRx"] = -0.02,
        ["ClipAlphaRy"] = -0.12,
        ["ClipRRMulti"] = 4,
        ["ClipAlphaX"] = 51,
        ["ClipAlphaY"] = 58,

        ["FlashlightAlphaRx"] = 0.02,
        ["FlashlightAlphaRy"] = -0.07,
        ["FlashRRMulti"] = 14,
        ["FlashlightAlphaX"] = 41,
        ["FlashlightAlphaY"] = 57,

        ["ScopeAlphaRx"] = 0.02,
        ["ScopeAlphaRy"] = 0.07,
        ["ScopeRRMulti"] = 16,
        ["ScopeAlphaX"] = 45,
        ["ScopeAlphaY"] = 48,

        ["GripAlphaRx"] = 0.07,
        ["GripAlphaRy"] = 0.07,
        ["GripRRMulti"] = 8,
        ["GripAlphaX"] = 38,
        ["GripAlphaY"] = 55,

        ["SkinAlphaRx"] = -0.02,
        ["SkinAlphaRy"] = 0.12,
        ["SkinRRMulti"] = 8,
        ["SkinAlphaX"] = 53,
        ["SkinAlphaY"] = 53
    },
    ['weapon_advancedrifle']     = { 
        ["name"] = "weapon_advancedrifle", 
        ["model"] = "w_ar_advancedrifle", 

        ["MaxRotationLeft"] = 10,
        ["MaxRotationRight"] = 100,
        
        ["SupressorAlphaRx"] = 0.03,
        ["SupressorAlphaRy"] = 0.07,
        ["SupressorRRMulti"] = 16,
        ["SupressorAlphaX"] = 35,
        ["SupressorAlphaY"] = 54,
 
        
        ["ClipAlphaRx"] = -0.02,
        ["ClipAlphaRy"] = -0.12,
        ["ClipRRMulti"] = 4,
        ["ClipAlphaX"] = 51,
        ["ClipAlphaY"] = 58,

        ["FlashlightAlphaRx"] = 0.02,
        ["FlashlightAlphaRy"] = -0.07,
        ["FlashRRMulti"] = 12,
        ["FlashlightAlphaX"] = 42,
        ["FlashlightAlphaY"] = 57,

        ["ScopeAlphaRx"] = 0.02,
        ["ScopeAlphaRy"] = 0.07,
        ["ScopeRRMulti"] = 16,
        ["ScopeAlphaX"] = 45,
        ["ScopeAlphaY"] = 48,

        ["GripAlphaRx"] = 0.07,
        ["GripAlphaRy"] = 0.07,
        ["GripRRMulti"] = 8,
        ["GripAlphaX"] = 40,
        ["GripAlphaY"] = 55,

        ["SkinAlphaRx"] = -0.02,
        ["SkinAlphaRy"] = 0.12,
        ["SkinRRMulti"] = 8,
        ["SkinAlphaX"] = 53,
        ["SkinAlphaY"] = 53
    },
    ['weapon_specialcarbine']     = { 
        ["name"] = "weapon_specialcarbine", 
        ["model"] = "w_ar_specialcarbine", 

        ["MaxRotationLeft"] = 10,
        ["MaxRotationRight"] = 100,
        
        ["SupressorAlphaRx"] = 0.04,
        ["SupressorAlphaRy"] = 0.07,
        ["SupressorRRMulti"] = 20,
        ["SupressorAlphaX"] = 26,
        ["SupressorAlphaY"] = 54,
 
        
        ["ClipAlphaRx"] = -0.02,
        ["ClipAlphaRy"] = -0.12,
        ["ClipRRMulti"] = 4,
        ["ClipAlphaX"] = 51,
        ["ClipAlphaY"] = 58,

        ["FlashlightAlphaRx"] = 0.02,
        ["FlashlightAlphaRy"] = -0.07,
        ["FlashRRMulti"] = 16,
        ["FlashlightAlphaX"] = 38,
        ["FlashlightAlphaY"] = 57,

        ["ScopeAlphaRx"] = 0.02,
        ["ScopeAlphaRy"] = 0.07,
        ["ScopeRRMulti"] = 16,
        ["ScopeAlphaX"] = 45,
        ["ScopeAlphaY"] = 48,

        ["GripAlphaRx"] = 0.07,
        ["GripAlphaRy"] = 0.07,
        ["GripRRMulti"] = 10,
        ["GripAlphaX"] = 35,
        ["GripAlphaY"] = 55,

        ["SkinAlphaRx"] = -0.02,
        ["SkinAlphaRy"] = 0.12,
        ["SkinRRMulti"] = 8,
        ["SkinAlphaX"] = 53,
        ["SkinAlphaY"] = 53
    },
    ['weapon_specialcarbine_mk2']     = { 
        ["name"] = "weapon_specialcarbine_mk2", 
        ["model"] = "w_ar_specialcarbinemk2", 

        ["MaxRotationLeft"] = 10,
        ["MaxRotationRight"] = 100,
        
        ["SupressorAlphaRx"] = 0.04,
        ["SupressorAlphaRy"] = 0.07,
        ["SupressorRRMulti"] = 20,
        ["SupressorAlphaX"] = 26,
        ["SupressorAlphaY"] = 54,
 
        
        ["ClipAlphaRx"] = -0.02,
        ["ClipAlphaRy"] = -0.12,
        ["ClipRRMulti"] = 4,
        ["ClipAlphaX"] = 51,
        ["ClipAlphaY"] = 58,

        ["FlashlightAlphaRx"] = 0.02,
        ["FlashlightAlphaRy"] = -0.07,
        ["FlashRRMulti"] = 16,
        ["FlashlightAlphaX"] = 38,
        ["FlashlightAlphaY"] = 57,

        ["ScopeAlphaRx"] = 0.02,
        ["ScopeAlphaRy"] = 0.07,
        ["ScopeRRMulti"] = 16,
        ["ScopeAlphaX"] = 45,
        ["ScopeAlphaY"] = 48,

        ["GripAlphaRx"] = 0.07,
        ["GripAlphaRy"] = 0.07,
        ["GripRRMulti"] = 10,
        ["GripAlphaX"] = 35,
        ["GripAlphaY"] = 55,

        ["SkinAlphaRx"] = -0.02,
        ["SkinAlphaRy"] = 0.12,
        ["SkinRRMulti"] = 8,
        ["SkinAlphaX"] = 53,
        ["SkinAlphaY"] = 53
    },
    ['weapon_bullpuprifle']     = { 
        ["name"] = "weapon_bullpuprifle", 
        ["model"] = "w_ar_bullpuprifle", 

        ["MaxRotationLeft"] = 10,
        ["MaxRotationRight"] = 100,
        
        ["SupressorAlphaRx"] = 0.04,
        ["SupressorAlphaRy"] = 0.07,
        ["SupressorRRMulti"] = 20,
        ["SupressorAlphaX"] = 26,
        ["SupressorAlphaY"] = 54,
 
        
        ["ClipAlphaRx"] = -0.02,
        ["ClipAlphaRy"] = -0.12,
        ["ClipRRMulti"] = 4,
        ["ClipAlphaX"] = 51,
        ["ClipAlphaY"] = 58,

        ["FlashlightAlphaRx"] = 0.02,
        ["FlashlightAlphaRy"] = -0.07,
        ["FlashRRMulti"] = 16,
        ["FlashlightAlphaX"] = 38,
        ["FlashlightAlphaY"] = 57,

        ["ScopeAlphaRx"] = 0.02,
        ["ScopeAlphaRy"] = 0.07,
        ["ScopeRRMulti"] = 16,
        ["ScopeAlphaX"] = 45,
        ["ScopeAlphaY"] = 48,

        ["GripAlphaRx"] = 0.07,
        ["GripAlphaRy"] = 0.07,
        ["GripRRMulti"] = 10,
        ["GripAlphaX"] = 35,
        ["GripAlphaY"] = 55,

        ["SkinAlphaRx"] = -0.02,
        ["SkinAlphaRy"] = 0.12,
        ["SkinRRMulti"] = 8,
        ["SkinAlphaX"] = 53,
        ["SkinAlphaY"] = 53
    },
    ['weapon_bullpuprifle_mk2']     = { 
        ["name"] = "weapon_bullpuprifle_mk2", 
        ["model"] = "w_ar_bullpupriflemk2", 

        ["MaxRotationLeft"] = 10,
        ["MaxRotationRight"] = 100,
        
        ["SupressorAlphaRx"] = 0.03,
        ["SupressorAlphaRy"] = 0.07,
        ["SupressorRRMulti"] = 16,
        ["SupressorAlphaX"] = 35,
        ["SupressorAlphaY"] = 54,
 
        
        ["ClipAlphaRx"] = -0.02,
        ["ClipAlphaRy"] = -0.12,
        ["ClipRRMulti"] = 4,
        ["ClipAlphaX"] = 51,
        ["ClipAlphaY"] = 58,

        ["FlashlightAlphaRx"] = 0.02,
        ["FlashlightAlphaRy"] = -0.07,
        ["FlashRRMulti"] = 16,
        ["FlashlightAlphaX"] = 41,
        ["FlashlightAlphaY"] = 57,

        ["ScopeAlphaRx"] = 0.02,
        ["ScopeAlphaRy"] = 0.07,
        ["ScopeRRMulti"] = 16,
        ["ScopeAlphaX"] = 45,
        ["ScopeAlphaY"] = 48,

        ["GripAlphaRx"] = 0.03,
        ["GripAlphaRy"] = 0.07,
        ["GripRRMulti"] = 4,
        ["GripAlphaX"] = 38,
        ["GripAlphaY"] = 55,

        ["SkinAlphaRx"] = -0.02,
        ["SkinAlphaRy"] = 0.12,
        ["SkinRRMulti"] = 8,
        ["SkinAlphaX"] = 53,
        ["SkinAlphaY"] = 53
    },

    ------------------------------------------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------------------------------------------
    --------------------------------------------------------------------   LMG   ------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------------------------------------------
    ['weapon_mg']     = { 
        ["name"] = "weapon_mg", 
        ["model"] = "w_mg_mg", 

        ["MaxRotationLeft"] = 10,
        ["MaxRotationRight"] = 100,
        
        ["SupressorAlphaRx"] = 0.05,
        ["SupressorAlphaRy"] = 0.07,
        ["SupressorRRMulti"] = 20,
        ["SupressorAlphaX"] = 18,
        ["SupressorAlphaY"] = 53,
 
        
        ["ClipAlphaRx"] = -0.02,
        ["ClipAlphaRy"] = -0.12,
        ["ClipRRMulti"] = 4,
        ["ClipAlphaX"] = 49,
        ["ClipAlphaY"] = 58,

        ["FlashlightAlphaRx"] = 0.02,
        ["FlashlightAlphaRy"] = -0.07,
        ["FlashRRMulti"] = 14,
        ["FlashlightAlphaX"] = 41,
        ["FlashlightAlphaY"] = 57,

        ["ScopeAlphaRx"] = 0.02,
        ["ScopeAlphaRy"] = 0.07,
        ["ScopeRRMulti"] = 16,
        ["ScopeAlphaX"] = 38,
        ["ScopeAlphaY"] = 48,

        ["GripAlphaRx"] = 0.07,
        ["GripAlphaRy"] = 0.07,
        ["GripRRMulti"] = 8,
        ["GripAlphaX"] = 38,
        ["GripAlphaY"] = 55,

        ["SkinAlphaRx"] = -0.02,
        ["SkinAlphaRy"] = 0.12,
        ["SkinRRMulti"] = 8,
        ["SkinAlphaX"] = 53,
        ["SkinAlphaY"] = 53
    },
    ['weapon_combatmg']     = { 
        ["name"] = "weapon_combatmg", 
        ["model"] = "w_mg_combatmg", 

        ["MaxRotationLeft"] = 10,
        ["MaxRotationRight"] = 100,
        
        ["SupressorAlphaRx"] = 0.05,
        ["SupressorAlphaRy"] = 0.07,
        ["SupressorRRMulti"] = 20,
        ["SupressorAlphaX"] = 18,
        ["SupressorAlphaY"] = 53,
 
        
        ["ClipAlphaRx"] = -0.02,
        ["ClipAlphaRy"] = -0.12,
        ["ClipRRMulti"] = 4,
        ["ClipAlphaX"] = 49,
        ["ClipAlphaY"] = 58,

        ["FlashlightAlphaRx"] = 0.02,
        ["FlashlightAlphaRy"] = -0.07,
        ["FlashRRMulti"] = 16,
        ["FlashlightAlphaX"] = 38,
        ["FlashlightAlphaY"] = 57,

        ["ScopeAlphaRx"] = 0.02,
        ["ScopeAlphaRy"] = 0.07,
        ["ScopeRRMulti"] = 16,
        ["ScopeAlphaX"] = 38,
        ["ScopeAlphaY"] = 48,

        ["GripAlphaRx"] = 0.07,
        ["GripAlphaRy"] = 0.07,
        ["GripRRMulti"] = 10,
        ["GripAlphaX"] = 35,
        ["GripAlphaY"] = 55,

        ["SkinAlphaRx"] = -0.02,
        ["SkinAlphaRy"] = 0.12,
        ["SkinRRMulti"] = 8,
        ["SkinAlphaX"] = 53,
        ["SkinAlphaY"] = 53
    },
    ['weapon_combatmg_mk2']     = { 
        ["name"] = "weapon_combatmg_mk2", 
        ["model"] = "w_mg_combatmgmk2", 

        ["MaxRotationLeft"] = 10,
        ["MaxRotationRight"] = 100,
        
        ["SupressorAlphaRx"] = 0.05,
        ["SupressorAlphaRy"] = 0.07,
        ["SupressorRRMulti"] = 20,
        ["SupressorAlphaX"] = 18,
        ["SupressorAlphaY"] = 53,
 
        
        ["ClipAlphaRx"] = -0.02,
        ["ClipAlphaRy"] = -0.12,
        ["ClipRRMulti"] = 4,
        ["ClipAlphaX"] = 49,
        ["ClipAlphaY"] = 58,

        ["FlashlightAlphaRx"] = 0.02,
        ["FlashlightAlphaRy"] = -0.07,
        ["FlashRRMulti"] = 16,
        ["FlashlightAlphaX"] = 38,
        ["FlashlightAlphaY"] = 57,

        ["ScopeAlphaRx"] = 0.02,
        ["ScopeAlphaRy"] = 0.07,
        ["ScopeRRMulti"] = 16,
        ["ScopeAlphaX"] = 38,
        ["ScopeAlphaY"] = 48,

        ["GripAlphaRx"] = 0.07,
        ["GripAlphaRy"] = 0.07,
        ["GripRRMulti"] = 10,
        ["GripAlphaX"] = 35,
        ["GripAlphaY"] = 55,

        ["SkinAlphaRx"] = -0.02,
        ["SkinAlphaRy"] = 0.12,
        ["SkinRRMulti"] = 8,
        ["SkinAlphaX"] = 53,
        ["SkinAlphaY"] = 53
    },
    ['weapon_gusenberg']     = { 
        ["name"] = "weapon_gusenberg", 
        ["model"] = "w_sb_gusenberg", 

        ["MaxRotationLeft"] = 10,
        ["MaxRotationRight"] = 100,
        
        ["SupressorAlphaRx"] = 0.05,
        ["SupressorAlphaRy"] = 0.07,
        ["SupressorRRMulti"] = 20,
        ["SupressorAlphaX"] = 18,
        ["SupressorAlphaY"] = 53,
 
        
        ["ClipAlphaRx"] = -0.02,
        ["ClipAlphaRy"] = -0.12,
        ["ClipRRMulti"] = 4,
        ["ClipAlphaX"] = 49,
        ["ClipAlphaY"] = 58,

        ["FlashlightAlphaRx"] = 0.02,
        ["FlashlightAlphaRy"] = -0.07,
        ["FlashRRMulti"] = 16,
        ["FlashlightAlphaX"] = 38,
        ["FlashlightAlphaY"] = 57,

        ["ScopeAlphaRx"] = 0.02,
        ["ScopeAlphaRy"] = 0.07,
        ["ScopeRRMulti"] = 16,
        ["ScopeAlphaX"] = 38,
        ["ScopeAlphaY"] = 48,

        ["GripAlphaRx"] = 0.07,
        ["GripAlphaRy"] = 0.07,
        ["GripRRMulti"] = 10,
        ["GripAlphaX"] = 35,
        ["GripAlphaY"] = 55,

        ["SkinAlphaRx"] = -0.02,
        ["SkinAlphaRy"] = 0.12,
        ["SkinRRMulti"] = 8,
        ["SkinAlphaX"] = 53,
        ["SkinAlphaY"] = 53
    },



    ------------------------------------------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------------------------------------------
    --------------------------------------------------------------------   SNIPERS   ---------------------------------------------------------
    ------------------------------------------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------------------------------------------
    ------------------------------------------------------------------------------------------------------------------------------------------
    ['weapon_sniperrifle']     = { 
        ["name"] = "weapon_sniperrifle", 
        ["model"] = "w_sr_sniperrifle", 

        ["MaxRotationLeft"] = 10,
        ["MaxRotationRight"] = 100,
        
        ["SupressorAlphaRx"] = 0.05,
        ["SupressorAlphaRy"] = 0.07,
        ["SupressorRRMulti"] = 20,
        ["SupressorAlphaX"] = 18,
        ["SupressorAlphaY"] = 53,
 
        
        ["ClipAlphaRx"] = -0.02,
        ["ClipAlphaRy"] = -0.12,
        ["ClipRRMulti"] = 4,
        ["ClipAlphaX"] = 49,
        ["ClipAlphaY"] = 58,

        ["FlashlightAlphaRx"] = 0.02,
        ["FlashlightAlphaRy"] = -0.07,
        ["FlashRRMulti"] = 14,
        ["FlashlightAlphaX"] = 41,
        ["FlashlightAlphaY"] = 57,

        ["ScopeAlphaRx"] = 0.02,
        ["ScopeAlphaRy"] = 0.07,
        ["ScopeRRMulti"] = 16,
        ["ScopeAlphaX"] = 38,
        ["ScopeAlphaY"] = 48,

        ["GripAlphaRx"] = 0.07,
        ["GripAlphaRy"] = 0.07,
        ["GripRRMulti"] = 8,
        ["GripAlphaX"] = 38,
        ["GripAlphaY"] = 55,

        ["SkinAlphaRx"] = -0.02,
        ["SkinAlphaRy"] = 0.12,
        ["SkinRRMulti"] = 8,
        ["SkinAlphaX"] = 53,
        ["SkinAlphaY"] = 53
    },
    ['weapon_heavysniper']     = { 
        ["name"] = "weapon_heavysniper", 
        ["model"] = "w_sr_heavysniper", 

        ["MaxRotationLeft"] = 10,
        ["MaxRotationRight"] = 100,
        
        ["SupressorAlphaRx"] = 0.05,
        ["SupressorAlphaRy"] = 0.07,
        ["SupressorRRMulti"] = 20,
        ["SupressorAlphaX"] = 18,
        ["SupressorAlphaY"] = 53,
 
        
        ["ClipAlphaRx"] = -0.02,
        ["ClipAlphaRy"] = -0.12,
        ["ClipRRMulti"] = 4,
        ["ClipAlphaX"] = 49,
        ["ClipAlphaY"] = 58,

        ["FlashlightAlphaRx"] = 0.02,
        ["FlashlightAlphaRy"] = -0.07,
        ["FlashRRMulti"] = 14,
        ["FlashlightAlphaX"] = 41,
        ["FlashlightAlphaY"] = 57,

        ["ScopeAlphaRx"] = 0.02,
        ["ScopeAlphaRy"] = 0.07,
        ["ScopeRRMulti"] = 16,
        ["ScopeAlphaX"] = 38,
        ["ScopeAlphaY"] = 48,

        ["GripAlphaRx"] = 0.07,
        ["GripAlphaRy"] = 0.07,
        ["GripRRMulti"] = 8,
        ["GripAlphaX"] = 38,
        ["GripAlphaY"] = 55,

        ["SkinAlphaRx"] = -0.02,
        ["SkinAlphaRy"] = 0.12,
        ["SkinRRMulti"] = 8,
        ["SkinAlphaX"] = 53,
        ["SkinAlphaY"] = 53
    },
    ['weapon_heavysniper_mk2']     = { 
        ["name"] = "weapon_heavysniper_mk2", 
        ["model"] = "w_sr_heavysnipermk2", 

        ["MaxRotationLeft"] = 10,
        ["MaxRotationRight"] = 100,
        
        ["SupressorAlphaRx"] = 0.05,
        ["SupressorAlphaRy"] = 0.07,
        ["SupressorRRMulti"] = 20,
        ["SupressorAlphaX"] = 18,
        ["SupressorAlphaY"] = 53,
 
        
        ["ClipAlphaRx"] = -0.02,
        ["ClipAlphaRy"] = -0.12,
        ["ClipRRMulti"] = 4,
        ["ClipAlphaX"] = 49,
        ["ClipAlphaY"] = 58,

        ["FlashlightAlphaRx"] = 0.02,
        ["FlashlightAlphaRy"] = -0.07,
        ["FlashRRMulti"] = 14,
        ["FlashlightAlphaX"] = 41,
        ["FlashlightAlphaY"] = 57,

        ["ScopeAlphaRx"] = 0.02,
        ["ScopeAlphaRy"] = 0.07,
        ["ScopeRRMulti"] = 16,
        ["ScopeAlphaX"] = 38,
        ["ScopeAlphaY"] = 48,

        ["GripAlphaRx"] = 0.07,
        ["GripAlphaRy"] = 0.07,
        ["GripRRMulti"] = 9,
        ["GripAlphaX"] = 36,
        ["GripAlphaY"] = 55,

        ["SkinAlphaRx"] = -0.02,
        ["SkinAlphaRy"] = 0.12,
        ["SkinRRMulti"] = 8,
        ["SkinAlphaX"] = 53,
        ["SkinAlphaY"] = 53
    },
    ['weapon_marksmanrifle']     = { 
        ["name"] = "weapon_marksmanrifle", 
        ["model"] = "w_sr_marksmanrifle", 

        ["MaxRotationLeft"] = 10,
        ["MaxRotationRight"] = 100,
        
        ["SupressorAlphaRx"] = 0.05,
        ["SupressorAlphaRy"] = 0.07,
        ["SupressorRRMulti"] = 20,
        ["SupressorAlphaX"] = 18,
        ["SupressorAlphaY"] = 51,
 
        
        ["ClipAlphaRx"] = -0.02,
        ["ClipAlphaRy"] = -0.12,
        ["ClipRRMulti"] = 4,
        ["ClipAlphaX"] = 49,
        ["ClipAlphaY"] = 58,

        ["FlashlightAlphaRx"] = 0.02,
        ["FlashlightAlphaRy"] = -0.07,
        ["FlashRRMulti"] = 14,
        ["FlashlightAlphaX"] = 41,
        ["FlashlightAlphaY"] = 57,

        ["ScopeAlphaRx"] = 0.02,
        ["ScopeAlphaRy"] = 0.07,
        ["ScopeRRMulti"] = 16,
        ["ScopeAlphaX"] = 38,
        ["ScopeAlphaY"] = 48,

        ["GripAlphaRx"] = 0.07,
        ["GripAlphaRy"] = 0.07,
        ["GripRRMulti"] = 9,
        ["GripAlphaX"] = 36,
        ["GripAlphaY"] = 55,

        ["SkinAlphaRx"] = -0.02,
        ["SkinAlphaRy"] = 0.12,
        ["SkinRRMulti"] = 8,
        ["SkinAlphaX"] = 53,
        ["SkinAlphaY"] = 53
    },
    ['weapon_marksmanrifle_mk2']     = { 
        ["name"] = "weapon_marksmanrifle_mk2", 
        ["model"] = "w_sr_marksmanriflemk2", 

        ["MaxRotationLeft"] = 10,
        ["MaxRotationRight"] = 100,
        
        ["SupressorAlphaRx"] = 0.05,
        ["SupressorAlphaRy"] = 0.07,
        ["SupressorRRMulti"] = 16,
        ["SupressorAlphaX"] = 24,
        ["SupressorAlphaY"] = 53,
 
        
        ["ClipAlphaRx"] = -0.02,
        ["ClipAlphaRy"] = -0.12,
        ["ClipRRMulti"] = 4,
        ["ClipAlphaX"] = 49,
        ["ClipAlphaY"] = 58,

        ["FlashlightAlphaRx"] = 0.02,
        ["FlashlightAlphaRy"] = -0.07,
        ["FlashRRMulti"] = 14,
        ["FlashlightAlphaX"] = 41,
        ["FlashlightAlphaY"] = 57,

        ["ScopeAlphaRx"] = 0.02,
        ["ScopeAlphaRy"] = 0.07,
        ["ScopeRRMulti"] = 16,
        ["ScopeAlphaX"] = 38,
        ["ScopeAlphaY"] = 48,

        ["GripAlphaRx"] = 0.07,
        ["GripAlphaRy"] = 0.07,
        ["GripRRMulti"] = 9,
        ["GripAlphaX"] = 36,
        ["GripAlphaY"] = 55,

        ["SkinAlphaRx"] = -0.02,
        ["SkinAlphaRy"] = 0.12,
        ["SkinRRMulti"] = 8,
        ["SkinAlphaX"] = 53,
        ["SkinAlphaY"] = 53
    },
}
-- Attachments List related to the old qb-core and qb-weapons version
Config.Attachments = {
    ['WEAPON_PISTOL'] = {
        ['defaultclip'] = {
            component = 'COMPONENT_PISTOL_CLIP_01',
            item = 'pistol_defaultclip',
            type = 'clip',
        },
        ['extendedclip'] = {
            component = 'COMPONENT_PISTOL_CLIP_02',
            item = 'pistol_extendedclip',
            type = 'clip',
        },
        ['flashlight'] = {
            component = 'COMPONENT_AT_PI_FLSH',
            item = 'pistol_flashlight',
        },
        ['suppressor'] = {
            component = 'COMPONENT_AR15_SUPP_02',
            item = 'deadairsandman',
        },
        ['luxuryfinish'] = {
            {
                component = 0,
                item = 'weapontint_black',
            },
            {
                component = 1,
                item = 'weapontint_green',
            },
            {
                component = 2,
                item = 'weapontint_gold',
            },
            {
                component = 3,
                item = 'weapontint_pink',
            },
            {
                component = 4,
                item = 'weapontint_army',
            },
            {
                component = 5,
                item = 'weapontint_lspd',
            },
            {
                component = 6,
                item = 'weapontint_orange',
            },
            {
                component = 7,
                item = 'weapontint_plat',
            },
        },
    },
    ['WEAPON_COMBATPISTOL'] = {
        ['defaultclip'] = {
            component = 'COMPONENT_COMBATPISTOL_CLIP_01',
            item = 'combatpistol_defaultclip',
            type = 'clip',
        },
        ['extendedclip'] = {
            component = 'COMPONENT_COMBATPISTOL_CLIP_02',
            item = 'combatpistol_extendedclip',
            type = 'clip',
        },
        ['flashlight'] = {
            component = 'COMPONENT_AT_PI_FLSH',
            item = 'pistol_flashlight',
        },
        ['suppressor'] = {
            component = 'COMPONENT_AT_PI_SUPP',
            item = 'pistol_suppressor',
        },
    },
    ['WEAPON_APPISTOL'] = {
        ['defaultclip'] = {
            component = 'COMPONENT_APPISTOL_CLIP_01',
            item = 'appistol_defaultclip',
            type = 'clip',
        },
        ['extendedclip'] = {
            component = 'COMPONENT_APPISTOL_CLIP_02',
            item = 'appistol_extendedclip',
            type = 'clip',
        },
        ['flashlight'] = {
            component = 'COMPONENT_AT_PI_FLSH',
            item = 'pistol_flashlight',
        },
        ['suppressor'] = {
            component = 'COMPONENT_AT_PI_SUPP',
            item = 'pistol_suppressor',
        },
    },
    ['WEAPON_PISTOL50'] = {
        ['defaultclip'] = {
            component = 'COMPONENT_PISTOL50_CLIP_01',
            item = 'pistol50_defaultclip',
            type = 'clip',
        },
        ['extendedclip'] = {
            component = 'COMPONENT_PISTOL50_CLIP_02',
            item = 'pistol50_extendedclip',
            type = 'clip',
        },
        ['flashlight'] = {
            component = 'COMPONENT_AT_PI_FLSH',
            item = 'pistol_flashlight',
        },
        ['suppressor'] = {
            component = 'COMPONENT_AT_AR_SUPP_02',
            item = 'pistol_suppressor',
        },
        ['luxuryfinish'] = {
            {
                component = 0,
                item = 'weapontint_black',
            },
            {
                component = 1,
                item = 'weapontint_green',
            },
            {
                component = 2,
                item = 'weapontint_gold',
            },
            {
                component = 3,
                item = 'weapontint_pink',
            },
            {
                component = 4,
                item = 'weapontint_army',
            },
            {
                component = 5,
                item = 'weapontint_lspd',
            },
            {
                component = 6,
                item = 'weapontint_orange',
            },
            {
                component = 7,
                item = 'weapontint_plat',
            },
        },
    },
    ['WEAPON_REVOLVER'] = {
        ['defaultclip'] = {
            component = 'COMPONENT_REVOLVER_CLIP_01',
            item = 'revolver_defaultclip',
        },
        ['vipvariant'] = {
            component = 'COMPONENT_REVOLVER_VARMOD_GOON',
            item = 'revolver_vipvariant',
            type = 'skin',
        },
        ['bodyguardvariant'] = {
            component = 'COMPONENT_REVOLVER_VARMOD_BOSS',
            item = 'revolver_bodyguardvariant',
            type = 'skin',
        },
    },
    ['WEAPON_SNSPISTOL'] = {
        ['defaultclip'] = {
            component = 'COMPONENT_SNSPISTOL_CLIP_01',
            item = 'snspistol_defaultclip',
            type = 'clip',
        },
        ['extendedclip'] = {
            component = 'COMPONENT_SNSPISTOL_CLIP_02',
            item = 'snspistol_extendedclip',
            type = 'clip',
        },
        ['grip'] = {
            component = 'COMPONENT_SNSPISTOL_VARMOD_LOWRIDER',
            item = 'snspistol_grip',
        },
    },
    ['WEAPON_HEAVYPISTOL'] = {
        ['defaultclip'] = {
            component = 'COMPONENT_HEAVYPISTOL_CLIP_01',
            item = 'heavypistol_defaultclip',
            type = 'clip',
        },
        ['extendedclip'] = {
            component = 'COMPONENT_HEAVYPISTOL_CLIP_02',
            item = 'heavypistol_extendedclip',
            type = 'clip',
        },
        ['flashlight'] = {
            component = 'COMPONENT_AT_PI_FLSH',
            item = 'pistol_flashlight',
        },
        ['suppressor'] = {
            component = 'COMPONENT_AT_PI_SUPP',
            item = 'pistol_suppressor',
        },
        ['grip'] = {
            component = 'COMPONENT_HEAVYPISTOL_VARMOD_LUXE',
            item = 'heavypistol_grip',
        },
    },
    ['WEAPON_VINTAGEPISTOL'] = {
        ['defaultclip'] = {
            component = 'COMPONENT_VINTAGEPISTOL_CLIP_01',
            item = 'vintagepistol_defaultclip',
            type = 'clip',
        },
        ['extendedclip'] = {
            component = 'COMPONENT_VINTAGEPISTOL_CLIP_02',
            item = 'vintagepistol_extendedclip',
            type = 'clip',
        },
        ['suppressor'] = {
            component = 'COMPONENT_AT_PI_SUPP',
            item = 'pistol_suppressor',
            type = 'silencer',
        },
    },
    -- SMG'S
    ['WEAPON_MICROSMG'] = {
        ['defaultclip'] = {
            component = 'COMPONENT_MICROSMG_CLIP_01',
            item = 'microsmg_defaultclip',
            type = 'clip',
        },
        ['extendedclip'] = {
            component = 'COMPONENT_MICROSMG_CLIP_02',
            item = 'microsmg_extendedclip',
            type = 'clip',
        },
        ['flashlight'] = {
            component = 'COMPONENT_AT_PI_FLSH',
            item = 'pistol_flashlight',
        },
        ['scope'] = {
            component = 'COMPONENT_AT_SCOPE_MACRO',
            item = 'microsmg_scope',
        },
        ['suppressor'] = {
            component = 'COMPONENT_AT_AR_SUPP_02',
            item = 'smg_suppressor',
        },
    },
    ['WEAPON_SMG'] = {
        ['defaultclip'] = {
            component = 'COMPONENT_SMG_CLIP_01',
            item = 'smg_defaultclip',
            type = 'clip',
        },
        ['extendedclip'] = {
            component = 'COMPONENT_SMG_CLIP_02',
            item = 'smg_extendedclip',
            type = 'clip',
        },
        ['drum'] = {
            component = 'COMPONENT_SMG_CLIP_03',
            item = 'smg_drum',
            type = 'clip',
        },
        ['flashlight'] = {
            component = 'COMPONENT_AT_AR_FLSH',
            item = 'rifle_flashlight',
        },
        ['scope'] = {
            component = 'COMPONENT_AT_SCOPE_MACRO_02',
            item = 'smg_scope',
        },
        ['suppressor'] = {
            component = 'COMPONENT_AT_PI_SUPP',
            item = 'pistol_suppressor',
        },
    },
    ['WEAPON_ASSAULTSMG'] = {
        ['defaultclip'] = {
            component = 'COMPONENT_ASSAULTSMG_CLIP_01',
            item = 'assaultsmg_defaultclip',
            type = 'clip',
        },
        ['extendedclip'] = {
            component = 'COMPONENT_ASSAULTSMG_CLIP_02',
            item = 'assaultsmg_extendedclip',
            type = 'clip',
        },
        ['flashlight'] = {
            component = 'COMPONENT_AT_AR_FLSH',
            item = 'rifle_flashlight',
        },
        ['scope'] = {
            component = 'COMPONENT_AT_SCOPE_MACRO',
            item = 'microsmg_scope',
        },
        ['suppressor'] = {
            component = 'COMPONENT_AT_AR_SUPP_02',
            item = 'smg_suppressor',
        },
    },
    ['WEAPON_MINISMG'] = {
        ['defaultclip'] = {
            component = 'COMPONENT_MINISMG_CLIP_01',
            item = 'minismg_defaultclip',
            type = 'clip',
        },
        ['extendedclip'] = {
            component = 'COMPONENT_MINISMG_CLIP_02',
            item = 'minismg_extendedclip',
            type = 'clip',
        },
    },
    ['WEAPON_MACHINEPISTOL'] = {
        ['defaultclip'] = {
            component = 'COMPONENT_MACHINEPISTOL_CLIP_01',
            item = 'machinepistol_defaultclip',
            type = 'clip',
        },
        ['extendedclip'] = {
            component = 'COMPONENT_MACHINEPISTOL_CLIP_02',
            item = 'machinepistol_extendedclip',
            type = 'clip',
        },
        ['drum'] = {
            component = 'COMPONENT_MACHINEPISTOL_CLIP_03',
            item = 'machinepistol_drum',
            type = 'clip',
        },
        ['suppressor'] = {
            component = 'COMPONENT_AT_PI_SUPP',
            item = 'pistol_suppressor',
        },
    },
    ['WEAPON_COMBATPDW'] = {
        ['defaultclip'] = {
            component = 'COMPONENT_COMBATPDW_CLIP_01',
            item = 'combatpdw_defaultclip',
            type = 'clip',
        },
        ['extendedclip'] = {
            component = 'COMPONENT_COMBATPDW_CLIP_02',
            item = 'combatpdw_extendedclip',
            type = 'clip',
        },
        ['drum'] = {
            component = 'COMPONENT_COMBATPDW_CLIP_03',
            item = 'combatpdw_drum',
            type = 'clip',
        },
        ['flashlight'] = {
            component = 'COMPONENT_AT_AR_FLSH',
            item = 'rifle_flashlight',
        },
        ['grip'] = {
            component = 'COMPONENT_AT_AR_AFGRIP',
            item = 'combatpdw_grip',
        },
        ['scope'] = {
            component = 'COMPONENT_AT_SCOPE_SMALL',
            item = 'combatpdw_scope',
        },
    },
    -- SHOTGUNS
    ['WEAPON_PUMPSHOTGUN'] = {
        ['flashlight'] = {
            component = 'COMPONENT_AT_AR_FLSH',
            item = 'rifle_flashlight',
        },
        ['suppressor'] = {
            component = 'COMPONENT_AT_SR_SUPP',
            item = 'shotgun_suppressor',
        },
    },
    ['WEAPON_SAWNOFFSHOTGUN'] = {
    },
    ['WEAPON_ASSAULTSHOTGUN'] = {
        ['defaultclip'] = {
            component = 'COMPONENT_ASSAULTSHOTGUN_CLIP_01',
            item = 'assaultshotgun_defaultclip',
            type = 'clip',
        },
        ['extendedclip'] = {
            component = 'COMPONENT_ASSAULTSHOTGUN_CLIP_02',
            item = 'assaultshotgun_extendedclip',
            type = 'clip',
        },
        ['flashlight'] = {
            component = 'COMPONENT_AT_AR_FLSH',
            item = 'rifle_flashlight',
        },
        ['suppressor'] = {
            component = 'COMPONENT_AT_AR_SUPP',
            item = 'rifle_suppressor',
        },
        ['grip'] = {
            component = 'COMPONENT_AT_AR_AFGRIP',
            item = 'rifle_grip',
        },
    },
    ['WEAPON_BULLPUPSHOTGUN'] = {
        ['flashlight'] = {
            component = 'COMPONENT_AT_AR_FLSH',
            item = 'rifle_flashlight',
        },
        ['suppressor'] = {
            component = 'COMPONENT_AT_AR_SUPP_02',
            item = 'smg_suppressor',
        },
        ['grip'] = {
            component = 'COMPONENT_AT_AR_AFGRIP',
            item = 'rifle_grip',
        },
    },
    ['WEAPON_HEAVYSHOTGUN'] = {
        ['defaultclip'] = {
            component = 'COMPONENT_HEAVYSHOTGUN_CLIP_01',
            item = 'heavyshotgun_defaultclip',
            type = 'clip',
        },
        ['extendedclip'] = {
            component = 'COMPONENT_HEAVYSHOTGUN_CLIP_02',
            item = 'heavyshotgun_extendedclip',
            type = 'clip',
        },
        ['drum'] = {
            component = 'COMPONENT_HEAVYSHOTGUN_CLIP_03',
            item = 'heavyshotgun_drum',
            type = 'clip',
        },
        ['flashlight'] = {
            component = 'COMPONENT_AT_AR_FLSH',
            item = 'rifle_flashlight',
        },
        ['suppressor'] = {
            component = 'COMPONENT_AT_AR_SUPP_02',
            item = 'smg_suppressor',
        },
        ['grip'] = {
            component = 'COMPONENT_AT_AR_AFGRIP',
            item = 'rifle_grip',
        },
    },
    ['WEAPON_COMBATSHOTGUN'] = {
        ['flashlight'] = {
            component = 'COMPONENT_AT_AR_FLSH',
            item = 'rifle_flashlight',
        },
        ['suppressor'] = {
            component = 'COMPONENT_AT_AR_SUPP',
            item = 'rifle_suppressor',
        },
    },
    -- RIFLES
    ['WEAPON_ASSAULTRIFLE'] = {
        ['defaultclip'] = {
            component = 'COMPONENT_ASSAULTRIFLE_CLIP_01',
            item = 'assaultrifle_defaultclip',
            type = 'clip',
        },
        ['extendedclip'] = {
            component = 'COMPONENT_ASSAULTRIFLE_CLIP_02',
            item = 'assaultrifle_extendedclip',
            type = 'clip',
        },
        ['drum'] = {
            component = 'COMPONENT_ASSAULTRIFLE_CLIP_03',
            item = 'assaultrifle_drum',
            type = 'clip',
        },
        ['flashlight'] = {
            component = 'COMPONENT_AT_AR_FLSH',
            item = 'rifle_flashlight',
        },
        ['scope'] = {
            component = 'COMPONENT_AT_SCOPE_MACRO',
            item = 'microsmg_scope',
        },
        ['suppressor'] = {
            component = 'COMPONENT_AT_AR_SUPP_02',
            item = 'rifle_suppressor',
        },
        ['grip'] = {
            component = 'COMPONENT_AT_AR_AFGRIP',
            item = 'rifle_grip',
        },
    },
    ['WEAPON_CARBINERIFLE'] = {
        ['defaultclip'] = {
            component = 'COMPONENT_CARBINERIFLE_CLIP_01',
            item = 'carbinerifle_defaultclip',
            type = 'clip',
        },
        ['extendedclip'] = {
            component = 'COMPONENT_CARBINERIFLE_CLIP_02',
            item = 'carbinerifle_extendedclip',
            type = 'clip',
        },
        ['drum'] = {
            component = 'COMPONENT_CARBINERIFLE_CLIP_03',
            item = 'carbinerifle_drum',
            type = 'clip',
        },
        ['flashlight'] = {
            component = 'COMPONENT_AT_AR_FLSH',
            item = 'rifle_flashlight',
        },
        ['scope'] = {
            component = 'COMPONENT_AT_SCOPE_MEDIUM',
            item = 'carbinerifle_scope',
        },
        ['suppressor'] = {
            component = 'COMPONENT_AT_AR_SUPP',
            item = 'rifle_suppressor',
        },
        ['grip'] = {
            component = 'COMPONENT_AT_AR_AFGRIP',
            item = 'rifle_grip',
        },
    },
    ['WEAPON_ADVANCEDRIFLE'] = {
        ['defaultclip'] = {
            component = 'COMPONENT_ADVANCEDRIFLE_CLIP_01',
            item = 'advancedrifle_defaultclip',
            type = 'clip',
        },
        ['extendedclip'] = {
            component = 'COMPONENT_ADVANCEDRIFLE_CLIP_02',
            item = 'advancedrifle_extendedclip',
            type = 'clip',
        },
        ['flashlight'] = {
            component = 'COMPONENT_AT_AR_FLSH',
            item = 'rifle_flashlight',
        },
        ['scope'] = {
            component = 'COMPONENT_AT_SCOPE_SMALL',
            item = 'combatpdw_scope',
        },
        ['suppressor'] = {
            component = 'COMPONENT_AT_AR_SUPP',
            item = 'rifle_suppressor',
        },
        ['grip'] = {
            component = 'COMPONENT_AT_AR_AFGRIP',
            item = 'rifle_grip',
        },
    },
    ['WEAPON_SPECIALCARBINE'] = {
        ['defaultclip'] = {
            component = 'COMPONENT_SPECIALCARBINE_CLIP_01',
            item = 'specialcarbine_defaultclip',
            type = 'clip',
        },
        ['extendedclip'] = {
            component = 'COMPONENT_SPECIALCARBINE_CLIP_02',
            item = 'specialcarbine_extendedclip',
            type = 'clip',
        },
        ['drum'] = {
            component = 'COMPONENT_SPECIALCARBINE_CLIP_03',
            item = 'specialcarbine_drum',
            type = 'clip',
        },
        ['flashlight'] = {
            component = 'COMPONENT_AT_AR_FLSH',
            item = 'rifle_flashlight',
        },
        ['scope'] = {
            component = 'COMPONENT_AT_SCOPE_MEDIUM',
            item = 'carbinerifle_scope',
        },
        ['suppressor'] = {
            component = 'COMPONENT_AT_AR_SUPP_02',
            item = 'smg_suppressor',
        },
        ['grip'] = {
            component = 'COMPONENT_AT_AR_AFGRIP',
            item = 'rifle_grip',
        },
    },
    ['WEAPON_BULLPUPRIFLE'] = {
        ['defaultclip'] = {
            component = 'COMPONENT_BULLPUPRIFLE_CLIP_01',
            item = 'bullpuprifle_defaultclip',
            type = 'clip',
        },
        ['extendedclip'] = {
            component = 'COMPONENT_BULLPUPRIFLE_CLIP_02',
            item = 'bullpuprifle_extendedclip',
            type = 'clip',
        },
        ['flashlight'] = {
            component = 'COMPONENT_AT_AR_FLSH',
            item = 'rifle_flashlight',
        },
        ['scope'] = {
            component = 'COMPONENT_AT_SCOPE_SMALL',
            item = 'combatpdw_scope',
        },
        ['suppressor'] = {
            component = 'COMPONENT_AT_AR_SUPP',
            item = 'rifle_suppressor',
        },
        ['grip'] = {
            component = 'COMPONENT_AT_AR_AFGRIP',
            item = 'rifle_grip',
        },
    },
    ['WEAPON_COMPACTRIFLE'] = {
        ['defaultclip'] = {
            component = 'COMPONENT_COMPACTRIFLE_CLIP_01',
            item = 'compactrifle_defaultclip',
            type = 'clip',
        },
        ['extendedclip'] = {
            component = 'COMPONENT_COMPACTRIFLE_CLIP_02',
            item = 'compactrifle_extendedclip',
            type = 'clip',
        },
        ['drum'] = {
            component = 'COMPONENT_COMPACTRIFLE_CLIP_03',
            item = 'compactrifle_drum',
            type = 'clip',
        },
    },
    ['WEAPON_HEAVYRIFLE'] = {
        ['defaultclip'] = {
            component = 'COMPONENT_HEAVYRIFLE_CLIP_01',
            item = 'bullpuprifle_defaultclip',
            type = 'clip',
        },
        ['extendedclip'] = {
            component = 'COMPONENT_HEAVYRIFLE_CLIP_02',
            item = 'bullpuprifle_extendedclip',
            type = 'clip',
        },
        ['flashlight'] = {
            component = 'COMPONENT_AT_AR_FLSH',
            item = 'rifle_flashlight',
        },
        ['scope'] = {
            component = 'COMPONENT_AT_SCOPE_MEDIUM',
            item = 'carbinerifle_scope',
        },
        ['suppressor'] = {
            component = 'COMPONENT_AT_AR_SUPP',
            item = 'rifle_suppressor',
        },
        ['grip'] = {
            component = 'COMPONENT_AT_AR_AFGRIP',
            item = 'rifle_grip',
        },
    },
    -- MACHINE GUNS
    ['WEAPON_GUSENBERG'] = {
        ['defaultclip'] = {
            component = 'COMPONENT_GUSENBERG_CLIP_01',
            item = 'gusenberg_defaultclip',
            type = 'clip',
        },
        ['extendedclip'] = {
            component = 'COMPONENT_GUSENBERG_CLIP_02',
            item = 'gusenberg_extendedclip',
            type = 'clip',
        },
    },
    -- LAUNCHERS
    ['WEAPON_EMPLAUNCHER'] = {
        ['defaultclip'] = {
            component = 'COMPONENT_EMPLAUNCHER_CLIP_01',
            item = 'emplauncher_defaultclip',
            type = 'clip',
        },
    },
    -- SNIPERS
    ['WEAPON_SNIPERRIFLE'] = {
        ['defaultclip'] = {
            component = 'COMPONENT_SNIPERRIFLE_CLIP_01',
            item = 'sniperrifle_defaultclip',
        },
        ['suppressor'] = {
            component = 'COMPONENT_AT_AR_SUPP_02',
            item = 'smg_suppressor',
        },
        ['scope'] = {
            component = 'COMPONENT_AT_SCOPE_LARGE',
            item = 'sniper_scope',
            type = 'scope',
        },
        ['advancedscope'] = {
            component = 'COMPONENT_AT_SCOPE_MAX',
            item = 'snipermax_scope',
            type = 'scope',
        },
        ['grip'] = {
            component = 'COMPONENT_SNIPERRIFLE_VARMOD_LUXE',
            item = 'sniper_grip',
        },
    },
    ['WEAPON_HEAVYSNIPER'] = {
        ['defaultclip'] = {
            component = 'COMPONENT_HEAVYSNIPER_CLIP_01',
            item = 'heavysniper_defaultclip',
        },
        ['scope'] = {
            component = 'COMPONENT_AT_SCOPE_LARGE',
            item = 'sniper_scope',
            type = 'scope',
        },
        ['advancedscope'] = {
            component = 'COMPONENT_AT_SCOPE_MAX',
            item = 'snipermax_scope',
            type = 'scope',
        },
    },
    ['WEAPON_MARKSMANRIFLE'] = {
        ['defaultclip'] = {
            component = 'COMPONENT_MARKSMANRIFLE_CLIP_01',
            item = 'marksmanrifle_defaultclip',
            type = 'clip',
        },
        ['extendedclip'] = {
            component = 'COMPONENT_MARKSMANRIFLE_CLIP_02',
            item = 'marksmanrifle_extendedclip',
            type = 'clip',
        },
        ['flashlight'] = {
            component = 'COMPONENT_AT_AR_FLSH',
            item = 'rifle_flashlight',
        },
        ['scope'] = {
            component = 'COMPONENT_AT_SCOPE_LARGE_FIXED_ZOOM',
            item = 'marksmanrifle_scope',
        },
        ['suppressor'] = {
            component = 'COMPONENT_AT_AR_SUPP',
            item = 'rifle_suppressor',
        },
        ['grip'] = {
            component = 'COMPONENT_AT_AR_AFGRIP',
            item = 'rifle_grip',
        },
    },
}
-- Attachments List related to the new qb-core and qb-weapons version
Config.NewAttachments = {
    clip_attachment = {
        weapon_pistol = `COMPONENT_PISTOL_CLIP_02`,
        weapon_pistol_mk2 = `COMPONENT_PISTOL_MK2_CLIP_02`,
        weapon_combatpistol = `COMPONENT_COMBATPISTOL_CLIP_02`,
        weapon_appistol = `COMPONENT_APPISTOL_CLIP_02`,
        weapon_pistol50 = `COMPONENT_PISTOL50_CLIP_02`,
        weapon_snspistol = `COMPONENT_SNSPISTOL_CLIP_02`,
        weapon_snspistol_mk2 = `COMPONENT_SNSPISTOL_MK2_CLIP_02`,
        weapon_heavypistol = `COMPONENT_HEAVYPISTOL_CLIP_02`,
        weapon_vintagepistol = `COMPONENT_VINTAGEPISTOL_CLIP_02`,
        weapon_ceramicpistol = `COMPONENT_CERAMICPISTOL_CLIP_02`,
        weapon_microsmg = `COMPONENT_MICROSMG_CLIP_02`,
        weapon_smg = `COMPONENT_SMG_CLIP_02`,
        weapon_assaultsmg = `COMPONENT_ASSAULTSMG_CLIP_02`,
        weapon_minismg = `COMPONENT_MINISMG_CLIP_02`,
        weapon_smg_mk2 = `COMPONENT_SMG_MK2_CLIP_02`,
        weapon_machinepistol = `COMPONENT_MACHINEPISTOL_CLIP_02`,
        weapon_combatpdw = `COMPONENT_COMBATPDW_CLIP_02`,
        weapon_assaultshotgun = `COMPONENT_ASSAULTSHOTGUN_CLIP_02`,
        weapon_heavyshotgun = `COMPONENT_HEAVYSHOTGUN_CLIP_02`,
        weapon_assaultrifle = `COMPONENT_ASSAULTRIFLE_CLIP_02`,
        weapon_carbinerifle = `COMPONENT_CARBINERIFLE_CLIP_02`,
        weapon_advancedrifle = `COMPONENT_ADVANCEDRIFLE_CLIP_02`,
        weapon_specialcarbine = `COMPONENT_SPECIALCARBINE_CLIP_02`,
        weapon_bullpuprifle = `COMPONENT_BULLPUPRIFLE_CLIP_02`,
        weapon_bullpuprifle_mk2 = `COMPONENT_BULLPUPRIFLE_MK2_CLIP_02`,
        weapon_specialcarbine_mk2 = `COMPONENT_SPECIALCARBINE_MK2_CLIP_02`,
        weapon_assaultrifle_mk2 = `COMPONENT_ASSAULTRIFLE_MK2_CLIP_02`,
        weapon_carbinerifle_mk2 = `COMPONENT_CARBINERIFLE_MK2_CLIP_02`,
        weapon_compactrifle = `COMPONENT_COMPACTRIFLE_CLIP_02`,
        weapon_militaryrifle = `COMPONENT_MILITARYRIFLE_CLIP_02`,
        weapon_heavyrifle = `COMPONENT_HEAVYRIFLE_CLIP_02`,
        weapon_mg = `COMPONENT_MG_CLIP_02`,
        weapon_combatmg = `COMPONENT_COMBATMG_CLIP_02`,
        weapon_combatmg_mk2 = `COMPONENT_COMBATMG_MK2_CLIP_02`,
        weapon_gusenberg = `COMPONENT_GUSENBERG_CLIP_02`,
        weapon_marksmanrifle = `COMPONENT_MARKSMANRIFLE_CLIP_02`,
        weapon_marksmanrifle_mk2 = `COMPONENT_MARKSMANRIFLE_MK2_CLIP_02`,
        weapon_heavysniper_mk2 = `COMPONENT_HEAVYSNIPER_MK2_CLIP_02`,
    },
    drum_attachment = {
        weapon_smg = `COMPONENT_SMG_CLIP_03`,
        weapon_machinepistol = `COMPONENT_MACHINEPISTOL_CLIP_03`,
        weapon_combatpdw = `COMPONENT_COMBATPDW_CLIP_03`,
        weapon_heavyshotgun = `COMPONENT_HEAVYSHOTGUN_CLIP_03`,
        weapon_assaultrifle = `COMPONENT_ASSAULTRIFLE_CLIP_03`,
        weapon_carbinerifle = `COMPONENT_CARBINERIFLE_CLIP_03`,
        weapon_specialcarbine = `COMPONENT_SPECIALCARBINE_CLIP_03`,
        weapon_compactrifle = `COMPONENT_COMPACTRIFLE_CLIP_03`,
    },
    flashlight_attachment = {
        weapon_pistol = `COMPONENT_AT_PI_FLSH`,
        weapon_pistol_mk2 = `COMPONENT_AT_PI_FLSH_02`,
        weapon_combatpistol = `COMPONENT_AT_PI_FLSH`,
        weapon_appistol = `COMPONENT_AT_PI_FLSH`,
        weapon_pistol50 = `COMPONENT_AT_PI_FLSH`,
        weapon_heavypistol = `COMPONENT_AT_PI_FLSH`,
        weapon_snspistol_mk2 = `COMPONENT_AT_PI_FLSH_03`,
        weapon_revolver_mk2 = `COMPONENT_AT_PI_FLSH`,
        weapon_microsmg = `COMPONENT_AT_PI_FLSH`,
        weapon_smg = `COMPONENT_AT_AR_FLSH`,
        weapon_assaultsmg = `COMPONENT_AT_AR_FLSH`,
        weapon_smg_mk2 = `COMPONENT_AT_AR_FLSH`,
        weapon_combatpdw = `COMPONENT_AT_AR_FLSH`,
        weapon_pumpshotgun = `COMPONENT_AT_AR_FLSH`,
        weapon_assaultshotgun = `COMPONENT_AT_AR_FLSH`,
        weapon_bullpupshotgun = `COMPONENT_AT_AR_FLSH`,
        weapon_pumpshotgun_mk2 = `COMPONENT_AT_AR_FLSH`,
        weapon_heavyshotgun = `COMPONENT_AT_AR_FLSH`,
        weapon_combatshotgun = `COMPONENT_AT_AR_FLSH`,
        weapon_assaultrifle = `COMPONENT_AT_AR_FLSH`,
        weapon_carbinerifle = `COMPONENT_AT_AR_FLSH`,
        weapon_advancedrifle = `COMPONENT_AT_AR_FLSH`,
        weapon_specialcarbine = `COMPONENT_AT_AR_FLSH`,
        weapon_bullpuprifle = `COMPONENT_AT_AR_FLSH`,
        weapon_bullpuprifle_mk2 = `COMPONENT_AT_AR_FLSH`,
        weapon_specialcarbine_mk2 = `COMPONENT_AT_AR_FLSH`,
        weapon_assaultrifle_mk2 = `COMPONENT_AT_AR_FLSH`,
        weapon_carbinerifle_mk2 = `COMPONENT_AT_AR_FLSH`,
        weapon_militaryrifle = `COMPONENT_AT_AR_FLSH`,
        weapon_heavyrifle = `COMPONENT_AT_AR_FLSH`,
        weapon_marksmanrifle = `COMPONENT_AT_AR_FLSH`,
        weapon_marksmanrifle_mk2 = `COMPONENT_AT_AR_FLSH`,
        weapon_grenadelauncher = `COMPONENT_AT_AR_FLSH`,
    },
    suppressor_attachment = {
        weapon_pistol = `COMPONENT_AT_PI_SUPP_02`,
        weapon_pistol_mk2 = `COMPONENT_AT_PI_SUPP_02`,
        weapon_combatpistol = `COMPONENT_AT_PI_SUPP`,
        weapon_appistol = `COMPONENT_AT_PI_SUPP`,
        weapon_pistol50 = `COMPONENT_AT_AR_SUPP_02`,
        weapon_heavypistol = `COMPONENT_AT_PI_SUPP`,
        weapon_snspistol_mk2 = `COMPONENT_AT_PI_SUPP_02`,
        weapon_vintagepistol = `COMPONENT_AT_PI_SUPP`,
        weapon_ceramicpistol = `COMPONENT_CERAMICPISTOL_SUPP`,
        weapon_microsmg = `COMPONENT_AT_AR_SUPP_02`,
        weapon_smg = `COMPONENT_AT_PI_SUPP`,
        weapon_assaultsmg = `COMPONENT_AT_AR_SUPP_02`,
        weapon_smg_mk2 = `COMPONENT_AT_PI_SUPP`,
        weapon_machinepistol = `COMPONENT_AT_PI_SUPP`,
        weapon_pumpshotgun = `COMPONENT_AT_SR_SUPP`,
        weapon_assaultshotgun = `COMPONENT_AT_AR_SUPP`,
        weapon_bullpupshotgun = `COMPONENT_AT_AR_SUPP_02`,
        weapon_pumpshotgun_mk2 = `COMPONENT_AT_SR_SUPP_03`,
        weapon_heavyshotgun = `COMPONENT_AT_AR_SUPP_02`,
        weapon_combatshotgun = `COMPONENT_AT_AR_SUPP`,
        weapon_assaultrifle = `COMPONENT_AT_AR_SUPP_02`,
        weapon_carbinerifle = `COMPONENT_AT_AR_SUPP`,
        weapon_advancedrifle = `COMPONENT_AT_AR_SUPP`,
        weapon_specialcarbine = `COMPONENT_AT_AR_SUPP_02`,
        weapon_bullpuprifle = `COMPONENT_AT_AR_SUPP`,
        weapon_bullpuprifle_mk2 = `COMPONENT_AT_AR_SUPP`,
        weapon_specialcarbine_mk2 = `COMPONENT_AT_AR_SUPP_02`,
        weapon_assaultrifle_mk2 = `COMPONENT_AT_AR_SUPP_02`,
        weapon_carbinerifle_mk2 = `COMPONENT_AT_AR_SUPP`,
        weapon_militaryrifle = `COMPONENT_AT_AR_SUPP`,
        weapon_heavyrifle = `COMPONENT_AT_AR_SUPP`,
        weapon_sniperrifle = `COMPONENT_AT_AR_SUPP_02`,
        weapon_marksmanrifle = `COMPONENT_AT_AR_SUPP`,
        weapon_marksmanrifle_mk2 = `COMPONENT_AT_AR_SUPP`,
        weapon_heavysniper_mk2 = `COMPONENT_AT_SR_SUPP_03`,
    },
    smallscope_attachment = {
        weapon_pistol_mk2 = `COMPONENT_AT_PI_RAIL`,
        weapon_snspistol_mk2 = `COMPONENT_AT_PI_RAIL_02`,
        weapon_microsmg = `COMPONENT_AT_SCOPE_MACRO`,
        weapon_smg = `COMPONENT_AT_SCOPE_MACRO_02`,
        weapon_assaultsmg = `COMPONENT_AT_SCOPE_MACRO`,
        weapon_combatpdw = `COMPONENT_AT_SCOPE_SMALL`,
        weapon_assaultrifle = `COMPONENT_AT_SCOPE_MACRO`,
        weapon_bullpuprifle = `COMPONENT_AT_SCOPE_SMALL`,
        weapon_militaryrifle = `COMPONENT_AT_SCOPE_SMALL`,
        weapon_mg = `COMPONENT_AT_SCOPE_SMALL_02`,
        weapon_revolver_mk2 = `COMPONENT_AT_SCOPE_MACRO_MK2`,
        weapon_smg_mk2 = `COMPONENT_AT_SCOPE_MACRO_02_SMG_MK2`,
        weapon_pumpshotgun_mk2 = `COMPONENT_AT_SCOPE_MACRO_MK2`,
        weapon_bullpuprifle_mk2 = `COMPONENT_AT_SCOPE_MACRO_02_MK2`,
        weapon_specialcarbine_mk2 = `COMPONENT_AT_SCOPE_MACRO_MK2`,
        weapon_assaultrifle_mk2 = `COMPONENT_AT_SCOPE_MACRO_MK2`,
        weapon_carbinerifle_mk2 = `COMPONENT_AT_SCOPE_MACRO_MK2`,
        weapon_advancedrifle = `COMPONENT_AT_SCOPE_SMALL`,
        weapon_grenadelauncher = `COMPONENT_AT_SCOPE_SMALL`,
    },
    medscope_attachment = {
        weapon_smg_mk2 = `COMPONENT_AT_SCOPE_SMALL_SMG_MK2`,
        weapon_pumpshotgun_mk2 = `COMPONENT_AT_SCOPE_SMALL_MK2`,
        weapon_bullpuprifle_mk2 = `COMPONENT_AT_SCOPE_SMALL_MK2`,
        weapon_combatmg_mk2 = `COMPONENT_AT_SCOPE_SMALL_MK2`,
        weapon_carbinerifle = `COMPONENT_AT_SCOPE_MEDIUM`,
        weapon_specialcarbine = `COMPONENT_AT_SCOPE_MEDIUM`,
        weapon_combatmg = `COMPONENT_AT_SCOPE_MEDIUM`,
        weapon_marksmanrifle_mk2 = `COMPONENT_AT_SCOPE_MEDIUM_MK2`,
    },
    largescope_attachment = {
        weapon_sniperrifle = `COMPONENT_AT_SCOPE_LARGE`,
        weapon_marksmanrifle = `COMPONENT_AT_SCOPE_LARGE_FIXED_ZOOM`,
        weapon_heavysniper_mk2 = `COMPONENT_AT_SCOPE_LARGE_MK2`,
    },
    holoscope_attachment = {
        weapon_heavyrevolver_mk2 = `COMPONENT_AT_SIGHTS`,
        weapon_smg_mk2 = `COMPONENT_AT_SIGHTS`,
        weapon_pumpshotgun_mk2 = `COMPONENT_AT_SIGHTS`,
        weapon_bullpuprifle_mk2 = `COMPONENT_AT_SIGHTS`,
        weapon_specialcarbine_mk2 = `COMPONENT_AT_SIGHTS`,
        weapon_assaultrifle_mk2 = `COMPONENT_AT_SIGHTS`,
        weapon_carbinerifle_mk2 = `COMPONENT_AT_SIGHTS`,
        weapon_combatmg_mk2 = `COMPONENT_AT_SIGHTS`,
        weapon_marksmanrifle_mk2 = `COMPONENT_AT_SIGHTS`,
    },
    advscope_attachment = {
        weapon_sniperrifle = `COMPONENT_AT_SCOPE_MAX`,
        weapon_heavysniper = `COMPONENT_AT_SCOPE_MAX`,
        weapon_heavysniper_mk2 = `COMPONENT_AT_SCOPE_MAX`,
    },
    nvscope_attachment = {
        weapon_heavysniper_mk2 = `COMPONENT_AT_SCOPE_NV`,
    },
    thermalscope_attachment = {
        weapon_heavysniper_mk2 = `COMPONENT_AT_SCOPE_THERMAL`,
    },
    flat_muzzle_brake = {
        weapon_smg_mk2 = `COMPONENT_AT_MUZZLE_01`,
        weapon_assaultrifle_mk2 = `COMPONENT_AT_MUZZLE_01`,
        weapon_carbinerifle_mk2 = `COMPONENT_AT_MUZZLE_01`,
        weapon_specialcarbine_mk2 = `COMPONENT_AT_MUZZLE_01`,
        weapon_bullpuprifle_mk2 = `COMPONENT_AT_MUZZLE_01`,
        weapon_combatmg_mk2 = `COMPONENT_AT_MUZZLE_01`,
        weapon_marksmanrifle_mk2 = `COMPONENT_AT_MUZZLE_01`,
    },
    tactical_muzzle_brake = {
        weapon_smg_mk2 = `COMPONENT_AT_MUZZLE_02`,
        weapon_assaultrifle_mk2 = `COMPONENT_AT_MUZZLE_02`,
        weapon_carbinerifle_mk2 = `COMPONENT_AT_MUZZLE_02`,
        weapon_specialcarbine_mk2 = `COMPONENT_AT_MUZZLE_02`,
        weapon_bullpuprifle_mk2 = `COMPONENT_AT_MUZZLE_02`,
        weapon_combatmg_mk2 = `COMPONENT_AT_MUZZLE_02`,
        weapon_marksmanrifle_mk2 = `COMPONENT_AT_MUZZLE_02`,
    },
    fat_end_muzzle_brake = {
        weapon_smg_mk2 = `COMPONENT_AT_MUZZLE_03`,
        weapon_assaultrifle_mk2 = `COMPONENT_AT_MUZZLE_03`,
        weapon_carbinerifle_mk2 = `COMPONENT_AT_MUZZLE_03`,
        weapon_specialcarbine_mk2 = `COMPONENT_AT_MUZZLE_03`,
        weapon_bullpuprifle_mk2 = `COMPONENT_AT_MUZZLE_03`,
        weapon_combatmg_mk2 = `COMPONENT_AT_MUZZLE_03`,
        weapon_marksmanrifle_mk2 = `COMPONENT_AT_MUZZLE_03`,
    },
    precision_muzzle_brake = {
        weapon_smg_mk2 = `COMPONENT_AT_MUZZLE_04`,
        weapon_assaultrifle_mk2 = `COMPONENT_AT_MUZZLE_04`,
        weapon_carbinerifle_mk2 = `COMPONENT_AT_MUZZLE_04`,
        weapon_specialcarbine_mk2 = `COMPONENT_AT_MUZZLE_04`,
        weapon_bullpuprifle_mk2 = `COMPONENT_AT_MUZZLE_04`,
        weapon_combatmg_mk2 = `COMPONENT_AT_MUZZLE_04`,
        weapon_marksmanrifle_mk2 = `COMPONENT_AT_MUZZLE_04`,
    },
    heavy_duty_muzzle_brake = {
        weapon_smg_mk2 = `COMPONENT_AT_MUZZLE_05`,
        weapon_assaultrifle_mk2 = `COMPONENT_AT_MUZZLE_05`,
        weapon_carbinerifle_mk2 = `COMPONENT_AT_MUZZLE_05`,
        weapon_specialcarbine_mk2 = `COMPONENT_AT_MUZZLE_05`,
        weapon_bullpuprifle_mk2 = `COMPONENT_AT_MUZZLE_05`,
        weapon_combatmg_mk2 = `COMPONENT_AT_MUZZLE_05`,
        weapon_marksmanrifle_mk2 = `COMPONENT_AT_MUZZLE_05`,
    },
    slanted_muzzle_brake = {
        weapon_smg_mk2 = `COMPONENT_AT_MUZZLE_06`,
        weapon_assaultrifle_mk2 = `COMPONENT_AT_MUZZLE_06`,
        weapon_carbinerifle_mk2 = `COMPONENT_AT_MUZZLE_06`,
        weapon_specialcarbine_mk2 = `COMPONENT_AT_MUZZLE_06`,
        weapon_bullpuprifle_mk2 = `COMPONENT_AT_MUZZLE_06`,
        weapon_combatmg_mk2 = `COMPONENT_AT_MUZZLE_06`,
        weapon_marksmanrifle_mk2 = `COMPONENT_AT_MUZZLE_06`,
    },
    split_end_muzzle_brake = {
        weapon_smg_mk2 = `COMPONENT_AT_MUZZLE_07`,
        weapon_assaultrifle_mk2 = `COMPONENT_AT_MUZZLE_07`,
        weapon_carbinerifle_mk2 = `COMPONENT_AT_MUZZLE_07`,
        weapon_specialcarbine_mk2 = `COMPONENT_AT_MUZZLE_07`,
        weapon_bullpuprifle_mk2 = `COMPONENT_AT_MUZZLE_07`,
        weapon_combatmg_mk2 = `COMPONENT_AT_MUZZLE_07`,
        weapon_marksmanrifle_mk2 = `COMPONENT_AT_MUZZLE_07`,
    },
    squared_muzzle_brake = {
        weapon_pumpshotgun_mk2 = `COMPONENT_AT_MUZZLE_08`,
        weapon_heavysniper_mk2 = `COMPONENT_AT_MUZZLE_08`
    },
    bellend_muzzle_brake = {
        weapon_heavysniper_mk2 = `COMPONENT_AT_MUZZLE_09`
    },
    barrel_attachment = {
        weapon_smg_mk2 = `COMPONENT_AT_SB_BARREL_02`,
        weapon_bullpuprifle_mk2 = `COMPONENT_AT_BP_BARREL_02`,
        weapon_specialcarbine_mk2 = `COMPONENT_AT_SC_BARREL_02`,
        weapon_assaultrifle_mk2 = `COMPONENT_AT_AR_BARREL_02`,
        weapon_carbinerifle_mk2 = `COMPONENT_AT_CR_BARREL_02`,
        weapon_combatmg_mk2 = `COMPONENT_AT_MG_BARREL_02`,
        weapon_marksmanrifle_mk2 = `COMPONENT_AT_MRFL_BARREL_02`,
        weapon_heavysniper_mk2 = `COMPONENT_AT_SR_BARREL_02`,
    },
    grip_attachment = {
        weapon_combatpdw = `COMPONENT_AT_AR_AFGRIP`,
        weapon_assaultshotgun = `COMPONENT_AT_AR_AFGRIP`,
        weapon_bullpupshotgun = `COMPONENT_AT_AR_AFGRIP`,
        weapon_heavyshotgun = `COMPONENT_AT_AR_AFGRIP`,
        weapon_assaultrifle = `COMPONENT_AT_AR_AFGRIP`,
        weapon_carbinerifle = `COMPONENT_AT_AR_AFGRIP`,
        weapon_advancedrifle = `COMPONENT_AT_AR_AFGRIP`,
        weapon_specialcarbine = `COMPONENT_AT_AR_AFGRIP`,
        weapon_bullpuprifle = `COMPONENT_AT_AR_AFGRIP`,
        weapon_bullpuprifle_mk2 = `COMPONENT_AT_AR_AFGRIP_02`,
        weapon_specialcarbine_mk2 = `COMPONENT_AT_AR_AFGRIP_02`,
        weapon_assaultrifle_mk2 = `COMPONENT_AT_AR_AFGRIP_02`,
        weapon_carbinerifle_mk2 = `COMPONENT_AT_AR_AFGRIP_02`,
        weapon_heavyrifle = `COMPONENT_AT_AR_AFGRIP`,
        weapon_combatmg = `COMPONENT_AT_AR_AFGRIP`,
        weapon_combatmg_mk2 = `COMPONENT_AT_AR_AFGRIP_02`,
        weapon_marksmanrifle = `COMPONENT_AT_AR_AFGRIP`,
        weapon_marksmanrifle_mk2 = `COMPONENT_AT_AR_AFGRIP_02`,
        weapon_grenadelauncher = `COMPONENT_AT_AR_AFGRIP`,
    },
    comp_attachment = {
        weapon_pistol_mk2 = `COMPONENT_AT_PI_COMP`,
        weapon_snspistol_mk2 = `COMPONENT_AT_PI_COMP_02`,
        weapon_revolver_mk2 = `COMPONENT_AT_PI_COMP_03`,
    },
    luxuryfinish_attachment = {
        weapon_pistol = `COMPONENT_PISTOL_VARMOD_LUXE`,
        weapon_combatpistol = `COMPONENT_COMBATPISTOL_VARMOD_LOWRIDER`,
        weapon_appistol = `COMPONENT_APPISTOL_VARMOD_LUXE`,
        weapon_pistol50 = `COMPONENT_PISTOL50_VARMOD_LUXE`,
        weapon_revolver = `COMPONENT_REVOLVER_VARMOD_GOON`,
        weapon_snspistol = `COMPONENT_SNSPISTOL_VARMOD_LOWRIDER`,
        weapon_heavypistol = `COMPONENT_HEAVYPISTOL_VARMOD_LUXE`,
        weapon_smg = `COMPONENT_SMG_VARMOD_LUXE`,
        weapon_assaultsmg = `COMPONENT_ASSAULTSMG_VARMOD_LOWRIDER`,
        weapon_microsmg = `COMPONENT_MICROSMG_VARMOD_LUXE`,
        weapon_pumpshotgun = `COMPONENT_PUMPSHOTGUN_VARMOD_LOWRIDER`,
        weapon_sawnoffshotgun = `COMPONENT_SAWNOFFSHOTGUN_VARMOD_LUXE`,
        weapon_assaultrifle = `COMPONENT_ASSAULTRIFLE_VARMOD_LUXE`,
        weapon_carbinerifle = `COMPONENT_CARBINERIFLE_VARMOD_LUXE`,
        weapon_advancedrifle = `COMPONENT_ADVANCEDRIFLE_VARMOD_LUXE`,
        weapon_specialcarbine = `COMPONENT_SPECIALCARBINE_VARMOD_LOWRIDER`,
        weapon_bullpuprifle = `COMPONENT_BULLPUPRIFLE_VARMOD_LOW`,
        weapon_heavyrifle = `COMPONENT_BULLPUPRIFLE_VARMOD_LOW`,
        weapon_mg = `COMPONENT_MG_VARMOD_LOWRIDER`,
        weapon_combatmg = `COMPONENT_COMBATMG_VARMOD_LOWRIDER`,
        weapon_sniperrifle = `COMPONENT_SNIPERRIFLE_VARMOD_LUXE`,
        weapon_marksmanrifle = `COMPONENT_MARKSMANRIFLE_VARMOD_LUXE`,
    },
    digicamo_attachment = {
        weapon_snspistol_mk2 = `COMPONENT_SNSPISTOL_MK2_CAMO`,
        weapon_pistol_mk2 = `COMPONENT_PISTOL_MK2_CAMO`,
        weapon_smg_mk2 = `COMPONENT_REVOLVER_MK2_CAMO`,
        weapon_pumpshotgun_mk2 = `COMPONENT_PUMPSHOTGUN_MK2_CAMO`,
        weapon_bullpuprifle_mk2 = `COMPONENT_BULLPUPRIFLE_MK2_CAMO`,
        weapon_specialcarbine_mk2 = `COMPONENT_SPECIALCARBINE_MK2_CAMO`,
        weapon_assaultrifle_mk2 = `COMPONENT_ASSAULTRIFLE_MK2_CAMO`,
        weapon_carbinerifle_mk2 = `COMPONENT_CARBINERIFLE_MK2_CAMO`,
        weapon_combatmg_mk2 = `COMPONENT_COMBATMG_MK2_CAMO`,
        weapon_marksmanrifle_mk2 = `COMPONENT_MARKSMANRIFLE_MK2_CAMO`,
        weapon_heavysniper_mk2 = `COMPONENT_HEAVYSNIPER_MK2_CAMO`,
    },
    brushcamo_attachment = {
        weapon_snspistol_mk2 = `COMPONENT_SNSPISTOL_MK2_CAMO_02`,
        weapon_pistol_mk2 = `COMPONENT_PISTOL_MK2_CAMO_02`,
        weapon_smg_mk2 = `COMPONENT_REVOLVER_MK2_CAMO_02`,
        weapon_pumpshotgun_mk2 = `COMPONENT_PUMPSHOTGUN_MK2_CAMO_02`,
        weapon_bullpuprifle_mk2 = `COMPONENT_BULLPUPRIFLE_MK2_CAMO_02`,
        weapon_specialcarbine_mk2 = `COMPONENT_SPECIALCARBINE_MK2_CAMO_02`,
        weapon_assaultrifle_mk2 = `COMPONENT_ASSAULTRIFLE_MK2_CAMO_02`,
        weapon_carbinerifle_mk2 = `COMPONENT_CARBINERIFLE_MK2_CAMO_02`,
        weapon_combatmg_mk2 = `COMPONENT_COMBATMG_MK2_CAMO_02`,
        weapon_marksmanrifle_mk2 = `COMPONENT_MARKSMANRIFLE_MK2_CAMO_02`,
        weapon_heavysniper_mk2 = `COMPONENT_HEAVYSNIPER_MK2_CAMO_02`,
    },
    woodcamo_attachment = {
        weapon_snspistol_mk2 = `COMPONENT_SNSPISTOL_MK2_CAMO_03`,
        weapon_pistol_mk2 = `COMPONENT_PISTOL_MK2_CAMO_03`,
        weapon_smg_mk2 = `COMPONENT_REVOLVER_MK2_CAMO_03`,
        weapon_pumpshotgun_mk2 = `COMPONENT_PUMPSHOTGUN_MK2_CAMO_03`,
        weapon_bullpuprifle_mk2 = `COMPONENT_BULLPUPRIFLE_MK2_CAMO_03`,
        weapon_specialcarbine_mk2 = `COMPONENT_SPECIALCARBINE_MK2_CAMO_03`,
        weapon_assaultrifle_mk2 = `COMPONENT_ASSAULTRIFLE_MK2_CAMO_03`,
        weapon_carbinerifle_mk2 = `COMPONENT_CARBINERIFLE_MK2_CAMO_03`,
        weapon_combatmg_mk2 = `COMPONENT_COMBATMG_MK2_CAMO_03`,
        weapon_marksmanrifle_mk2 = `COMPONENT_MARKSMANRIFLE_MK2_CAMO_03`,
        weapon_heavysniper_mk2 = `COMPONENT_HEAVYSNIPER_MK2_CAMO_03`,
    },
    skullcamo_attachment = {
        weapon_snspistol_mk2 = `COMPONENT_SNSPISTOL_MK2_CAMO_04`,
        weapon_pistol_mk2 = `COMPONENT_PISTOL_MK2_CAMO_04`,
        weapon_smg_mk2 = `COMPONENT_REVOLVER_MK2_CAMO_04`,
        weapon_pumpshotgun_mk2 = `COMPONENT_PUMPSHOTGUN_MK2_CAMO_04`,
        weapon_bullpuprifle_mk2 = `COMPONENT_BULLPUPRIFLE_MK2_CAMO_04`,
        weapon_specialcarbine_mk2 = `COMPONENT_SPECIALCARBINE_MK2_CAMO_04`,
        weapon_assaultrifle_mk2 = `COMPONENT_ASSAULTRIFLE_MK2_CAMO_04`,
        weapon_carbinerifle_mk2 = `COMPONENT_CARBINERIFLE_MK2_CAMO_04`,
        weapon_combatmg_mk2 = `COMPONENT_COMBATMG_MK2_CAMO_04`,
        weapon_marksmanrifle_mk2 = `COMPONENT_MARKSMANRIFLE_MK2_CAMO_04`,
        weapon_heavysniper_mk2 = `COMPONENT_HEAVYSNIPER_MK2_CAMO_04`,
    },
    sessantacamo_attachment = {
        weapon_snspistol_mk2 = `COMPONENT_SNSPISTOL_MK2_CAMO_05`,
        weapon_pistol_mk2 = `COMPONENT_PISTOL_MK2_CAMO_05`,
        weapon_smg_mk2 = `COMPONENT_REVOLVER_MK2_CAMO_05`,
        weapon_pumpshotgun_mk2 = `COMPONENT_PUMPSHOTGUN_MK2_CAMO_05`,
        weapon_bullpuprifle_mk2 = `COMPONENT_BULLPUPRIFLE_MK2_CAMO_05`,
        weapon_specialcarbine_mk2 = `COMPONENT_SPECIALCARBINE_MK2_CAMO_05`,
        weapon_assaultrifle_mk2 = `COMPONENT_ASSAULTRIFLE_MK2_CAMO_05`,
        weapon_carbinerifle_mk2 = `COMPONENT_CARBINERIFLE_MK2_CAMO_05`,
        weapon_combatmg_mk2 = `COMPONENT_COMBATMG_MK2_CAMO_05`,
        weapon_marksmanrifle_mk2 = `COMPONENT_MARKSMANRIFLE_MK2_CAMO_05`,
        weapon_heavysniper_mk2 = `COMPONENT_HEAVYSNIPER_MK2_CAMO_05`,
    },
    perseuscamo_attachment = {
        weapon_snspistol_mk2 = `COMPONENT_SNSPISTOL_MK2_CAMO_06`,
        weapon_pistol_mk2 = `COMPONENT_PISTOL_MK2_CAMO_06`,
        weapon_smg_mk2 = `COMPONENT_REVOLVER_MK2_CAMO_06`,
        weapon_pumpshotgun_mk2 = `COMPONENT_PUMPSHOTGUN_MK2_CAMO_06`,
        weapon_bullpuprifle_mk2 = `COMPONENT_BULLPUPRIFLE_MK2_CAMO_06`,
        weapon_specialcarbine_mk2 = `COMPONENT_SPECIALCARBINE_MK2_CAMO_06`,
        weapon_assaultrifle_mk2 = `COMPONENT_ASSAULTRIFLE_MK2_CAMO_06`,
        weapon_carbinerifle_mk2 = `COMPONENT_CARBINERIFLE_MK2_CAMO_06`,
        weapon_combatmg_mk2 = `COMPONENT_COMBATMG_MK2_CAMO_06`,
        weapon_marksmanrifle_mk2 = `COMPONENT_MARKSMANRIFLE_MK2_CAMO_06`,
        weapon_heavysniper_mk2 = `COMPONENT_HEAVYSNIPER_MK2_CAMO_06`,
    },
    leopardcamo_attachment = {
        weapon_snspistol_mk2 = `COMPONENT_SNSPISTOL_MK2_CAMO_07`,
        weapon_pistol_mk2 = `COMPONENT_PISTOL_MK2_CAMO_07`,
        weapon_smg_mk2 = `COMPONENT_REVOLVER_MK2_CAMO_07`,
        weapon_pumpshotgun_mk2 = `COMPONENT_PUMPSHOTGUN_MK2_CAMO_07`,
        weapon_bullpuprifle_mk2 = `COMPONENT_BULLPUPRIFLE_MK2_CAMO_07`,
        weapon_specialcarbine_mk2 = `COMPONENT_SPECIALCARBINE_MK2_CAMO_07`,
        weapon_assaultrifle_mk2 = `COMPONENT_ASSAULTRIFLE_MK2_CAMO_07`,
        weapon_carbinerifle_mk2 = `COMPONENT_CARBINERIFLE_MK2_CAMO_07`,
        weapon_combatmg_mk2 = `COMPONENT_COMBATMG_MK2_CAMO_07`,
        weapon_marksmanrifle_mk2 = `COMPONENT_MARKSMANRIFLE_MK2_CAMO_07`,
        weapon_heavysniper_mk2 = `COMPONENT_HEAVYSNIPER_MK2_CAMO_07`,
    },
    zebracamo_attachment = {
        weapon_snspistol_mk2 = `COMPONENT_SNSPISTOL_MK2_CAMO_08`,
        weapon_pistol_mk2 = `COMPONENT_PISTOL_MK2_CAMO_08`,
        weapon_smg_mk2 = `COMPONENT_REVOLVER_MK2_CAMO_08`,
        weapon_pumpshotgun_mk2 = `COMPONENT_PUMPSHOTGUN_MK2_CAMO_08`,
        weapon_bullpuprifle_mk2 = `COMPONENT_BULLPUPRIFLE_MK2_CAMO_08`,
        weapon_specialcarbine_mk2 = `COMPONENT_SPECIALCARBINE_MK2_CAMO_08`,
        weapon_assaultrifle_mk2 = `COMPONENT_ASSAULTRIFLE_MK2_CAMO_08`,
        weapon_carbinerifle_mk2 = `COMPONENT_CARBINERIFLE_MK2_CAMO_08`,
        weapon_combatmg_mk2 = `COMPONENT_COMBATMG_MK2_CAMO_08`,
        weapon_marksmanrifle_mk2 = `COMPONENT_MARKSMANRIFLE_MK2_CAMO_08`,
        weapon_heavysniper_mk2 = `COMPONENT_HEAVYSNIPER_MK2_CAMO_08`,
    },
    geocamo_attachment = {
        weapon_snspistol_mk2 = `COMPONENT_SNSPISTOL_MK2_CAMO_09`,
        weapon_pistol_mk2 = `COMPONENT_PISTOL_MK2_CAMO_09`,
        weapon_smg_mk2 = `COMPONENT_REVOLVER_MK2_CAMO_09`,
        weapon_pumpshotgun_mk2 = `COMPONENT_PUMPSHOTGUN_MK2_CAMO_09`,
        weapon_bullpuprifle_mk2 = `COMPONENT_BULLPUPRIFLE_MK2_CAMO_09`,
        weapon_specialcarbine_mk2 = `COMPONENT_SPECIALCARBINE_MK2_CAMO_09`,
        weapon_assaultrifle_mk2 = `COMPONENT_ASSAULTRIFLE_MK2_CAMO_09`,
        weapon_carbinerifle_mk2 = `COMPONENT_CARBINERIFLE_MK2_CAMO_09`,
        weapon_combatmg_mk2 = `COMPONENT_COMBATMG_MK2_CAMO_09`,
        weapon_marksmanrifle_mk2 = `COMPONENT_MARKSMANRIFLE_MK2_CAMO_09`,
        weapon_heavysniper_mk2 = `COMPONENT_HEAVYSNIPER_MK2_CAMO_09`,
    },
    boomcamo_attachment = {
        weapon_snspistol_mk2 = `COMPONENT_SNSPISTOL_MK2_CAMO_10`,
        weapon_pistol_mk2 = `COMPONENT_PISTOL_MK2_CAMO_10`,
        weapon_smg_mk2 = `COMPONENT_REVOLVER_MK2_CAMO_10`,
        weapon_pumpshotgun_mk2 = `COMPONENT_PUMPSHOTGUN_MK2_CAMO_10`,
        weapon_bullpuprifle_mk2 = `COMPONENT_BULLPUPRIFLE_MK2_CAMO_10`,
        weapon_specialcarbine_mk2 = `COMPONENT_SPECIALCARBINE_MK2_CAMO_10`,
        weapon_assaultrifle_mk2 = `COMPONENT_ASSAULTRIFLE_MK2_CAMO_10`,
        weapon_carbinerifle_mk2 = `COMPONENT_CARBINERIFLE_MK2_CAMO_10`,
        weapon_combatmg_mk2 = `COMPONENT_COMBATMG_MK2_CAMO_10`,
        weapon_marksmanrifle_mk2 = `COMPONENT_MARKSMANRIFLE_MK2_CAMO_10`,
        weapon_heavysniper_mk2 = `COMPONENT_HEAVYSNIPER_MK2_CAMO_10`,
    },
    patriotcamo_attachment = {
        weapon_heavyrifle_mk2 = `COMPONENT_REVOLVER_MK2_CAMO_IND_01`,
        weapon_snspistol_mk2 = `COMPONENT_SNSPISTOL_MK2_CAMO_IND_01`,
        weapon_pistol_mk2 = `COMPONENT_PISTOL_MK2_CAMO_IND_01`,
        weapon_smg_mk2 = `COMPONENT_REVOLVER_MK2_CAMO_IND_01`,
        weapon_pumpshotgun_mk2 = `COMPONENT_PUMPSHOTGUN_MK2_CAMO_IND_01`,
        weapon_bullpuprifle_mk2 = `COMPONENT_BULLPUPRIFLE_MK2_CAMO_IND_01`,
        weapon_specialcarbine_mk2 = `COMPONENT_SPECIALCARBINE_MK2_CAMO_IND_01`,
        weapon_assaultrifle_mk2 = `COMPONENT_ASSAULTRIFLE_MK2_CAMO_IND_01`,
        weapon_carbinerifle_mk2 = `COMPONENT_CARBINERIFLE_MK2_CAMO_IND_01`,
        weapon_combatmg_mk2 = `COMPONENT_COMBATMG_MK2_CAMO_IND_01`,
        weapon_marksmanrifle_mk2 = `COMPONENT_MARKSMANRIFLE_MK2_CAMO_IND_01`,
        weapon_heavysniper_mk2 = `COMPONENT_HEAVYSNIPER_MK2_CAMO_IND_01`,
    },
    weapontint_0 = {
        weapon_pistol = 0,
        weapon_combatpistol = 0,
        weapon_appistol = 0,
        weapon_pistol50 = 0,
        weapon_snspistol = 0, 
        weapon_heavypistol = 0,
        weapon_vintagepistol = 0,
        weapon_ceramicpistol = 0,
        weapon_microsmg = 0,
        weapon_smg = 0,
        weapon_assaultsmg = 0,
        weapon_minismg = 0, 
        weapon_machinepistol = 0,
        weapon_combatpdw = 0,
        weapon_assaultshotgun = 0,
        weapon_heavyshotgun = 0,
        weapon_assaultrifle = 0,
        weapon_carbinerifle = 0,
        weapon_advancedrifle = 0,
        weapon_specialcarbine = 0,
        weapon_bullpuprifle = 0,
        weapon_compactrifle = 0,
        weapon_militaryrifle = 0,
        weapon_heavyrifle = 0,
        weapon_mg = 0,
        weapon_combatmg = 0, 
        weapon_gusenberg = 0,
        weapon_marksmanrifle = 0,
    },
    weapontint_1 = {
        weapon_pistol = 1,
        weapon_combatpistol = 1,
        weapon_appistol = 1,
        weapon_pistol51 = 1,
        weapon_snspistol = 1, 
        weapon_heavypistol = 1,
        weapon_vintagepistol = 1,
        weapon_ceramicpistol = 1,
        weapon_microsmg = 1,
        weapon_smg = 1,
        weapon_assaultsmg = 1,
        weapon_minismg = 1, 
        weapon_machinepistol = 1,
        weapon_combatpdw = 1,
        weapon_assaultshotgun = 1,
        weapon_heavyshotgun = 1,
        weapon_assaultrifle = 1,
        weapon_carbinerifle = 1,
        weapon_advancedrifle = 1,
        weapon_specialcarbine = 1,
        weapon_bullpuprifle = 1,
        weapon_compactrifle = 1,
        weapon_militaryrifle = 1,
        weapon_heavyrifle = 1,
        weapon_mg = 1,
        weapon_combatmg = 1, 
        weapon_gusenberg = 1,
        weapon_marksmanrifle = 1,
    },
    weapontint_2 = {
        weapon_pistol = 2,
        weapon_combatpistol = 2,
        weapon_appistol = 2,
        weapon_pistol52 = 2,
        weapon_snspistol = 2, 
        weapon_heavypistol = 2,
        weapon_vintagepistol = 2,
        weapon_ceramicpistol = 2,
        weapon_microsmg = 2,
        weapon_smg = 2,
        weapon_assaultsmg = 2,
        weapon_minismg = 2, 
        weapon_machinepistol = 2,
        weapon_combatpdw = 2,
        weapon_assaultshotgun = 2,
        weapon_heavyshotgun = 2,
        weapon_assaultrifle = 2,
        weapon_carbinerifle = 2,
        weapon_advancedrifle = 2,
        weapon_specialcarbine = 2,
        weapon_bullpuprifle = 2,
        weapon_compactrifle = 2,
        weapon_militaryrifle = 2,
        weapon_heavyrifle = 2,
        weapon_mg = 2,
        weapon_combatmg = 2, 
        weapon_gusenberg = 2,
        weapon_marksmanrifle = 2,
    },
    weapontint_3 = {
        weapon_pistol = 3,
        weapon_combatpistol = 3,
        weapon_appistol = 3,
        weapon_pistol53 = 3,
        weapon_snspistol = 3, 
        weapon_heavypistol = 3,
        weapon_vintagepistol = 3,
        weapon_ceramicpistol = 3,
        weapon_microsmg = 3,
        weapon_smg = 3,
        weapon_assaultsmg = 3,
        weapon_minismg = 3, 
        weapon_machinepistol = 3,
        weapon_combatpdw = 3,
        weapon_assaultshotgun = 3,
        weapon_heavyshotgun = 3,
        weapon_assaultrifle = 3,
        weapon_carbinerifle = 3,
        weapon_advancedrifle = 3,
        weapon_specialcarbine = 3,
        weapon_bullpuprifle = 3,
        weapon_compactrifle = 3,
        weapon_militaryrifle = 3,
        weapon_heavyrifle = 3,
        weapon_mg = 3,
        weapon_combatmg = 3, 
        weapon_gusenberg = 3,
        weapon_marksmanrifle = 3,
    },
    weapontint_4 = {
        weapon_pistol = 4,
        weapon_combatpistol = 4,
        weapon_appistol = 4,
        weapon_pistol54 = 4,
        weapon_snspistol = 4, 
        weapon_heavypistol = 4,
        weapon_vintagepistol = 4,
        weapon_ceramicpistol = 4,
        weapon_microsmg = 4,
        weapon_smg = 4,
        weapon_assaultsmg = 4,
        weapon_minismg = 4, 
        weapon_machinepistol = 4,
        weapon_combatpdw = 4,
        weapon_assaultshotgun = 4,
        weapon_heavyshotgun = 4,
        weapon_assaultrifle = 4,
        weapon_carbinerifle = 4,
        weapon_advancedrifle = 4,
        weapon_specialcarbine = 4,
        weapon_bullpuprifle = 4,
        weapon_compactrifle = 4,
        weapon_militaryrifle = 4,
        weapon_heavyrifle = 4,
        weapon_mg = 4,
        weapon_combatmg = 4, 
        weapon_gusenberg = 4,
        weapon_marksmanrifle = 4,
    },
    weapontint_5 = {
        weapon_pistol = 5,
        weapon_combatpistol = 5,
        weapon_appistol = 5,
        weapon_pistol55 = 5,
        weapon_snspistol = 5, 
        weapon_heavypistol = 5,
        weapon_vintagepistol = 5,
        weapon_ceramicpistol = 5,
        weapon_microsmg = 5,
        weapon_smg = 5,
        weapon_assaultsmg = 5,
        weapon_minismg = 5, 
        weapon_machinepistol = 5,
        weapon_combatpdw = 5,
        weapon_assaultshotgun = 5,
        weapon_heavyshotgun = 5,
        weapon_assaultrifle = 5,
        weapon_carbinerifle = 5,
        weapon_advancedrifle = 5,
        weapon_specialcarbine = 5,
        weapon_bullpuprifle = 5,
        weapon_compactrifle = 5,
        weapon_militaryrifle = 5,
        weapon_heavyrifle = 5,
        weapon_mg = 5,
        weapon_combatmg = 5, 
        weapon_gusenberg = 5,
        weapon_marksmanrifle = 5,
    },
    weapontint_6 = {
        weapon_pistol = 6,
        weapon_combatpistol = 6,
        weapon_appistol = 6,
        weapon_pistol56 = 6,
        weapon_snspistol = 6, 
        weapon_heavypistol = 6,
        weapon_vintagepistol = 6,
        weapon_ceramicpistol = 6,
        weapon_microsmg = 6,
        weapon_smg = 6,
        weapon_assaultsmg = 6,
        weapon_minismg = 6, 
        weapon_machinepistol = 6,
        weapon_combatpdw = 6,
        weapon_assaultshotgun = 6,
        weapon_heavyshotgun = 6,
        weapon_assaultrifle = 6,
        weapon_carbinerifle = 6,
        weapon_advancedrifle = 6,
        weapon_specialcarbine = 6,
        weapon_bullpuprifle = 6,
        weapon_compactrifle = 6,
        weapon_militaryrifle = 6,
        weapon_heavyrifle = 6,
        weapon_mg = 6,
        weapon_combatmg = 6, 
        weapon_gusenberg = 6,
        weapon_marksmanrifle = 6,
    },
    weapontint_7 = {
        weapon_pistol = 7,
        weapon_combatpistol = 7,
        weapon_appistol = 7,
        weapon_pistol57 = 7,
        weapon_snspistol = 7, 
        weapon_heavypistol = 7,
        weapon_vintagepistol = 7,
        weapon_ceramicpistol = 7,
        weapon_microsmg = 7,
        weapon_smg = 7,
        weapon_assaultsmg = 7,
        weapon_minismg = 7, 
        weapon_machinepistol = 7,
        weapon_combatpdw = 7,
        weapon_assaultshotgun = 7,
        weapon_heavyshotgun = 7,
        weapon_assaultrifle = 7,
        weapon_carbinerifle = 7,
        weapon_advancedrifle = 7,
        weapon_specialcarbine = 7,
        weapon_bullpuprifle = 7,
        weapon_compactrifle = 7,
        weapon_militaryrifle = 7,
        weapon_heavyrifle = 7,
        weapon_mg = 7,
        weapon_combatmg = 7, 
        weapon_gusenberg = 7,
        weapon_marksmanrifle = 7,
    },
    weapontint_mk2_0 = {
        weapon_pistol_mk2 = 0,
        weapon_snspistol_mk2 = 0,
        weapon_smg_mk2 = 0,
        weapon_bullpuprifle_mk2 = 0,
        weapon_specialcarbine_mk2 = 0,
        weapon_assaultrifle_mk2 = 0,
        weapon_carbinerifle_mk2 = 0,
        weapon_combatmg_mk2 = 0,
        weapon_marksmanrifle_mk2 = 0,
        weapon_heavysniper_mk2 = 0,
    },
    weapontint_mk2_1 = {
        weapon_pistol_mk2 = 1,
        weapon_snspistol_mk2 = 1,
        weapon_smg_mk2 = 1,
        weapon_bullpuprifle_mk2 = 1,
        weapon_specialcarbine_mk2 = 1,
        weapon_assaultrifle_mk2 = 1,
        weapon_carbinerifle_mk2 = 1,
        weapon_combatmg_mk2 = 1,
        weapon_marksmanrifle_mk2 = 1,
        weapon_heavysniper_mk2 = 1,
    },
    weapontint_mk2_2 = {
        weapon_pistol_mk2 = 2,
        weapon_snspistol_mk2 = 2,
        weapon_smg_mk2 = 2,
        weapon_bullpuprifle_mk2 = 2,
        weapon_specialcarbine_mk2 = 2,
        weapon_assaultrifle_mk2 = 2,
        weapon_carbinerifle_mk2 = 2,
        weapon_combatmg_mk2 = 2,
        weapon_marksmanrifle_mk2 = 2,
        weapon_heavysniper_mk2 = 2,
    },
    weapontint_mk2_3 = {
        weapon_pistol_mk2 = 3,
        weapon_snspistol_mk2 = 3,
        weapon_smg_mk2 = 3,
        weapon_bullpuprifle_mk2 = 3,
        weapon_specialcarbine_mk2 = 3,
        weapon_assaultrifle_mk2 = 3,
        weapon_carbinerifle_mk2 = 3,
        weapon_combatmg_mk2 = 3,
        weapon_marksmanrifle_mk2 = 3,
        weapon_heavysniper_mk2 = 3,
    },
    weapontint_mk2_4 = {
        weapon_pistol_mk2 = 4,
        weapon_snspistol_mk2 = 4,
        weapon_smg_mk2 = 4,
        weapon_bullpuprifle_mk2 = 4,
        weapon_specialcarbine_mk2 = 4,
        weapon_assaultrifle_mk2 = 4,
        weapon_carbinerifle_mk2 = 4,
        weapon_combatmg_mk2 = 4,
        weapon_marksmanrifle_mk2 = 4,
        weapon_heavysniper_mk2 = 4,
    },
    weapontint_mk2_5 = {
        weapon_pistol_mk2 = 5,
        weapon_snspistol_mk2 = 5,
        weapon_smg_mk2 = 5,
        weapon_bullpuprifle_mk2 = 5,
        weapon_specialcarbine_mk2 = 5,
        weapon_assaultrifle_mk2 = 5,
        weapon_carbinerifle_mk2 = 5,
        weapon_combatmg_mk2 = 5,
        weapon_marksmanrifle_mk2 = 5,
        weapon_heavysniper_mk2 = 5,
    },
    weapontint_mk2_6 = {
        weapon_pistol_mk2 = 6,
        weapon_snspistol_mk2 = 6,
        weapon_smg_mk2 = 6,
        weapon_bullpuprifle_mk2 = 6,
        weapon_specialcarbine_mk2 = 6,
        weapon_assaultrifle_mk2 = 6,
        weapon_carbinerifle_mk2 = 6,
        weapon_combatmg_mk2 = 6,
        weapon_marksmanrifle_mk2 = 6,
        weapon_heavysniper_mk2 = 6,
    },
    weapontint_mk2_7 = {
        weapon_pistol_mk2 = 7,
        weapon_snspistol_mk2 = 7,
        weapon_smg_mk2 = 7,
        weapon_bullpuprifle_mk2 = 7,
        weapon_specialcarbine_mk2 = 7,
        weapon_assaultrifle_mk2 = 7,
        weapon_carbinerifle_mk2 = 7,
        weapon_combatmg_mk2 = 7,
        weapon_marksmanrifle_mk2 = 7,
        weapon_heavysniper_mk2 = 7,
    },
    weapontint_mk2_8 = {
        weapon_pistol_mk2 = 8,
        weapon_snspistol_mk2 = 8,
        weapon_smg_mk2 = 8,
        weapon_bullpuprifle_mk2 = 8,
        weapon_specialcarbine_mk2 = 8,
        weapon_assaultrifle_mk2 = 8,
        weapon_carbinerifle_mk2 = 8,
        weapon_combatmg_mk2 = 8,
        weapon_marksmanrifle_mk2 = 8,
        weapon_heavysniper_mk2 = 8,
    },
    weapontint_mk2_9 = {
        weapon_pistol_mk2 = 9,
        weapon_snspistol_mk2 = 9,
        weapon_smg_mk2 = 9,
        weapon_bullpuprifle_mk2 = 9,
        weapon_specialcarbine_mk2 = 9,
        weapon_assaultrifle_mk2 = 9,
        weapon_carbinerifle_mk2 = 9,
        weapon_combatmg_mk2 = 9,
        weapon_marksmanrifle_mk2 = 9,
        weapon_heavysniper_mk2 = 9,
    },
    weapontint_mk2_10 = {
        weapon_pistol_mk2 = 10,
        weapon_snspistol_mk2 = 10,
        weapon_smg_mk2 = 10,
        weapon_bullpuprifle_mk2 = 10,
        weapon_specialcarbine_mk2 = 10,
        weapon_assaultrifle_mk2 = 10,
        weapon_carbinerifle_mk2 = 10,
        weapon_combatmg_mk2 = 10,
        weapon_marksmanrifle_mk2 = 10,
        weapon_heavysniper_mk2 = 10,
    },
    weapontint_mk2_11 = {
        weapon_pistol_mk2 = 11,
        weapon_snspistol_mk2 = 11,
        weapon_smg_mk2 = 11,
        weapon_bullpuprifle_mk2 = 11,
        weapon_specialcarbine_mk2 = 11,
        weapon_assaultrifle_mk2 = 11,
        weapon_carbinerifle_mk2 = 11,
        weapon_combatmg_mk2 = 11,
        weapon_marksmanrifle_mk2 = 11,
        weapon_heavysniper_mk2 = 11,
    },
    weapontint_mk2_12 = {
        weapon_pistol_mk2 = 12,
        weapon_snspistol_mk2 = 12,
        weapon_smg_mk2 = 12,
        weapon_bullpuprifle_mk2 = 12,
        weapon_specialcarbine_mk2 = 12,
        weapon_assaultrifle_mk2 = 12,
        weapon_carbinerifle_mk2 = 12,
        weapon_combatmg_mk2 = 12,
        weapon_marksmanrifle_mk2 = 12,
        weapon_heavysniper_mk2 = 12,
    },
    weapontint_mk2_13 = {
        weapon_pistol_mk2 = 13,
        weapon_snspistol_mk2 = 13,
        weapon_smg_mk2 = 13,
        weapon_bullpuprifle_mk2 = 13,
        weapon_specialcarbine_mk2 = 13,
        weapon_assaultrifle_mk2 = 13,
        weapon_carbinerifle_mk2 = 13,
        weapon_combatmg_mk2 = 13,
        weapon_marksmanrifle_mk2 = 13,
        weapon_heavysniper_mk2 = 13,
    },
    weapontint_mk2_14 = {
        weapon_pistol_mk2 = 14,
        weapon_snspistol_mk2 = 14,
        weapon_smg_mk2 = 14,
        weapon_bullpuprifle_mk2 = 14,
        weapon_specialcarbine_mk2 = 14,
        weapon_assaultrifle_mk2 = 14,
        weapon_carbinerifle_mk2 = 14,
        weapon_combatmg_mk2 = 14,
        weapon_marksmanrifle_mk2 = 14,
        weapon_heavysniper_mk2 = 14,
    },
    weapontint_mk2_15 = {
        weapon_pistol_mk2 = 15,
        weapon_snspistol_mk2 = 15,
        weapon_smg_mk2 = 15,
        weapon_bullpuprifle_mk2 = 15,
        weapon_specialcarbine_mk2 = 15,
        weapon_assaultrifle_mk2 = 15,
        weapon_carbinerifle_mk2 = 15,
        weapon_combatmg_mk2 = 15,
        weapon_marksmanrifle_mk2 = 15,
        weapon_heavysniper_mk2 = 15,
    },
    weapontint_mk2_16 = {
        weapon_pistol_mk2 = 16,
        weapon_snspistol_mk2 = 16,
        weapon_smg_mk2 = 16,
        weapon_bullpuprifle_mk2 = 16,
        weapon_specialcarbine_mk2 = 16,
        weapon_assaultrifle_mk2 = 16,
        weapon_carbinerifle_mk2 = 16,
        weapon_combatmg_mk2 = 16,
        weapon_marksmanrifle_mk2 = 16,
        weapon_heavysniper_mk2 = 16,
    },
    weapontint_mk2_17 = {
        weapon_pistol_mk2 = 17,
        weapon_snspistol_mk2 = 17,
        weapon_smg_mk2 = 17,
        weapon_bullpuprifle_mk2 = 17,
        weapon_specialcarbine_mk2 = 17,
        weapon_assaultrifle_mk2 = 17,
        weapon_carbinerifle_mk2 = 17,
        weapon_combatmg_mk2 = 17,
        weapon_marksmanrifle_mk2 = 17,
        weapon_heavysniper_mk2 = 17,
    },
    weapontint_mk2_18 = {
        weapon_pistol_mk2 = 18,
        weapon_snspistol_mk2 = 18,
        weapon_smg_mk2 = 18,
        weapon_bullpuprifle_mk2 = 18,
        weapon_specialcarbine_mk2 = 18,
        weapon_assaultrifle_mk2 = 18,
        weapon_carbinerifle_mk2 = 18,
        weapon_combatmg_mk2 = 18,
        weapon_marksmanrifle_mk2 = 18,
        weapon_heavysniper_mk2 = 18,
    },
    weapontint_mk2_19 = {
        weapon_pistol_mk2 = 19,
        weapon_snspistol_mk2 = 19,
        weapon_smg_mk2 = 19,
        weapon_bullpuprifle_mk2 = 19,
        weapon_specialcarbine_mk2 = 19,
        weapon_assaultrifle_mk2 = 19,
        weapon_carbinerifle_mk2 = 19,
        weapon_combatmg_mk2 = 19,
        weapon_marksmanrifle_mk2 = 19,
        weapon_heavysniper_mk2 = 19,
    },
    weapontint_mk2_20 = {
        weapon_pistol_mk2 = 20,
        weapon_snspistol_mk2 = 20,
        weapon_smg_mk2 = 20,
        weapon_bullpuprifle_mk2 = 20,
        weapon_specialcarbine_mk2 = 20,
        weapon_assaultrifle_mk2 = 20,
        weapon_carbinerifle_mk2 = 20,
        weapon_combatmg_mk2 = 20,
        weapon_marksmanrifle_mk2 = 20,
        weapon_heavysniper_mk2 = 20,
    },
    weapontint_mk2_21 = {
        weapon_pistol_mk2 = 21,
        weapon_snspistol_mk2 = 21,
        weapon_smg_mk2 = 21,
        weapon_bullpuprifle_mk2 = 21,
        weapon_specialcarbine_mk2 = 21,
        weapon_assaultrifle_mk2 = 21,
        weapon_carbinerifle_mk2 = 21,
        weapon_combatmg_mk2 = 21,
        weapon_marksmanrifle_mk2 = 21,
        weapon_heavysniper_mk2 = 21,
    },
    weapontint_mk2_22 = {
        weapon_pistol_mk2 = 22,
        weapon_snspistol_mk2 = 22,
        weapon_smg_mk2 = 22,
        weapon_bullpuprifle_mk2 = 22,
        weapon_specialcarbine_mk2 = 22,
        weapon_assaultrifle_mk2 = 22,
        weapon_carbinerifle_mk2 = 22,
        weapon_combatmg_mk2 = 22,
        weapon_marksmanrifle_mk2 = 22,
        weapon_heavysniper_mk2 = 22,
    },
    weapontint_mk2_23 = {
        weapon_pistol_mk2 = 23,
        weapon_snspistol_mk2 = 23,
        weapon_smg_mk2 = 23,
        weapon_bullpuprifle_mk2 = 23,
        weapon_specialcarbine_mk2 = 23,
        weapon_assaultrifle_mk2 = 23,
        weapon_carbinerifle_mk2 = 23,
        weapon_combatmg_mk2 = 23,
        weapon_marksmanrifle_mk2 = 23,
        weapon_heavysniper_mk2 = 23,
    },
    weapontint_mk2_24 = {
        weapon_pistol_mk2 = 24,
        weapon_snspistol_mk2 = 24,
        weapon_smg_mk2 = 24,
        weapon_bullpuprifle_mk2 = 24,
        weapon_specialcarbine_mk2 = 24,
        weapon_assaultrifle_mk2 = 24,
        weapon_carbinerifle_mk2 = 24,
        weapon_combatmg_mk2 = 24,
        weapon_marksmanrifle_mk2 = 24,
        weapon_heavysniper_mk2 = 24,
    },
    weapontint_mk2_25 = {
        weapon_pistol_mk2 = 25,
        weapon_snspistol_mk2 = 25,
        weapon_smg_mk2 = 25,
        weapon_bullpuprifle_mk2 = 25,
        weapon_specialcarbine_mk2 = 25,
        weapon_assaultrifle_mk2 = 25,
        weapon_carbinerifle_mk2 = 25,
        weapon_combatmg_mk2 = 25,
        weapon_marksmanrifle_mk2 = 25,
        weapon_heavysniper_mk2 = 25,
    },
    weapontint_mk2_26 = {
        weapon_pistol_mk2 = 26,
        weapon_snspistol_mk2 = 26,
        weapon_smg_mk2 = 26,
        weapon_bullpuprifle_mk2 = 26,
        weapon_specialcarbine_mk2 = 26,
        weapon_assaultrifle_mk2 = 26,
        weapon_carbinerifle_mk2 = 26,
        weapon_combatmg_mk2 = 26,
        weapon_marksmanrifle_mk2 = 26,
        weapon_heavysniper_mk2 = 26,
    },
    weapontint_mk2_27 = {
        weapon_pistol_mk2 = 27,
        weapon_snspistol_mk2 = 27,
        weapon_smg_mk2 = 27,
        weapon_bullpuprifle_mk2 = 27,
        weapon_specialcarbine_mk2 = 27,
        weapon_assaultrifle_mk2 = 27,
        weapon_carbinerifle_mk2 = 27,
        weapon_combatmg_mk2 = 27,
        weapon_marksmanrifle_mk2 = 27,
        weapon_heavysniper_mk2 = 27,
    },
    weapontint_mk2_28 = {
        weapon_pistol_mk2 = 28,
        weapon_snspistol_mk2 = 28,
        weapon_smg_mk2 = 28,
        weapon_bullpuprifle_mk2 = 28,
        weapon_specialcarbine_mk2 = 28,
        weapon_assaultrifle_mk2 = 28,
        weapon_carbinerifle_mk2 = 28,
        weapon_combatmg_mk2 = 28,
        weapon_marksmanrifle_mk2 = 28,
        weapon_heavysniper_mk2 = 28,
    },
    weapontint_mk2_29 = {
        weapon_pistol_mk2 = 29,
        weapon_snspistol_mk2 = 29,
        weapon_smg_mk2 = 29,
        weapon_bullpuprifle_mk2 = 29,
        weapon_specialcarbine_mk2 = 29,
        weapon_assaultrifle_mk2 = 29,
        weapon_carbinerifle_mk2 = 29,
        weapon_combatmg_mk2 = 29,
        weapon_marksmanrifle_mk2 = 29,
        weapon_heavysniper_mk2 = 29,
    },
    weapontint_mk2_30 = {
        weapon_pistol_mk2 = 30,
        weapon_snspistol_mk2 = 30,
        weapon_smg_mk2 = 30,
        weapon_bullpuprifle_mk2 = 30,
        weapon_specialcarbine_mk2 = 30,
        weapon_assaultrifle_mk2 = 30,
        weapon_carbinerifle_mk2 = 30,
        weapon_combatmg_mk2 = 30,
        weapon_marksmanrifle_mk2 = 30,
        weapon_heavysniper_mk2 = 30,
    },
    weapontint_mk2_31 = {
        weapon_pistol_mk2 = 31,
        weapon_snspistol_mk2 = 31,
        weapon_smg_mk2 = 31,
        weapon_bullpuprifle_mk2 = 31,
        weapon_specialcarbine_mk2 = 31,
        weapon_assaultrifle_mk2 = 31,
        weapon_carbinerifle_mk2 = 31,
        weapon_combatmg_mk2 = 31,
        weapon_marksmanrifle_mk2 = 31,
        weapon_heavysniper_mk2 = 31,
    },
    weapontint_mk2_32 = {
        weapon_pistol_mk2 = 32,
        weapon_snspistol_mk2 = 32,
        weapon_smg_mk2 = 32,
        weapon_bullpuprifle_mk2 = 32,
        weapon_specialcarbine_mk2 = 32,
        weapon_assaultrifle_mk2 = 32,
        weapon_carbinerifle_mk2 = 32,
        weapon_combatmg_mk2 = 32,
        weapon_marksmanrifle_mk2 = 32,
        weapon_heavysniper_mk2 = 32,
    },
}
-- Attachments List related to ox-inventory (qb-core old, new and esx) version
Config.OxAttachments = {
    ['at_flashlight'] = {
        label = 'Tactical Flashlight',
        weight = 120,
        type = 'flashlight',
        client = {
            component = {
                `COMPONENT_AT_AR_FLSH`,
                `COMPONENT_AT_AR_FLSH_REH`,
                `COMPONENT_AT_PI_FLSH`,
                `COMPONENT_AT_PI_FLSH_02`,
                `COMPONENT_AT_PI_FLSH_03`,
            },
            usetime = 2500
        }
    },

    ['at_suppressor_light'] = {
        label = 'Suppressor',
        weight = 280,
        type = 'muzzle',
        client = {
            component = {
                `COMPONENT_AT_PI_SUPP`,
                `COMPONENT_AT_PI_SUPP_02`,
                `COMPONENT_CERAMICPISTOL_SUPP`,
                `COMPONENT_PISTOLXM3_SUPP`
            },
            usetime = 2500
        }
    },

    ['at_suppressor_heavy'] = {
        label = 'Tactical Suppressor',
        weight = 280,
        type = 'muzzle',
        client = {
            component = {
                `COMPONENT_AT_AR_SUPP`,
                `COMPONENT_AT_AR_SUPP_02`,
                `COMPONENT_AT_SR_SUPP`,
                `COMPONENT_AT_SR_SUPP_03`
            },
            usetime = 2500
        }
    },

    ['at_grip'] = {
        label = 'Grip',
        type = 'grip',
        weight = 280,
        client = {
            component = {
                `COMPONENT_AT_AR_AFGRIP`,
                `COMPONENT_AT_AR_AFGRIP_02`
            },
            usetime = 2500
        }
    },

    ['at_barrel'] = {
        label = 'Heavy Barrel',
        type = 'barrel',
        weight = 280,
        client = {
            component = {
                `COMPONENT_AT_AR_BARREL_02`,
                `COMPONENT_AT_BP_BARREL_02`,
                `COMPONENT_AT_CR_BARREL_02`,
                `COMPONENT_AT_MG_BARREL_02`,
                `COMPONENT_AT_MRFL_BARREL_02`,
                `COMPONENT_AT_SB_BARREL_02`,
                `COMPONENT_AT_SC_BARREL_02`,
                `COMPONENT_AT_SR_BARREL_02`,
            },
            usetime = 2500
        }
    },

    ['at_clip_extended_pistol'] = {
        label = 'Extended Pistol Clip',
        type = 'magazine',
        weight = 280,
        client = {
            component = {
                `COMPONENT_APPISTOL_CLIP_02`,
                `COMPONENT_CERAMICPISTOL_CLIP_02`,
                `COMPONENT_COMBATPISTOL_CLIP_02`,
                `COMPONENT_HEAVYPISTOL_CLIP_02`,
                `COMPONENT_PISTOL_CLIP_02`,
                `COMPONENT_PISTOL_MK2_CLIP_02`,
                `COMPONENT_PISTOL50_CLIP_02`,
                `COMPONENT_SNSPISTOL_CLIP_02`,
                `COMPONENT_SNSPISTOL_MK2_CLIP_02`,
                `COMPONENT_VINTAGEPISTOL_CLIP_02`,
                `COMPONENT_TECPISTOL_CLIP_02`,
            },
            usetime = 2500
        }
    },

    ['at_clip_extended_smg'] = {
        label = 'Extended SMG Clip',
        type = 'magazine',
        weight = 280,
        client = {
            component = {
                `COMPONENT_ASSAULTSMG_CLIP_02`,
                `COMPONENT_COMBATPDW_CLIP_02`,
                `COMPONENT_MACHINEPISTOL_CLIP_02`,
                `COMPONENT_MICROSMG_CLIP_02`,
                `COMPONENT_MINISMG_CLIP_02`,
                `COMPONENT_SMG_CLIP_02`,
                `COMPONENT_SMG_MK2_CLIP_02`,
            },
            usetime = 2500
        }
    },

    ['at_clip_extended_shotgun'] = {
        label = 'Extended Shotgun Clip',
        type = 'magazine',
        weight = 280,
        client = {
            component = {
                `COMPONENT_ASSAULTSHOTGUN_CLIP_02`,
                `COMPONENT_HEAVYSHOTGUN_CLIP_02`,
            },
            usetime = 2500
        }
    },

    ['at_clip_extended_rifle'] = {
        label = 'Extended Rifle Clip',
        type = 'magazine',
        weight = 280,
        client = {
            component = {
                `COMPONENT_ADVANCEDRIFLE_CLIP_02`,
                `COMPONENT_ASSAULTRIFLE_CLIP_02`,
                `COMPONENT_ASSAULTRIFLE_MK2_CLIP_02`,
                `COMPONENT_BULLPUPRIFLE_CLIP_02`,
                `COMPONENT_BULLPUPRIFLE_MK2_CLIP_02`,
                `COMPONENT_CARBINERIFLE_CLIP_02`,
                `COMPONENT_CARBINERIFLE_MK2_CLIP_02`,
                `COMPONENT_COMPACTRIFLE_CLIP_02`,
                `COMPONENT_HEAVYRIFLE_CLIP_02`,
                `COMPONENT_MILITARYRIFLE_CLIP_02`,
                `COMPONENT_SPECIALCARBINE_CLIP_02`,
                `COMPONENT_SPECIALCARBINE_MK2_CLIP_02`,
                `COMPONENT_TACTICALRIFLE_CLIP_02`,
            },
            usetime = 2500
        }
    },

    ['at_clip_extended_mg'] = {
        label = 'Extended MG Clip',
        type = 'magazine',
        weight = 280,
        client = {
            component = {
                `COMPONENT_GUSENBERG_CLIP_02`,
                `COMPONENT_MG_CLIP_02`,
                `COMPONENT_COMBATMG_CLIP_02`,
                `COMPONENT_COMBATMG_MK2_CLIP_02`,
            },
            usetime = 2500
        }
    },

    ['at_clip_extended_sniper'] = {
        label = 'Extended Sniper Clip',
        type = 'magazine',
        weight = 280,
        client = {
            component = {
                `COMPONENT_HEAVYSNIPER_MK2_CLIP_02`,
                `COMPONENT_MARKSMANRIFLE_CLIP_02`,
                `COMPONENT_MARKSMANRIFLE_MK2_CLIP_02`,
            },
            usetime = 2500
        }
    },

    ['at_clip_drum_smg'] = {
        label = 'SMG Drum',
        type = 'magazine',
        weight = 280,
        client = {
            component = {
                `COMPONENT_COMBATPDW_CLIP_03`,
                `COMPONENT_MACHINEPISTOL_CLIP_03`,
                `COMPONENT_SMG_CLIP_03`,
            },
            usetime = 2500
        }
    },

    ['at_clip_drum_shotgun'] = {
        label = 'Shotgun Drum',
        type = 'magazine',
        weight = 280,
        client = {
            component = {
                `COMPONENT_HEAVYSHOTGUN_CLIP_03`
            },
            usetime = 2500
        }
    },

    ['at_clip_drum_rifle'] = {
        label = 'Rifle Drum',
        type = 'magazine',
        weight = 280,
        client = {
            component = {
                `COMPONENT_ASSAULTRIFLE_CLIP_03`,
                `COMPONENT_COMPACTRIFLE_CLIP_03`,
                `COMPONENT_CARBINERIFLE_CLIP_03`,
                `COMPONENT_SPECIALCARBINE_CLIP_03`,
            },
            usetime = 2500
        }
    },

    ['at_compensator'] = {
        label = 'Compensator',
        type = 'muzzle',
        weight = 280,
        client = {
            component = {
                `COMPONENT_AT_PI_COMP`,
                `COMPONENT_AT_PI_COMP_02`,
                `COMPONENT_AT_PI_COMP_03`
            },
            usetime = 2500
        }
    },

    ['at_scope_macro'] = {
        label = 'Macro Scope',
        type = 'sight',
        weight = 280,
        client = {
            component = {
                `COMPONENT_AT_SCOPE_MACRO`,
                `COMPONENT_AT_SCOPE_MACRO_02`,
                `COMPONENT_AT_SCOPE_MACRO_MK2`,
                `COMPONENT_AT_SCOPE_MACRO_02_MK2`,
                `COMPONENT_AT_SCOPE_MACRO_02_SMG_MK2`
            },
            usetime = 2500
        }
    },

    ['at_scope_small'] = {
        label = 'Small Scope',
        type = 'sight',
        weight = 280,
        client = {
            component = {
                `COMPONENT_AT_SCOPE_SMALL`,
                `COMPONENT_AT_SCOPE_SMALL_02`,
                `COMPONENT_AT_SCOPE_SMALL_MK2`,
                `COMPONENT_AT_SCOPE_SMALL_SMG_MK2`
            },
            usetime = 2500
        }
    },

    ['at_scope_medium'] = {
        label = 'Medium Scope',
        type = 'sight',
        weight = 280,
        client = {
            component = {
                `COMPONENT_AT_SCOPE_MEDIUM`,
                `COMPONENT_AT_SCOPE_MEDIUM_MK2`
            },
            usetime = 2500
        }
    },

    ['at_scope_large'] = {
        label = 'Large Scope',
        type = 'sight',
        weight = 280,
        client = {
            component = {
                `COMPONENT_AT_SCOPE_LARGE_MK2`
            },
            usetime = 2500
        }
    },

    ['at_scope_advanced'] = {
        label = 'Advanced Scope',
        type = 'sight',
        weight = 280,
        client = {
            component = {
                `COMPONENT_AT_SCOPE_MAX`
            },
            usetime = 2500
        }
    },

    ['at_scope_nv'] = {
        label = 'NV Scope',
        type = 'sight',
        weight = 420,
        client = {
            component = {
                `COMPONENT_AT_SCOPE_NV`
            },
            usetime = 2500
        }
    },

    ['at_scope_thermal'] = {
        label = 'Thermal Scope',
        type = 'sight',
        weight = 420,
        client = {
            component = {
                `COMPONENT_AT_SCOPE_THERMAL`
            },
            usetime = 2500
        }
    },

    ['at_scope_holo'] = {
        label = 'Holographic Sight',
        type = 'sight',
        weight = 280,
        client = {
            component = {
                `COMPONENT_AT_PI_RAIL`,
                `COMPONENT_AT_PI_RAIL_02`,
                `COMPONENT_AT_SIGHTS`,
                `COMPONENT_AT_SIGHTS_SMG`
            },
            usetime = 2500
        }
    },

    ['at_muzzle_flat'] = {
        label = 'Flat Muzzle',
        type = 'muzzle',
        weight = 80,
        client = {
            component = {
                `COMPONENT_AT_MUZZLE_01`
            },
            usetime = 2500
        }
    },

    ['at_muzzle_tactical'] = {
        label = 'Tactical Muzzle',
        type = 'muzzle',
        weight = 80,
        client = {
            component = {
                `COMPONENT_AT_MUZZLE_02`
            },
            usetime = 2500
        }
    },

    ['at_muzzle_fat'] = {
        label = 'Fat Muzzle',
        type = 'muzzle',
        weight = 80,
        client = {
            component = {
                `COMPONENT_AT_MUZZLE_03`
            },
            usetime = 2500
        }
    },

    ['at_muzzle_precision'] = {
        label = 'Precision Muzzle',
        type = 'muzzle',
        weight = 80,
        client = {
            component = {
                `COMPONENT_AT_MUZZLE_04`
            },
            usetime = 2500
        }
    },

    ['at_muzzle_heavy'] = {
        label = 'Heavy Muzzle',
        type = 'muzzle',
        weight = 80,
        client = {
            component = {
                `COMPONENT_AT_MUZZLE_05`
            },
            usetime = 2500
        }
    },

    ['at_muzzle_slanted'] = {
        label = 'Slanted Muzzle',
        type = 'muzzle',
        weight = 80,
        client = {
            component = {
                `COMPONENT_AT_MUZZLE_06`
            },
            usetime = 2500
        }
    },

    ['at_muzzle_split'] = {
        label = 'Split Muzzle',
        type = 'muzzle',
        weight = 80,
        client = {
            component = {
                `COMPONENT_AT_MUZZLE_07`
            },
            usetime = 2500
        }
    },

    ['at_muzzle_squared'] = {
        label = 'Squared Muzzle',
        type = 'muzzle',
        weight = 80,
        client = {
            component = {
                `COMPONENT_AT_MUZZLE_08`
            },
            usetime = 2500
        }
    },

    ['at_muzzle_bell'] = {
        label = 'Bell Muzzle',
        type = 'muzzle',
        weight = 80,
        client = {
            component = {
                `COMPONENT_AT_MUZZLE_09`
            },
            usetime = 2500
        }
    },

    ['at_skin_luxe'] = {
        label = 'Luxury Weapon Kit',
        type = 'skin',
        weight = 50,
        client = {
            component = {
                `COMPONENT_ASSAULTRIFLE_VARMOD_LUXE`,
                `COMPONENT_ASSAULTSMG_VARMOD_LOWRIDER`,
                `COMPONENT_CARBINERIFLE_VARMOD_LUXE`,
                `COMPONENT_COMBATPISTOL_VARMOD_LOWRIDER`,
                `COMPONENT_MARKSMANRIFLE_VARMOD_LUXE`,
                `COMPONENT_MG_VARMOD_LOWRIDER`,
                `COMPONENT_MICROSMG_VARMOD_LUXE`,
                `COMPONENT_PISTOL_VARMOD_LUXE`,
                `COMPONENT_PUMPSHOTGUN_VARMOD_LOWRIDER`,
                `COMPONENT_SMG_VARMOD_LUXE`
            },
            usetime = 2500
        }
    },

    ['at_skin_wood'] = {
        label = 'Wood Weapon Kit',
        type = 'skin',
        weight = 50,
        client = {
            component = {
                `COMPONENT_HEAVYPISTOL_VARMOD_LUXE`,
                `COMPONENT_SNIPERRIFLE_VARMOD_LUXE`,
                `COMPONENT_SNSPISTOL_VARMOD_LOWRIDER`
            },
            usetime = 2500
        }
    },

    ['at_skin_metal'] = {
        label = 'Metal Weapon Kit',
        type = 'skin',
        weight = 50,
        client = {
            component = {
                `COMPONENT_ADVANCEDRIFLE_VARMOD_LUXE`,
                `COMPONENT_APPISTOL_VARMOD_LUXE`,
                `COMPONENT_BULLPUPRIFLE_VARMOD_LOW`,
                `COMPONENT_SAWNOFFSHOTGUN_VARMOD_LUXE`,
                `COMPONENT_SPECIALCARBINE_VARMOD_LOWRIDER`
            },
            usetime = 2500
        }
    },

    ['at_skin_pearl'] = {
        label = 'Pearl Weapon Kit',
        type = 'skin',
        weight = 50,
        client = {
            component = {
                `COMPONENT_PISTOL50_VARMOD_LUXE`
            },
            usetime = 2500
        }
    },

    ['at_skin_ballas'] = {
        label = 'Ballas Weapon Kit',
        type = 'skin',
        weight = 50,
        client = {
            component = {
                `COMPONENT_KNUCKLE_VARMOD_BALLAS`
            },
            usetime = 2500
        }
    },

    ['at_skin_diamond'] = {
        label = 'Diamond Weapon Kit',
        type = 'skin',
        weight = 50,
        client = {
            component = {
                `COMPONENT_KNUCKLE_VARMOD_DIAMOND`
            },
            usetime = 2500
        }
    },

    ['at_skin_dollar'] = {
        label = 'Dollar Weapon Kit',
        type = 'skin',
        weight = 50,
        client = {
            component = {
                `COMPONENT_KNUCKLE_VARMOD_DOLLAR`
            },
            usetime = 2500
        }
    },

    ['at_skin_hate'] = {
        label = 'Hate Weapon Kit',
        type = 'skin',
        weight = 50,
        client = {
            component = {
                `COMPONENT_KNUCKLE_VARMOD_HATE`
            },
            usetime = 2500
        }
    },

    ['at_skin_king'] = {
        label = 'King Weapon Kit',
        type = 'skin',
        weight = 50,
        client = {
            component = {
                `COMPONENT_KNUCKLE_VARMOD_KING`
            },
            usetime = 2500
        }
    },

    ['at_skin_love'] = {
        label = 'Love Weapon Kit',
        type = 'skin',
        weight = 50,
        client = {
            component = {
                `COMPONENT_KNUCKLE_VARMOD_LOVE`
            },
            usetime = 2500
        }
    },

    ['at_skin_pimp'] = {
        label = 'Pimp Weapon Kit',
        type = 'skin',
        weight = 50,
        client = {
            component = {
                `COMPONENT_KNUCKLE_VARMOD_PIMP`
            },
            usetime = 2500
        }
    },

    ['at_skin_player'] = {
        label = 'Player Weapon Kit',
        type = 'skin',
        weight = 50,
        client = {
            component = {
                `COMPONENT_KNUCKLE_VARMOD_PLAYER`
            },
            usetime = 2500
        }
    },

    ['at_skin_vagos'] = {
        label = 'Vagos Weapon Kit',
        type = 'skin',
        weight = 50,
        client = {
            component = {
                `COMPONENT_KNUCKLE_VARMOD_VAGOS`
            },
            usetime = 2500
        }
    },

    ['at_skin_blagueurs'] = {
        label = 'Blagueurs Weapon Kit',
        type = 'skin',
        weight = 50,
        client = {
            component = {
                `COMPONENT_BAT_VARMOD_XM3`
            },
            usetime = 2500
        }
    },

    ['at_skin_splatter'] = {
        label = 'Splatter Weapon Kit',
        type = 'skin',
        weight = 50,
        client = {
            component = {
                `COMPONENT_BAT_VARMOD_XM3_01`
            },
            usetime = 2500
        }
    },

    ['at_skin_bulletholes'] = {
        label = 'Bullet Holes Weapon Kit',
        type = 'skin',
        weight = 50,
        client = {
            component = {
                `COMPONENT_BAT_VARMOD_XM3_02`
            },
            usetime = 2500
        }
    },

    ['at_skin_burgershot'] = {
        label = 'Burger Shot Weapon Kit',
        type = 'skin',
        weight = 50,
        client = {
            component = {
                `COMPONENT_BAT_VARMOD_XM3_03`
            },
            usetime = 2500
        }
    },

    ['at_skin_cluckinbell'] = {
        label = 'Cluckin Bell Weapon Kit',
        type = 'skin',
        weight = 50,
        client = {
            component = {
                `COMPONENT_BAT_VARMOD_XM3_04`
            },
            usetime = 2500
        }
    },

    ['at_skin_fatalincursion'] = {
        label = 'Fatal Incursion Weapon Kit',
        type = 'skin',
        weight = 50,
        client = {
            component = {
                `COMPONENT_BAT_VARMOD_XM3_05`
            },
            usetime = 2500
        }
    },

    ['at_skin_luchalibre'] = {
        label = 'Lucha Libre Weapon Kit',
        type = 'skin',
        weight = 50,
        client = {
            component = {
                `COMPONENT_BAT_VARMOD_XM3_06`
            },
            usetime = 2500
        }
    },

    ['at_skin_trippy'] = {
        label = 'Trippy Weapon Kit',
        type = 'skin',
        weight = 50,
        client = {
            component = {
                `COMPONENT_BAT_VARMOD_XM3_07`
            },
            usetime = 2500
        }
    },

    ['at_skin_tiedye'] = {
        label = 'Tie-Dye Weapon Kit',
        type = 'skin',
        weight = 50,
        client = {
            component = {
                `COMPONENT_BAT_VARMOD_XM3_08`
            },
            usetime = 2500
        }
    },

    ['at_skin_wall'] = {
        label = 'Wall Weapon Kit',
        type = 'skin',
        weight = 50,
        client = {
            component = {
                `COMPONENT_BAT_VARMOD_XM3_09`
            },
            usetime = 2500
        }
    },

    ['at_skin_vip'] = {
        label = 'VIP Weapon Kit',
        type = 'skin',
        weight = 50,
        client = {
            component = {
                `COMPONENT_REVOLVER_VARMOD_BOSS`,
                `COMPONENT_SWITCHBLADE_VARMOD_VAR1`
            },
            usetime = 2500
        }
    },

    ['at_skin_bodyguard'] = {
        label = 'Bodyguard Weapon Kit',
        type = 'skin',
        weight = 50,
        client = {
            component = {
                `COMPONENT_REVOLVER_VARMOD_GOON`,
                `COMPONENT_SWITCHBLADE_VARMOD_VAR2`
            },
            usetime = 2500
        }
    },

    ['at_skin_festive'] = {
        label = 'Festive Weapon Kit',
        type = 'skin',
        weight = 50,
        client = {
            component = {
                `COMPONENT_RAYPISTOL_VARMOD_XMAS18`
            },
            usetime = 2500
        }
    },

    ['at_skin_security'] = {
        label = 'Security Weapon Kit',
        type = 'skin',
        weight = 50,
        client = {
            component = {
                `COMPONENT_APPISTOL_VARMOD_SECURITY`,
                `COMPONENT_MICROSMG_VARMOD_SECURITY`,
            },
            usetime = 2500
        }
    },

    ['at_skin_camo'] = {
        label = 'Camo Weapon Kit',
        type = 'skin',
        weight = 50,
        client = {
            component = {
                `COMPONENT_ASSAULTRIFLE_MK2_CAMO`,
                `COMPONENT_BULLPUPRIFLE_MK2_CAMO`,
                `COMPONENT_CARBINERIFLE_MK2_CAMO`,
                `COMPONENT_COMBATMG_MK2_CAMO`,
                `COMPONENT_HEAVYSNIPER_MK2_CAMO`,
                `COMPONENT_MARKSMANRIFLE_MK2_CAMO`,
                `COMPONENT_PISTOL_MK2_CAMO`,
                `COMPONENT_PUMPSHOTGUN_MK2_CAMO`,
                `COMPONENT_REVOLVER_MK2_CAMO`,
                `COMPONENT_SMG_MK2_CAMO`,
                `COMPONENT_SNSPISTOL_MK2_CAMO`,
                `COMPONENT_SPECIALCARBINE_MK2_CAMO`,
            },
            usetime = 2500
        }
    },

    ['at_skin_brushstroke'] = {
        label = 'Brushstroke Weapon Kit',
        type = 'skin',
        weight = 50,
        client = {
            component = {
                `COMPONENT_ASSAULTRIFLE_MK2_CAMO_02`,
                `COMPONENT_BULLPUPRIFLE_MK2_CAMO_02`,
                `COMPONENT_CARBINERIFLE_MK2_CAMO_02`,
                `COMPONENT_COMBATMG_MK2_CAMO_02`,
                `COMPONENT_HEAVYSNIPER_MK2_CAMO_02`,
                `COMPONENT_MARKSMANRIFLE_MK2_CAMO_02`,
                `COMPONENT_PISTOL_MK2_CAMO_02`,
                `COMPONENT_PUMPSHOTGUN_MK2_CAMO_02`,
                `COMPONENT_REVOLVER_MK2_CAMO_02`,
                `COMPONENT_SMG_MK2_CAMO_02`,
                `COMPONENT_SNSPISTOL_MK2_CAMO_02`,
                `COMPONENT_SPECIALCARBINE_MK2_CAMO_02`,
            },
            usetime = 2500
        }
    },

    ['at_skin_woodland'] = {
        label = 'Woodland Weapon Kit',
        type = 'skin',
        weight = 50,
        client = {
            component = {
                `COMPONENT_ASSAULTRIFLE_MK2_CAMO_03`,
                `COMPONENT_BULLPUPRIFLE_MK2_CAMO_03`,
                `COMPONENT_CARBINERIFLE_MK2_CAMO_03`,
                `COMPONENT_COMBATMG_MK2_CAMO_03`,
                `COMPONENT_HEAVYSNIPER_MK2_CAMO_03`,
                `COMPONENT_MARKSMANRIFLE_MK2_CAMO_03`,
                `COMPONENT_PISTOL_MK2_CAMO_03`,
                `COMPONENT_PUMPSHOTGUN_MK2_CAMO_03`,
                `COMPONENT_REVOLVER_MK2_CAMO_03`,
                `COMPONENT_SMG_MK2_CAMO_03`,
                `COMPONENT_SNSPISTOL_MK2_CAMO_03`,
                `COMPONENT_SPECIALCARBINE_MK2_CAMO_03`,
            },
            usetime = 2500
        }
    },

    ['at_skin_skull'] = {
        label = 'Skull Weapon Kit',
        type = 'skin',
        weight = 50,
        client = {
            component = {
                `COMPONENT_ASSAULTRIFLE_MK2_CAMO_04`,
                `COMPONENT_BULLPUPRIFLE_MK2_CAMO_04`,
                `COMPONENT_CARBINERIFLE_MK2_CAMO_04`,
                `COMPONENT_COMBATMG_MK2_CAMO_04`,
                `COMPONENT_HEAVYSNIPER_MK2_CAMO_04`,
                `COMPONENT_MARKSMANRIFLE_MK2_CAMO_04`,
                `COMPONENT_PISTOL_MK2_CAMO_04`,
                `COMPONENT_PUMPSHOTGUN_MK2_CAMO_04`,
                `COMPONENT_REVOLVER_MK2_CAMO_04`,
                `COMPONENT_SMG_MK2_CAMO_04`,
                `COMPONENT_SNSPISTOL_MK2_CAMO_04`,
                `COMPONENT_SPECIALCARBINE_MK2_CAMO_04`,
            },
            usetime = 2500
        }
    },

    ['at_skin_sessanta'] = {
        label = 'Sessanta Weapon Kit',
        type = 'skin',
        weight = 50,
        client = {
            component = {
                `COMPONENT_ASSAULTRIFLE_MK2_CAMO_05`,
                `COMPONENT_BULLPUPRIFLE_MK2_CAMO_05`,
                `COMPONENT_CARBINERIFLE_MK2_CAMO_05`,
                `COMPONENT_COMBATMG_MK2_CAMO_05`,
                `COMPONENT_HEAVYSNIPER_MK2_CAMO_05`,
                `COMPONENT_MARKSMANRIFLE_MK2_CAMO_05`,
                `COMPONENT_PISTOL_MK2_CAMO_05`,
                `COMPONENT_PUMPSHOTGUN_MK2_CAMO_05`,
                `COMPONENT_REVOLVER_MK2_CAMO_05`,
                `COMPONENT_SMG_MK2_CAMO_05`,
                `COMPONENT_SNSPISTOL_MK2_CAMO_05`,
                `COMPONENT_SPECIALCARBINE_MK2_CAMO_05`,
            },
            usetime = 2500
        }
    },

    ['at_skin_perseus'] = {
        label = 'Perseus Weapon Kit',
        type = 'skin',
        weight = 50,
        client = {
            component = {
                `COMPONENT_ASSAULTRIFLE_MK2_CAMO_06`,
                `COMPONENT_BULLPUPRIFLE_MK2_CAMO_06`,
                `COMPONENT_CARBINERIFLE_MK2_CAMO_06`,
                `COMPONENT_COMBATMG_MK2_CAMO_06`,
                `COMPONENT_HEAVYSNIPER_MK2_CAMO_06`,
                `COMPONENT_MARKSMANRIFLE_MK2_CAMO_06`,
                `COMPONENT_PISTOL_MK2_CAMO_06`,
                `COMPONENT_PUMPSHOTGUN_MK2_CAMO_06`,
                `COMPONENT_REVOLVER_MK2_CAMO_06`,
                `COMPONENT_SMG_MK2_CAMO_06`,
                `COMPONENT_SNSPISTOL_MK2_CAMO_06`,
                `COMPONENT_SPECIALCARBINE_MK2_CAMO_06`,
            },
            usetime = 2500
        }
    },

    ['at_skin_leopard'] = {
        label = 'Leopard Weapon Kit',
        type = 'skin',
        weight = 50,
        client = {
            component = {
                `COMPONENT_ASSAULTRIFLE_MK2_CAMO_07`,
                `COMPONENT_BULLPUPRIFLE_MK2_CAMO_07`,
                `COMPONENT_CARBINERIFLE_MK2_CAMO_07`,
                `COMPONENT_COMBATMG_MK2_CAMO_07`,
                `COMPONENT_HEAVYSNIPER_MK2_CAMO_07`,
                `COMPONENT_MARKSMANRIFLE_MK2_CAMO_07`,
                `COMPONENT_PISTOL_MK2_CAMO_07`,
                `COMPONENT_PUMPSHOTGUN_MK2_CAMO_07`,
                `COMPONENT_REVOLVER_MK2_CAMO_07`,
                `COMPONENT_SMG_MK2_CAMO_07`,
                `COMPONENT_SNSPISTOL_MK2_CAMO_07`,
                `COMPONENT_SPECIALCARBINE_MK2_CAMO_07`,
            },
            usetime = 2500
        }
    },

    ['at_skin_zebra'] = {
        label = 'Zebra Weapon Kit',
        type = 'skin',
        weight = 50,
        client = {
            component = {
                `COMPONENT_ASSAULTRIFLE_MK2_CAMO_08`,
                `COMPONENT_BULLPUPRIFLE_MK2_CAMO_08`,
                `COMPONENT_CARBINERIFLE_MK2_CAMO_08`,
                `COMPONENT_COMBATMG_MK2_CAMO_08`,
                `COMPONENT_HEAVYSNIPER_MK2_CAMO_08`,
                `COMPONENT_MARKSMANRIFLE_MK2_CAMO_08`,
                `COMPONENT_PISTOL_MK2_CAMO_08`,
                `COMPONENT_PUMPSHOTGUN_MK2_CAMO_08`,
                `COMPONENT_REVOLVER_MK2_CAMO_08`,
                `COMPONENT_SMG_MK2_CAMO_08`,
                `COMPONENT_SNSPISTOL_MK2_CAMO_08`,
                `COMPONENT_SPECIALCARBINE_MK2_CAMO_08`,
            },
            usetime = 2500
        }
    },

    ['at_skin_geometric'] = {
        label = 'Geometric Weapon Kit',
        type = 'skin',
        weight = 50,
        client = {
            component = {
                `COMPONENT_ASSAULTRIFLE_MK2_CAMO_09`,
                `COMPONENT_BULLPUPRIFLE_MK2_CAMO_09`,
                `COMPONENT_CARBINERIFLE_MK2_CAMO_09`,
                `COMPONENT_COMBATMG_MK2_CAMO_09`,
                `COMPONENT_HEAVYSNIPER_MK2_CAMO_09`,
                `COMPONENT_MARKSMANRIFLE_MK2_CAMO_09`,
                `COMPONENT_PISTOL_MK2_CAMO_09`,
                `COMPONENT_PUMPSHOTGUN_MK2_CAMO_09`,
                `COMPONENT_REVOLVER_MK2_CAMO_09`,
                `COMPONENT_SMG_MK2_CAMO_09`,
                `COMPONENT_SNSPISTOL_MK2_CAMO_09`,
                `COMPONENT_SPECIALCARBINE_MK2_CAMO_09`,
            },
            usetime = 2500
        }
    },

    ['at_skin_boom'] = {
        label = 'Boom Weapon Kit',
        type = 'skin',
        weight = 50,
        client = {
            component = {
                `COMPONENT_ASSAULTRIFLE_MK2_CAMO_10`,
                `COMPONENT_BULLPUPRIFLE_MK2_CAMO_10`,
                `COMPONENT_CARBINERIFLE_MK2_CAMO_10`,
                `COMPONENT_COMBATMG_MK2_CAMO_10`,
                `COMPONENT_HEAVYSNIPER_MK2_CAMO_10`,
                `COMPONENT_MARKSMANRIFLE_MK2_CAMO_10`,
                `COMPONENT_PISTOL_MK2_CAMO_10`,
                `COMPONENT_PUMPSHOTGUN_MK2_CAMO_10`,
                `COMPONENT_REVOLVER_MK2_CAMO_10`,
                `COMPONENT_SMG_MK2_CAMO_10`,
                `COMPONENT_SNSPISTOL_MK2_CAMO_10`,
                `COMPONENT_SPECIALCARBINE_MK2_CAMO_10`,
            },
            usetime = 2500
        }
    },

    ['at_skin_patriotic'] = {
        label = 'Patriotic Weapon Kit',
        type = 'skin',
        weight = 50,
        client = {
            component = {
                `COMPONENT_ASSAULTRIFLE_MK2_CAMO_IND_01`,
                `COMPONENT_BULLPUPRIFLE_MK2_CAMO_IND_01`,
                `COMPONENT_CARBINERIFLE_MK2_CAMO_IND_01`,
                `COMPONENT_COMBATMG_MK2_CAMO_IND_01`,
                `COMPONENT_HEAVYSNIPER_MK2_CAMO_IND_01`,
                `COMPONENT_MARKSMANRIFLE_MK2_CAMO_IND_01`,
                `COMPONENT_PISTOL_MK2_CAMO_IND_01`,
                `COMPONENT_PUMPSHOTGUN_MK2_CAMO_IND_01`,
                `COMPONENT_REVOLVER_MK2_CAMO_IND_01`,
                `COMPONENT_SMG_MK2_CAMO_IND_01`,
                `COMPONENT_SNSPISTOL_MK2_CAMO_IND_01`,
                `COMPONENT_SPECIALCARBINE_MK2_CAMO_IND_01`,
            },
            usetime = 2500
        }
    },
}


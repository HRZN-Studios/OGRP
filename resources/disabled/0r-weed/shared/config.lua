--[[ Configuration settings ]]
Config        = {}

---Locale setting for language localization.
Config.Locale = "en"

--[[ If qb-inventory is used and the version is higher than 2.0.0 then enable this setting, otherwise leave it disabled ]]
Config.NewInventoryQB = true

--[[ Commands ]]
Config.Commands = {}

--[[ Usable Items ]]
Config.UsableItems = {
    --[[ Seeds ]]
    ["weed_seed"] = { itemName = "weed_seed", type = "seed" },
    --[[ Fertilizers ]]
    ["fertilizer_old"] = { itemName = "fertilizer_old", type = "fertilizer", effect = 15 },
    ["fertilizer_normal"] = { itemName = "fertilizer_normal", type = "fertilizer", effect = 25 },
    ["fertilizer_premium"] = { itemName = "fertilizer_premium", type = "fertilizer", effect = 50 },
    --[[ Harvested Weed ]]
    ["weed_plant"] = { itemName = "weed_plant", type = "harvested" },
    --[[ Weed Brick ]]
    ["weed_brick"] = { itemName = "weed_brick", type = "weed_brick", need_plant_for_one = 3 },
    --[[ # ]]
}

--The amount you will get when you clone.
--If you have clone genetics, this value will increase by 1. 
--If you set it to 0, the cloning feature will be disabled.
Config.WeedCloneAmount = 2

--[[
    TimeToGrow | Time that a plant takes to fully grow (1-100) in minutes.
    Default: 180 (3 hours)
]]
Config.TimeToGrow = 180

--[[ Update Time | minutes | Everything will be checked every time this value. ]]
Config.UpdatePlants        = 5

Config.DryIncrease         = 5         -- Increase of the dry amount each controls (without Header and Fans).
Config.FertilizerDecay     = 5         -- Decrease amount of the Fertilizer.
Config.WaterDecay          = 5         -- Decrease amount of the Water.

Config.FertilizerThreshold = 45        -- Value under it, the Plant Health will decrease
Config.WaterThreshold      = 45        -- Value under it, the Plant Health will decrease
Config.LightThreshold      = 45        -- Value under it, the Plant Health will decrease

Config.HealthBaseDecay     = { 5, 10 } -- The decrease amount of the Plant Health when needs are missing.(water, nutrition and lights)

--[[ Animations ]]
Config.Animations = {
    Planting = {
        lib = "amb@world_human_gardener_plant@male@idle_a", anim = "idle_a", timeout = 5000,
    },
    Fertilizer = {
        lib = "amb@world_human_gardener_plant@male@idle_a", anim = "idle_a", timeout = 5000,
    },
}

--[[ Props ]]

Config.TableProps = {
    ["bkr_prop_weed_table_01a"] = {},
}

Config.DryerProps = {
    ["qua_weed_dryer"] = { slot = 6 },
}

Config.HeaterProps = {
    ["qua_weed_heather"] = { effect = 15 },
    ["prop_elec_heater_01"] = { effect = 10 },
    ["prop_patio_heater_01"] = { effect = 5 },
}

Config.LightProps = {
    ["prop_wall_light_05a"] = { effect = 50 },
    ["ch_prop_ch_lamp_ceiling_w_01a"] = { effect = 25 },
    ["h4_prop_x17_sub_lampa_small_blue"] = { effect = 15 },
}

Config.FanProps = {
    ["prop_fan_01"] = { effect = 15 },
    ["v_res_fa_fan"] = { effect = 10 },
    ["prop_wall_vent_02"] = { effect = 5 },
}

--[[ ! Please do not change !]]
Config.PlanterProps = {
    ["qua_weed_planter"] = { max_plant = 6 },
    ["qua_weed_planter_basic"] = { max_plant = 6 },
}

Config.WetProps = {
    ["qua_weed_wet"] = {},
}

--[[ ! Please do not change it. The order is important ! ]]
Config.WeedProps = {
    [1] = `bkr_prop_weed_bud_01a`,
    [2] = `bkr_prop_weed_med_01a`,
    [3] = `bkr_prop_weed_med_01b`,
    [4] = `bkr_prop_weed_lrg_01a`,
    [5] = `bkr_prop_weed_lrg_01b`
}

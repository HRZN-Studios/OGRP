---@class iUsableItemInfo
---@field type "seed"|"fertilizer"
---@field effect number|nil

---@class iPlant
---@field id number
---@field zoneId string
---@field genetics string
---@field stage number
---@field health number
---@field light number
---@field water number
---@field fertilizer number
---@field coords vec3
---@field entity? number

---@class iPlantedSeeds
---@field players number[]
---@field plants iPlant[]


---@class CreatedZoneObjects
---@field entity number
---@field plantId number

---@class iItemMetadata
---@field dry number
---@field genetics string

---@class iItem
---@field name string
---@field metadata iItemMetadata

---@class iDryer
---@field id number
---@field zoneId string
---@field dryerId string
---@field extraDryEffect number
---@field items table<number, iItem>


---@class iZones
---@field players number[]
---@field lastCheck number|nil

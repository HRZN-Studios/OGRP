SQL = {}

---@class CitizenData
---@field identifier string
---@field firstname string
---@field lastname string
---@field dateofbirth string
---@field sex 'M' | 'F'

---@param identifier string
---@param cb function(CitizenData[])
SQL.GetCitizenByIdentifier = function(identifier, cb)
    if Config.Frameworks.ESX.enabled then
        MySQL.query('SELECT identifier, firstname, lastname, dateofbirth, '..Config.GenderTable.sqlUserName..' FROM users WHERE identifier = ?', {identifier}, function(results)
            for k, v in pairs(results) do
                if v.sex == Config.GenderTable.sqlNames['male'] then
                    v.sex = TRANSLATIONS[Config.Language].FILES_SEX_MALE
                elseif v.sex == Config.GenderTable.sqlNames['female'] then
                    v.sex = TRANSLATIONS[Config.Language].FILES_SEX_FEMALE
                else
                    v.sex = 'UNKNOWN'
                end
            end
            cb(results)
        end)
    elseif Config.Frameworks.QB.enabled then
        MySQL.query('SELECT citizenid AS identifier, charinfo FROM players WHERE citizenid = ?', {identifier}, function(results)
            local data = {}
            for k, v in pairs(results) do
                local charinfo = json.decode(v.charinfo)
                table.insert(data, {
                    identifier = v.identifier,
                    firstname = charinfo.firstname,
                    lastname = charinfo.lastname,
                    dateofbirth = charinfo.birthdate,
                    sex = charinfo.gender == Config.GenderTable.sqlNames['male'] and TRANSLATIONS[Config.Language].FILES_SEX_MALE or charinfo.gender == Config.GenderTable.sqlNames['female'] and TRANSLATIONS[Config.Language].FILES_SEX_MALE or 'UNKNOWN'
                })
            end
            cb(data)
        end)
    else
        print('[^2INFO] ^0[^5QF-MDT^0] encountered a problem at [^5GetCitizenByIdentifier^0], if you are using a [^5CUSTOM FRAMEWORK / STANDALONE^0] open a ticket on our discord server and wait for help with configuration!')
        -- SCRIPT IT BY OWN
    end
end

---@param plate string
---@param cb function(VehicleData | nil)
SQL.GetVehicle = function(plate, cb, source)
    local data = {}
    data.type = "vehicle"
    data.plate = plate
    
    if Config.Frameworks.ESX.enabled then
        MySQL.query('SELECT owner, plate, vehicle FROM owned_vehicles WHERE plate = ? LIMIT 1', {plate:upper()}, function(results)
            local result = {}
            
            if not results[1] then
                return cb(nil)
            end

            local vehicle = json.decode(results[1].vehicle).model

            result.plate = results[1].plate
            result.type = "vehicle"
            result.model = SERVER.getVehicleModel(source, vehicle)

            for i=1, #results, 1 do
                local owner = MySQL.single.await('SELECT identifier, firstname, lastname FROM users WHERE identifier = ?', {results[i].owner})
                if not owner then
                    return cb(nil)
                end
                result['owner'] = owner
            end
            
            --// IF YOU HAVE SOME SUBOWNER SYSTEM YOU CAN CONNECT IT HERE
            data.subowner = {
                identifier = "",
                firstname = "",
                lastname = ""
            }

            local notes = MySQL.query.await('SELECT * FROM qf_mdt_vehicle_notes WHERE plate = ? ORDER BY date DESC', {plate:upper()})
            result.notes = notes or {}
            cb(result)
        end)
    elseif Config.Frameworks.QB.enabled then
        MySQL.query('SELECT citizenid AS owner, plate, UPPER(vehicle) AS model FROM player_vehicles WHERE plate = ?', {plate:upper()}, function(results)
            if not results[1] then
                return cb(nil)
            end
            data.model = results[1].model
            data.owner = SQL.GetOwner(results[1].owner)
            --// IF YOU HAVE SOME SUBOWNER SYSTEM YOU CAN CONNECT IT HERE
            data.subowner = {
                identifier = "",
                firstname = "",
                lastname = ""
            }

            local notes = MySQL.query.await('SELECT * FROM qf_mdt_vehicle_notes WHERE plate = ? ORDER BY date DESC', {plate:upper()})
            data.notes = notes or {}
            cb(data)
        end)
    else
        print('[^2INFO] ^0[^5QF-MDT^0] encountered a problem at [^5GetVehicle^0], if you are using a [^5CUSTOM FRAMEWORK / STANDALONE^0] open a ticket on our discord server and wait for help with configuration!')
        -- SCRIPT IT BY OWN
    end
end

---@param identifier string
---@return {[string]: boolean}
SQL.GetPlayerLicenses = function(identifier)
    if Config.Frameworks.ESX.enabled then
        if Config.Licenses.esx_license then
            return MySQL.query.await('SELECT type FROM user_licenses WHERE owner = ?', {identifier})
        elseif Config.Licenses.bcs_license then
            return MySQL.query.await('SELECT license FROM licenses WHERE owner = ?', {identifier})
        end
    elseif Config.Frameworks.QB.enabled then
        if Config.Licenses.qb_license then
            return MySQL.query.await('SELECT JSON_EXTRACT(metadata, "$.licenses") AS licenses FROM players WHERE citizenid = ?', {identifier})
        elseif Config.Licenses.bcs_license then
            return MySQL.query.await('SELECT license FROM licenses WHERE owner = ?', {identifier})
        end
    else
        print('[^2INFO] ^0[^5QF-MDT^0] encountered a problem at [^5GetPlayerLicenses^0], if you are using a [^5CUSTOM FRAMEWORK / STANDALONE^0] open a ticket on our discord server and wait for help with configuration!')
        -- SCRIPT IT BY OWN
    end
end

---@param value string
---@param cb function(CitizenData[])
SQL.SearchCitizen = function(value, cb)
    if Config.Frameworks.ESX.enabled then
        MySQL.query('SELECT identifier, firstname, lastname, dateofbirth, '..Config.GenderTable.sqlUserName..', mdt_picture, mdt_searched, NULL as avatar FROM users WHERE LOWER(CONCAT(`firstname`, " " ,`lastname`)) LIKE "%' .. value .. '%" LIMIT 30', {}, function(results)
            for k, v in pairs(results) do
                if v.sex == Config.GenderTable.sqlNames['male'] then
                    v.sex = TRANSLATIONS[Config.Language].FILES_SEX_MALE
                elseif v.sex == Config.GenderTable.sqlNames['female'] then
                    v.sex = TRANSLATIONS[Config.Language].FILES_SEX_FEMALE
                else
                    v.sex = 'UNKNOWN'
                end
            end
            cb(results)
        end)
    elseif Config.Frameworks.QB.enabled then
        MySQL.query('SELECT citizenid AS identifier, charinfo, mdt_picture, mdt_searched, NULL as avatar FROM players WHERE CONCAT(LOWER(JSON_UNQUOTE(JSON_EXTRACT(charinfo, "$.firstname"))), " ", LOWER(JSON_UNQUOTE(JSON_EXTRACT(charinfo, "$.lastname")))) LIKE "%' .. value .. '%" LIMIT 30', function(results)
            local data = {}
            for k, v in pairs(results) do
                local charinfo = json.decode(v.charinfo)
                if charinfo then
                    table.insert(data, {
                        identifier = v.identifier,
                        firstname = charinfo.firstname,
                        lastname = charinfo.lastname,
                        dateofbirth = charinfo.birthdate,
                        sex = charinfo.gender == Config.GenderTable.sqlNames['male'] and TRANSLATIONS[Config.Language].FILES_SEX_MALE or charinfo.gender == Config.GenderTable.sqlNames['female'] and TRANSLATIONS[Config.Language].FILES_SEX_MALE or 'UNKNOWN',
                        mdt_searched = v.mdt_searched,
                        mdt_picture = v.mdt_picture,
                        avatar = nil
                    })
                end
            end
            cb(data)
        end)
    else
        print('[^2INFO] ^0[^5QF-MDT^0] encountered a problem at [^5SearchCitizen^0], if you are using a [^5CUSTOM FRAMEWORK / STANDALONE^0] open a ticket on our discord server and wait for help with configuration!')
        -- SCRIPT IT BY OWN
    end
end

SQL.SearchCitizenIdentifier = function(value, cb)
    if Config.Frameworks.ESX.enabled then
        MySQL.query('SELECT identifier, firstname, lastname, dateofbirth, '..Config.GenderTable.sqlUserName..', mdt_picture, mdt_searched, NULL as avatar FROM users WHERE identifier = ? LIMIT 1', {value}, function(results)
            for k, v in pairs(results) do
                if v.sex == Config.GenderTable.sqlNames['male'] then
                    v.sex = TRANSLATIONS[Config.Language].FILES_SEX_MALE
                elseif v.sex == Config.GenderTable.sqlNames['female'] then
                    v.sex = TRANSLATIONS[Config.Language].FILES_SEX_FEMALE
                else
                    v.sex = 'UNKNOWN'
                end
            end
            cb(results)
        end)
    elseif Config.Frameworks.QB.enabled then
        MySQL.query('SELECT citizenid AS identifier, charinfo, mdt_picture, mdt_searched, NULL as avatar FROM players WHERE citizenid = ? LIMIT 1', {value}, function(results)
            local data = {}
            for k, v in pairs(results) do
                local charinfo = json.decode(v.charinfo)
                table.insert(data, {
                    identifier = v.identifier,
                    firstname = charinfo.firstname,
                    lastname = charinfo.lastname,
                    dateofbirth = charinfo.birthdate,
                    sex = charinfo.gender == Config.GenderTable.sqlNames['male'] and TRANSLATIONS[Config.Language].FILES_SEX_MALE or charinfo.gender == Config.GenderTable.sqlNames['female'] and TRANSLATIONS[Config.Language].FILES_SEX_MALE or 'UNKNOWN',
                    mdt_searched = v.mdt_searched,
                    mdt_picture = v.mdt_picture,
                    avatar = nil
                })
            end
            cb(data)
        end)
    else
        print('[^2INFO] ^0[^5QF-MDT^0] encountered a problem at [^5SearchCitizenIdentifier^0], if you are using a [^5CUSTOM FRAMEWORK / STANDALONE^0] open a ticket on our discord server and wait for help with configuration!')
        -- SCRIPT IT BY OWN
    end
end

---@param identifier string
---@return VehicleSearched[]
SQL.GetPlayerVehicles = function(identifier)
    if Config.Frameworks.ESX.enabled then
        return MySQL.query.await('SELECT plate, vehicle FROM owned_vehicles WHERE owner = ?', {identifier})
    elseif Config.Frameworks.QB.enabled then
        return MySQL.query.await('SELECT plate, vehicle AS model, hash FROM player_vehicles WHERE citizenid = ?', {identifier})
    else
        print('[^2INFO] ^0[^5QF-MDT^0] encountered a problem at [^5GetPlayerVehicles^0], if you are using a [^5CUSTOM FRAMEWORK / STANDALONE^0] open a ticket on our discord server and wait for help with configuration!')
        -- SCRIPT IT BY OWN
    end
end

---@class OwnerTable
---@field identifier string
---@field firstname string
---@field lastname string

---@param identifier string
---@return OwnerTable
SQL.GetOwner = function(identifier)
    if Config.Frameworks.ESX.enabled then
        return MySQL.single.await('SELECT identifier, firstname, lastname FROM users WHERE identifier = ?', {identifier})
    elseif Config.Frameworks.QB.enabled then
        return MySQL.single.await('SELECT citizenid AS identifier, JSON_UNQUOTE(JSON_EXTRACT(charinfo, "$.firstname")) AS firstname, JSON_UNQUOTE(JSON_EXTRACT(charinfo, "$.lastname")) AS lastname FROM players WHERE citizenid = ?', {identifier})
    else
        print('[^2INFO] ^0[^5QF-MDT^0] encountered a problem at [^5GetOwner^0], if you are using a [^5CUSTOM FRAMEWORK / STANDALONE^0] open a ticket on our discord server and wait for help with configuration!')
        -- SCRIPT IT BY OWN
    end
end

---@param identifier string
---@return string
SQL.GetName = function(identifier)
    if Config.Frameworks.ESX.enabled then
        return MySQL.scalar.await('SELECT CONCAT(firstname, " ", lastname) FROM users WHERE identifier = ?', {identifier})
    elseif Config.Frameworks.QB.enabled then
        return MySQL.scalar.await('SELECT CONCAT(JSON_UNQUOTE(JSON_EXTRACT(charinfo, "$.firstname")), " ", JSON_UNQUOTE(JSON_EXTRACT(charinfo, "$.lastname"))) FROM players WHERE citizenid = ?', {identifier})
    else
        print('[^2INFO] ^0[^5QF-MDT^0] encountered a problem at [^5GetName^0], if you are using a [^5CUSTOM FRAMEWORK / STANDALONE^0] open a ticket on our discord server and wait for help with configuration!')
        -- SCRIPT IT BY OWN
    end
end

---@param plate string
---@return string
SQL.GetVehicleOwnerIdentifier = function (plate)
    if Config.Frameworks.ESX.enabled then
        return MySQL.scalar.await('SELECT owner FROM owned_vehicles WHERE plate = ?', {plate})
    elseif Config.Frameworks.QB.enabled then
        return MySQL.scalar.await('SELECT citizenid FROM player_vehicles WHERE plate = ?', {plate})
    else
        print('[^2INFO] ^0[^5QF-MDT^0] encountered a problem at [^5GetVehicleOwnerIdentifier^0], if you are using a [^5CUSTOM FRAMEWORK / STANDALONE^0] open a ticket on our discord server and wait for help with configuration!')
        -- SCRIPT IT BY OWn
    end
end
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
                    sex = charinfo.gender == Config.GenderTable.sqlNames['male'] and TRANSLATIONS[Config.Language].FILES_SEX_MALE or charinfo.gender == Config.GenderTable.sqlNames['female'] and TRANSLATIONS[Config.Language].FILES_SEX_MALE or 'UNKNOWN',
                })
            end
            cb(data)
        end)
    else
        print('[^2INFO] ^0[^5QF-MDT-EMS^0] encountered a problem at [^5GetCitizenByIdentifier^0], if you are using a [^5CUSTOM FRAMEWORK / STANDALONE^0] open a ticket on our discord server and wait for help with configuration!')
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
        print('[^2INFO] ^0[^5QF-MDT-EMS^0] encountered a problem at [^5GetPlayerLicenses^0], if you are using a [^5CUSTOM FRAMEWORK / STANDALONE^0] open a ticket on our discord server and wait for help with configuration!')
        -- SCRIPT IT BY OWN
    end
end

---@param value string
---@param cb function(CitizenData[])
SQL.SearchCitizen = function(value, cb)
    if Config.Frameworks.ESX.enabled then
        MySQL.query('SELECT identifier, firstname, lastname, dateofbirth, '..Config.GenderTable.sqlUserName..', mdt_ems_picture, mdt_ems_searched, NULL as avatar FROM users WHERE LOWER(CONCAT(`firstname`, " " ,`lastname`)) LIKE "%' .. value .. '%" LIMIT 30', {}, function(results)
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
        MySQL.query('SELECT citizenid AS identifier, charinfo, mdt_ems_picture, mdt_ems_searched, NULL as avatar FROM players WHERE CONCAT(LOWER(JSON_UNQUOTE(JSON_EXTRACT(charinfo, "$.firstname"))), " ", LOWER(JSON_UNQUOTE(JSON_EXTRACT(charinfo, "$.lastname")))) LIKE "%' .. value .. '%" LIMIT 30', function(results)
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
                        mdt_ems_searched = v.mdt_ems_searched,
                        mdt_ems_picture = v.mdt_ems_picture,
                        avatar = nil
                    })
                end
            end
            cb(data)
        end)
    else
        print('[^2INFO] ^0[^5QF-MDT-EMS^0] encountered a problem at [^5SearchCitizen^0], if you are using a [^5CUSTOM FRAMEWORK / STANDALONE^0] open a ticket on our discord server and wait for help with configuration!')
        -- SCRIPT IT BY OWN
    end
end

SQL.SearchCitizenIdentifier = function(value, cb)
    if Config.Frameworks.ESX.enabled then
        MySQL.query('SELECT identifier, firstname, lastname, dateofbirth, '..Config.GenderTable.sqlUserName..', mdt_ems_picture, mdt_ems_searched, NULL as avatar FROM users WHERE identifier = ? LIMIT 1', {value}, function(results)
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
        MySQL.query('SELECT citizenid AS identifier, charinfo, mdt_ems_picture, mdt_ems_searched, NULL as avatar FROM players WHERE citizenid = ? LIMIT 1', {value}, function(results)
            local data = {}
            for k, v in pairs(results) do
                local charinfo = json.decode(v.charinfo)
                table.insert(data, {
                    identifier = v.identifier,
                    firstname = charinfo.firstname,
                    lastname = charinfo.lastname,
                    dateofbirth = charinfo.birthdate,
                    sex = charinfo.gender == Config.GenderTable.sqlNames['male'] and TRANSLATIONS[Config.Language].FILES_SEX_MALE or charinfo.gender == Config.GenderTable.sqlNames['female'] and TRANSLATIONS[Config.Language].FILES_SEX_MALE or 'UNKNOWN',
                    mdt_ems_searched = v.mdt_ems_searched,
                    mdt_ems_picture = v.mdt_ems_picture,
                    avatar = nil
                })
            end
            cb(data)
        end)
    else
        print('[^2INFO] ^0[^5QF-MDT-EMS^0] encountered a problem at [^5SearchCitizenIdentifier^0], if you are using a [^5CUSTOM FRAMEWORK / STANDALONE^0] open a ticket on our discord server and wait for help with configuration!')
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
        print('[^2INFO] ^0[^5QF-MDT-EMS^0] encountered a problem at [^5GetPlayerVehicles^0], if you are using a [^5CUSTOM FRAMEWORK / STANDALONE^0] open a ticket on our discord server and wait for help with configuration!')
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
        print('[^2INFO] ^0[^5QF-MDT-EMS^0] encountered a problem at [^5GetOwner^0], if you are using a [^5CUSTOM FRAMEWORK / STANDALONE^0] open a ticket on our discord server and wait for help with configuration!')
        -- SCRIPT IT BY OWN
    end
end
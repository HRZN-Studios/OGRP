Characters = {}
Characters.ActiveUsers = {}
Characters.Jobs = {}
Characters.JobGrades = {}

if FrameworkSelected == 'ESX' then
    MySQL.ready(function()
        local jobs = MySQL.query.await('SELECT * FROM `jobs`')
        local job_grades = MySQL.query.await('SELECT `job_name`, `grade`, `label` FROM `job_grades`')
        for k,v in ipairs(jobs) do
            Characters.Jobs[v.name] = v.label
        end
        for k,v in ipairs(job_grades) do
            if not Characters.JobGrades[v.job_name] then
                Characters.JobGrades[v.job_name] = {}
            end
            Characters.JobGrades[v.job_name][tonumber(v.grade)] = v.label 
        end
        debugPrint('Done loading JOBS')

        MySQL.query.await('CREATE TABLE IF NOT EXISTS `zsx_multicharacter_slots` (`identifier` varchar(255) NOT NULL, `amount` int(1) NOT NULL, PRIMARY KEY (`identifier`) ) ENGINE=InnoDB DEFAULT CHARSET=utf8;')
        Wait(1000)
        local length = tonumber(MySQL.query.await("SELECT COLUMN_NAME, CHARACTER_MAXIMUM_LENGTH FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'zsx_multicharacter_slots' AND COLUMN_NAME = 'identifier' AND DATA_TYPE = 'varchar'")[1].CHARACTER_MAXIMUM_LENGTH)
        assert(length == 255, '^5Invalid VARCHAR length for table zsx_multicharacter_slots!\n^2Please refer to the docs: https://zsx-development.gitbook.io/docs/multicharacter/common-issues/database\n\n')
    end)
end

Characters.GetIdentifier = function(src, noCut)
    local identifier = GetPlayerIdentifierByType(src, Config.Characters.IdentifierType)
    assert(identifier ~= nil, '^5Invalid identifier type for config value Config.Characters.IdentifierType!\n^2Please refer to the docs: https://zsx-development.gitbook.io/docs/multicharacter/common-issues/other\n\n')
    local convertedIdentifier
    if FrameworkSelected == 'ESX' then
        if not noCut then
            local colonIndex = string.find(identifier, ":")
            convertedIdentifier = string.sub(identifier, colonIndex + 1)
        elseif noCut then
            convertedIdentifier = identifier
        end
    elseif FrameworkSelected == 'QBCore' then
        convertedIdentifier = identifier
    end

    return convertedIdentifier
end

Characters.Get = function(src)
    local identifier = Characters.GetIdentifier(src)
    local PREFIX = Config.Prefix or 'char'
    local query
    if FrameworkSelected == 'ESX' then
        query = "SELECT * FROM `users` WHERE identifier LIKE '%"..identifier.."'"
    elseif FrameworkSelected == 'QBCore' then
        query = "SELECT * FROM `players` WHERE `license` LIKE '%"..identifier.."'"
    end
    
    local response = MySQL.query.await(query)
    local characters = {}
    for k,v in ipairs(response) do
        if FrameworkSelected == 'ESX' then
            local checkMulticharacterMode = string.sub(v.identifier, 1, string.len(PREFIX)) == PREFIX
            assert(checkMulticharacterMode, '^5Your es_extended does not use Config.Multichar. Player identifier: ^3'..v.identifier..'\n^2Please refer to the docs: https://zsx-development.gitbook.io/docs/multicharacter/common-issues/esx\n\n')
        end
        local id = FrameworkSelected == 'ESX' and tonumber(string.sub(v.identifier, #PREFIX+1, string.find(v.identifier, ':')-1)) or FrameworkSelected == 'QBCore' and tonumber(v.cid)
        if FrameworkSelected == 'ESX' then
            local job = v.job
            local grade = v.job_grade
            assert(Characters.Jobs[job] ~= nil, '^5Failed to get the job from object. Player identifier: ^3'..v.identifier..'\n^2Please refer to the docs: https://zsx-development.gitbook.io/docs/multicharacter/common-issues/esx\n\n')
            assert(Characters.JobGrades[job] ~= nil, '^5Failed to get the job grade from object. Player identifier: ^3'..v.identifier..'\n^2Please refer to the docs: https://zsx-development.gitbook.io/docs/multicharacter/common-issues/esx\n\n')
            assert(Characters.JobGrades[job][tonumber(grade)] ~= nil, '^5Failed to get the job grade from object. Player identifier: ^3'..v.identifier..'\n^2Please refer to the docs: https://zsx-development.gitbook.io/docs/multicharacter/common-issues/esx\n\n')
            assert(v.position ~= nil and v.position ~= '', '^5Failed to get player position. Player identifier: ^3'..v.identifier..'\n^2Please refer to the docs: https://zsx-development.gitbook.io/docs/multicharacter/common-issues/esx\n\n')
            v.job = {
                name = job,
                label = Characters.Jobs[job],
                grade_label = Characters.JobGrades[job][tonumber(grade)]
            }
            local coords = json.decode(v.position)
            v.position = coords
            v.id = id
            v.skin = Characters.ConvertSkin(v.identifier)
            table.insert(characters, v)
        elseif FrameworkSelected == 'QBCore' then
            local skinResponse = MySQL.query.await("SELECT * FROM `playerskins` WHERE `citizenid` = '"..v.citizenid.."' AND active = 1")
            local responseCharData = json.decode(v.charinfo)
            local responseJobData = json.decode(v.job)
            local characterData = {
                sex = tonumber(response[1].gender) == 0 and 'm' or 'f',
                skin = Characters.ConvertSkin(v.citizenid),
                model = skinResponse[1] and tonumber(skinResponse[1].model) or false,
                position = json.decode(v.position),
                firstname = responseCharData.firstname,
                lastname = responseCharData.lastname,
                job = {
                    name = responseJobData.name,
                    label = responseJobData.label,
                    grade_label = responseJobData.grade.name
                },
                id = id
            }
            table.insert(characters, characterData)
        end
    end

    return characters
end

Characters.GetFirst = function(src)
    local identifier = Characters.GetIdentifier(src)
    local query
    if FrameworkSelected == 'ESX' then
        query = "SELECT * FROM `users` WHERE identifier LIKE '%"..identifier.."'"
    elseif FrameworkSelected == 'QBCore' then
        query = "SELECT * FROM `players` WHERE `license` LIKE '%"..identifier.."' ORDER BY `id`"
    end
    local response = MySQL.query.await(query)
    if FrameworkSelected == 'ESX' then
        local PREFIX = Config.Prefix
        for k,v in ipairs(response) do
            local checkMulticharacterMode = string.sub(v.identifier, 1, string.len(PREFIX)) == PREFIX
            assert(checkMulticharacterMode, '^5Your es_extended does not use Config.Multichar. Player identifier: ^3'..v.identifier..'\n^2Please refer to the docs: https://zsx-development.gitbook.io/docs/multicharacter/common-issues/esx\n\n')
            local job = v.job
            local grade = v.job_grade
            assert(Characters.Jobs[job] ~= nil, '^5Failed to get the job from object. Player identifier: ^3'..v.identifier..'\n^2Please refer to the docs: https://zsx-development.gitbook.io/docs/multicharacter/common-issues/esx\n\n')
            assert(Characters.JobGrades[job] ~= nil, '^5Failed to get the job grade from object. Player identifier: ^3'..v.identifier..'\n^2Please refer to the docs: https://zsx-development.gitbook.io/docs/multicharacter/common-issues/esx\n\n')
            assert(Characters.JobGrades[job][tonumber(grade)] ~= nil, '^5Failed to get the job grade from object. Player identifier: ^3'..v.identifier..'\n^2Please refer to the docs: https://zsx-development.gitbook.io/docs/multicharacter/common-issues/esx\n\n')
            assert(v.position ~= nil, '^5Failed to get player position. Player identifier: ^3'..v.identifier..'\n^2Please refer to the docs: https://zsx-development.gitbook.io/docs/multicharacter/common-issues/esx\n\n')
            v.skin = Characters.ConvertSkin(v.identifier)
            v.job = {
                name = job,
                label = Characters.Jobs[job],
                grade_label = Characters.JobGrades[job][tonumber(grade)]
            }
            v.id = tonumber(string.sub(v.identifier, #PREFIX+1, string.find(v.identifier, ':')-1))
        end
        return response[1]
    elseif FrameworkSelected == 'QBCore' then
        local skinResponse = MySQL.query.await("SELECT * FROM `playerskins` WHERE `citizenid` = '"..response[1].citizenid.."' AND active = 1")
        local responseCharData = json.decode(response[1].charinfo)
        local responseJobData = json.decode(response[1].job)
        local characterData = {
            sex = tonumber(response[1].gender) == 0 and 'm' or 'f',
            skin = Characters.ConvertSkin(response[1].citizenid),
            model = skinResponse[1] and tonumber(skinResponse[1].model) or false,
            position = json.decode(response[1].position),
            firstname = responseCharData.firstname,
            lastname = responseCharData.lastname,
            job = {
                name = responseJobData.name,
                label = responseJobData.label,
                grade_label = responseJobData.grade.name
            },
            id = response[1].cid
        }
        return characterData
    end
end

Characters.GetNum = function(src, num)
    local identifier = Characters.GetIdentifier(src)
    local query
    if FrameworkSelected == 'ESX' then
        query = "SELECT * FROM `users` WHERE identifier LIKE '%"..Config.Prefix..''..num..':'..identifier.."'"
    elseif FrameworkSelected == 'QBCore' then
        query = "SELECT * FROM `players` WHERE `license` LIKE '%"..identifier.."' AND `cid` = "..num..""
    end
    local response = MySQL.query.await(query)
    local PREFIX = Config.Prefix
    if FrameworkSelected == 'ESX' then
        for k,v in ipairs(response) do
            local checkMulticharacterMode = string.sub(v.identifier, 1, string.len(PREFIX)) == PREFIX
            assert(checkMulticharacterMode, '^5Your es_extended does not use Config.Multichar. Player identifier: ^3'..v.identifier..'\n^2Please refer to the docs: https://zsx-development.gitbook.io/docs/multicharacter/common-issues/esx\n\n')
            local job = v.job
            local grade = v.job_grade
            assert(Characters.Jobs[job] ~= nil, '^5Failed to get the job from object. Player identifier: ^3'..v.identifier..'\n^2Please refer to the docs: https://zsx-development.gitbook.io/docs/multicharacter/common-issues/esx\n\n')
            assert(Characters.JobGrades[job] ~= nil, '^5Failed to get the job grade from object. Player identifier: ^3'..v.identifier..'\n^2Please refer to the docs: https://zsx-development.gitbook.io/docs/multicharacter/common-issues/esx\n\n')
            assert(Characters.JobGrades[job][tonumber(grade)] ~= nil, '^5Failed to get the job grade from object. Player identifier: ^3'..v.identifier..'\n^2Please refer to the docs: https://zsx-development.gitbook.io/docs/multicharacter/common-issues/esx\n\n')
            assert(v.position ~= nil, '^5Failed to get player position. Player identifier: ^3'..v.identifier..'\n^2Please refer to the docs: https://zsx-development.gitbook.io/docs/multicharacter/common-issues/esx\n\n')
            v.skin = Characters.ConvertSkin(v.identifier)
            v.job = {
                name = job,
                label = Characters.Jobs[job],
                grade_label = Characters.JobGrades[job][tonumber(grade)]
            }
        end
        return {character = response[1], id = num}
    elseif FrameworkSelected == 'QBCore' then
        local skinResponse = MySQL.query.await("SELECT * FROM `playerskins` WHERE `citizenid` = '"..response[1].citizenid.."' AND active = 1")
        local responseCharData = json.decode(response[1].charinfo)
        local responseJobData = json.decode(response[1].job)
        local characterData = {
            sex = tonumber(response[1].gender) == 0 and 'm' or 'f',
            skin = Characters.ConvertSkin(response[1].citizenid),
            model = skinResponse[1] and tonumber(skinResponse[1].model) or false,
            position = json.decode(response[1].position),
            firstname = responseCharData.firstname,
            lastname = responseCharData.lastname,
            job = {
                name = responseJobData.name,
                label = responseJobData.label,
                grade_label = responseJobData.grade.name
            }
        }
        return {character = characterData, id = num}
    end
    
end

Characters.DoesUserHaveCharacters = function(src)
    local identifier = Characters.GetIdentifier(src)
    local query
    if FrameworkSelected == 'ESX' then
        query = "SELECT * FROM `users` WHERE identifier LIKE '%"..identifier.."'"
    elseif FrameworkSelected == 'QBCore' then
        query = "SELECT * FROM `players` WHERE `license` LIKE '%"..identifier.."'"
    end
    local response = MySQL.query.await(query)
    return #response > 0
end

Characters.GetSlots = function(src)
    local identifier = Characters.GetIdentifier(src, true)
    local query = "SELECT * FROM `zsx_multicharacter_slots` WHERE `identifier` = ?"
    local result = MySQL.prepare.await(query, {identifier})
    if not result or not result.amount then 
        MySQL.insert.await('INSERT INTO `zsx_multicharacter_slots` (`identifier`, `amount`) VALUES (?, ?)', {
            identifier,
            Config.Characters.Free,
        })
        return Config.Characters.Free
    end
    return result.amount
end

Characters.GetAmount = function(src)
    local identifier = Characters.GetIdentifier(src)
    local query
    if FrameworkSelected == 'ESX' then
        query = "SELECT COUNT(*) FROM `users` WHERE identifier LIKE '%"..identifier.."'"
    elseif FrameworkSelected == 'QBCore' then
        query = "SELECT COUNT(*) FROM `players` WHERE `license` LIKE '%"..identifier.."'"
    end
    local response = MySQL.query.await(query)
    return tonumber(response[1]['COUNT(*)'])
end

Characters.ConvertProperties = function(identifier, charId)
    local properties = {}
    if GetResourceState('esx_property') == 'started' then
        -- only for ESX
        local query = "SELECT * FROM `owned_properties` WHERE `owner` = ?"
        local response = MySQL.query.await(query,  {Config.Prefix..''..charId..':'..identifier})
        if response then
            for k,v in ipairs(response) do
                local queryPropertiesData = "SELECT `name`, `label`, `entering` FROM `properties` WHERE `name` = ?"
                local responseData = MySQL.single.await(queryPropertiesData, {v.name})
                responseData.entering = json.decode(responseData.entering)
                properties[v.name] = {
                    name = v.name,
                    type = "property",
                    label = responseData.label,
                    coords = vector3(responseData.entering.x, responseData.entering.y, responseData.entering.z),
                }
            end
        end
    end
    if GetResourceState('qb-apartments') == 'started' then
        --only for QBCore
        local citizenResponse = MySQL.query.await("SELECT `citizenid` FROM `players` WHERE `license` LIKE '%"..identifier.."' AND `cid` = ?", {charId})
        local query = "SELECT * FROM `apartments` WHERE `citizenid` = ?"
        local response = MySQL.query.await(query, {citizenResponse[1].citizenid})
        for k,v in ipairs(response) do
            if Apartments.Locations[v.type] then
                properties[v.name] = {
                    name = v.name,
                    type = "property",
                    label = v.label,
                    coords = Apartments.Locations[v.type].coords.enter,
                }
            end
        end
    end
    if GetResourceState('qb-houses') == 'started' then
        --only for QBCore
        local citizenResponse = MySQL.query.await("SELECT `citizenid` FROM `players` WHERE `license` LIKE '%"..identifier.."' AND `cid` = ?", {charId})
        local query = "SELECT * FROM `player_houses` WHERE `citizenid` = ?"
        local response = MySQL.query.await(query, {citizenResponse[1].citizenid})
        
        for k,v in ipairs(response) do
            if Characters.QBHouses[v.house] then
                properties[v.house] = {
                    name = v.house,
                    type = "property",
                    label = v.label,
                    coords = vector3(Characters.QBHouses[v.house].coords.enter.x, Characters.QBHouses[v.house].coords.enter.y, Characters.QBHouses[v.house].coords.enter.z),
                }
            end
        end
    end
    if GetResourceState('qs-housing') == 'started' then
        local response 
        if FrameworkSelected == 'QBCore' then
            local citizenResponse = MySQL.query.await("SELECT `citizenid` FROM `players` WHERE `license` LIKE '%"..identifier.."' AND `cid` = ?", {charId})
            response = MySQL.query.await("SELECT * FROM `player_houses` WHERE `citizenid` = ?", {citizenResponse[1].citizenid})
        elseif FrameworkSelected == 'ESX' then
            response = MySQL.query.await("SELECT * FROM `player_houses` WHERE `citizenid` = ?", {Config.Prefix..''..charId..':'..identifier})
        end
        for k,v in ipairs(response) do
            if Characters.QSHouses[v.house] then
                properties[v.house] = {
                    name = v.house,
                    type = "property",
                    label = Characters.QSHouses[v.house].label,
                    coords = vector3(Characters.QSHouses[v.house].coords.enter.x, Characters.QSHouses[v.house].coords.enter.y, Characters.QSHouses[v.house].coords.enter.z),
                }
            end
        end
    end
    if GetResourceState('ps-housing') == 'started' then
        --only for QBCore
        local citizenResponse = MySQL.query.await("SELECT `citizenid` FROM `players` WHERE `license` LIKE '%"..identifier.."' AND `cid` = ?", {charId})
        local query = "SELECT * FROM `properties` WHERE `owner_citizenid` = ?"
        response = MySQL.query.await(query, {citizenResponse[1].citizenid})
        for k,v in ipairs(response) do
            local coords = json.decode(v.door_data)
            if coords and coords.x and coords.y and coords.z then
                properties['house_'..v.property_id] = {
                    name = 'house_'..v.property_id,
                    type = "property",
                    label = v.apartment,
                    coords = vector3(coords.x, coords.y, coords.z),
                }
            end
        end
    end
    if GetResourceState('bcs_housing') == 'started' then
        local response
        if FrameworkSelected == 'ESX' then
            response = exports['bcs_housing']:GetOwnedHomes(Config.Prefix..''..charId..':'..identifier)
        elseif FrameworkSelected == 'QBCore' then
            local citizenResponse = MySQL.query.await("SELECT `citizenid` FROM `players` WHERE `license` LIKE '%"..identifier.."' AND `cid` = ?", {charId})
            response = exports['bcs_housing']:GetOwnedHomes(citizenResponse[1].citizenid)
        end
        for k,v in ipairs(response) do
            properties[v.identifier] = {
                name = v.identifier,
                type = "property",
                label = v.name,
                coords = vector3(v.entry.x, v.entry.y, v.entry.z),
            }
        end
    end
    if GetResourceState('loaf_housing') == 'started' then
    end
    return properties
end

local function mergeTables(...)
    local mergedTable = {}
    for _, tbl in ipairs({...}) do
        if type(tbl) == "table" then
            for index, value in pairs(tbl) do
                mergedTable[index] = value
            end
        end
    end
    return mergedTable
end

Characters.ConvertSkin = function(convertedIdentifier)
    local skin = nil
    local appearanceResource = Config.ForceAppereance ~= false and Config.ForceAppereance or (GetResourceState('skinchanger') == 'started' and 'skinchanger' or GetResourceState('skinchanger') == 'fivem-appearance' and 'fivem-appearance' or GetResourceState('illenium-appearance') == 'started' and 'illenium-appearance' or GetResourceState('qb-clothing') == 'started' and 'qb-clothing' or GetResourceState('crm-appearance') == 'started' and 'crm-appearance' or GetResourceState('bl_appearance') == 'started' and 'bl_appearance' or GetResourceState('tgiann-clothing') == 'started' and 'tgiann-clothing')
    if appearanceResource == 'skinchanger' then
        if FrameworkSelected == 'ESX' then
            local result = MySQL.query.await("SELECT `skin` FROM `users` WHERE `identifier` = ?", {convertedIdentifier})
            if result and result[1] and result[1].skin then
                skin = json.decode(result[1].skin)
            end
        elseif FrameworkSelected == 'QBCore' then
            local result = MySQL.query.await("SELECT * FROM `playerskins` WHERE `citizenid` = ? AND active = 1", {convertedIdentifier})
            if result and result[1] and result[1].skin then
                skin = json.decode(result[1].skin)
            end
        end
    elseif appearanceResource == 'fivem-appearance' then
        if FrameworkSelected == 'ESX' then
            local result = MySQL.query.await("SELECT `skin` FROM `users` WHERE `identifier` = ?", {convertedIdentifier})
            if result and result[1] and result[1].skin then
                skin = json.decode(result[1].skin)
            end
        elseif FrameworkSelected == 'QBCore' then
            local result = MySQL.query.await("SELECT * FROM `playerskins` WHERE `citizenid` = ? AND active = 1", {convertedIdentifier})
            if result and result[1] and result[1].skin then
                skin = json.decode(result[1].skin)
            end
        end
    elseif appearanceResource == 'illenium-appearance' then
        if FrameworkSelected == 'ESX' then
            local result = MySQL.query.await("SELECT `skin` FROM `users` WHERE `identifier` = ?", {convertedIdentifier})
            if result and result[1] and result[1].skin then
                skin = json.decode(result[1].skin)
            end
        elseif FrameworkSelected == 'QBCore' then
            local result = MySQL.query.await("SELECT * FROM `playerskins` WHERE `citizenid` = ? AND active = 1", {convertedIdentifier})
            if result and result[1] and result[1].skin then
                skin = json.decode(result[1].skin)
            end
        end
    elseif appearanceResource == 'qb-clothing' then
        if FrameworkSelected == 'ESX' then
            debugPrint('Tried to access qb-clothing in ESX. Are you sure you added proper resource to your framework?')
        elseif FrameworkSelected == 'QBCore' then
            local result = MySQL.query.await("SELECT * FROM `playerskins` WHERE `citizenid` = ? AND active = 1", {convertedIdentifier})
            if result and result[1] and result[1].skin then
                skin = json.decode(result[1].skin)
            end
        end
    elseif appearanceResource == 'crm-appearance' then
        if FrameworkSelected == 'ESX' then
            local result = MySQL.query.await("SELECT `skin` FROM `users` WHERE `identifier` = ?", {convertedIdentifier})
            if result and result[1] and result[1].skin then
                skin = json.decode(result[1].skin)
            end
        elseif FrameworkSelected == 'QBCore' then
            local result = MySQL.query.await("SELECT * FROM `playerskins` WHERE `citizenid` = ? AND active = 1", {convertedIdentifier})
            if result and result[1] and result[1].skin then
                skin = json.decode(result[1].skin)
            end
        end
    elseif appearanceResource == 'bl_appearance' then
        local result = MySQL.query.await("SELECT * FROM `appearance` WHERE `id` = ?", {convertedIdentifier})
        if result and result[1] and result[1].skin then
            local decodedSkin = json.decode(result[1].skin)
            skin = mergeTables(json.decode(result[1].skin), json.decode(result[1].clothes), json.decode(result[1].tattoos))
        end
    elseif appearanceResource == 'tgiann-clothing' then
        local result = MySQL.query.await("SELECT * FROM tgiann_skin WHERE citizenid = ?", { convertedIdentifier })
        if result and result[1] and result[1].skin then
            skin = {
                skin = json.decode(result[1].skin),
                model = tonumber(result[1].model)
            }
        end
    end
    return skin
end

Characters.Remove = function(src, charid)
    local identifier = Characters.GetIdentifier(src)
    local query
    if FrameworkSelected == 'ESX' then
        query = "DELETE FROM `users` WHERE `identifier` = '"..Config.Prefix..""..charid..":"..identifier.."'"
    elseif FrameworkSelected == 'QBCore' then
        query = "DELETE FROM `players` WHERE `license` LIKE '%"..identifier.."' AND `cid` = "..charid
    end
    MySQL.query.await(query)
end

Characters.GetProperties = function(src, charId)
    if not charId then charId = 1 end
    local identifier = Characters.GetIdentifier(src)
    local properties = Characters.ConvertProperties(identifier, charId)

    return properties
end

Framework.RegisterServerCallback('ZSX_Multicharacter:Get:Characters', function(source, cb)
    cb(Characters.Get(source))
end)

Framework.RegisterServerCallback('ZSX_Multicharacter:Get:FirstChar', function(source, cb)
    cb(Characters.GetFirst(source))
end)

Framework.RegisterServerCallback('ZSX_Multicharacter:Get:NumChar', function(source, cb, num)
    cb(Characters.GetNum(source, num))
end)

Framework.RegisterServerCallback('ZSX_Multicharacter:Get:PlayerSlots', function(source, cb)
    cb(Characters.GetSlots(source))
end)

Framework.RegisterServerCallback('ZSX_Multicharacter:Get:CharactersExists', function(source, cb)
    cb(Characters.DoesUserHaveCharacters(source))
end)

Framework.RegisterServerCallback('ZSX_Multicharacter:Get:Properties', function(source, cb, id)
    cb(Characters.GetProperties(source, id))
end)

Framework.RegisterServerCallback('ZSX_Multicharacter:Event:SelectedCharacter', function(source, cb, id)
    if FrameworkSelected == 'ESX' then
        TriggerEvent('esx:onPlayerJoined', source, 'char'..id)
        while ESX.GetPlayerFromId(source) == nil do
            Wait(100)
        end
        Characters.ActiveUsers[tostring(source)] = {
            id = id,
            identifier = Characters.GetIdentifier(source),
        }
        cb('DONE')
    elseif FrameworkSelected == 'QBCore' then
        local identifier = Characters.GetIdentifier(source)
        local response = MySQL.query.await("SELECT `citizenid` FROM `players` WHERE `license` LIKE '%"..identifier.."' AND `cid` = "..id)
        if QBCore.Player.Login(source, response[1].citizenid) then
            repeat
                Wait(10)
            until QBCore.Functions.GetPlayerByCitizenId(response[1].citizenid)
            Characters.ActiveUsers[tostring(source)] = {
                id = id,
                identifier = Characters.GetIdentifier(source),
            }
            TriggerClientEvent('ZSX_Multicharacter:CreateQBInstance', source)
            cb('DONE')
            print('^2[qb-core]^7 '..GetPlayerName(source)..' has succesfully loaded!')
            QBCore.Commands.Refresh(source)
            TriggerEvent("qb-log:server:CreateLog", "joinleave", "Loaded", "green", "**".. GetPlayerName(source) .. "** ("..(QBCore.Functions.GetIdentifier(source, 'discord') or 'undefined') .." |  ||"  ..(QBCore.Functions.GetIdentifier(source, 'ip') or 'undefined') ..  "|| | " ..(QBCore.Functions.GetIdentifier(source, 'license') or 'undefined') .." | "..source..") loaded..")
        end
    end
end)

Framework.RegisterServerCallback('ZSX_Multicharacter:Event:RemoveCharacter', function(source, cb, id)
    Characters.Remove(source, id)
    cb(Characters.DoesUserHaveCharacters(source))
end)

RegisterNetEvent('ZSX_Multicharacter:Event:Logout')
AddEventHandler('ZSX_Multicharacter:Event:Logout', function()
    if FrameworkSelected == 'ESX' then
        TriggerEvent('esx:playerLogout', source)
    elseif FrameworkSelected == 'QBCore' then
        QBCore.Player.Logout(source)
    end
end)

RegisterNetEvent('ZSX_Multicharacter:Save:Appereance')
AddEventHandler('ZSX_Multicharacter:Save:Appereance', function(skin)
    if not skin then return debugPrint('There was an error saving player skin') end
    if FrameworkSelected == 'ESX' then
		local xPlayer = ESX.GetPlayerFromId(source)
		MySQL.query.await('UPDATE users SET skin = ? WHERE identifier = ?', {json.encode(skin), xPlayer.identifier})
	elseif FrameworkSelected == 'QBCore' then
		local Player = QBCore.Functions.GetPlayer(source)
        MySQL.query('DELETE FROM playerskins WHERE citizenid = ?', { Player.PlayerData.citizenid }, function()
            MySQL.insert('INSERT INTO playerskins (citizenid, model, skin, active) VALUES (?, ?, ?, ?)', {Player.PlayerData.citizenid, skin.model, json.encode(skin), 1})
        end)
	end
end)

Framework.RegisterServerCallback('ZSX_Multicharacter:Create:Player', function(source, cb, data)
    local src = source
    local playerSlots = Characters.GetSlots(src)
    local playerCharacters = Characters.GetAmount(src)
    if playerCharacters + 1 > playerSlots then return debugPrint('User: '..GetPlayerName(src)..' ['..src..']'..' attempt to create a character with max amount of slots.') end
    if FrameworkSelected == 'ESX' then
        TriggerEvent('esx:onPlayerJoined', source, Config.Prefix..''..(data.charIndex or playerCharacters + 1), {
            firstname = data.firstname,
            lastname = data.lastname,
            sex = data.gender == 'male' and 'm' or 'f',
            height = tonumber(data.height),
            dateofbirth = data.date,
        })

        while ESX.GetPlayerFromId(source) == nil do
            Wait(100)
        end

        Characters.ActiveUsers[tostring(source)] = {
            id = data.charIndex or (playerCharacters + 1),
            identifier = Characters.GetIdentifier(source),
        }
        Addon.StarterItems(source)

        cb({id = data.charIndex or playerCharacters + 1})
    elseif FrameworkSelected == 'QBCore' then
        local identifier = Characters.GetIdentifier(source)
        if QBCore.Player.Login(source, false, {
            cid = data.charIndex or playerCharacters + 1,
            charinfo = {
                firstname = data.firstname,
                lastname = data.lastname,
                birthdate = data.date,
                gender = data.gender == 'male' and 0 or 1,
                height = tonumber(data.height),
                nationality = data.nationality
            }
        }) then

            repeat
                Wait(10)
            until QBCore.Functions.GetPlayer(source)

            Addon.StarterItems(source)

            TriggerClientEvent('ZSX_Multicharacter:CreateQBInstance', source)
            Characters.ActiveUsers[tostring(source)] = {
                id = data.charIndex or (playerCharacters + 1),
                identifier = Characters.GetIdentifier(source),
            }
            
            cb({id = data.charIndex or playerCharacters + 1})
            
            print('^2[qb-core]^7 '..GetPlayerName(source)..' has succesfully loaded!')
            QBCore.Commands.Refresh(source)
            TriggerEvent("qb-log:server:CreateLog", "joinleave", "Loaded", "green", "**".. GetPlayerName(source) .. "** ("..(QBCore.Functions.GetIdentifier(source, 'discord') or 'undefined') .." |  ||"  ..(QBCore.Functions.GetIdentifier(source, 'ip') or 'undefined') ..  "|| | " ..(QBCore.Functions.GetIdentifier(source, 'license') or 'undefined') .." | "..source..") loaded..")
        end
    end
end)

if FrameworkSelected == 'QBCore' then
    MySQL.ready(function()
        MySQL.query.await('CREATE TABLE IF NOT EXISTS `zsx_multicharacter_slots` (`identifier` varchar(255) NOT NULL, `amount` int(1) NOT NULL, PRIMARY KEY (`identifier`) ) ENGINE=InnoDB DEFAULT CHARSET=utf8;')
        if GetResourceState('qb-houses') == 'started' then
            local housesList = MySQL.query.await('SELECT * FROM houselocations', {})
            Characters.QBHouses = {}
            for k,v in ipairs(housesList) do
                if v.owned == 1 then
                    Characters.QBHouses[v.name] = {
                        label = v.label,
                        coords = json.decode(v.coords),
                    }
                end
            end
        end
    end)
    function loadHouseData(src) -- function to load data to other resources for QBCore
        local HouseGarages = {}
        local Houses = {}
        local result = MySQL.query.await('SELECT * FROM houselocations', {})
        if result[1] ~= nil then
            for _, v in pairs(result) do
                local owned = false
                if tonumber(v.owned) == 1 then
                    owned = true
                end
                local house_coords = json.decode(v.coords)
                local garage = v.garage ~= nil and json.decode(v.garage) or {}
                Houses[v.name] = {
                    name = v.name,
                    coords = house_coords.enter,
                    owned = owned,
                    price = v.price,
                    locked = true,
                    type = 'property',
                    adress = v.label,
                    tier = v.tier,
                    garage = garage,
                    decorations = {},
                }
                HouseGarages[v.name] = {
                    label = v.label,
                    takeVehicle = garage,
                }
            end
        end
        TriggerClientEvent("qb-garages:client:houseGarageConfig", src, HouseGarages)
        TriggerClientEvent("qb-houses:client:setHouseConfig", src, Houses)
        return Houses
    end
end

MySQL.ready(function()
    Wait(1000)
    if GetResourceState('qs-housing') == 'started' then
        local housesList = MySQL.query.await('SELECT * FROM houselocations', {})
        Characters.QSHouses = {}
        for k,v in ipairs(housesList) do
            Characters.QSHouses[v.name] = {
                label = v.label,
                coords = json.decode(v.coords),
            }
        end
    end
end)
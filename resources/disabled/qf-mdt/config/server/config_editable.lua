EDITABLE = {}

---@param xPlayer xPlayer
---@return string
EDITABLE.GetBadge = function(xPlayer)
    if xPlayer then
        if Config.ShowBadgeSystem then
            --// Add your badge system below commented code is example use of my badges in esx

            -- local badge = json.decode(xPlayer.get('job_id'))
                                        
            -- if badge.id then
            --     badge.id = badge.id
            --     return '['..badge.id..']'
            -- else
            --     badge.id = 0
            --     return '['..badge.id..']'
            -- end

            -- return "[01]"
            print('[QF-MDT-LSPD]: REMEMBER TO CONFIGURE GET BADGE SYSTEM (config_editable:21)!')
            return "[01]"
        else
            return tostring(xPlayer.source)
        end
    end
end

EDITABLE.GetRadio = function(id)
    if id then
        if Config.ShowRadio then
            if Config.UsingRadio.pma_voice then
                local plyState = Player(id).state
                local radioChannel = plyState.radioChannel

                if radioChannel == nil or radioChannel == 0 then
                    return 'Unknown'
                end

                return tostring(radioChannel)
            else
                -- print('[QF-MDT-LSPD]: SET YOUR EXPORT FOR USERID RADIO CHANNEL (config_editable:42)')
                return '0'
            end
        else
            return "["..tostring(id).."]"
        end
    end
end

---@param xPlayer xPlayer
---@return int
EDITABLE.GetPhoneNumber = function(identifier)
    --// Add your function for get phone number
    if Config.Phones.hype_phone then
        if Config.Frameworks.ESX.enabled then
            local SELECT_PHONE_NUMBER = 'SELECT `phone_number` FROM `users` WHERE `identifier` = ?'
            local number = ''

            if not number or number == '' then
                local result = MySQL.Sync.fetchAll(SELECT_PHONE_NUMBER, { identifier })
                if result[1] then
                    number = result[1].phone_number
                end
            end
            
            return number
        elseif Config.Frameworks.QB.enabled then
            local SELECT_PHONE_NUMBER = 'SELECT `charinfo` FROM `players` WHERE `citizenid` = ?'
            local number = ''

            if not number or number == '' then
                local result = MySQL.Sync.fetchAll(SELECT_PHONE_NUMBER, { identifier })
                if result[1] then
                    number = json.decode(result[1].phone)
                end
            end
            
            return number
        else
            print('[^2INFO^0] [^5QF-MDT^0] Please configure [^2EDITABLE.GetPhoneNumber^0]')
            return 555555
        end
    elseif Config.Phones.qs_smartphone then
        if Config.Frameworks.ESX.enabled then
            local query = "SELECT JSON_UNQUOTE(JSON_EXTRACT(charinfo, '$.phone')) AS phone FROM users WHERE identifier = ?"
            local response = MySQL.query.await(query, {identifier})

            if response and #response > 0 then
                local phone = response[1].phone

                if phone ~= nil and phone ~= '' then
                    return phone
                end
            end

            return 555555
        elseif Config.Frameworks.QB.enabled then
            local query = "SELECT JSON_UNQUOTE(JSON_EXTRACT(charinfo, '$.phone')) AS phone FROM players WHERE citizenid = ?"
            local response = MySQL.query.await(query, {identifier})

            if response and #response > 0 then
                local phone = response[1].phone

                if phone ~= nil and phone ~= '' then
                    return phone
                end
            end

            return 555555
        else
            print('[^2INFO^0] [^5QF-MDT^0] Please configure [^2EDITABLE.GetPhoneNumber^0]')
            return 555555
        end
    elseif Config.Phones.qs_smartphone_pro then
        return exports['qs-smartphone-pro']:GetPhoneNumberFromIdentifier(identifier, true)
    elseif Config.Phones.yflip_phone then
        return exports["yflip-phone"]:GetPhoneNumberByIdentifier(identifier)
    elseif Config.Phones.lb_phone then
        if Config.Frameworks.ESX.enabled then
            local query = "SELECT phone_number AS phone FROM phone_phones WHERE id = ?"
            local response = MySQL.query.await(query, {identifier})

            if response and #response > 0 then
                local phone = response[1].phone

                if phone ~= nil and phone ~= '' then
                    return phone
                end
            end

            return 555555
        elseif Config.Frameworks.QB.enabled then
            local query = "SELECT phone_number AS phone FROM phone_phones WHERE id = ?"
            local response = MySQL.query.await(query, {identifier})

            if response and #response > 0 then
                local phone = response[1].phone

                if phone ~= nil and phone ~= '' then
                    return phone
                end
            end

            return 555555
        else
            print('[^2INFO^0] [^5QF-MDT^0] Please configure [^2EDITABLE.GetPhoneNumber^0]')
            return 555555
        end
    elseif Config.Phones.qb_phone then
        if Config.Frameworks.ESX.enabled then
            local query = "SELECT JSON_UNQUOTE(JSON_EXTRACT(charinfo, '$.phone')) AS phone FROM users WHERE identifier = ?"
            local response = MySQL.query.await(query, {identifier})

            if response and #response > 0 then
                local phone = response[1].phone

                if phone ~= nil and phone ~= '' then
                    return phone
                end
            end

            return 555555
        elseif Config.Frameworks.QB.enabled then
            local query = "SELECT JSON_UNQUOTE(JSON_EXTRACT(charinfo, '$.phone')) AS phone FROM players WHERE citizenid = ?"
            local response = MySQL.query.await(query, {identifier})

            if response and #response > 0 then
                local phone = response[1].phone

                if phone ~= nil and phone ~= '' then
                    return phone
                end
            end

            return 555555
        else
            print('[^2INFO^0] [^5QF-MDT^0] Please configure [^2EDITABLE.GetPhoneNumber^0]')
            return 555555
        end
    elseif Config.Phones.gks_phone then
        if Config.Frameworks.ESX.enabled then
            local SELECT_PHONE_NUMBER = 'SELECT `phone_number` FROM `gksphone_settings` WHERE `identifier` = ?'
            local number = ''

            if not number or number == '' then
                local result = MySQL.Sync.fetchAll(SELECT_PHONE_NUMBER, { identifier })
                if result[1] then
                    number = result[1].phone_number
                end
            end
            
            return number
        elseif Config.Frameworks.QB.enabled then
            local query = "SELECT JSON_UNQUOTE(JSON_EXTRACT(charinfo, '$.phone')) AS phone FROM players WHERE citizenid = ?"
            local response = MySQL.query.await(query, {identifier})

            if response and #response > 0 then
                local phone = response[1].phone

                if phone ~= nil and phone ~= '' then
                    return phone
                end
            end

            return 555555
        else
            print('[^2INFO^0] [^5QF-MDT^0] Please configure [^2EDITABLE.GetPhoneNumber^0]')
            return 555555
        end
    elseif Config.Phones.road_phone then
        local number = exports['roadphone']:getNumberFromIdentifier(identifier)

        if number then
            return number
        else
            return 555555
        end
    elseif Config.Phones.npwd_phone then
        if Config.Frameworks.ESX.enabled then
            local query = "SELECT phone_number AS phone FROM users WHERE identifier = ?"
            local response = MySQL.query.await(query, {identifier})

            if response and #response > 0 then
                local phone = response[1].phone

                if phone ~= nil and phone ~= '' then
                    return phone
                end
            end

            return 555555
        elseif Config.Frameworks.QB.enabled then
            local query = "SELECT phone_number AS phone FROM players WHERE id = ?"
            local response = MySQL.query.await(query, {identifier})

            if response and #response > 0 then
                local phone = response[1].phone

                if phone ~= nil and phone ~= '' then
                    return phone
                end
            end

            return 555555
        else
            print('[^2INFO^0] [^5QF-MDT^0] Please configure [^2EDITABLE.GetPhoneNumber^0]')
            return 555555
        end
    elseif Config.Phones.okok_phone then
        local query = "SELECT phone_number AS phone FROM okokphone_phones WHERE owner = ?"
        local response = MySQL.query.await(query, {identifier})

        if response and #response > 0 then
            local phone = response[1].phone

            if phone ~= nil and phone ~= '' then
                return phone
            end
        end

        return 555555
    else
        print('[^2INFO^0] [^5QF-MDT^0] Please configure [^2EDITABLE.GetPhoneNumber^0]')
        return 555555
    end
end

---@param time number
---@return string
EDITABLE.ConvertTime = function(time)
    if not time then
        return "00:00:00"
    end

    local hours = math.floor(time / 3600)
    local remaining = time % 3600
    local minutes = math.floor(remaining / 60)
    remaining = remaining % 60
    local seconds = remaining

    if hours < 10 then
        hours = "0" .. tostring(hours)
    end
    if minutes < 10 then
        minutes = "0" .. tostring(minutes)
    end
    if seconds < 10 then
        seconds = "0" .. tostring(seconds)
    end

    local answer = hours .. ":" .. minutes .. ":" .. seconds
    
    return answer
end


EDITABLE.GetTime = function(xPlayer)
    --// Add your duty time system
    if xPlayer then
        if xPlayer.source then
            local rank = Player(xPlayer.source).state.RankTimePolice
            if rank then
                return tostring((Player(xPlayer.source).state.RankTimePolice / 60))
            else
                return "0"
            end
        end
    end

    return "0"
end

CALLBACK.RegisterServerCallback('qf_mdt:getCurrentHouse', function(source, cb, value)
    if Config.Properties.esx_property_old then
        local property = MySQL.single.await('SELECT label, name FROM properties WHERE LOWER(`name`) LIKE "%' .. value:lower() .. '%" LIMIT 30')

        local house_data = {
            label = property.label,
            name = property.name,
            data = {
                owned = false,
                owner = '',
            },
            notes = {}
        }

        local owner = MySQL.single.await('SELECT owner FROM owned_properties WHERE name = ?', {value})
        if owner and owner.owner then
            local a = MySQL.single.await('SELECT firstname, lastname FROM users WHERE identifier = ?', {owner.owner})
            house_data.data.owned = true
            house_data.data.owner = a.firstname .. ' ' .. a.lastname
        end

        local notes = MySQL.query.await('SELECT id, date, note, officer FROM qf_mdt_housenotes WHERE house_name = ?', {value})
        if #notes > 0 then
            for h, j in pairs(notes) do
                local notes_length = #house_data.notes
                house_data.notes[notes_length + 1] = {
                    id = j.id,
                    date = j.date,
                    reason = j.note,
                    officer = j.officer
                }
            end
        end

        cb(house_data)
    elseif Config.Properties.esx_property_legacy then
        local PropertiesList = LoadResourceFile("esx_property", 'properties.json')
        local Properties = {}

        if PropertiesList then
            Properties = json.decode(PropertiesList)

            for k, v in pairs(Properties) do       
                if v.Name:lower():find(value:lower()) then
                    local house_data = {
                        label = v.Name,
                        name = v.Name,
                        data = {
                            owned = false,
                            owner = '',
                        },
                        notes = {}
                    }

                    local owner = v.Owner

                    if owner then
                        local ownerPlayer = FRAMEWORK.GetPlayerFromIdentifier(v.Owner)

                        if ownerPlayer then
                            house_data.data.owned = true
                            house_data.data.owner = FRAMEWORK.GetFirstName(ownerPlayer) .. ' ' .. FRAMEWORK.GetLastName(ownerPlayer)
                        else
                            house_data.data.owned = false
                            house_data.data.owner = ''
                        end
                    end

                    local notes = MySQL.query.await('SELECT id, date, note, officer FROM qf_mdt_housenotes WHERE house_name = ?', {v.Name})
                    if #notes > 0 then
                        for h, j in pairs(notes) do
                            local notes_length = #house_data.notes
                            house_data.notes[notes_length + 1] = {
                                id = j.id,
                                date = j.date,
                                reason = j.note,
                                officer = j.officer
                            }
                        end
                    end

                    cb(house_data)
                end
            end
        end
    elseif Config.Properties.qb_apartments then
        local property = MySQL.single.await('SELECT label, name FROM apartments WHERE LOWER(`name`) LIKE "%' .. value:lower() .. '%" LIMIT 30')

        local house_data = {
            label = property.label,
            name = property.name,
            data = {
                owned = false,
                owner = '',
            },
            notes = {}
        }

        local owner = MySQL.single.await('SELECT citizenid FROM apartments WHERE name = ?', {value})

        if owner then
            local ownerPlayer = FRAMEWORK.GetPlayerFromIdentifier(owner.citizenid)

            if ownerPlayer then
                house_data.data.owned = true
                house_data.data.owner = FRAMEWORK.GetFirstName(ownerPlayer) .. ' ' .. FRAMEWORK.GetLastName(ownerPlayer)
            else
                house_data.data.owned = false
                house_data.data.owner = ''
            end
        end

        local notes = MySQL.query.await('SELECT id, date, note, officer FROM qf_mdt_housenotes WHERE house_name = ?', {value})
        if #notes > 0 then
            for h, j in pairs(notes) do
                local notes_length = #house_data.notes
                house_data.notes[notes_length + 1] = {
                    id = j.id,
                    date = j.date,
                    reason = j.note,
                    officer = j.officer
                }
            end
        end

        cb(house_data)
    elseif Config.Properties.qs_housing then
        local property = MySQL.single.await('SELECT label, name FROM houselocations WHERE LOWER(`name`) LIKE "%' .. value:lower() .. '%" LIMIT 30')

        local house_data = {
            label = property.label,
            name = property.name,
            data = {
                owned = false,
                owner = '',
            },
            notes = {}
        }

        if Config.Frameworks.ESX.enabled then
            local owner = MySQL.single.await('SELECT citizenid FROM player_houses WHERE house = ?', {value})

            if owner then
                local ownerPlayer = FRAMEWORK.GetPlayerFromIdentifier(owner.citizenid)
    
                if ownerPlayer then
                    house_data.data.owned = true
                    house_data.data.owner = FRAMEWORK.GetFirstName(ownerPlayer) .. ' ' .. FRAMEWORK.GetLastName(ownerPlayer)
                else
                    house_data.data.owned = false
                    house_data.data.owner = ''
                end
            end
        elseif Config.Frameworks.QB.enabled then
            local owner = MySQL.single.await('SELECT citizenid FROM player_houses WHERE house = ?', {value})

            if owner then
                local ownerPlayer = FRAMEWORK.GetPlayerFromIdentifier(owner.citizenid)
    
                if ownerPlayer then
                    house_data.data.owned = true
                    house_data.data.owner = FRAMEWORK.GetFirstName(ownerPlayer) .. ' ' .. FRAMEWORK.GetLastName(ownerPlayer)
                else
                    house_data.data.owned = false
                    house_data.data.owner = ''
                end
            end
        end

        local notes = MySQL.query.await('SELECT id, date, note, officer FROM qf_mdt_housenotes WHERE house_name = ?', {value})
        if #notes > 0 then
            for h, j in pairs(notes) do
                local notes_length = #house_data.notes
                house_data.notes[notes_length + 1] = {
                    id = j.id,
                    date = j.date,
                    reason = j.note,
                    officer = j.officer
                }
            end
        end

        cb(house_data)
    elseif Config.Properties.loaf_housing then
        local property = MySQL.single.await('SELECT id, propertyid FROM loaf_properties WHERE LOWER(`propertyid`) LIKE "%' .. value .. '%" LIMIT 30')

        local house_data = {
            label = property.id,
            name = property.propertyid,
            data = {
                owned = false,
                owner = '',
            },
            notes = {}
        }

        local owner = MySQL.single.await('SELECT owner FROM loaf_properties WHERE propertyid = ?', {value})
        if owner then
            local ownerPlayer = FRAMEWORK.GetPlayerFromIdentifier(owner.owner)

            if ownerPlayer then
                house_data.data.owned = true
                house_data.data.owner = FRAMEWORK.GetFirstName(ownerPlayer) .. ' ' .. FRAMEWORK.GetLastName(ownerPlayer)
            else
                house_data.data.owned = false
                house_data.data.owner = ''
            end
        end

        local notes = MySQL.query.await('SELECT id, date, note, officer FROM qf_mdt_housenotes WHERE house_name = ?', {value})
        if #notes > 0 then
            for h, j in pairs(notes) do
                local notes_length = #house_data.notes
                house_data.notes[notes_length + 1] = {
                    id = j.id,
                    date = j.date,
                    reason = j.note,
                    officer = j.officer
                }
            end
        end

        cb(house_data)
    elseif Config.Properties.ps_housing then
        local property = MySQL.single.await('SELECT street, property_id FROM properties WHERE LOWER(`street`) LIKE "%' .. value:lower() .. '%" LIMIT 30')

        local house_data = {
            label = property.street,
            name = property.property_id,
            data = {
                owned = false,
                owner = '',
            },
            notes = {}
        }

        local owner = MySQL.single.await('SELECT owner_citizenid FROM properties WHERE street = ?', {value})
        if owner then
            local ownerPlayer = FRAMEWORK.GetPlayerFromIdentifier(owner.owner_citizenid)

            if ownerPlayer then
                house_data.data.owned = true
                house_data.data.owner = FRAMEWORK.GetFirstName(ownerPlayer) .. ' ' .. FRAMEWORK.GetLastName(ownerPlayer)
            else
                house_data.data.owned = false
                house_data.data.owner = ''
            end
        end

        local notes = MySQL.query.await('SELECT id, date, note, officer FROM qf_mdt_housenotes WHERE house_name = ?', {value})
        if #notes > 0 then
            for h, j in pairs(notes) do
                local notes_length = #house_data.notes
                house_data.notes[notes_length + 1] = {
                    id = j.id,
                    date = j.date,
                    reason = j.note,
                    officer = j.officer
                }
            end
        end

        cb(house_data)
    elseif Config.Properties.bcs_housing then
        local property = MySQL.single.await('SELECT name, identifier FROM house LEFT JOIN house_owned ON house.identifier = house_owned.identifier WHERE LOWER(`name`) LIKE "%' .. value:lower() .. '%" LIMIT 30')
        
        local house_data = {
            label = property.name,
            name = property.identifier,
            data = {
                owned = property.owner and true or false,
                owner = property.owner and FRAMEWORK.GetFirstName(property.owner) .. ' ' .. FRAMEWORK.GetLastName(property.owner) or '',
            },
            notes = {}
        }
        
        local notes = MySQL.query.await('SELECT id, date, note, officer FROM qf_mdt_housenotes WHERE house_name = ?', { value })
        if #notes > 0 then
            for h, j in pairs(notes) do
                local notes_length = #house_data.notes
                house_data.notes[notes_length + 1] = {
                    id = j.id,
                    date = j.date,
                    reason = j.note,
                    officer = j.officer
                }
            end
        end
        
        cb(house_data)
    elseif Config.Properties.nolag_properties then
        local property = MySQL.single.await('SELECT label, name FROM properties WHERE LOWER(`name`) LIKE "%' .. value:lower() .. '%" LIMIT 30')

        local house_data = {
            label = property.label,
            name = property.name,
            data = {
                owned = false,
                owner = '',
            },
            notes = {}
        }

        if Config.Frameworks.ESX.enabled then
            local owner = MySQL.single.await('SELECT owner FROM properties WHERE name = ?', {value})

            if owner then
                local ownerPlayer = FRAMEWORK.GetPlayerFromIdentifier(owner.owner)
    
                if ownerPlayer then
                    house_data.data.owned = true
                    house_data.data.owner = FRAMEWORK.GetFirstName(ownerPlayer) .. ' ' .. FRAMEWORK.GetLastName(ownerPlayer)
                else
                    house_data.data.owned = false
                    house_data.data.owner = ''
                end
            end
        elseif Config.Frameworks.QB.enabled then
            local owner = MySQL.single.await('SELECT owner FROM properties WHERE name = ?', {value})

            if owner then
                local ownerPlayer = FRAMEWORK.GetPlayerFromIdentifier(owner.owner)
    
                if ownerPlayer then
                    house_data.data.owned = true
                    house_data.data.owner = FRAMEWORK.GetFirstName(ownerPlayer) .. ' ' .. FRAMEWORK.GetLastName(ownerPlayer)
                else
                    house_data.data.owned = false
                    house_data.data.owner = ''
                end
            end
        end

        local notes = MySQL.query.await('SELECT id, date, note, officer FROM qf_mdt_housenotes WHERE house_name = ?', {value})
        if #notes > 0 then
            for h, j in pairs(notes) do
                local notes_length = #house_data.notes
                house_data.notes[notes_length + 1] = {
                    id = j.id,
                    date = j.date,
                    reason = j.note,
                    officer = j.officer
                }
            end
        end

        cb(house_data)
    elseif Config.Properties.rx_housing then
        local property = MySQL.single.await('SELECT label FROM rxhousing WHERE LOWER(`label`) LIKE "%' .. value:lower() .. '%" LIMIT 30')

        local house_data = {
            label = property.label,
            name = property.label,
            data = {
                owned = false,
                owner = '',
            },
            notes = {}
        }

        if Config.Frameworks.ESX.enabled then
            local owner = MySQL.single.await('SELECT owner FROM rxhousing WHERE LOWER(`label`) LIKE "%' .. value:lower() .. '%"')

            if owner then
                local ownerPlayer = FRAMEWORK.GetPlayerFromIdentifier(owner.owner)
    
                if ownerPlayer then
                    house_data.data.owned = true
                    house_data.data.owner = FRAMEWORK.GetFirstName(ownerPlayer) .. ' ' .. FRAMEWORK.GetLastName(ownerPlayer)
                else
                    house_data.data.owned = false
                    house_data.data.owner = ''
                end
            end
        elseif Config.Frameworks.QB.enabled then
            local owner = MySQL.single.await('SELECT owner FROM rxhousing WHERE LOWER(`label`) LIKE "%' .. value:lower() .. '%"')

            if owner then
                local ownerPlayer = FRAMEWORK.GetPlayerFromIdentifier(owner.owner)
    
                if ownerPlayer then
                    house_data.data.owned = true
                    house_data.data.owner = FRAMEWORK.GetFirstName(ownerPlayer) .. ' ' .. FRAMEWORK.GetLastName(ownerPlayer)
                else
                    house_data.data.owned = false
                    house_data.data.owner = ''
                end
            end
        end

        local notes = MySQL.query.await('SELECT id, date, note, officer FROM qf_mdt_housenotes WHERE house_name = ?', {value})
        if #notes > 0 then
            for h, j in pairs(notes) do
                local notes_length = #house_data.notes
                house_data.notes[notes_length + 1] = {
                    id = j.id,
                    date = j.date,
                    reason = j.note,
                    officer = j.officer
                }
            end
        end

        cb(house_data)
    elseif Config.Properties.rx_housing then
        local property = MySQL.single.await('SELECT label FROM rxhousing WHERE LOWER(`label`) LIKE "%' .. value:lower() .. '%" LIMIT 30')

        local house_data = {
            label = property.label,
            name = property.label,
            data = {
                owned = false,
                owner = '',
            },
            notes = {}
        }

        if Config.Frameworks.ESX.enabled then
            local owner = MySQL.single.await('SELECT owner FROM rxhousing WHERE LOWER(`label`) LIKE "%' .. value:lower() .. '%"')

            if owner then
                local ownerPlayer = FRAMEWORK.GetPlayerFromIdentifier(owner.owner)
    
                if ownerPlayer then
                    house_data.data.owned = true
                    house_data.data.owner = FRAMEWORK.GetFirstName(ownerPlayer) .. ' ' .. FRAMEWORK.GetLastName(ownerPlayer)
                else
                    house_data.data.owned = false
                    house_data.data.owner = ''
                end
            end
        elseif Config.Frameworks.QB.enabled then
            local owner = MySQL.single.await('SELECT owner FROM rxhousing WHERE LOWER(`label`) LIKE "%' .. value:lower() .. '%"')

            if owner then
                local ownerPlayer = FRAMEWORK.GetPlayerFromIdentifier(owner.owner)
    
                if ownerPlayer then
                    house_data.data.owned = true
                    house_data.data.owner = FRAMEWORK.GetFirstName(ownerPlayer) .. ' ' .. FRAMEWORK.GetLastName(ownerPlayer)
                else
                    house_data.data.owned = false
                    house_data.data.owner = ''
                end
            end
        end

        local notes = MySQL.query.await('SELECT id, date, note, officer FROM qf_mdt_housenotes WHERE house_name = ?', {value})
        if #notes > 0 then
            for h, j in pairs(notes) do
                local notes_length = #house_data.notes
                house_data.notes[notes_length + 1] = {
                    id = j.id,
                    date = j.date,
                    reason = j.note,
                    officer = j.officer
                }
            end
        end

        cb(house_data)
    
    else
        print('[^2INFO] ^0[^5QF-MDT^0] encountered a problem at [^5getCurrentHouse^0], if you are using a [^5CUSTOM FRAMEWORK / STANDALONE^0] open a ticket on our discord server and wait for help with configuration!')
        -- SCRIPT BY OWN
    end
end)

RegisterServerEvent('qf-mdt:searchHouses', function(value)
    local src = source
    local xPlayer = FRAMEWORK.GetPlayerFromId(src)
    
    if xPlayer then
        if Config.Jobs.OnDuty[xPlayer.job.name] then
            if Config.Properties.esx_property_old then
                local data = {}
        
                MySQL.query('SELECT label, name FROM properties WHERE CONCAT(name, " ", label) LIKE "%' .. value:lower() .. '%" LIMIT 30', {}, function(result)
                    for k, v in pairs(result) do
                        local data_length = #data
        
                        data[data_length + 1] = {
                            label = v.label,
                            name = v.name,
                            data = {
                                owned = false,
                                owner = '',
                            },
                            notes = {}
                        }
        
                        local owner = MySQL.single.await('SELECT owner FROM owned_properties WHERE name = ?', {v.name})
                        if owner and owner.owner then
                            local a = MySQL.single.await('SELECT firstname, lastname FROM users WHERE identifier = ?', {owner.owner})
                            data[data_length + 1].data.owned = true
                            data[data_length + 1].data.owner = a.firstname .. ' ' .. a.lastname
                        end
        
                        local notes = MySQL.query.await('SELECT id, date, note, officer FROM qf_mdt_housenotes WHERE house_name = ?', {v.name})
                        if #notes > 0 then
                            for h, j in pairs(notes) do
                                local notes_length = #data[data_length + 1].notes
                                data[data_length + 1].notes[notes_length + 1] = {
                                    id = j.id,
                                    date = j.date,
                                    reason = j.note,
                                    officer = j.officer
                                }
                            end
                        end
                    end
                    TriggerClientEvent('qf-mdt:housesResults', src, data)
                end)
            elseif Config.Properties.esx_property_legacy then
                local data = {}
        
                local PropertiesList = LoadResourceFile("esx_property", 'properties.json')
                local Properties = {}
        
                if PropertiesList then
                    Properties = json.decode(PropertiesList)
        
                    for k, v in pairs(Properties) do
                        local data_length = #data
        
                        if v.Name:lower():find(value:lower()) then
                            data[data_length + 1] = {
                                label = v.Name,
                                name = v.Name,
                                data = {
                                    owned = false,
                                    owner = '',
                                },
                                notes = {}
                            }
        
                            local owner = v.Owner
        
                            if owner then
                                local ownerPlayer = FRAMEWORK.GetPlayerFromIdentifier(v.Owner)
        
                                if ownerPlayer then
                                    data[data_length + 1].data.owned = true
                                    data[data_length + 1].data.owner = FRAMEWORK.GetFirstName(ownerPlayer) .. ' ' .. FRAMEWORK.GetLastName(ownerPlayer)
                                else
                                    data[data_length + 1].data.owned = false
                                    data[data_length + 1].data.owner = ''
                                end
                            end
        
                            local notes = MySQL.query.await('SELECT id, date, note, officer FROM qf_mdt_housenotes WHERE house_name = ?', {v.Name})
                            if #notes > 0 then
                                for h, j in pairs(notes) do
                                    local notes_length = #data[data_length + 1].notes
                                    data[data_length + 1].notes[notes_length + 1] = {
                                        id = j.id,
                                        date = j.date,
                                        reason = j.note,
                                        officer = j.officer
                                    }
                                end
                            end
        
                            TriggerClientEvent('qf-mdt:housesResults', src, data)
                        end             
                    end
                end
            elseif Config.Properties.qb_apartments then
                local data = {}
        
                MySQL.query('SELECT label, name FROM apartments WHERE CONCAT(name, " ", label) LIKE "%' .. value:lower() .. '%" LIMIT 30', {}, function(result)
                    for k, v in pairs(result) do
                        local data_length = #data
        
                        data[data_length + 1] = {
                            label = v.label,
                            name = v.name,
                            data = {
                                owned = false,
                                owner = '',
                            },
                            notes = {}
                        }
        
                        local owner = MySQL.single.await('SELECT citizenid FROM apartments WHERE name = ?', {value})
        
                        if owner then
                            local ownerPlayer = FRAMEWORK.GetPlayerFromIdentifier(owner.citizenid)
        
                            if ownerPlayer then
                                data[data_length + 1].data.owned = true
                                data[data_length + 1].data.owner = FRAMEWORK.GetFirstName(ownerPlayer) .. ' ' .. FRAMEWORK.GetLastName(ownerPlayer)
                            else
                                data[data_length + 1].data.owned = false
                                data[data_length + 1].data.owner = ''
                            end
                        end
        
                        local notes = MySQL.query.await('SELECT id, date, note, officer FROM qf_mdt_housenotes WHERE house_name = ?', {v.name})
                        if #notes > 0 then
                            for h, j in pairs(notes) do
                                local notes_length = #data[data_length + 1].notes
                                data[data_length + 1].notes[notes_length + 1] = {
                                    id = j.id,
                                    date = j.date,
                                    reason = j.note,
                                    officer = j.officer
                                }
                            end
                        end
                    end
                    TriggerClientEvent('qf-mdt:housesResults', src, data)
                end)
            elseif Config.Properties.qs_housing then
                local data = {}
        
                MySQL.query('SELECT label, name FROM houselocations WHERE CONCAT(name, " ", label) LIKE "%' .. value:lower() .. '%" LIMIT 30', {}, function(result)
                    for k, v in pairs(result) do
                        local data_length = #data
        
                        data[data_length + 1] = {
                            label = v.label,
                            name = v.name,
                            data = {
                                owned = false,
                                owner = '',
                            },
                            notes = {}
                        }
        
                        if Config.Frameworks.ESX.enabled then
                            local owner = MySQL.single.await('SELECT citizenid FROM player_houses WHERE house = ?', {v.name})
        
                            if owner then
                                local ownerPlayer = FRAMEWORK.GetPlayerFromIdentifier(owner.citizenid)
            
                                if ownerPlayer then
                                    data[data_length + 1].data.owned = true
                                    data[data_length + 1].data.owner = FRAMEWORK.GetFirstName(ownerPlayer) .. ' ' .. FRAMEWORK.GetLastName(ownerPlayer)
                                else
                                    data[data_length + 1].data.owned = false
                                    data[data_length + 1].data.owner = ''
                                end
                            end
                        elseif Config.Frameworks.QB.enabled then
                            local owner = MySQL.single.await('SELECT citizenid FROM player_houses WHERE house = ?', {v.name})
        
                            if owner then
                                local ownerPlayer = FRAMEWORK.GetPlayerFromIdentifier(owner.citizenid)
            
                                if ownerPlayer then
                                    data[data_length + 1].data.owned = true
                                    data[data_length + 1].data.owner = FRAMEWORK.GetFirstName(ownerPlayer) .. ' ' .. FRAMEWORK.GetLastName(ownerPlayer)
                                else
                                    data[data_length + 1].data.owned = false
                                    data[data_length + 1].data.owner = ''
                                end
                            end
                        end
        
                        local notes = MySQL.query.await('SELECT id, date, note, officer FROM qf_mdt_housenotes WHERE house_name = ?', {v.name})
                        if #notes > 0 then
                            for h, j in pairs(notes) do
                                local notes_length = #data[data_length + 1].notes
                                data[data_length + 1].notes[notes_length + 1] = {
                                    id = j.id,
                                    date = j.date,
                                    reason = j.note,
                                    officer = j.officer
                                }
                            end
                        end
                    end
                    TriggerClientEvent('qf-mdt:housesResults', src, data)
                end)
            elseif Config.Properties.loaf_housing then
                local data = {}
        
                MySQL.query('SELECT id, propertyid FROM loaf_properties WHERE CONCAT(id, " ", propertyid) LIKE "%' .. value:lower() .. '%" LIMIT 30', {}, function(result)
                    for k, v in pairs(result) do
                        local data_length = #data
        
                        data[data_length + 1] = {
                            label = v.id,
                            name = v.propertyid,
                            data = {
                                owned = false,
                                owner = '',
                            },
                            notes = {}
                        }
        
                        local owner = MySQL.single.await('SELECT owner FROM loaf_properties WHERE propertyid = ?', {v.propertyid})
                        if owner then
                            local ownerPlayer = FRAMEWORK.GetPlayerFromIdentifier(owner.owner)
        
                            if ownerPlayer then
                                data[data_length + 1].data.owned = true
                                data[data_length + 1].data.owner = FRAMEWORK.GetFirstName(ownerPlayer) .. ' ' .. FRAMEWORK.GetLastName(ownerPlayer)
                            else
                                data[data_length + 1].data.owned = false
                                data[data_length + 1].data.owner = ''
                            end
                        end
        
                        local notes = MySQL.query.await('SELECT id, date, note, officer FROM qf_mdt_housenotes WHERE house_name = ?', {v.name})
                        if #notes > 0 then
                            for h, j in pairs(notes) do
                                local notes_length = #data[data_length + 1].notes
                                data[data_length + 1].notes[notes_length + 1] = {
                                    id = j.id,
                                    date = j.date,
                                    reason = j.note,
                                    officer = j.officer
                                }
                            end
                        end
                    end
                    TriggerClientEvent('qf-mdt:housesResults', src, data)
                end)
            elseif Config.Properties.ps_housing then
                local data = {}
        
                MySQL.query('SELECT street, property_id FROM properties WHERE CONCAT(id, " ", property_id) LIKE "%' .. value:lower() .. '%" LIMIT 30', {}, function(result)
                    for k, v in pairs(result) do
                        local data_length = #data
        
                        data[data_length + 1] = {
                            label = v.street,
                            name = v.property_id,
                            data = {
                                owned = false,
                                owner = '',
                            },
                            notes = {}
                        }
        
                        local owner = MySQL.single.await('SELECT owner_citizenid FROM properties WHERE street = ?', {v.street})
                        if owner then
                            local ownerPlayer = FRAMEWORK.GetPlayerFromIdentifier(owner.owner_citizenid)
        
                            if ownerPlayer then
                                data[data_length + 1].data.owned = true
                                data[data_length + 1].data.owner = FRAMEWORK.GetFirstName(ownerPlayer) .. ' ' .. FRAMEWORK.GetLastName(ownerPlayer)
                            else
                                data[data_length + 1].data.owned = false
                                data[data_length + 1].data.owner = ''
                            end
                        end
        
                        local notes = MySQL.query.await('SELECT id, date, note, officer FROM qf_mdt_housenotes WHERE house_name = ?', {v.name})
                        if #notes > 0 then
                            for h, j in pairs(notes) do
                                local notes_length = #data[data_length + 1].notes
                                data[data_length + 1].notes[notes_length + 1] = {
                                    id = j.id,
                                    date = j.date,
                                    reason = j.note,
                                    officer = j.officer
                                }
                            end
                        end
                    end
                    TriggerClientEvent('qf-mdt:housesResults', src, data)
                end)
            elseif Config.Properties.bcs_housing then
                local data = {}

                MySQL.query('SELECT name, house.identifier, owner FROM house LEFT JOIN house_owned ON house.identifier = house_owned.identifier WHERE name LIKE "%' .. value:lower() .. '%" LIMIT 30', function(result)
                    for k, v in pairs(result) do
                        local data_length = #data
                
                        data[data_length + 1] = {
                            label = v.name,
                            name = v.identifier,
                            data = {
                                owned = v.owner and true or false,
                                owner = v.owner and FRAMEWORK.GetFirstName(v.owner) .. ' ' .. FRAMEWORK.GetLastName(v.owner) or '',
                            },
                            notes = {}
                        }
                
                        local notes = MySQL.query.await('SELECT id, date, note, officer FROM qf_mdt_housenotes WHERE house_name = ?', { v.name })
                        if #notes > 0 then
                            for h, j in pairs(notes) do
                                local notes_length = #data[data_length + 1].notes
                                data[data_length + 1].notes[notes_length + 1] = {
                                    id = j.id,
                                    date = j.date,
                                    reason = j.note,
                                    officer = j.officer
                                }
                            end
                        end
                    end
                    TriggerClientEvent('qf-mdt:housesResults', src, data)
                end)
            elseif Config.Properties.nolag_properties then
                local data = {}
        
                MySQL.query('SELECT label, name FROM properties WHERE CONCAT(name, " ", label) LIKE "%' .. value:lower() .. '%" LIMIT 30', {}, function(result)
                    for k, v in pairs(result) do
                        local data_length = #data
        
                        data[data_length + 1] = {
                            label = v.label,
                            name = v.name,
                            data = {
                                owned = false,
                                owner = '',
                            },
                            notes = {}
                        }
        
                        if Config.Frameworks.ESX.enabled then
                            local owner = MySQL.single.await('SELECT owner FROM properties WHERE house = ?', {v.name})
        
                            if owner then
                                local ownerPlayer = FRAMEWORK.GetPlayerFromIdentifier(owner.owner)
            
                                if ownerPlayer then
                                    data[data_length + 1].data.owned = true
                                    data[data_length + 1].data.owner = FRAMEWORK.GetFirstName(ownerPlayer) .. ' ' .. FRAMEWORK.GetLastName(ownerPlayer)
                                else
                                    data[data_length + 1].data.owned = false
                                    data[data_length + 1].data.owner = ''
                                end
                            end
                        elseif Config.Frameworks.QB.enabled then
                            local owner = MySQL.single.await('SELECT owner FROM properties WHERE house = ?', {v.name})
        
                            if owner then
                                local ownerPlayer = FRAMEWORK.GetPlayerFromIdentifier(owner.owner)
            
                                if ownerPlayer then
                                    data[data_length + 1].data.owned = true
                                    data[data_length + 1].data.owner = FRAMEWORK.GetFirstName(ownerPlayer) .. ' ' .. FRAMEWORK.GetLastName(ownerPlayer)
                                else
                                    data[data_length + 1].data.owned = false
                                    data[data_length + 1].data.owner = ''
                                end
                            end
                        end
        
                        local notes = MySQL.query.await('SELECT id, date, note, officer FROM qf_mdt_housenotes WHERE house_name = ?', {v.name})
                        if #notes > 0 then
                            for h, j in pairs(notes) do
                                local notes_length = #data[data_length + 1].notes
                                data[data_length + 1].notes[notes_length + 1] = {
                                    id = j.id,
                                    date = j.date,
                                    reason = j.note,
                                    officer = j.officer
                                }
                            end
                        end
                    end
                    TriggerClientEvent('qf-mdt:housesResults', src, data)
                end)
            elseif Config.Properties.rx_housing then
                local data = {}
        
                MySQL.query('SELECT label FROM rxhousing WHERE LOWER(`label`) LIKE "%' .. value:lower() .. '%" LIMIT 30', {}, function(result)
                    for k, v in pairs(result) do
                        local data_length = #data
        
                        data[data_length + 1] = {
                            label = v.label,
                            name = v.name,
                            data = {
                                owned = false,
                                owner = '',
                            },
                            notes = {}
                        }
        
                        if Config.Frameworks.ESX.enabled then
                            local owner = MySQL.single.await('SELECT owner FROM rxhousing WHERE LOWER(`label`) LIKE "%' .. v.name:lower() .. '%"')
        
                            if owner then
                                local ownerPlayer = FRAMEWORK.GetPlayerFromIdentifier(owner.owner)
            
                                if ownerPlayer then
                                    data[data_length + 1].data.owned = true
                                    data[data_length + 1].data.owner = FRAMEWORK.GetFirstName(ownerPlayer) .. ' ' .. FRAMEWORK.GetLastName(ownerPlayer)
                                else
                                    data[data_length + 1].data.owned = false
                                    data[data_length + 1].data.owner = ''
                                end
                            end
                        elseif Config.Frameworks.QB.enabled then
                            local owner = MySQL.single.await('SELECT owner FROM rxhousing WHERE LOWER(`label`) LIKE "%' .. v.name:lower() .. '%"')
        
                            if owner then
                                local ownerPlayer = FRAMEWORK.GetPlayerFromIdentifier(owner.owner)
            
                                if ownerPlayer then
                                    data[data_length + 1].data.owned = true
                                    data[data_length + 1].data.owner = FRAMEWORK.GetFirstName(ownerPlayer) .. ' ' .. FRAMEWORK.GetLastName(ownerPlayer)
                                else
                                    data[data_length + 1].data.owned = false
                                    data[data_length + 1].data.owner = ''
                                end
                            end
                        end
        
                        local notes = MySQL.query.await('SELECT id, date, note, officer FROM qf_mdt_housenotes WHERE house_name = ?', {v.name})
                        if #notes > 0 then
                            for h, j in pairs(notes) do
                                local notes_length = #data[data_length + 1].notes
                                data[data_length + 1].notes[notes_length + 1] = {
                                    id = j.id,
                                    date = j.date,
                                    reason = j.note,
                                    officer = j.officer
                                }
                            end
                        end
                    end
                    TriggerClientEvent('qf-mdt:housesResults', src, data)
                end)
            else
                print('[^2INFO] ^0[^5QF-MDT^0] encountered a problem at [^5searchHouses^0], if you are using a [^5CUSTOM FRAMEWORK / STANDALONE^0] open a ticket on our discord server and wait for help with configuration!')
                -- SCRIPT BY OWN
            end
        end
    end
end)

RegisterServerEvent('qf-mdt:houses', function()
    local src = source
    local xPlayer = FRAMEWORK.GetPlayerFromId(src)

    if xPlayer then
        if Config.Jobs.OnDuty[xPlayer.job.name] then
            if Config.Properties.esx_property_old then
                local data = {}
        
                MySQL.query('SELECT label, name FROM properties', {}, function(result)
                    for k, v in pairs(result) do
                        local data_length = #data
        
                        data[data_length + 1] = {
                            label = v.label,
                            name = v.name,
                            data = {
                                owned = false,
                                owner = '',
                            },
                            notes = {}
                        }
        
                        local owner = MySQL.single.await('SELECT owner FROM owned_properties WHERE name = ?', {v.name})
                        if owner and owner.owner then
                            local a = MySQL.single.await('SELECT firstname, lastname FROM users WHERE identifier = ?', {owner.owner})
                            data[data_length + 1].data.owned = true
                            data[data_length + 1].data.owner = a.firstname .. ' ' .. a.lastname
                        end
        
                        local notes = MySQL.query.await('SELECT id, date, note, officer FROM qf_mdt_housenotes WHERE house_name = ?', {v.name})
                        if #notes > 0 then
                            for h, j in pairs(notes) do
                                local notes_length = #data[data_length + 1].notes
                                data[data_length + 1].notes[notes_length + 1] = {
                                    id = j.id,
                                    date = j.date,
                                    reason = j.note,
                                    officer = j.officer
                                }
                            end
                        end
                    end
                    TriggerClientEvent('qf-mdt:housesResults', src, data)
                end)
            elseif Config.Properties.esx_property_legacy then
                local data = {}
        
                local PropertiesList = LoadResourceFile("esx_property", 'properties.json')
                local Properties = {}
        
                if PropertiesList then
                    Properties = json.decode(PropertiesList)
        
                    for k, v in pairs(Properties) do
                        local data_length = #data
        
                        data[data_length + 1] = {
                            label = v.Name,
                            name = v.Name,
                            data = {
                                owned = false,
                                owner = '',
                            },
                            notes = {}
                        }
        
                        local owner = v.Owner
        
                        if owner then
                            local ownerPlayer = FRAMEWORK.GetPlayerFromIdentifier(v.Owner)
        
                            if ownerPlayer then
                                data[data_length + 1].data.owned = true
                                data[data_length + 1].data.owner = FRAMEWORK.GetFirstName(ownerPlayer) .. ' ' .. FRAMEWORK.GetLastName(ownerPlayer)
                            else
                                data[data_length + 1].data.owned = false
                                data[data_length + 1].data.owner = ''
                            end
                        end
        
                        local notes = MySQL.query.await('SELECT id, date, note, officer FROM qf_mdt_housenotes WHERE house_name = ?', {v.Name})
                        if #notes > 0 then
                            for h, j in pairs(notes) do
                                local notes_length = #data[data_length + 1].notes
                                data[data_length + 1].notes[notes_length + 1] = {
                                    id = j.id,
                                    date = j.date,
                                    reason = j.note,
                                    officer = j.officer
                                }
                            end
                        end
        
                        TriggerClientEvent('qf-mdt:housesResults', src, data)
                    end
                end
            elseif Config.Properties.qb_apartments then
                local data = {}
        
                MySQL.query('SELECT label, name FROM apartments', {}, function(result)
                    for k, v in pairs(result) do
                        local data_length = #data
        
                        data[data_length + 1] = {
                            label = v.label,
                            name = v.name,
                            data = {
                                owned = false,
                                owner = '',
                            },
                            notes = {}
                        }
        
                        local owner = MySQL.single.await('SELECT citizenid FROM apartments WHERE name = ?', {v.name})
        
                        if owner then
                            local ownerPlayer = FRAMEWORK.GetPlayerFromIdentifier(owner.citizenid)
        
                            if ownerPlayer then
                                data[data_length + 1].data.owned = true
                                data[data_length + 1].data.owner = FRAMEWORK.GetFirstName(ownerPlayer) .. ' ' .. FRAMEWORK.GetLastName(ownerPlayer)
                            else
                                data[data_length + 1].data.owned = false
                                data[data_length + 1].data.owner = ''
                            end
                        end
        
                        local notes = MySQL.query.await('SELECT id, date, note, officer FROM qf_mdt_housenotes WHERE house_name = ?', {v.name})
                        if #notes > 0 then
                            for h, j in pairs(notes) do
                                local notes_length = #data[data_length + 1].notes
                                data[data_length + 1].notes[notes_length + 1] = {
                                    id = j.id,
                                    date = j.date,
                                    reason = j.note,
                                    officer = j.officer
                                }
                            end
                        end
                    end
        
                    TriggerClientEvent('qf-mdt:housesResults', src, data)
                end)
            elseif Config.Properties.qs_housing then
                local data = {}
        
                MySQL.query('SELECT label, name FROM houselocations', {}, function(result)
                    for k, v in pairs(result) do
                        local data_length = #data
        
                        data[data_length + 1] = {
                            label = v.label,
                            name = v.name,
                            data = {
                                owned = false,
                                owner = '',
                            },
                            notes = {}
                        }
        
                        if Config.Frameworks.ESX.enabled then
                            local owner = MySQL.single.await('SELECT citizenid FROM player_houses WHERE house = ?', {v.name})
        
                            if owner then
                                local ownerPlayer = FRAMEWORK.GetPlayerFromIdentifier(owner.citizenid)
            
                                if ownerPlayer then
                                    data[data_length + 1].data.owned = true
                                    data[data_length + 1].data.owner = FRAMEWORK.GetFirstName(ownerPlayer) .. ' ' .. FRAMEWORK.GetLastName(ownerPlayer)
                                else
                                    data[data_length + 1].data.owned = false
                                    data[data_length + 1].data.owner = ''
                                end
                            end
                        elseif Config.Frameworks.QB.enabled then
                            local owner = MySQL.single.await('SELECT citizenid FROM player_houses WHERE house = ?', {v.name})
        
                            if owner then
                                local ownerPlayer = FRAMEWORK.GetPlayerFromIdentifier(owner.citizenid)
            
                                if ownerPlayer then
                                    data[data_length + 1].data.owned = true
                                    data[data_length + 1].data.owner = FRAMEWORK.GetFirstName(ownerPlayer) .. ' ' .. FRAMEWORK.GetLastName(ownerPlayer)
                                else
                                    data[data_length + 1].data.owned = false
                                    data[data_length + 1].data.owner = ''
                                end
                            end
                        end
        
                        local notes = MySQL.query.await('SELECT id, date, note, officer FROM qf_mdt_housenotes WHERE house_name = ?', {v.name})
                        if #notes > 0 then
                            for h, j in pairs(notes) do
                                local notes_length = #data[data_length + 1].notes
                                data[data_length + 1].notes[notes_length + 1] = {
                                    id = j.id,
                                    date = j.date,
                                    reason = j.note,
                                    officer = j.officer
                                }
                            end
                        end
                    end
        
                    TriggerClientEvent('qf-mdt:housesResults', src, data)
                end)
            elseif Config.Properties.loaf_housing then
                local data = {}
        
                MySQL.query('SELECT id, propertyid FROM loaf_properties', {}, function(result)
                    for k, v in pairs(result) do
                        local data_length = #data
        
                        data[data_length + 1] = {
                            label = v.id,
                            name = v.propertyid,
                            data = {
                                owned = false,
                                owner = '',
                            },
                            notes = {}
                        }
        
                        local owner = MySQL.single.await('SELECT owner FROM loaf_properties WHERE propertyid = ?', {v.propertyid})
        
                        if owner then
                            local ownerPlayer = FRAMEWORK.GetPlayerFromIdentifier(owner.owner)
        
                            if ownerPlayer then
                                data[data_length + 1].data.owned = true
                                data[data_length + 1].data.owner = FRAMEWORK.GetFirstName(ownerPlayer) .. ' ' .. FRAMEWORK.GetLastName(ownerPlayer)
                            else
                                data[data_length + 1].data.owned = false
                                data[data_length + 1].data.owner = ''
                            end
                        end
        
                        local notes = MySQL.query.await('SELECT id, date, note, officer FROM qf_mdt_housenotes WHERE house_name = ?', {v.name})
                        if #notes > 0 then
                            for h, j in pairs(notes) do
                                local notes_length = #data[data_length + 1].notes
                                data[data_length + 1].notes[notes_length + 1] = {
                                    id = j.id,
                                    date = j.date,
                                    reason = j.note,
                                    officer = j.officer
                                }
                            end
                        end
                    end
        
                    TriggerClientEvent('qf-mdt:housesResults', src, data)
                end)
            elseif Config.Properties.ps_housing then
                local data = {}
        
                MySQL.query('SELECT street, property_id FROM properties', {}, function(result)
                    for k, v in pairs(result) do
                        local data_length = #data
        
                        data[data_length + 1] = {
                            label = v.street,
                            name = v.property_id,
                            data = {
                                owned = false,
                                owner = '',
                            },
                            notes = {}
                        }
        
                        local owner = MySQL.single.await('SELECT owner_citizenid FROM properties WHERE street = ?', {v.street})
        
                        if owner then
                            local ownerPlayer = FRAMEWORK.GetPlayerFromIdentifier(owner.owner_citizenid)
        
                            if ownerPlayer then
                                data[data_length + 1].data.owned = true
                                data[data_length + 1].data.owner = FRAMEWORK.GetFirstName(ownerPlayer) .. ' ' .. FRAMEWORK.GetLastName(ownerPlayer)
                            else
                                data[data_length + 1].data.owned = false
                                data[data_length + 1].data.owner = ''
                            end
                        end
        
                        local notes = MySQL.query.await('SELECT id, date, note, officer FROM qf_mdt_housenotes WHERE house_name = ?', {v.name})
                        if #notes > 0 then
                            for h, j in pairs(notes) do
                                local notes_length = #data[data_length + 1].notes
                                data[data_length + 1].notes[notes_length + 1] = {
                                    id = j.id,
                                    date = j.date,
                                    reason = j.note,
                                    officer = j.officer
                                }
                            end
                        end
                    end
        
                    TriggerClientEvent('qf-mdt:housesResults', src, data)
                end)
            elseif Config.Properties.bcs_housing then
                local data = {}
        
                MySQL.query('SELECT name, identifier FROM house', {}, function(result)
                    for k, v in pairs(result) do
                        local data_length = #data
        
                        data[data_length + 1] = {
                            label = v.name,
                            name = v.identifier,
                            data = {
                                owned = false,
                                owner = '',
                            },
                            notes = {}
                        }
        
                        local owner = MySQL.single.await('SELECT owner FROM house_owned WHERE identifier = ?', {v.identifier})
        
                        if owner then
                            local ownerPlayer = FRAMEWORK.GetPlayerFromIdentifier(owner.owner)
        
                            if ownerPlayer then
                                data[data_length + 1].data.owned = true
                                data[data_length + 1].data.owner = FRAMEWORK.GetFirstName(ownerPlayer) .. ' ' .. FRAMEWORK.GetLastName(ownerPlayer)
                            else
                                data[data_length + 1].data.owned = false
                                data[data_length + 1].data.owner = ''
                            end
                        end
        
                        local notes = MySQL.query.await('SELECT id, date, note, officer FROM qf_mdt_housenotes WHERE house_name = ?', {v.name})
                        if #notes > 0 then
                            for h, j in pairs(notes) do
                                local notes_length = #data[data_length + 1].notes
                                data[data_length + 1].notes[notes_length + 1] = {
                                    id = j.id,
                                    date = j.date,
                                    reason = j.note,
                                    officer = j.officer
                                }
                            end
                        end
                    end
        
                    TriggerClientEvent('qf-mdt:housesResults', src, data)
                end)
            elseif Config.Properties.nolag_properties then
                local data = {}
        
                MySQL.query('SELECT label, name FROM properties', {}, function(result)
                    for k, v in pairs(result) do
                        local data_length = #data
        
                        data[data_length + 1] = {
                            label = v.label,
                            name = v.name,
                            data = {
                                owned = false,
                                owner = '',
                            },
                            notes = {}
                        }
        
                        if Config.Frameworks.ESX.enabled then
                            local owner = MySQL.single.await('SELECT owner FROM properties WHERE house = ?', {v.name})
        
                            if owner then
                                local ownerPlayer = FRAMEWORK.GetPlayerFromIdentifier(owner.owner)
            
                                if ownerPlayer then
                                    data[data_length + 1].data.owned = true
                                    data[data_length + 1].data.owner = FRAMEWORK.GetFirstName(ownerPlayer) .. ' ' .. FRAMEWORK.GetLastName(ownerPlayer)
                                else
                                    data[data_length + 1].data.owned = false
                                    data[data_length + 1].data.owner = ''
                                end
                            end
                        elseif Config.Frameworks.QB.enabled then
                            local owner = MySQL.single.await('SELECT owner FROM properties WHERE house = ?', {v.name})
        
                            if owner then
                                local ownerPlayer = FRAMEWORK.GetPlayerFromIdentifier(owner.owner)
            
                                if ownerPlayer then
                                    data[data_length + 1].data.owned = true
                                    data[data_length + 1].data.owner = FRAMEWORK.GetFirstName(ownerPlayer) .. ' ' .. FRAMEWORK.GetLastName(ownerPlayer)
                                else
                                    data[data_length + 1].data.owned = false
                                    data[data_length + 1].data.owner = ''
                                end
                            end
                        end
        
                        local notes = MySQL.query.await('SELECT id, date, note, officer FROM qf_mdt_housenotes WHERE house_name = ?', {v.name})
                        if #notes > 0 then
                            for h, j in pairs(notes) do
                                local notes_length = #data[data_length + 1].notes
                                data[data_length + 1].notes[notes_length + 1] = {
                                    id = j.id,
                                    date = j.date,
                                    reason = j.note,
                                    officer = j.officer
                                }
                            end
                        end
                    end
        
                    TriggerClientEvent('qf-mdt:housesResults', src, data)
                end)
            elseif Config.Properties.rx_housing then
                local data = {}
        
                MySQL.query('SELECT label FROM properties', {}, function(result)
                    for k, v in pairs(result) do
                        local data_length = #data
        
                        data[data_length + 1] = {
                            label = v.label,
                            name = v.label,
                            data = {
                                owned = false,
                                owner = '',
                            },
                            notes = {}
                        }
        
                        if Config.Frameworks.ESX.enabled then
                            local owner = MySQL.single.await('SELECT owner FROM rxhousing WHERE LOWER(`label`) = ?', {v.name:lower()})
        
                            if owner then
                                local ownerPlayer = FRAMEWORK.GetPlayerFromIdentifier(owner.owner)
            
                                if ownerPlayer then
                                    data[data_length + 1].data.owned = true
                                    data[data_length + 1].data.owner = FRAMEWORK.GetFirstName(ownerPlayer) .. ' ' .. FRAMEWORK.GetLastName(ownerPlayer)
                                else
                                    data[data_length + 1].data.owned = false
                                    data[data_length + 1].data.owner = ''
                                end
                            end
                        elseif Config.Frameworks.QB.enabled then
                            local owner = MySQL.single.await('SELECT owner FROM rxhousing WHERE LOWER(`label`) = ?', {v.name:lower()})
        
                            if owner then
                                local ownerPlayer = FRAMEWORK.GetPlayerFromIdentifier(owner.owner)
            
                                if ownerPlayer then
                                    data[data_length + 1].data.owned = true
                                    data[data_length + 1].data.owner = FRAMEWORK.GetFirstName(ownerPlayer) .. ' ' .. FRAMEWORK.GetLastName(ownerPlayer)
                                else
                                    data[data_length + 1].data.owned = false
                                    data[data_length + 1].data.owner = ''
                                end
                            end
                        end
        
                        local notes = MySQL.query.await('SELECT id, date, note, officer FROM qf_mdt_housenotes WHERE house_name = ?', {v.name})
                        if #notes > 0 then
                            for h, j in pairs(notes) do
                                local notes_length = #data[data_length + 1].notes
                                data[data_length + 1].notes[notes_length + 1] = {
                                    id = j.id,
                                    date = j.date,
                                    reason = j.note,
                                    officer = j.officer
                                }
                            end
                        end
                    end
        
                    TriggerClientEvent('qf-mdt:housesResults', src, data)
                end)
            else
                print('[^2INFO] ^0[^5QF-MDT^0] encountered a problem at [^5houses^0], if you are using a [^5CUSTOM FRAMEWORK / STANDALONE^0] open a ticket on our discord server and wait for help with configuration!')
                -- SCRIPT BY OWN
            end
        end
    end
end)

CALLBACK.RegisterServerCallback('qf_mdt:getData', function(source, cb, data)
    if data.type == 'vehicle' then
        local result = {}
        SQL.GetVehicle(data.identifier:upper(), function(results)
            result = results
            local notes = MySQL.query.await('SELECT * FROM qf_mdt_vehicle_notes WHERE plate = ? ORDER BY time DESC', {data.identifier:upper()})
            result.notes = notes or {}
            cb(result)
        end, source)
    elseif data.type == 'citizen' then
        SQL.SearchCitizenIdentifier(data.identifier, function(results)
            local result = {}
        
            if not results[1] then
                cb(nil)
                return
            end
        
            result = results[1]
            result.type = "citizen"
            result.licenses = {}
            for k, v in pairs(Config.CitizenLicenses) do
                result.licenses[v.sqlName] = false
            end
        
            result.phone = EDITABLE.GetPhoneNumber(data.identifier)

            local fines = MySQL.query.await('SELECT * FROM qf_mdt_fines WHERE identifier = ? ORDER BY date DESC', { data.identifier })
            result.fines = fines or {}
        
            local jails = MySQL.query.await('SELECT * FROM qf_mdt_jails WHERE identifier = ? ORDER BY date DESC', { data.identifier })
            result.jails = jails or {}
        
            local notes = MySQL.query.await('SELECT * FROM qf_mdt_citizen_notes WHERE identifier = ? ORDER BY date DESC', { data.identifier })
            result.notes = notes or {}
        
            result.vehicles = {}
            local vehicles = SQL.GetPlayerVehicles(data.identifier)
        
            if Config.Frameworks.ESX.enabled then
                for i = 1, #vehicles do
                    local vehicle = json.decode(vehicles[i].vehicle).model
                    if vehicle then
                        table.insert(result.vehicles, {
                            plate = vehicles[i].plate,
                            model = SERVER.getVehicleModel(source, vehicle),
                            status = "-"
                        })
                    end
                end

                if Config.Licenses.esx_license then
                    local licenses = MySQL.query.await('SELECT type FROM user_licenses WHERE owner = ?', { data.identifier })
                    for k, v in pairs(licenses) do
                        if result.licenses[v.type] == false then
                            result.licenses[v.type] = true
                        end
                    end
                elseif Config.Licenses.bcs_license then
                    local licenses = MySQL.query.await('SELECT license FROM licenses WHERE owner = ?', { data.identifier })
                    for k, v in pairs(licenses) do
                        if result.licenses[v.license] == false then
                            result.licenses[v.license] = true
                        end
                    end
                end
            elseif Config.Frameworks.QB.enabled then
                for i = 1, #vehicles do
                    local vehicle = json.decode(vehicles[i].hash)
                    if vehicle then
                        table.insert(result.vehicles, {
                            plate = vehicles[i].plate,
                            model = SERVER.getVehicleModel(source, json.decode(vehicles[i].hash)),
                            status = "-"
                        })
                    end
                end
                
                if Config.Licenses.qb_license then
                    local licenses = SQL.GetPlayerLicenses(data.identifier)

                    for k, v in pairs(licenses) do
                        if result.licenses[v] == false then
                            result.licenses[v] = true
                        end
                    end
                elseif Config.Licenses.bcs_license then
                    local licenses = SQL.GetPlayerLicenses(data.identifier)
                    
                    for k, v in pairs(licenses) do
                        if result.licenses[v] == false then
                            result.licenses[v] = true
                        end
                    end
                end
            else
                print('[^2INFO] ^0[^5QF-MDT^0] encountered a problem at [^5getData^0], if you are using a [^5CUSTOM FRAMEWORK / STANDALONE^0] open a ticket on our discord server and wait for help with configuration!')
                -- SCRIPT IT BY OWN
            end
        
            cb(result)
        end)
        
    end
end)

RegisterServerEvent('qf_mdt:addVehicleNote', function(data)
    local src = source
    local xPlayer = FRAMEWORK.GetPlayerFromId(src)

    if xPlayer then
        if not Config.Jobs.OnDuty[xPlayer.job.name] then
            return
        end

        if #data.note >= 250 then
            xPlayer.showNotification(_L('MAX_MARKS'))
            return
        end

        local officer = EDITABLE.GetBadge(xPlayer) .. " " .. FRAMEWORK.GetFirstName(xPlayer) .. " " .. FRAMEWORK.GetLastName(xPlayer)
        MySQL.insert('INSERT INTO qf_mdt_vehicle_notes (plate, date, note, officer) VALUES (LEFT(?, 100), ?, LEFT(?, 1000), LEFT(?, 100))', {data.plate:upper(), os.time(), data.note, officer})
        
        if Config.Frameworks.ESX.enabled then
            MySQL.query('SELECT owner, plate, vehicle FROM owned_vehicles WHERE plate = ? LIMIT 1', {data.plate:upper()}, function(results)
                if #SERVER.lastNotes.vehicles > 5 then
                    table.remove(SERVER.lastNotes.vehicles, 1)
                end
            
                local ownerIdentifier = SQL.GetVehicleOwnerIdentifier(data.plate:upper())
                local owner = SQL.GetName(ownerIdentifier)
                local vehicle = json.decode(results[1].vehicle).model
            
                table.insert(SERVER.lastNotes.vehicles, {
                    model = SERVER.getVehicleModel(src, vehicle),
                    plate = data.plate:upper(),
                    reason = data.note,
                    date = os.time(),
                    owner = owner or "",
                    officer = officer
                })
    
                if Config.UseWebhooks then 
                    SERVER.SendLog("addVehicleNote", (Config.Webhooks["addVehicleNote"].description):format(GetPlayerName(src), SERVER.getVehicleModel(src, vehicle), data.plate:upper(), data.note))
                end
            end)
        elseif Config.Frameworks.QB.enabled then
            MySQL.query('SELECT owner, plate, vehicle AS model FROM player_vehicles WHERE plate = ? LIMIT 1', {data.plate:upper()}, function(results)
                if #SERVER.lastNotes.vehicles > 5 then
                    table.remove(SERVER.lastNotes.vehicles, 1)
                end
            
                local ownerIdentifier = SQL.GetVehicleOwnerIdentifier(data.plate:upper())
                local owner = SQL.GetName(ownerIdentifier)
                local vehicle = json.decode(results[1].vehicle).model
            
                table.insert(SERVER.lastNotes.vehicles, {
                    model = SERVER.getVehicleModel(src, vehicle),
                    plate = data.plate:upper(),
                    reason = data.note,
                    date = os.time(),
                    owner = owner or "",
                    officer = officer
                })
    
                if Config.UseWebhooks then 
                    SERVER.SendLog("addVehicleNote", (Config.Webhooks["addVehicleNote"].description):format(GetPlayerName(src), SERVER.getVehicleModel(src, vehicle), data.plate:upper(), data.note))
                end
            end)
        else
            print('[^2INFO] ^0[^5QF-MDT^0] encountered a problem at [^5addVehicleNote^0], if you are using a [^5CUSTOM FRAMEWORK / STANDALONE^0] open a ticket on our discord server and wait for help with configuration!')
            -- SCRIPT BY OWN
        end
    end
end)

RegisterServerEvent('qf_mdt:addCitizenNote', function(data)
    local src = source
    local xPlayer = FRAMEWORK.GetPlayerFromId(src)

    if xPlayer then
        if not Config.Jobs.OnDuty[xPlayer.job.name] then
            return
        end
    
        if #data.note >= 250 then
            xPlayer.showNotification(_L('MAX_MARKS'))
            return
        end
    
        if Config.Frameworks.ESX.enabled then
            local officer = EDITABLE.GetBadge(xPlayer) .. " " .. FRAMEWORK.GetFirstName(xPlayer) .. " " .. FRAMEWORK.GetLastName(xPlayer)
            MySQL.insert('INSERT INTO qf_mdt_citizen_notes (identifier, date, reason, officer) VALUES (LEFT(?, 100), ?, LEFT(?, 1000), LEFT(?, 100))', {data.identifier, os.time(), data.note, officer})
            local name = MySQL.scalar.await('SELECT CONCAT(firstname, " ", lastname) FROM users WHERE identifier = ?', {data.identifier})
        
            if #SERVER.lastNotes.citizen > 5 then
                table.remove(SERVER.lastNotes.citizen, 1)
            end
        
            table.insert(SERVER.lastNotes.citizen, {
                name = name or "",
                date = os.time(),
                reason = data.note,
                officer = officer
            })
        
            if Config.UseWebhooks then 
                SERVER.SendLog("addCitizenNote", (Config.Webhooks["addCitizenNote"].description):format(GetPlayerName(src), name, data.note))
            end
        elseif Config.Frameworks.QB.enabled then
            local officer = EDITABLE.GetBadge(xPlayer) .. " " .. FRAMEWORK.GetFirstName(xPlayer) .. " " .. FRAMEWORK.GetLastName(xPlayer)
            MySQL.insert('INSERT INTO qf_mdt_citizen_notes (identifier, date, reason, officer) VALUES (LEFT(?, 100), ?, LEFT(?, 1000), LEFT(?, 100))', {data.identifier, os.time(), data.note, officer})
           
            local player = MySQL.Sync.fetchScalar('SELECT charinfo FROM players WHERE citizenid = ?', {data.identifier})
            local xCH = player
            local playerData = json.decode(xCH)

            if #SERVER.lastNotes.citizen > 5 then
                table.remove(SERVER.lastNotes.citizen, 1)
            end
        
            table.insert(SERVER.lastNotes.citizen, {
                name = (playerData.firstname .. ' ' .. playerData.lastname) or "",
                date = os.time(),
                reason = data.note,
                officer = officer
            })
        
            if Config.UseWebhooks then 
                SERVER.SendLog("addCitizenNote", (Config.Webhooks["addCitizenNote"].description):format(GetPlayerName(src), (playerData.firstname .. ' ' .. playerData.lastname) or "", data.note))
            end
        else
            print('[^2INFO] ^0[^5QF-MDT^0] encountered a problem at [^5addCitizenNote^0], if you are using a [^5CUSTOM FRAMEWORK / STANDALONE^0] open a ticket on our discord server and wait for help with configuration!')
            -- SCRIPT BY OWN
        end
    end
end)

RegisterServerEvent('qf_mdt:submitFine', function(data)
    local src = source
    local xPlayer = FRAMEWORK.GetPlayerFromId(src)

    if not Config.Jobs.OnDuty[xPlayer.job.name] then
        return
    end

    local zSource, zPlayer = nil, nil

    if not data.identifier then
        return
    end

    if Config.Frameworks.ESX.enabled then
        zSource = FRAMEWORK.GetPlayerFromIdentifier(data.identifier)
        if zSource then
            zPlayer = FRAMEWORK.GetPlayerFromId(zSource.source)
        end
    elseif Config.Frameworks.QB.enabled then
        zSource = FRAMEWORK.GetPlayerFromIdentifier(data.identifier)
        
        if zSource then
            zPlayer = FRAMEWORK.GetPlayerFromId(zSource.PlayerData.source)
        end
    else
        print('[^2INFO] ^0[^5QF-MDT^0] encountered a problem at [^5submitFine^0], if you are using a [^5CUSTOM FRAMEWORK / STANDALONE^0] open a ticket on our discord server and wait for help with configuration!')
    end

    if xPlayer then
        if zPlayer then
            local xCoords = GetEntityCoords(GetPlayerPed(xPlayer.source))
            local zCoords = GetEntityCoords(GetPlayerPed(zPlayer.source))

            if #(xCoords - zCoords) > Config.MaxDistanceToJailFine then
                return xPlayer.showNotification(_L('PLAYER_TOO_FAR'))
            end

            if xPlayer.source == zPlayer.source then
                return xPlayer.showNotification(_L('SAME_PEOPLE'))
            end

            if data.fine and data.fine > 0 then
                if Config.SocietyScripts.esx_society then
                    TriggerEvent('esx_addonaccount:getSharedAccount', Config.Society.name, function(account)
                        if account then
                            account.addMoney(data.fine * Config.Society.percentToPoliceJob)
                        end
                    end)
        
                    -- xPlayer.addAccountMoney('bank', data.fine * Config.Society.percentToPoliceMan)
                    -- zPlayer.removeAccountMoney('bank', data.fine)
                    
                    if Config.UseWebhooks then 
                        SERVER.SendLog("submitFine", (Config.Webhooks["submitFine"].description):format(GetPlayerName(src), data.fine * Config.Society.percentToPoliceJob))
                    end
                elseif Config.SocietyScripts.qb_management then
                    exports['qb-management']:AddMoney(Config.Society.name, data.fine * Config.Society.percentToPoliceJob)
                    xPlayer.addAccountMoney('bank', data.fine * Config.Society.percentToPoliceMan)

                    zPlayer.removeAccountMoney('bank', data.fine)

                    if Config.UseWebhooks then 
                        SERVER.SendLog("submitFine", (Config.Webhooks["submitFine"].description):format(GetPlayerName(src), data.fine * Config.Society.percentToPoliceJob))
                    end
                elseif Config.SocietyScripts.qb_banking then
                    exports['qb-banking']:AddMoney(Config.Society.name, data.fine * Config.Society.percentToPoliceJob, data.reason)

                    zPlayer.removeAccountMoney('bank', data.fine)

                    if Config.UseWebhooks then 
                        SERVER.SendLog("submitFine", (Config.Webhooks["submitFine"].description):format(GetPlayerName(src), data.fine * Config.Society.percentToPoliceJob))
                    end
                elseif Config.SocietyScripts.bcs_CompanyManager then
                    if Config.UseWebhooks then 
                        SERVER.SendLog("submitFine", (Config.Webhooks["submitFine"].description):format(GetPlayerName(src), data.fine * Config.Society.percentToPoliceJob))
                    end

                    local from = {
                        label = Config.Society.label,
                        job = Config.Society.jobname,
                        identifier = Config.Society.jobname,
                    }

                    TriggerEvent('bill:createBill', zPlayer.source, 5000, Config.Society.label, from)
                end
                
                if Config.BillingScripts.okokBilling then
                    xPlayer.addAccountMoney('bank', data.fine * Config.Society.percentToPoliceMan)
                    zPlayer.removeAccountMoney('bank', data.fine)

                    TriggerEvent("okokBilling:CreateCustomInvoice", zPlayer.source, data.fine, data.reason, 'Fine', Config.Society.name, Config.Society.label)
                    TriggerClientEvent('qf-mdt:okokBilling', xPlayer.source, zPlayer.source, data.fine, data.reason, 'Fine', Config.Society.name, Config.Society.label)

                    if Config.UseWebhooks then 
                        SERVER.SendLog("submitFine", (Config.Webhooks["submitFine"].description):format(GetPlayerName(src), data.fine * Config.Society.percentToPoliceJob))
                    end
                elseif Config.BillingScripts.codemBilling then
                    exports['codem-billing']:createBilling(xPlayer.source, zPlayer.source, data.fine, data.reason, Config.Society.name)
                    
                    if Config.UseWebhooks then 
                        SERVER.SendLog("submitFine", (Config.Webhooks["submitFine"].description):format(GetPlayerName(src), data.fine * Config.Society.percentToPoliceJob))
                    end
                elseif Config.BillingScripts.esx_billing then
                    TriggerClientEvent('qf_mdt:esxBilling', xPlayer.source, zPlayer.source, Config.Society.name, Config.Society.label, data.fine)

                    if Config.UseWebhooks then 
                        SERVER.SendLog("submitFine", (Config.Webhooks["submitFine"].description):format(GetPlayerName(src), data.fine * Config.Society.percentToPoliceJob))
                    end
                elseif Config.BillingScripts.qs_billing then
                    exports['qs-billing']:ServerCreateInvoice(xPlayer.source, 'Fine', data.reason, data.fine, true, false, true, true, nil)
                elseif Config.BillingScripts.cs_billing then
                    exports['cs_billing']:createBill({
                        playerID = zPlayer.source, --Player's ID to whom you want to send an invoice
                        society = Config.Society.name, --Invoice Society Name
                        society_name = Config.Society.label, --Invoice Society Label
                        amount = data.fine, --Invoice Amount
                    
                        senderID = xPlayer.source,         --[OPTIONAL] Invoice Sender's ID
                        title = 'Police Invoice',  --[OPTIONAL] Invoice Title
                        notes = data.reason, --[OPTIONAL] Invoice Notes
                    })
                elseif Config.BillingScripts.zerio_invoice then
                    exports["zerio-invoice"]:NewInvoice({
                        type = "player",
                        sendDate = os.date("%Y/%m/%d %X"),
                        dueDate = os.date("%Y/%m/%d %X"),
                        receiver = zPlayer.identifier,
                        senderJob = xPlayer.job.name,
                        senderPlayer = xPlayer.identifier,
                        reason = data.reason,
                        category = "Police Fine",
                        products = {{price = data.fine, description = data.reason, quantity = 1}}
                    })

                    if Config.UseWebhooks then 
                        SERVER.SendLog("submitFine", (Config.Webhooks["submitFine"].description):format(GetPlayerName(src), data.fine * Config.Society.percentToPoliceJob))
                    end
                else
                    xPlayer.addAccountMoney('bank', data.fine * Config.Society.percentToPoliceMan)
                    zPlayer.removeAccountMoney('bank', data.fine)

                    if Config.UseWebhooks then 
                        SERVER.SendLog("submitFine", (Config.Webhooks["submitFine"].description):format(GetPlayerName(src), data.fine * Config.Society.percentToPoliceJob))
                    end

                    print('[^2INFO] ^0[^5QF-MDT^0] encountered a problem at [^5submitFine^0], if you are using a [^5CUSTOM FRAMEWORK / STANDALONE^0] open a ticket on our discord server and wait for help with configuration!')
                    -- SCRIPT BY OWN
                end

                if Config.Banks.qf_banking then
                    TriggerEvent("qf-banking:addBankHistory", zPlayer.source, data.fine, 'Fine', 'bank', zPlayer.getAccount('bank').money)
                    TriggerEvent("qf-banking:addBankHistory", xPlayer.source, data.fine * Config.Society.percentToPoliceMan, '% from fine', 'bank', xPlayer.getAccount('bank').money) 
                elseif Config.Banks.okokBanking then
                    TriggerEvent('okokBanking:AddNewTransaction', Config.Society.label, Config.Society.label, zPlayer.getName(), zPlayer.getIdentifier(), data.fine, data.reason)
                elseif Config.Banks.codeMBanking then
                    exports['codem-bank']:addtransaction(zPlayer.source, data.fine, 'bills')
                elseif Config.Banks.brutal_banking then
                    TriggerClientEvent('brutal_banking:client:AddTransaction', zPlayer.source, data.fine, type, 'Fine')
                end
            end

            if data.jail and data.jail > 0 then
                xPlayer.showNotification((_L('JAIL_POLICEMAN', zPlayer.source, FRAMEWORK.GetFirstName(zPlayer), FRAMEWORK.GetLastName(zPlayer), data.fine, data.jail)))
                zPlayer.showNotification((_L('JAIL_PLAYER', xPlayer.source, FRAMEWORK.GetFirstName(xPlayer), FRAMEWORK.GetLastName(xPlayer), data.fine, data.jail)))
                --// Add your jail event above there text is example event for this

                if Config.Jails.pickle_prisons then
                    TriggerClientEvent('qf_mdt:pickleSent', xPlayer.source, zPlayer.source, data.jail)
                elseif Config.Jails.rcore_prison then
                    exports['rcore_prison']:Jail(zPlayer.source, data.jail, data.reason)
                elseif Config.Jails.brutal_policejob_jail then
                    TriggerClientEvent('qf_mdt:brutalSend', xPlayer.source, zPlayer.source, data.reason, data.jail)
                elseif Config.Jails.qb_prison then
                    TriggerClientEvent('qf_mdt:qbPrisonSend', xPlayer.source, zPlayer.source, data.jail)
                elseif Config.Jails.esx_jailer_xlem0n then
                    TriggerEvent('xlem0n_jailer:wpierdolchuja', xPlayer.source, zPlayer.source, data.jail)
                elseif Config.Jails.esx_qalle_jail then
                    TriggerEvent("esx-qalle-jail:jailPlayer", zPlayer.source, data.jail, data.reason)
                elseif Config.Jails.s7pack_jail then
                    TriggerClientEvent('qf_mdt:s7packJail', xPlayer.source, zPlayer.source, data.jail, data.reason)
                elseif Config.Jails.tk_jail then
                    exports['tk_jail']:jail(zPlayer.source, data.jail)
                elseif Config.Jails.u_jail then
                    TriggerClientEvent("u-jail:jailPlayer", zPlayer.source, data.jail)
                else
                    print('[^2INFO] ^0[^5QF-MDT^0] Please configure Jail System! If you are using an unsupported jail system contact us at ticket and we will help you with hooking it up.')
                end

                MySQL.insert('INSERT INTO qf_mdt_jails (identifier, reason, fine, jail, date, officer) VALUES (LEFT(?, 100), LEFT(?, 1000), ?, ?, ?, LEFT(?, 100))', {data.identifier, data.reason, data.fine, data.jail, os.time(), data.officer})
            else
                xPlayer.showNotification((_L('FINE_POLICEMAN', zPlayer.source, FRAMEWORK.GetFirstName(zPlayer), FRAMEWORK.GetLastName(zPlayer), data.fine)))
                zPlayer.showNotification((_L('FINE_PLAYER', xPlayer.source, FRAMEWORK.GetFirstName(xPlayer), FRAMEWORK.GetLastName(xPlayer), data.fine)))
                MySQL.insert('INSERT INTO qf_mdt_fines (identifier, reason, fine, date, officer) VALUES (LEFT(?, 100), LEFT(?, 1000), ?, ?, LEFT(?, 100))', {data.identifier, data.reason, data.fine, os.time(), data.officer})
            end
        else
            xPlayer.showNotification(_L('PLAYER_NOT_AVAILABLE'))
        end
    end
end)

RegisterCommand(Config.Jobs.AccessCode.command, function(source, args, message, rawCommand)
	local src = source
    local xPlayer = FRAMEWORK.GetPlayerFromId(src)

    if xPlayer then
        if (xPlayer.job and Config.Jobs.OnDuty[xPlayer.job.name]) then
            if xPlayer.job.grade < Config.Jobs.AccessCode.fromGrade then
                xPlayer.showNotification(_L('DONT_HAVE_ACCESS'))
            else
                local arg = args[1] and args[1]:lower()
                arg = tonumber(arg)

                if Config.CityStatuses[arg] then
                    local mapping = Config.CityStatuses[arg]
                    TriggerEvent('qf_mdt:updateCityStatus', mapping)
                    TriggerClientEvent('chat:addMessage1', -1, "LSPD", mapping.color, mapping.message, "fas fa-newspaper")
                else
                    xPlayer.showNotification(_L('INCORRECT_CODE'))
                end

                if Config.UseWebhooks then
                    SERVER.SendLog("codeCommand", (Config.Webhooks["codeCommand"].description):format(GetPlayerName(src), args[1]))
                end
            end
        end
    end
end, false)

RegisterServerEvent('qf_mdt:getHours', function(src)
    local xPlayer = FRAMEWORK.GetPlayerFromId(src)

    if xPlayer then
        MySQL.query('SELECT time FROM qf_mdt_time WHERE identifier = ?', {xPlayer.getIdentifier()}, function(result)
            if result[1] then
                Player(src).state.RankTimePolice = tonumber(result[1].time)
            else
                MySQL.insert('INSERT INTO qf_mdt_time (identifier, name, time) VALUES (?, ?, ?)', {xPlayer.getIdentifier(), xPlayer.getName(), 5}, function()
                    Player(src).state.RankTimePolice = 1
                end)
            end
        end)
    end
end)

RegisterServerEvent('qf_mdt:saveHours', function(identifier, hours)
    if identifier then
        MySQL.query('UPDATE qf_mdt_time SET time = ? WHERE identifier = ?', {hours, identifier})
    end
end)

RegisterServerEvent('qf-mdt:saveHours', function(id, mins)
    print('[QF-MDT]: SAVED '..mins..'minutes for: '..id)
end)

RegisterCommand('lspd_resthours', function(src)
    local _src = src
    local xp = FRAMEWORK.GetPlayerFromId(_src)

    if xp.job.grade < Config.Jobs.ResetHours then return end

    TriggerClientEvent('qf_mdt:resetHoursPlayer', -1)
    MySQL.query('UPDATE qf_mdt_time SET time = 0')
    xp.showNotification('All of the police hours got reseted')
end, false)

RegisterServerEvent('qf-mdt:resetHoursPlayerX', function(id)
    local _src = source
    local xp = FRAMEWORK.GetPlayerFromId(_src)
    local tp = FRAMEWORK.GetPlayerFromId(id)

    TriggerClientEvent('qf_mdt:resetHoursPlayer', id)
    MySQL.query('UPDATE qf_mdt_time SET time = 0 WHERE identifier = ?', {tp.identifier})
    xp.showNotification('Police hours for id '..id..' got reseted')
end)


RegisterServerEvent('qf_mdt:giveLicensePlayer', function(data)
    local src = source
    local xPlayer = FRAMEWORK.GetPlayerFromId(src)

    if not data.current_data then
        MySQL.query('INSERT INTO user_licenses (type, owner) VALUES (?, ?)', {data.value, data.player})
    else
        MySQL.query('DELETE FROM user_licenses WHERE type = ? AND owner = ?', {data.value, data.player})
    end
end)
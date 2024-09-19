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
            print('[QF-MDT-EMS]: REMEMBER TO CONFIGURE GET BADGE SYSTEM (config_editable:21)!')
            return "[01]"
        else
            return tostring(xPlayer.source)
        end
    end
end

EDITABLE.GetRadio = function(id)
    if Config.ShowRadio then
        local plyState = Player(id).state
        local radioChannel = plyState.radioChannel

        if radioChannel == nil or radioChannel == 0 then
            return 'Nieznana'
        end

        return radioChannel
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
            print('[^2INFO^0] [^5QF-MDT-EMS^0] Please configure [^2EDITABLE.GetPhoneNumber^0]')
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
            print('[^2INFO^0] [^5QF-MDT-EMS^0] Please configure [^2EDITABLE.GetPhoneNumber^0]')
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
            print('[^2INFO^0] [^5QF-MDT^0] QB_PHONE cant work at ESX! [^2EDITABLE.GetPhoneNumber^0]')

            return 555555
        elseif Config.Frameworks.QB.enabled then
            local player = MySQL.Sync.fetchScalar('SELECT charinfo FROM players WHERE citizenid = ?', {identifier})
            local xCH = player
            local playerData = json.decode(xCH)

            if player then
                if playerData.phone ~= nil then
                    return playerData.phone
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
        print('[^2INFO^0] [^5QF-MDT-EMS^0] Please configure [^2EDITABLE.GetPhoneNumber^0]')
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
    -- return EDITABLE.ConvertTime(MySQL.scalar.await('SELECT timespent FROM users WHERE identifier = ?', {xPlayer.getIdentifier()}))
    -- return EDITABLE.ConvertTime(28140) --// IF YOU USE SOME COUNTING USER DUTYTIME YOU CAN GET IT HERE

    if xPlayer then
        if xPlayer.source then
            local rank = Player(xPlayer.source).state.RankTimeAmbulance
            if rank then
                return tostring((Player(xPlayer.source).state.RankTimeAmbulance / 60))
            else
                return "0"
            end
        end
    end

    return "0"
end

CALLBACK.RegisterServerCallback('qf-mdt-ems:getData', function(source, cb, data)
    if data.type == 'citizen' then
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
        
            local fines = MySQL.query.await('SELECT * FROM qf_mdt_ems_fines WHERE identifier = ? ORDER BY date DESC', { data.identifier })
            result.fines = fines or {}

            local notes = MySQL.query.await('SELECT * FROM qf_mdt_ems_citizen_notes WHERE identifier = ? ORDER BY date DESC', { data.identifier })
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
                print('[^2INFO] ^0[^5QF-MDT-EMS^0] encountered a problem at [^5getData^0], if you are using a [^5CUSTOM FRAMEWORK / STANDALONE^0] open a ticket on our discord server and wait for help with configuration!')
                -- SCRIPT IT BY OWN
            end
        
            cb(result)
        end)
    end
end)

RegisterServerEvent('qf-mdt-ems:addCitizenNote', function(data)
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
            MySQL.insert('INSERT INTO qf_mdt_ems_citizen_notes (identifier, date, reason, officer) VALUES (LEFT(?, 100), ?, LEFT(?, 1000), LEFT(?, 100))', {data.identifier, os.time(), data.note, officer})
            local name = MySQL.scalar.await('SELECT CONCAT(firstname, " ", lastname) FROM users WHERE identifier = ?', {data.identifier})
        
            if #SERVER.lastNotes.citizen > 5 then
                table.remove(SERVER.lastNotes.citizen, 1)
            end
        
            table.insert(SERVER.lastNotes.citizen, {
                name = name or _L('UNKNOWN_PERSON'),
                date = os.time(),
                reason = data.note,
                officer = officer
            })
        
            if Config.UseWebhooks then 
                SERVER.SendLog("addCitizenNote", (Config.Webhooks["addCitizenNote"].description):format(src, name, data.note))
            end
        elseif Config.Frameworks.QB.enabled then
            local officer = EDITABLE.GetBadge(xPlayer) .. " " .. FRAMEWORK.GetFirstName(xPlayer) .. " " .. FRAMEWORK.GetLastName(xPlayer)
            MySQL.insert('INSERT INTO qf_mdt_ems_citizen_notes (identifier, date, reason, officer) VALUES (LEFT(?, 100), ?, LEFT(?, 1000), LEFT(?, 100))', {data.identifier, os.time(), data.note, officer})
           
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
                SERVER.SendLog("addCitizenNote", (Config.Webhooks["addCitizenNote"].description):format(src, (playerData.firstname .. ' ' .. playerData.lastname) or "", data.note))
            end
        else
            print('[^2INFO] ^0[^5QF-MDT-EMS^0] encountered a problem at [^5addCitizenNote^0], if you are using a [^5CUSTOM FRAMEWORK / STANDALONE^0] open a ticket on our discord server and wait for help with configuration!')
            -- SCRIPT BY OWN
        end
    end
end)

RegisterServerEvent('qf-mdt-ems:submitFine', function(data)
    local src = source
    local xPlayer = FRAMEWORK.GetPlayerFromId(src)

    if not Config.Jobs.OnDuty[xPlayer.job.name] then
        return
    end

    if not data.identifier then
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

            if #(xCoords - zCoords) > Config.MaxDistanceToInvoice then
                return xPlayer.showNotification(_L('PLAYER_TOO_FAR'))
            end

            if xPlayer.source == zPlayer.source then
                return xPlayer.showNotification(_L('SAME_PEOPLE'))
            end

            if data.fine and data.fine > 0 then
                if Config.SocietyScripts.esx_society then
                    if data.fine >= 100000 then xPlayer.showNotification('Na ten moment nie możesz wystawić faktury większej niż (100.000$)') return end
                    TriggerEvent('esx_addonaccount:getSharedAccount', Config.Society.name, function(account)
                        if account then
                            account.addMoney(data.fine * Config.Society.percentToHospital)
                            xPlayer.addAccountMoney('bank', data.fine * Config.Society.percentToDoctor)
                        end
                    end)
        
                    zPlayer.removeAccountMoney('bank', data.fine)
                    
                    if Config.Banks.qf_banking then
                        TriggerEvent("qf_banking:addBankHistory", zPlayer.source, data.fine, 'Faktura [EMS]', 'bank', zPlayer.getAccount('bank').money)
                        TriggerEvent("qf_banking:addBankHistory", xPlayer.source, data.fine * Config.Society.percentToDoctor, '% z wystawionej faktury', 'bank', xPlayer.getAccount('bank').money) 
                    elseif Config.Banks.okokBanking then
                        TriggerEvent('okokBanking:AddNewTransaction', Config.Society.label, Config.Society.name, zPlayer.getName(), zPlayer.getIdentifier(), data.fine, data.reason)
                    elseif Config.Banks.codeMBanking then
                        exports['codem-bank']:addtransaction(zPlayer.source, data.fine, 'bills')
                    end

                    if Config.UseWebhooks then 
                        SERVER.SendLog("submitFine", (Config.Webhooks["submitFine"].description):format(src, data.fine * Config.Society.percentToHospital))
                    end
                elseif Config.SocietyScripts.qb_management then
                    exports['qb-management']:AddMoney(Config.Society.name, data.fine * Config.Society.percentToHospital)
                    xPlayer.addAccountMoney('bank', data.fine * Config.Society.percentToDoctor)

                    if Config.Banks.qf_banking then
                        TriggerEvent("qf_banking:addBankHistory", xPlayer.source, data.fine * Config.Society.percentToDoctor, '% from Invoice', 'bank', xPlayer.getAccount('bank').money) 
                        TriggerEvent("qf_banking:addBankHistory", zPlayer.source, data.fine, 'Invoice', 'bank', zPlayer.getAccount('bank').money)
                    elseif Config.Banks.okokBanking then
                        TriggerEvent('okokBanking:AddNewTransaction', Config.Society.label, Config.Society.name, zPlayer.getName(), zPlayer.getIdentifier(), data.fine, data.reason)
                    elseif Config.Banks.codeMBanking then
                        exports['codem-bank']:addtransaction(zPlayer.source, data.fine, 'bills')
                    end

                    zPlayer.removeAccountMoney('bank', data.fine)

                    if Config.UseWebhooks then 
                        SERVER.SendLog("submitFine", (Config.Webhooks["submitFine"].description):format(src, data.fine * Config.Society.percentToHospital))
                    end
                elseif Config.SocietyScripts.qb_banking then
                    exports['qb-banking']:AddMoney(Config.Society.name, data.fine * Config.Society.percentToBoss, data.reason)

                    zPlayer.removeAccountMoney('bank', data.fine)

                    if Config.UseWebhooks then 
                        SERVER.SendLog("submitFine", (Config.Webhooks["submitFine"].description):format(src, data.fine * Config.Society.percentToBoss))
                    end
                elseif Config.SocietyScripts.bcs_CompanyManager then
                    if Config.Banks.qf_banking then
                        TriggerEvent("qf_banking:addBankHistory", xPlayer.source, data.fine * Config.Society.percentToDoctor, '% from Invoice', 'bank', xPlayer.getAccount('bank').money) 
                        TriggerEvent("qf_banking:addBankHistory", zPlayer.source, data.fine, 'Invoice', 'bank', zPlayer.getAccount('bank').money)
                    elseif Config.Banks.okokBanking then
                        TriggerEvent('okokBanking:AddNewTransaction', Config.Society.label, Config.Society.name, zPlayer.getName(), zPlayer.getIdentifier(), data.fine, data.reason)
                    elseif Config.Banks.codeMBanking then
                        exports['codem-bank']:addtransaction(zPlayer.source, data.fine, 'bills')
                    end

                    if Config.UseWebhooks then 
                        SERVER.SendLog("submitFine", (Config.Webhooks["submitFine"].description):format(src, data.fine * Config.Society.percentToHospital))
                    end

                    local from = {
                        label = Config.Society.label,
                        job = Config.Society.jobname,
                        identifier = Config.Society.jobname,
                    }

                    TriggerEvent('bill:createBill', zPlayer.source, 5000, Config.Society.label, from)
                elseif Config.BillingScripts.okokBilling then
                    xPlayer.addAccountMoney('bank', data.fine * Config.Society.percentToDoctor)

                    if Config.Banks.qf_banking then
                        TriggerEvent("qf_banking:addBankHistory", xPlayer.source, data.fine * Config.Society.percentToDoctor, '% from Invoice', 'bank', xPlayer.getAccount('bank').money) 
                        TriggerEvent("qf_banking:addBankHistory", zPlayer.source, data.fine, 'Invoice', 'bank', zPlayer.getAccount('bank').money)
                    elseif Config.Banks.okokBanking then
                        TriggerEvent('okokBanking:AddNewTransaction', Config.Society.label, Config.Society.name, zPlayer.getName(), zPlayer.getIdentifier(), data.fine, data.reason)
                    elseif Config.Banks.codeMBanking then
                        exports['codem-bank']:addtransaction(zPlayer.source, data.fine, 'bills')
                    end

                    zPlayer.removeAccountMoney('bank', data.fine)

                    TriggerEvent("okokBilling:CreateCustomInvoice", zPlayer.source, data.fine, data.reason, 'Invoice', Config.Society.name, Config.Society.label)
                    TriggerClientEvent('qf-mdt:okokBilling', xPlayer.source, zPlayer.source, data.fine, data.reason, 'Invoice', Config.Society.name, Config.Society.label)

                    if Config.UseWebhooks then 
                        SERVER.SendLog("submitFine", (Config.Webhooks["submitFine"].description):format(src, data.fine * Config.Society.percentToHospital))
                    end
                elseif Config.BillingScripts.codemBilling then
                    exports['codem-billing']:createBilling(xPlayer.source, zPlayer.source, data.fine, data.reason, Config.Society.name)
                    
                    if Config.UseWebhooks then 
                        SERVER.SendLog("submitFine", (Config.Webhooks["submitFine"].description):format(src, data.fine * Config.Society.percentToHospital))
                    end
                elseif Config.BillingScripts.esx_billing then
                    TriggerClientEvent('qf_mdt_ems:esxBilling', src, zPlayer.source, Config.Society.name, Config.Society.label, data.fine)
                    
                    if Config.UseWebhooks then 
                        SERVER.SendLog("submitFine", (Config.Webhooks["submitFine"].description):format(src, data.fine * Config.Society.percentToHospital))
                    end
                elseif Config.BillingScripts.zerio_invoice then
                    if Config.Banks.qf_banking then
                        TriggerEvent("qf_banking:addBankHistory", xPlayer.source, data.fine * Config.Society.percentToDoctor, '% from Invoice', 'bank', xPlayer.getAccount('bank').money) 
                        TriggerEvent("qf_banking:addBankHistory", zPlayer.source, data.fine, 'Invoice', 'bank', zPlayer.getAccount('bank').money)
                    elseif Config.Banks.okokBanking then
                        TriggerEvent('okokBanking:AddNewTransaction', Config.Society.label, Config.Society.name, zPlayer.getName(), zPlayer.getIdentifier(), data.fine, data.reason)
                    elseif Config.Banks.codeMBanking then
                        exports['codem-bank']:addtransaction(zPlayer.source, data.fine, 'bills')
                    end

                    exports["zerio-invoice"]:NewInvoice({
                        type = "player",
                        sendDate = os.date("%Y/%m/%d %X"),
                        dueDate = os.date("%Y/%m/%d %X"),
                        receiver = zPlayer.identifier,
                        senderJob = xPlayer.job.name,
                        senderPlayer = xPlayer.identifier,
                        reason = data.reason,
                        category = "Hospital Invoice",
                        products = {{price = data.fine, description = data.reason, quantity = 1}}
                    })
                    
                    if Config.UseWebhooks then 
                        SERVER.SendLog("submitFine", (Config.Webhooks["submitFine"].description):format(src, data.fine * Config.Society.percentToHospital))
                    end
                else
                    xPlayer.addAccountMoney('bank', data.fine * Config.Society.percentToDoctor)

                    if Config.Banks.qf_banking then
                        TriggerEvent("qf_banking:addBankHistory", xPlayer.source, data.fine * Config.Society.percentToDoctor, '% from Invoice', 'bank', xPlayer.getAccount('bank').money) 
                        TriggerEvent("qf_banking:addBankHistory", zPlayer.source, data.fine, 'Invoice', 'bank', zPlayer.getAccount('bank').money)
                    elseif Config.Banks.okokBanking then
                        TriggerEvent('okokBanking:AddNewTransaction', Config.Society.label, Config.Society.name, zPlayer.getName(), zPlayer.getIdentifier(), data.fine, data.reason)
                    elseif Config.Banks.codeMBanking then
                        exports['codem-bank']:addtransaction(zPlayer.source, data.fine, 'bills')
                    end

                    zPlayer.removeAccountMoney('bank', data.fine)

                    if Config.UseWebhooks then 
                        SERVER.SendLog("submitFine", (Config.Webhooks["submitFine"].description):format(src, data.fine * Config.Society.percentToHospital))
                    end
                    print('[^2INFO] ^0[^5QF-MDT-EMS^0] encountered a problem at [^5submitFine^0], if you are using a [^5CUSTOM FRAMEWORK / STANDALONE^0] open a ticket on our discord server and wait for help with configuration!')
                    -- SCRIPT BY OWN
                end
            end

            xPlayer.showNotification((_L('FINE_DOCTORMAN', zPlayer.source, FRAMEWORK.GetFirstName(zPlayer), FRAMEWORK.GetLastName(zPlayer), data.fine)))
            zPlayer.showNotification((_L('FINE_PLAYER', xPlayer.source, FRAMEWORK.GetFirstName(xPlayer), FRAMEWORK.GetLastName(xPlayer), data.fine)))
            MySQL.insert('INSERT INTO qf_mdt_ems_fines (identifier, reason, fine, date, officer) VALUES (LEFT(?, 100), LEFT(?, 1000), ?, ?, LEFT(?, 100))', {data.identifier, data.reason, data.fine, os.time(), data.officer})
        else
            xPlayer.showNotification(_L('PLAYER_NOT_AVAILABLE'))
        end
    end
end)

RegisterServerEvent('qf_mdt_ems:getHours', function(src)
    local xPlayer = FRAMEWORK.GetPlayerFromId(src)

    if xPlayer then
        MySQL.query('SELECT time FROM qf_mdt_ems_time WHERE identifier = ?', {xPlayer.getIdentifier()}, function(result)
            if result[1] then
                Player(src).state.RankTimeAmbulance = tonumber(result[1].time)
            else
                MySQL.insert('INSERT INTO qf_mdt_ems_time (identifier, name, time) VALUES (?, ?, ?)', {xPlayer.getIdentifier(), xPlayer.getName(), 5}, function()
                    Player(src).state.RankTimeAmbulance = 1
                end)
            end
        end)
    end
end)

RegisterServerEvent('qf_mdt_ems:saveHours', function(identifier, hours)
    if identifier then
        MySQL.query('UPDATE qf_mdt_ems_time SET time = ? WHERE identifier = ?', {hours, identifier})
    end
end)

RegisterServerEvent('qf-mdt-ems:saveHours', function(id, mins)
    print('[QF-MDT]: SAVED '..mins..'minutes for: '..id)
end)


RegisterCommand('ems_resthours', function(src)
    local _src = src
    local xp = FRAMEWORK.GetPlayerFromId(_src)

    if xp.job.grade < Config.Jobs.ResetHours then return end

    TriggerClientEvent('qf_mdt_ems:resetHoursPlayer', -1)
    MySQL.query('UPDATE qf_mdt_ems_time SET time = ?', {0})
    xp.showNotification('All of the ambulance hours got reseted')
end, false)

RegisterServerEvent('qf-mdt-ems:resetHoursPlayerX', function(id)
    local _src = source
    local xp = FRAMEWORK.GetPlayerFromId(_src)
    local tp = FRAMEWORK.GetPlayerFromId(id)

    TriggerClientEvent('qf_mdt:resetHoursPlayer', id)
    MySQL.query('UPDATE qf_mdt_time SET time = 0 WHERE identifier = ?', {tp.identifier})
    xp.showNotification('Police hours for id '..id..' got reseted')
end)

RegisterServerEvent('qf_mdt_ems:giveLicensePlayer', function(data)
    local src = source
    local xPlayer = FRAMEWORK.GetPlayerFromId(src)

    if not data.current_data then
        MySQL.query('INSERT INTO user_licenses (type, owner) VALUES (?, ?)', {data.value, data.player})
    else
        MySQL.query('DELETE FROM user_licenses WHERE type = ? AND owner = ?', {data.value, data.player})
    end
end)
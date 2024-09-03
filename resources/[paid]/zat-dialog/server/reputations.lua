local QBCore = nil

Citizen.CreateThread(function() 
    if Config.Framework == "qb" then
        QBCore = exports[Config.FrameworkPseudo]:GetCoreObject()
    end
end)

Citizen.CreateThread(function() 
    RegisterServerCallback('zat-dialog:server:GetMyReputation', function(source, cb, mission)
        local src = source
        local MyRep = 0
        if Config.Framework == "qb" then
            local Player = QBCore.Functions.GetPlayer(src)
            local cid = Player.PlayerData.citizenid
            result = MySQL.prepare.await('SELECT * FROM dialog where cid = ?', { cid }) 
            if result == nil then
                MyRep = 0
            else
                local Data = json.decode(result.rep)
                if Data[mission] ~= nil then 
                    MyRep = tonumber(Data[mission])
                else
                    MyRep = 0
                end
            end
        elseif Config.Framework == 'esx' then 
            local Player = ESX.GetPlayerFromId(src)
            local cid = Player.getIdentifier()
            result = MySQL.prepare.await('SELECT * FROM dialog where cid = ?', { cid })
            if result == nil then
                MyRep = 0
            else
                local Data = json.decode(result.rep)
                if Data[mission] ~= nil then 
                    MyRep = tonumber(Data[mission])
                else
                    MyRep = 0
                end
            end
        end
        Wait(200)
        cb(MyRep)
    end)
end)

RegisterNetEvent('zat-dialog:server:IncreaseRep', function(mission, amount)
    local src = source
    if Config.Framework == "qb" then
        local Player = QBCore.Functions.GetPlayer(src)
        local cid = Player.PlayerData.citizenid
        local result = MySQL.scalar.await('SELECT rep FROM dialog WHERE cid = ?', { cid })
        if result ~= nil then
            local Data = json.decode(result)
            if Data[mission] ~= nil then
                Data[mission] = Data[mission] + amount
            else
                Data[mission] = amount
            end
            MySQL.update('UPDATE `dialog` SET `rep` = ? WHERE `cid` = ?', { json.encode(Data), cid })
        else
            local Data = {}
            Data[mission] = amount
            MySQL.insert('INSERT INTO dialog (`cid`, `rep`) VALUES (?, ?)', {cid, json.encode(Data)})
        end
    elseif Config.Framework == 'esx' then 
        local Player = ESX.GetPlayerFromId(src)
        local cid = Player.getIdentifier()
        local result = MySQL.scalar.await('SELECT rep FROM dialog WHERE cid = ?', { cid })
        if result ~= nil then
            local Data = json.decode(result)
            if Data[mission] ~= nil then
                Data[mission] = Data[mission] + amount
            else
                Data[mission] = amount
            end
            MySQL.update('UPDATE `dialog` SET `rep` = ? WHERE `cid` = ?', { json.encode(Data), cid })
        else
            local Data = {}
            Data[mission] = amount
            MySQL.insert('INSERT INTO dialog (`cid`, `rep`) VALUES (?, ?)', {cid, json.encode(Data)})
        end
    end
end)
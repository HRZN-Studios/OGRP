local QBCore = nil
local ESX = nil
Citizen.CreateThread(function() 
    if Config.Framework == "qb" then
        QBCore = exports[Config.FrameworkPseudo]:GetCoreObject()
    elseif Config.Framework == "esx" then
        ESX = exports['es_extended']:getSharedObject()
    end
end)

function RegisterServerCallback(name, cb)
    if Config.Framework == "qb" then
         QBCore.Functions.CreateCallback(name, cb)
    elseif Config.Framework == "esx" then
        ESX.RegisterServerCallback(name, cb)
    end
end

function NotifyServerFramework(src, text, type)
    if Config.Framework == "qb" then
        TriggerClientEvent('QBCore:Notify', src, text, type) 
    elseif Config.Framework == "esx" then
        TriggerClientEvent("esx:showNotification", src, text, type) 
    end
end

function Pay(src, data)
    if Config.Framework == 'qb' then
        local Player = QBCore.Functions.GetPlayer(src)
        if Player.PlayerData.money.cash >= data.amount then
            Player.Functions.RemoveMoney("cash", data.amount)
            for k, v in pairs(data.items) do
                if v.amount > 0 then
                    GiveItem(src, v.name, v.amount, v.info)
                end
            end
        else
            NotifyServerFramework(src, _U("dia_ncs"), 'error')
        end
    elseif Config.Framework == 'esx' then
        local Player = ESX.GetPlayerFromId(src)
        if Player.getAccount('money').money >= data.amount then
            Player.removeAccountMoney('money', data.amount)
            for k, v in pairs(data.items) do
                if v.amount > 0 then
                    GiveItem(src, v.name, v.amount, v.info)
                end
            end
        else
            NotifyServerFramework(src, _U("dia_ncs"), 'error')
        end
    end
end
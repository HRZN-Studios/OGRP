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

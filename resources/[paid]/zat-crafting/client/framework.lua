local QBCore = nil

Citizen.CreateThread(function() 
    if Config.Framework == "qb" then
        QBCore = exports[Config.FrameworkPseudo]:GetCoreObject()
    end
end)

function NotifyFramework(text, type)
    if Config.Framework == "qb" then
        QBCore.Functions.Notify(text, type)
    elseif Config.Framework == "esx" then
        ESX.ShowNotification(text, type)
    end
end

function TriggerServerCallback(name, cb, ...)
    if Config.Framework == "qb" then
        QBCore.Functions.TriggerCallback(name, cb, ...)
    else
        ESX.TriggerServerCallback(name, cb, ...)
    end
end

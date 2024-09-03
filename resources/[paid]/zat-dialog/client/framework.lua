local QBCore = nil

Citizen.CreateThread(function() 
    if Config.Framework == "qb" then
        QBCore = exports[Config.FrameworkPseudo]:GetCoreObject()
        RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
            PlayerJob = JobInfo
            setJob(PlayerJob)
        end)
        
        RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
            QBCore.Functions.GetPlayerData(function(PlayerData)
                PlayerJob = PlayerData.job
                setJob(PlayerJob)
            end)
        end)
    elseif Config.Framework == "esx" then
        RegisterNetEvent('esx:setJob')
        AddEventHandler('esx:setJob', function(job)
            ESX.PlayerData.job = job
            PlayerJob = job
            setJob(PlayerJob)
        end)

        RegisterNetEvent('esx:playerLoaded')
        AddEventHandler('esx:playerLoaded', function(PlayerData)
            PlayerJob = PlayerData.job
            setJob(PlayerJob)
        end)
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


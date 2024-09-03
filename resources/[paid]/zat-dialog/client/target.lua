local QBCore = nil
local PlayerJob = {}

Citizen.CreateThread(function() 
    if Config.Framework == "qb" then
        QBCore = exports[Config.FrameworkPseudo]:GetCoreObject()
    end
end)

function setJob(JobInfo)
    PlayerJob = JobInfo
end

Citizen.CreateThread(function()
    if not Config.UseInteract then
        for k, v in ipairs(Config.NPCs) do
            exports['qb-target']:AddBoxZone("NPC_Dialog"..k, vector3(v.coords.x, v.coords.y, v.coords.z+1.0), 2.0, 2.0, {
            name = "NPC_Dialog"..k,
            heading = 90.0,
            debugPoly = false,
            minZ = v.coords.z - 2.0,
            maxZ = v.coords.z + 2.0,
            }, {
                options = {
                    {
                        type            = 'client',
                        event           = 'zat-dialog:client:OpenMenu',
                        label           = _U("dia_tal"), 
                        icon            = 'fas fa-cash-register',
                        job             = v.job,
                        gang            = v.gang,
                        index           = k,
                    },
                },
                distance = 2.5
            })
        end
    else
        for k, v in ipairs(Config.NPCs) do
            exports.interact:AddInteraction({
                coords = vector3(v.coords.x, v.coords.y, v.coords.z+1.0), 
                distance = 8.0, -- optional
                interactDst = 1.2, -- optional
                id = "NPC_Dialog"..k, -- needed for removing interactions
                name = "NPC_Dialog"..k, -- optional
                options = {
                    {
                        label = _U("dia_tal"),
                        canInteract = function(entity, coords, args)
                            local groups = v.groups
                            if type(groups) == 'table' then
                                grade = groups[PlayerJob.name]
                                if Config.Framework == 'qb' then
                                    if grade and PlayerJob.grade.level >= grade then
                                        return true
                                    end
                                elseif Config.Framework == 'esx' then
                                    if grade and PlayerJob.grade >= grade then
                                        return true
                                    end
                                end
                            elseif groups == 'all' or groups == PlayerJob.name then
                                return true
                            end
                            return false
                        end,
                        action = function(entity, coords, args)
                            local Data = {
                                index = k
                            }
                            TriggerEvent('zat-dialog:client:OpenMenu', Data)
                        end,

                    },
                }
            })
        end
    end
end)


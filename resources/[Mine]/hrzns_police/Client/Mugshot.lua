
local InMugshot = false

RegisterNetEvent('hrzns_police:mugshot', function(location, copid, copdata, susdata, notes)
    local Name
    local Sex
    local DOB
    local copname
    local ped = PlayerPedId()
    local suscoords = GetEntityCoords(ped)
    local mug = Config.MugShotLocs[location].Suspectloc.pos
    local distance = Vdist(suscoords, mug)
    if distance < Config.MugShotLocs[location].Suspectloc.MaxDist then
        InMugshot = true
        if Config.Framework == 'QBCore' then
            Name = susdata.charinfo.firstname .. ' ' .. susdata.charinfo.lastname
            Sex = susdata.charinfo.gender
            DOB = susdata.charinfo.birthdate
            copname = copdata.charinfo.firstname .. ' ' .. copdata.charinfo.lastname
        elseif Config.Framework == 'ESX' then
            Name = susdata.variables.firstName .. ' ' .. susdata.variables.lastName
            Sex = susdata.variables.sex
            DOB = susdata.variables.dateofbirth
            copname = copdata.variables.firstName .. ' ' .. copdata.variables.lastName
        end
        local ScaleformBoard = LoadScale("mugshot_board_01")
        local RenderHandle = CreateRenderModel("ID_Text", "prop_police_id_text")
        CreateThread(function()
            while RenderHandle do
                HideHudAndRadarThisFrame()
                SetTextRenderId(RenderHandle)
                Set_2dLayer(4)
                SetScriptGfxDrawBehindPausemenu(1)
                DrawScaleformMovie(ScaleformBoard, 0.405, 0.37, 0.81, 0.74, 255, 255, 255, 255, 0)
                SetScriptGfxDrawBehindPausemenu(0)
                SetTextRenderId(GetDefaultScriptRendertargetRenderId())
                SetScriptGfxDrawBehindPausemenu(1)
                SetScriptGfxDrawBehindPausemenu(0)
                Wait(0)
            end
        end)
        Wait(250)
        BeginScaleformMovieMethod(ScaleformBoard, 'SET_BOARD')
        PushScaleformMovieMethodParameterString(Config.MugShotLocs[location].BoardHeader)
        PushScaleformMovieMethodParameterString(Name)
        PushScaleformMovieMethodParameterString(DOB)
        PushScaleformMovieMethodParameterString(Sex)
        PushScaleformMovieFunctionParameterInt(0)
        PushScaleformMovieFunctionParameterInt(math.random(000, 999))
        PushScaleformMovieFunctionParameterInt(116)
        EndScaleformMovieMethod()
        local MugCam = CreateCameraWithParams(Config.MugShotLocs[location].Camera.hash, Config.MugShotLocs[location].Camera.posx, Config.MugShotLocs[location].Camera.posy, Config.MugShotLocs[location].Camera.posz, Config.MugShotLocs[location].Camera.rotx, Config.MugShotLocs[location].Camera.roty, Config.MugShotLocs[location].Camera.rotz, Config.MugShotLocs[location].Camera.fov, Config.MugShotLocs[location].Camera.active, Config.MugShotLocs[location].Camera.rotOrder)
        RenderScriptCams(1, 0, 0, 1, 1)
        Wait(250)
        CreateThread(function()
            FreezeEntityPosition(ped, true)
            SetPauseMenuActive(false)
            while InMugshot do
                DisableAllControlActions(0)
                EnableControlAction(0, 249, true)
                EnableControlAction(0, 46, true)
                Wait(0)
            end
        end)
        SetEntityCoords(ped, mug.x, mug.y, mug.z)
        SetEntityHeading(ped, Config.MugShotLocs[location].Suspectloc.heading)
        LoadModel("prop_police_id_board")
        LoadModel("prop_police_id_text")
        local Board = CreateObject("prop_police_id_board", suscoords, true, true, false)
        local BoardOverlay = CreateObject("prop_police_id_text", suscoords, true, true, false)
        AttachEntityToEntity(BoardOverlay, Board, -1, 4103, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
        SetModelAsNoLongerNeeded("prop_police_id_board")
        SetModelAsNoLongerNeeded("prop_police_id_text")
        SetCurrentPedWeapon(ped, "weapon_unarmed", 1)
        ClearPedWetness(ped)
        ClearPedBloodDamage(ped)
        AttachEntityToEntity(Board, ped, GetPedBoneIndex(ped, 28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0, 0, 0, 0, 2, 1)	
        loadAnimDict("mp_character_creation@lineup@male_a")
        TaskPlayAnim(ped, "mp_character_creation@lineup@male_a", "loop_raised", 8.0, 8.0, -1, 49, 0, false, false, false)
        Wait(1000)
        exports['screenshot-basic']:requestScreenshotUpload(Config.MugShotOptions.ScreenShotHook, 'files[]', {encoding = 'jpg'}, function(data)
            local Response = json.decode(data)
            local imageURL = Response.attachments[1].url
            print('cb')
            TriggerServerEvent('hrzns_police:muglog', copname, DOB, Sex, Name, notes, imageURL)
        end)
        Wait(5000)
        DestroyCam(MugCam, 0)
        RenderScriptCams(0, 0, 1, 1, 1)
        SetFocusEntity(ped)
        DeleteObject(Board)
        DeleteObject(BoardOverlay)
        RenderHandle = nil
        InMugshot = false
        ClearPedTasks(ped)
        FreezeEntityPosition(ped, false)
    else
        TriggerServerEvent('hrzns_police:SNotify', copid, 'error', 'Police', 'Suspect is too far away from the location')
    end
end)

function FillBoard(location)
    local input = lib.inputDialog('Mugshot', {
        {type = 'number', label = 'Citizen ID', description = 'The Server ID of the person being arrested.', icon = 'hashtag'},
        {type = 'textarea', label = 'Mugshot Notes', description = 'Any notes for the mugshot.', placeholder = 'Has a Big scar on his left check.'}
    })
    if not input then return end
    TriggerServerEvent('hrzns_police:mugshotSV', location, input[1], input[2])
end

for _, v in pairs(Config.MugShotLocs) do
    if Config.MugShotOptions.enabled == true then
        exports.ox_target:addBoxZone({
            coords = v.Target.coords,
            size = v.Target.size,
            rotation = v.Target.rotation,
            debug = v.Target.debug,
            groups = {
                v.Target.groups,
            },
            options = {
                {
                    icon = "fa-solid fa-camera",
                    label = 'Take Mugshot',
                    distance = 2,
                    onSelect = function()
                        local location = tostring(_)
                        FillBoard(location)
                    end
                },
            }
        })
    end
end
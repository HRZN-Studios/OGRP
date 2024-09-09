local JailMarker = false

local IsHandcuffed = false
local IsZipped = false
local CuffType = nil
local IsHardCuffed = false
local object = nil
local mycount = 0

local InMugshot = false

local IsEscorted = false
local IsCarried = false

-- #ANCHOR - Callbacks

lib.callback.register('hrzns_police:GetCuffs', function()
    local stats
    if IsHandcuffed == true then
        stats = 'cuffed'
    elseif IsZipped == true then
        stats = 'zipped' 
    else
        stats = 'nocuff'
    end
    return stats
end)

lib.callback.register('hrzns_police:GetCuffType', function()
    local stats
    if IsHardCuffed == true then
        stats = 'hard'
    else
        stats = nil
    end
    return stats
end)

lib.callback.register('hrzns_police:GetEscort', function()
    local stats
    if IsEscorted == true then
        stats = 'escorted'
    elseif IsCarried == true then
        stats = 'carried'
    else
        stats = nil
    end
    return stats
end)

-- #ANCHOR - Jail Function 

RegisterCommand('jailm', function(raw, args)

    -- ToDo Add Dialog that gets nearest players

    if args[1] == 'force' then
        print('busted')
    else
        JailPlayer()
    end
end)

function JailPlayer()
    print('jailed')
    JailMarker = true
    if Config.JailWalk then
        while JailMarker do
            Citizen.Wait(1)
            if Config.PDWalkMarker then
                DrawMarker(20, Config.PDJailMarkers.LSPD.Marker.x, Config.PDJailMarkers.LSPD.Marker.y, Config.PDJailMarkers.LSPD.Marker.z, 0.0,0.0,0.0,0.0,0.0,0.0,0.3,0.3,0.3,0,0,255,200,0,1,0,1,0,0,0)
            end
            local pedcoords = GetEntityCoords(PlayerPedId())
            if GetDistanceBetweenCoords(pedcoords, Config.PDJailMarkers.LSPD.Marker, true) < 0.5 then
                print('busted')
                JailMarker = false
            end
        end
    else
        print('busted')
    end
end

-- #ANCHOR - Prop Logic

RegisterCommand('cone', function()
    local model = `prop_mp_cone_02`
    createProp('cone')
end)

function createProp(prop)
    local model = nil
    if prop == 'cone' then
        model = `prop_mp_cone_02`
    elseif prop == 'pdbarrier' then
        model = 'prop_barrier_work05'
    elseif prop == 'medicbag' then

    end
    local offset = GetEntityCoords(cache.ped) + GetEntityForwardVector(cache.ped) * 3
    lib.requestModel(model)
    local obj = CreateObject(model, offset.x, offset.y, offset.z, false, false, false)
    local data = exports.object_gizmo:useGizmo(obj)
    DeleteEntity(obj)
    lib.print.info(data)
    if data.exit == 'done' then
        TriggerServerEvent('createprop', data.position, data.rotation, model, true)
    end
end

-- #ANCHOR - Cuff Logic

RegisterCommand('cuff', function(raw, args)
    local item
    local cuffhard
    if args[1] == nil or 'cuff' then
        item = 'cuffs'
    elseif args[1] == 'zip' then
        item = 'zip'
    end
    if args[2] == 'hard' then
        cuffhard = 'hard'
    else
        cuffhard = 'false'
    end

    CuffPlayer(nil, item, cuffhard)
end)

function CuffPlayer(id, item, cuffhard)
    if id == nil then
        local coords = GetEntityCoords(PlayerPedId())
        local closestPlayer = GetPlayerServerId(lib.getClosestPlayer(coords))
        print(closestPlayer)
        if closestPlayer == nil then
            lib.notify({
                title = 'General',
                description = 'No player nearby',
                type = 'error'
            })
        else
            local id = closestPlayer
            heading = GetEntityHeading(PlayerPedId())
            loc = GetEntityForwardVector(PlayerPedId(-1))
            coords = GetEntityCoords(PlayerPedId())
            TriggerServerEvent('hrzns_police:CuffPlayer', id, heading, loc, coords, item, cuffhard)
        end
    end
end

RegisterNetEvent('hrzns_police:cuffed', function(id, cufftype, cuffhard)
    Animation('mp_arrest_paired', 'crook_p2_back_right', 8.0, -8, 3750 , 2)
    print(Config.MaxCuffs..' '..mycount)
    Wait(4000)
    if mycount < Config.MaxCuffs then
        print('minigame')
       local success = lib.skillCheck({'hard'}, {'e'})
       if success then
            mycount = mycount + 1
            Wait(500)
            ClearPedTasks(PlayerPedId())
            TriggerServerEvent('hrzns_police:SNotify', id, 'error', 'Police', 'Suspect broke Cuffs!')
        else
            print('failed minigame')
            mycount = 0
            Wait(3000)
            if Config.CuffsAsItems then
                if cuffhard then
                    if cufftype == 'cuffs' then
                        TriggerServerEvent('hrzns_police:RemoveItems', id, 'cuffs', 2)
                    elseif cufftype == 'zip' then
                        TriggerServerEvent('hrzns_police:RemoveItems', id, 'zip', 2)
                    end
                else
                    if cufftype == 'cuffs' then
                        TriggerServerEvent('hrzns_police:RemoveItems', id, 'cuffs', 1)
                    elseif cufftype == 'zip' then
                        TriggerServerEvent('hrzns_police:RemoveItems', id, 'zip', 1)
                    end
                end
            end
            ImCuffed(cufftype, cuffhard)
       end
    else
        mycount = 0
        Wait(3000)
        if Config.CuffsAsItems then
            if cuffhard then
                if cufftype == 'cuffs' then
                    TriggerServerEvent('hrzns_police:RemoveItems', id, 'cuffs', 2)
                elseif cufftype == 'zip' then
                    TriggerServerEvent('hrzns_police:RemoveItems', id, 'zip', 2)
                end
            else
                if cufftype == 'cuffs' then
                    TriggerServerEvent('hrzns_police:RemoveItems', id, 'cuffs', 1)
                elseif cufftype == 'zip' then
                    TriggerServerEvent('hrzns_police:RemoveItems', id, 'zip', 1)
                end
            end
        end
        ImCuffed(cufftype, cuffhard)
    end
end)

function ImCuffed(cufftype, cuffhard)
    local coords = GetEntityCoords(PlayerPedId(-1))
    LoadModel('p_cs_cuffs_02_s')
    LoadModel('ba_prop_battle_cuffs')
    if cuffhard == 'hard' then
        IsHardCuffed = true
    end
    if cufftype == 'cuffs' then
        object = CreateObject('p_cs_cuffs_02_s',coords,true,false)
        AttachEntityToEntity(object, PlayerPedId(-1), GetPedBoneIndex(PlayerPedId(-1), 60309), -0.055, 0.06, 0.04, 265.0, 155.0, 80.0, true, false, false, false, 0, true)
        IsHandcuffed = true
    elseif cufftype == 'zip' then
        object = CreateObject('ba_prop_battle_cuffs',coords,true,false)
        AttachEntityToEntity(object, PlayerPedId(-1), GetPedBoneIndex(PlayerPedId(-1), 60309), -0.055, 0.06, 0.04, 265.0, 155.0, 80.0, true, false, false, false, 0, true)
        IsZipped = true
    end
    LocalPlayer.state:set('invBusy', true, false)
    CreateThread(function()
        while IsHandcuffed or IsZipped do
            Wait(0)
            DisableControlAction(0, 24, true) -- Attack
			DisableControlAction(0, 257, true) -- Attack 2
			DisableControlAction(0, 25, true) -- Aim
			DisableControlAction(0, 263, true) -- Melee Attack 1
			DisableControlAction(0, 45, true) -- Reload
			DisableControlAction(0, 22, true) -- Jump
			DisableControlAction(0, 44, true) -- Cover
			DisableControlAction(0, 37, true) -- Select Weapon
			DisableControlAction(0, 288, true) -- Phone
			DisableControlAction(0, 170, true) -- Animations
			DisableControlAction(0, 167, true) -- Job
			DisableControlAction(0, 73, true) -- Clearing animation
			DisableControlAction(2, 199, true) -- Pause screen
			DisableControlAction(0, 59, true) -- Steering in vehicle
			DisableControlAction(2, 36, true) -- Stealth
			DisableControlAction(0, 47, true)  -- Weapon
			DisableControlAction(0, 257, true) -- Melee
			DisableControlAction(0, 140, true) -- Melee
			DisableControlAction(0, 264, true) -- Melee
			DisableControlAction(0, 141, true) -- Melee
			DisableControlAction(0, 142, true) -- Melee
			DisableControlAction(0, 143, true) -- Melee
            if IsHardCuffed then
                DisableControlAction(0, 32, true) -- W
                DisableControlAction(0, 34, true) -- A
                DisableControlAction(0, 31, true) -- S 
                DisableControlAction(0, 30, true) -- D 
                if IsEntityPlayingAnim(PlayerPedId(-1), 'mp_arresting', 'idle', 3) ~= 1 then
                    if isDead == true then
                        ClearPedSecondaryTask(PlayerPedId(-1))
                    else
                        loadAnimDict('anim@move_m@prisoner_cuffed')
                        TaskPlayAnim(PlayerPedId(-1), 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0.0, false, false, false)
                    end
                end
            else
                if IsEntityPlayingAnim(PlayerPedId(-1), 'mp_arresting', 'idle', 3) ~= 1 then
                    if isDead == true then
                        ClearPedSecondaryTask(PlayerPedId(-1))
                    else
                        loadAnimDict('anim@move_m@prisoner_cuffed')
                        TaskPlayAnim(PlayerPedId(-1), 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0.0, false, false, false)
                    end
                end
            end
        end
    end)
end

RegisterCommand('uncuff', function(raw , args)
    local item
    if args[1] == nil then
        item = 'cuffkey'
    elseif args[1] == 'pliers' then
        item = 'pliers'
    elseif args[1] == 'cutters' then
        item = 'cutters'
    elseif args[1] == 'hmkey' then
        item = 'hmkey'
    end
    UnCuff(nil, item)
end)

function UnCuff(id, item)
    if id == nil then
        local coords = GetEntityCoords(PlayerPedId())
        local closestPlayer = GetPlayerServerId(lib.getClosestPlayer(coords))
        print(closestPlayer)
        if closestPlayer == nil then
            lib.notify({
                title = 'General',
                description = 'No player nearby',
                type = 'error'
            })
        else
            local id = closestPlayer
            TriggerServerEvent('hrzns_police:UncuffPlayer', id, item)
        end
    else
        TriggerServerEvent('hrzns_police:UncuffPlayer', id, item)
    end
end

RegisterNetEvent('hrzns_police:uncufftest', function(id, item)
    local success
    if item == 'cutters' then
        success = lib.skillCheck({'medium'}, {'e'})
        if success then
            TriggerServerEvent('hrzns_police:UnCuff', id, item)
        else
            lib.notify({
                title = 'Police',
                description = 'You failed the minigame',
                type = 'error'
            })
        end
    elseif item == 'pliers' then
        success = lib.skillCheck({'easy'}, {'e'})
        if success then
            TriggerServerEvent('hrzns_police:UnCuff', id, item)
        else
            lib.notify({
                title = 'Police',
                description = 'You failed the minigame',
                type = 'error'
            })
        end

    elseif item == 'cuffkey' then
        TriggerServerEvent('hrzns_police:UnCuff', id, item)
    elseif item == 'hmkey' then
        success = lib.skillCheck({'hard'}, {'e'})
        if success then
            TriggerServerEvent('hrzns_police:UnCuff', id, item)
        else
            lib.notify({
                title = 'Police',
                description = 'You failed the minigame',
                type = 'error'
            })
        end
    end
end)


RegisterNetEvent('hrzns_police:uncuffed', function(id, item)
    if item == 'cutters' then
        IsHardCuffed = false
    else 
        IsHardCuffed = false
        IsHandcuffed = false
        DeleteObject(object)
        ClearPedTasks(PlayerPedId(-1))
        LocalPlayer.state:set('invBusy', false)
    end
end)

RegisterNetEvent('hrzns_police:arrest', function(stuff)
    if stuff == 'uncuff' then
        Animation('mp_arresting', 'a_uncuff', 8.0, -8, -1, 2)
        Wait(5500)
        ClearPedTasks(PlayerPedId(-1))
    else
        Animation('mp_arrest_paired', 'cop_p2_back_right', 8.0, -8, 3750 , 2)
        ClearPedTasks(PlayerPedId(-1))
    end
end)

-- #ANCHOR - Mugshot Logic

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

-- #ANCHOR - Misc. Functions

RegisterNetEvent('hrzns_police:Notify', function(info, title, msg)
    print('notified')
    lib.notify({
        title = title,
        description = msg,
        type = info
    })    
end)

RegisterNetEvent('minigame', function(dif, input)
    lib.skillCheck(dif, input)
end)

function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Wait(10)
    end
end

function Animation(animdict, animname, inspd, outspd, dur, flag)
    print('animating')
    local ped = PlayerPedId()
    loadAnimDict(animdict)
    TaskPlayAnim(ped, animdict, animname, inspd, outspd, dur, flag, 0, 0, 0, 0)
end

function LoadModel(model)
    RequestModel(GetHashKey(model))
    while not HasModelLoaded(GetHashKey(model)) do
        Wait(0)
    end
end

function LoadScale(scalef)
	local handle = RequestScaleformMovie(scalef)
    while not HasScaleformMovieLoaded(handle) do
        Wait(0)
    end
	return handle
end

function CreateRenderModel(name, model)
	local handle = 0
	if not IsNamedRendertargetRegistered(name) then
		RegisterNamedRendertarget(name, 0)
	end
	if not IsNamedRendertargetLinked(model) then
		LinkNamedRendertarget(model)
	end
	if IsNamedRendertargetRegistered(name) then
		handle = GetNamedRendertargetRenderId(name)
	end
	return handle
end

RegisterCommand('test', function()
    local success = lib.skillCheck({'easy'}, {'e'})
    if success then
        lib.notify({
            title = 'Police',
            description = 'You passed the minigame',
            type = 'success'
        })
    else
        lib.notify({
            title = 'Police',
            description = 'You failed the minigame',
            type = 'error'
        })
    end
end)


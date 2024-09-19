local JailMarker = false


local IsEscorted = false
local IsCarried = false

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
    print('IsHandcuffed '..tostring(IsHandcuffed)..', IsZipped '..tostring(IsZipped)..', IsHardCuffed '..tostring(IsHardCuffed))
end)




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

lib.callback.register('hrzns_police:hasPropLoaded', function(model)
    local loaded = false
    RequestModel(GetHashKey(model))
    while not HasModelLoaded(GetHashKey(model)) do
        Wait(0)
    end
    loaded = true
    return loaded
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

RegisterNetEvent('hrzns_police:Notify', function(info, thing, msg)
    lib.notify({
        title = thing,
        description = msg,
        type = info
    })
end)

function loadAnimDict(dict)
    print('loading '..dict)
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

function invstatus(bool)
    if Config.inventory == 'ox' then
        if bool == true then
            LocalPlayer.state.invBusy = true
        else
            LocalPlayer.state.invBusy = false
        end
    end
end



-- temp
RegisterCommand('carry', function(source, args, rawCommand)
    if args[1] == nil then
        var = 'carry'
    else
        var = args[1]
    end
    TriggerEvent('hrzns_police:Carry', nil, var)
end)
  
RegisterCommand('cuff', function(source, args, rawCommand)
    if args[1] == nil then
        item = 'cuffs'
    else
        item = args[1]
    end
    if args[2] == nil then
        hard = Config.CuffItemBehavior
    else
        hard = args[2]
    end
    CuffPlayer(args[3], item, hard)
end)  

RegisterCommand('uncuff', function(source, args, rawCommand)
    if args[1] == nil then
        hard = 'hard'
    else
        hard = args[1]
    end
    UncuffPlayer(args[2], item, hard)
end)

-- local carrycmd = lib.addCommand('carry', {
--     help = 'Carry a Player',
--     params = {
--         {
--             name = 'kind',
--             type = 'string',
--             help = 'The kind of carrying (carry or escort)',
--             optional = true,
--         },
--     },
-- }, function(source, args, raw)
--     print('carry command')
--     if args.kind == nil then
--         var = 'carry'
--     else
--         var = args.kind
--     end
--     TriggerEvent('hrzns_police:Carry', nil, var)
-- end)


-- lib.addCommand('cuff', {
--     help = 'Cuff a player',
--     params = {
--         {
--             name = 'id',
--             type = 'number',
--             help = 'The Player ID',
--             optional = true,
--         },
--         {
--             name = 'cuff',
--             type = 'string',
--             help = 'Item for cuffing (cuffs or zip)',
--             optional = true,
--         },
--         {
--             name = 'hard',
--             type = 'sting',
--             help = 'Type of cuffing (hard or soft)',
--             optional = true,
--         },
--     },
--     restricted = Config.CuffJob
-- }, function(source, args, raw)
--     print('cuff command')
--     if args.cuff == nil then
--         item = 'cuffs'
--     else
--         item = args.cuff
--     end
--     if args.hard == nil then
--         hard = Config.CuffItemBehavior
--     else
--         hard = args.hard
--     end
--     CuffPlayer(args.id, item, hard)
-- end)

-- lib.addCommand('uncuff', {
--     help = 'Cuff a player',
--     params = {
--         {
--             name = 'id',
--             type = 'number',
--             help = 'The Player ID',
--             optional = true,
--         },
--         {
--             name = 'hard',
--             type = 'sting',
--             help = 'Type of uncuffing (hard or soft)',
--             optional = true,
--         },
--     },
-- }, function(source, args, raw)
--     print('uncuff command')
--     if args.hard == nil then
--         hard = 'hard'
--     else
--         hard = args.hard
--     end
--     UncuffPlayer(args.id, item, hard)
-- end)


-- old code


-- RegisterCommand('carry', function(source, args, rawCommand)
--     if InAnim then
--         TriggerEvent('hrzns_police:Carry', CarriedId)
--     else
--         if args[1] == nil then
--             var = 'carry'
--         else
--             var = args[1]
--         end
--         TriggerEvent('hrzns_police:Carry', args[2], var)
--     end
-- end, false)


-- debug


RegisterCommand('ecdebug', function(source, args, rawCommand)
    local ped = GetPlayerPed(args[1])
    ClearPedTasks(ped)
end, false)


RegisterCommand('friskdebug', function()
    TriggerEvent('hrzns_police:frisk', 1)
end)


RegisterCommand('clearcuffs', function(raw)
    TriggerServerEvent('hrzns_police:clearcuffs')
end)


RegisterCommand('prop', function()
    createProp('prop_mp_cone_02')
end)



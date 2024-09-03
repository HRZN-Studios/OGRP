Framework = nil
Library = nil
ox_inventory = nil
Depsloaded = false
itemsToSearch = {}
labels = {}

local frameworks = {
    ['ESX'] = 'es_extended',
    ['QBCORE'] = 'qb-core',
    ['OX'] = 'ox_core',
}

local custominventories = {
    ['OX'] = 'ox_inventory'
}

local inventories = {
    ['ESX'] = 'es_extended',
    ['QBCORE'] = 'qb-inventory'
}

local targets = {
    ['OX'] = 'ox_target',
    ['QTARGET'] = 'qtarget',
    ['QBCORE'] = 'qb-target'
}

local function unknownDep(message)
    CreateThread(function()
        local message = string.format('[%s] %s', GetCurrentResourceName(), message)
        while true do
            print(message)
            Wait(5000)
        end
    end)
end

local function fail()
    return 'failed'
end

local function loadframework(fw)
    local file = ('imports/%s.lua'):format(IsDuplicityVersion() and 'server' or 'client')
    local import = LoadResourceFile('ox_core', file)
    local chunk = import ~= nil and assert(load(import, ('@@ox_core/%s'):format(file))) or fail
    Framework = fw == 'ox_core' and chunk() or fw == 'es_extended' and exports[fw]:getSharedObject() or fw == 'qb-core' and exports[fw]:GetCoreObject() or fail
end

local function loadlib()
    local import = LoadResourceFile('ox_lib', 'init.lua')
    local chunk = import ~= nil and assert(load(import, ('@@ox_lib/%s'):format('init.lua'))) or fail
    Library = chunk()
end

local function loadinventory(inv)
    if inv == 'OX' then
        ox_inventory = exports.ox_inventory
        for _, v in pairs(exports.ox_inventory:Items()) do
            labels[v.name] = v.label
        end
    elseif inv == 'QBCORE' then
        CreateThread(function() for _, v in pairs(Framework.Shared.Items) do labels[v.name] = v.label end end)
    end
end


CreateThread(function()
    local timeout = 0
    local resourcestate = GetResourceState('ox_lib')
    if resourcestate == 'missing' then unknownDep('ox_lib is missing, please ensure you download the latest release') return end
    if resourcestate == 'started' then loadlib() end
    if resourcestate == 'stopped' then
        AddEventHandler('onResourceStart', function(resource)
            if resource == 'ox_lib' then
                loadlib()
            end
        end)
    end

    repeat
        timeout += 1
        Wait(1)
    until GetResourceState('ox_lib') == 'started' or Library == 'failed' or timeout >= 60000
    if Library == 'failed' or timeout >= 60000 and GetResourceState('ox_lib') ~= 'started' then unknownDep('ox_lib was found but failed to load') return end

    local timeout = 0
    for k, v in pairs(frameworks) do
        local resourcestate = GetResourceState(v)
        if resourcestate == 'started' then
            Config.Framework = k
            loadframework(v)
            break
        elseif resourcestate == 'stopped' then
            Config.Framework = k
            AddEventHandler('onResourceStart', function(resource)
                if resource == v then
                    loadframework(v)
                end
            end)
            break
        end
    end
    repeat
        timeout += 1
        Wait(1)
    until GetResourceState(frameworks[Config.Framework]) == 'started' or Framework == 'failed' or timeout >= 60000 or Config.Framework == nil
    if Framework == 'failed' or Config.Framework == nil or timeout >= 60000 and GetResourceState(frameworks[Config.Framework]) ~= 'started' then unknownDep('failed to detect framework') return end

    local timeout = 0
    for k, v in pairs(custominventories) do
        local resourcestate = GetResourceState(v)
        if resourcestate == 'started' then
            Config.inventory = k
            loadinventory(Config.inventory)
            break
        elseif resourcestate == 'stopped' then
            Config.inventory = k
            AddEventHandler('onResourceStart', function(resource)
                if resource == v then
                    loadinventory(Config.inventory)
                end
            end)
            break
        end
    end
    if Config.inventory == nil then
        local defaultInv = inventories?[Config.Framework]
        if defaultInv ~= nil then
            local resourcestate = GetResourceState(defaultInv)
            if resourcestate == 'started' then
                Config.inventory = Config.Framework
                loadinventory(Config.inventory)
            elseif resourcestate == 'stopped' then
                Config.inventory = Config.Framework
                AddEventHandler('onResourceStart', function(resource)
                    if resource == defaultInv then
                        loadinventory(Config.inventory)
                    end
                end)
            end
        end
    end
    repeat
        timeout += 1
        Wait(1)
    until custominventories[Config.inventory] and GetResourceState(custominventories[Config.inventory]) == 'started' or inventories[Config.inventory] and GetResourceState(inventories[Config.inventory]) == 'started' or timeout >= 60000
    if Config.inventory == nil or timeout >= 60000 and GetResourceState(inventories[Config.inventory]) ~= 'started' and GetResourceState(custominventories[Config.inventory]) ~= 'started' then unknownDep('Failed to detect inventory.') return end

    if Config.Target then
        local timeout = 0
        for k, v in pairs(targets) do
            if GetResourceState(v) == 'started' then
                Config.targetSystem = k
                if v == 'ox_target' then
                    break
                end
            elseif GetResourceState(v) == 'stopped' then
                Config.targetSystem = k
                if v == 'ox_target' then
                    break
                end
            end
        end
        repeat
            timeout += 1
            Wait(1)
        until GetResourceState(targets[Config.targetSystem]) == 'started' or timeout >= 60000
        if timeout >= 60000 and GetResourceState(targets[Config.targetSystem]) ~= 'started' then unknownDep('Config.Target set to true but cannot find compatabile target system.') return end

        function createTarget(name, ent)
            if targets[Config.targetSystem] == 'ox_target' then
                exports[targets[Config.targetSystem]]:addLocalEntity(ent, {
                    {
                        name = name,
                        icon = "far fa-comment",
                        label = _U('target_use'),
                        onSelect = function()
                            OpenRecycler(name)
                        end,
                        canInteract = function(entity, distance, coords, name, bone)
                            return distance < 2.5
                        end
                    },
                    {
                        name = name,
                        icon = "far fa-comment",
                        label = _U('target_collect'),
                        onSelect = function()
                            OpenList(name)
                        end,
                        canInteract = function(entity, distance, coords, name, bone)
                            return distance < 2.5
                        end
                    }
                })
            else
                exports[targets[Config.targetSystem]]:RemoveZone(name)
                exports[targets[Config.targetSystem]]:AddEntityZone(name, ent, {
                    name = name,
                    debugPoly = false,
                    useZ = true
                        }, {
                    options = {
                        {
                            icon = 'far fa-comment',
                            label = _U('target_use'),
                            action = function(entity)
                                OpenRecycler(name)
                            end
                        },
                        {
                            icon = 'far fa-comment',
                            label = _U('target_collect'),
                            action = function(entity)
                                OpenList(name)
                            end
                        },
                    },
                    distance = 2.0
                })
            end
        end
    end
    
    for k in pairs(Config.Items) do
        itemsToSearch[#itemsToSearch + 1] = k
    end
    Depsloaded = true
end)

function Notify(data)
    lib.notify({type = data.type, description = data.description})
end
RegisterNetEvent('OT_recycler:notify', Notify)
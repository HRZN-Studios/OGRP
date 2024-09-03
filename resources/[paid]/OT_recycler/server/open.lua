local webhook = nil -- Webhook for discord logs (optional)
Framework = nil
Inventory = nil
Depsloaded = false
ox_inventory = nil
itemsToSearch = {}
labels = {}

local frameworks = {
    ['ESX'] = 'es_extended',
    ['QBCORE'] = 'qb-core',
    ['OX'] = 'ox_core'
}

local custominventories = {
    ['OX'] = 'ox_inventory'
}

local inventories = {
    ['ESX'] = 'es_extended',
    ['QBCORE'] = 'qb-inventory'
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
    if resourcestate == 'missing' then unknownDep('ox_lib') return end
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
    if Library == 'failed' or timeout >= 60000 and GetResourceState('ox_lib') ~= 'started' then unknownDep('ox_lib') return end

    print('Loaded ox_lib')

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
    if Framework == 'failed' or Config.Framework == nil or timeout >= 60000 and GetResourceState(frameworks[Config.Framework]) ~= 'started' then unknownDep('framework') return end
    print('Loaded Framework: ' .. Config.Framework)

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
    until custominventories[Config.inventory] and GetResourceState(custominventories[Config.inventory]) == 'started' or inventories[Config.inventory] and GetResourceState(inventories[Config.inventory]) == 'started' or timeout >= 60000 or Config.inventory == nil
    if Config.inventory == nil or timeout >= 60000 and GetResourceState(inventories[Config.inventory]) ~= 'started' and GetResourceState(custominventories[Config.inventory]) ~= 'started' then unknownDep('inventory') return end
    print('Loaded Inventory: ' .. Config.inventory)

    for k in pairs(Config.Items) do
        itemsToSearch[#itemsToSearch + 1] = k
    end

    function getPlayerIdentifier(src)
        if Config.Framework == 'OX' then
            local player = Ox.GetPlayer(src)
            return player.charId
        elseif Config.Framework == 'ESX' then
            local xPlayer = Framework.GetPlayerFromId(src)
            return xPlayer.identifier
        elseif Config.Framework == 'QBCORE' then
            local Player = Framework.Functions.GetPlayer(src)
            return Player.PlayerData.citizenid
        end
    end
    
    function addItem(src, name, amount)
        if Config.inventory == 'ESX' then
            local xPlayer = Framework.GetPlayerFromId(src)
            if xPlayer.canCarryItem(name, amount) then
                xPlayer.addInventoryItem(name, amount)
                return true
            else
                return false
            end
        elseif Config.inventory == 'OX' then
            local canCarryItem = ox_inventory:CanCarryItem(src, name, amount)
            if not canCarryItem then return false end
            ox_inventory:AddItem(src, name, amount)
            return true
        elseif Config.inventory == 'QBCORE' then
            local Player = Framework.Functions.GetPlayer(src)
            Player.Functions.AddItem(name, amount)
            return true
        end
    end
    
    function removeItem(src, name, amount)
        if Config.inventory == 'ESX' then
            local xPlayer = Framework.GetPlayerFromId(src)
            local itemcount = xPlayer.getInventoryItem(name).count
            if itemcount >= amount  then
                xPlayer.removeInventoryItem(name, amount)
                return true
            else
                return false
            end
        elseif Config.inventory == 'OX' then
            local count = ox_inventory:Search(src, 'count', name)
            if count >= amount then
                ox_inventory:RemoveItem(src, name, amount)
                return true
            else
                return false
            end
        elseif Config.inventory == 'QBCORE' then
            local Player = Framework.Functions.GetPlayer(src)
            local item = Player.Functions.GetItemByName(name)
            if item.amount >= amount then
                Player.Functions.RemoveItem(name, amount)
                return true
            else
                return false
            end
        end
    end
    
    function searchItem(src, name, amount)
        if amount == nil then amount = 1 end
        if Config.inventory == 'ESX' then
            local xPlayer = Framework.GetPlayerFromId(src)
            local itemcount = xPlayer.getInventoryItem(name).count
            if itemcount ~= nil and itemcount >= amount then
                return itemcount
            end
            return false
        elseif Config.inventory == 'OX' then
            local search = ox_inventory:Search(src, 'count', name)
            if search ~= nil and search >= amount then
                return search
            end
            return false
        elseif Config.inventory == 'QBCORE' then
            local Player = Framework.Functions.GetPlayer(src)
            local item = Player.Functions.GetItemByName(name)
            if item ~= nil and item.amount >= amount then
                return item.amount
            end
            return false
        end
    end
    
    function getrecycleItems(src)
        local recyclables = {}
        if Config.inventory == 'ESX' then
            local xPlayer = Framework.GetPlayerFromId(src)
            for i = 1, #itemsToSearch do
                local item = xPlayer.getInventoryItem(itemsToSearch[i])
                if item ~= nil and item.count >= 1 then
                    recyclables[#recyclables + 1] = {label = item.label, name = item.name, count = item.count}
                end
            end
            return recyclables
        elseif Config.inventory == 'OX' then
            local search = ox_inventory:Search(src, 'count', itemsToSearch)
            for k, v in pairs(search) do
                if v >= 1 then
                    recyclables[#recyclables + 1] = {label = labels[k], name = k, count = v}
                end
            end
            return recyclables
        elseif Config.inventory == 'QBCORE' then
            local Player = Framework.Functions.GetPlayer(src)
            for i = 1, #itemsToSearch do
                local item = Player.Functions.GetItemByName(itemsToSearch[i])
                if item ~= nil and item.amount >= 1 then
                    recyclables[#recyclables + 1] = {label = item.label, name = item.name, count = item.amount}
                end
            end
            return recyclables
        end
    end

    function log(title, message)
        if not webhook or message == nil then return end
        local data = {
            {
                ['title'] = title,
                ['color'] = 2738053,
                ['footer'] = {
                    ['text'] = os.date('%c'),
                },
                ['description'] = message,
                ['author'] = {
                    ['name'] = 'Recycler Logs',
                    ['icon_url'] = 'https://cdn.discordapp.com/icons/941423187105816616/d43b0d5536ca20bb0cc5c99b92478d38.webp',
                },
            }
        }
        PerformHttpRequest(webhook, function() end, 'POST', json.encode({ username = 'Recycler Logs', embeds = data}), { ['Content-Type'] = 'application/json' })
    end
    Depsloaded = true
end)


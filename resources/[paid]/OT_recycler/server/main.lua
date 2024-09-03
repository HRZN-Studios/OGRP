GlobalState.recyclingDisabled = false
local recyclers = {}

function dump(table, nb)
	if nb == nil then
		nb = 0
	end
	if type(table) == 'table' then
		local s = ''
		for i = 1, nb + 1, 1 do
			s = s .. "    "
		end
		s = '{\n'
		for k,v in pairs(table) do
			if type(k) ~= 'number' then k = '"'..k..'"' end
			for i = 1, nb, 1 do
				s = s .. "    "
			end
			s = s .. '['..k..'] = ' .. dump(v, nb + 1) .. ',\n'
		end
		for i = 1, nb, 1 do
			s = s .. "    "
		end
		return s .. '}'
	else
		return tostring(table)
	end
end

local function table_length(tbl)
    local length = 0
    for k in pairs(tbl) do length += 1 end
    return length
end

local function getReward(name, count)
    local item = Config.Items[name].rewards
    local rewards = {}
    for k, v in pairs(item) do
        local chanceNum = math.random(1, 100)
        if chanceNum <= v.chance then
            local total = v.max > 1 and (math.random(v.min or 1, v.max) * count) or 1 * count
            local time = os.time()
            local canCollect = (time + ((Config.Items[name].rewards[k].durationPerItem * total) / 1000))
            local finish = os.date('%H:%M', math.floor(canCollect))
            rewards[#rewards + 1] = {name = k, label = labels[k] or k, count = total, canCollect = canCollect, finish = finish}
        end
    end
    return rewards
end

local function concatRewards(rewards)
    local new = nil
    local suffix = ', '
    for k, v in pairs(rewards) do
        if v.label == nil then
            if new == nil then
                new = "" .. string.format('%s x %s', v.count, v.name)
            else
                new = new .. suffix .. string.format('%s x %s', v.count, v.name)
            end
        else
            if new == nil then
                new = "" .. string.format('%s x %s', v.count, v.label)
            else
                new = new .. suffix .. string.format('%s x %s', v.count, v.label)
            end
        end
    end
    return new
end

local function notify(source, data)
    TriggerClientEvent('OT_recycler:notify', source, data)
end

local function fetchRecycled(id, identifier)
    local kvp = GetResourceKvpString(('recycled:%s:%s'):format(id, identifier))
    local data = json.decode(kvp)
    return data
end

local function saveRecycled(id, identifier, data)
    SetResourceKvp(('recycled:%s:%s'):format(id, identifier), json.encode(data))
end

local function convertItems()
    local kvpData = json.decode(GetResourceKvpString('recycled'))
    if not kvpData then return end

    local recyclerData = Config.Recyclers[1]
    if not recyclerData then return end

    for identifier, data in pairs(kvpData) do saveRecycled(recyclerData.id, identifier, data) end
end

local function recycleItems(source, data)
    if not recyclers[data.id] then notify(source, {type = 'error', description = _U('recycler_disabled')}) return end
    if GlobalState.recyclingDisabled then notify(source, {type = 'error', description = _U('recycler_disabled')}) return end

    local identifier = getPlayerIdentifier(source)

    local amount = searchItem(source, data.item)
    if not amount or amount < data.amount then notify(source, {type = 'error', description = _U('missing_items')}) return end

    local rewards = getReward(data.item, data.amount)
    if not rewards then notify(source, {type = 'error', description = _U('recycler_take_long')}) return end

    if not removeItem(source, data.item, data.amount) then notify(source, {type = 'error', description = _U('recycler_unable_remove')}) return end

    local recycled = fetchRecycled(data.id, identifier)
    if not recycled then recycled = {} end
    table.insert(recycled, rewards)
    log(('%s [%s]'):format(GetPlayerName(source), identifier), ('Recycled %s x %s for %s'):format(data.amount, data.item, concatRewards(rewards)))
    saveRecycled(data.id, identifier, recycled)
    return true
end

local function redeemItems(source, data)
    if not recyclers[data.id] then notify(source, {type = 'error', description = _U('recycler_disabled')}) return end
    if GlobalState.recyclingDisabled then notify(source, {type = 'error', description = _U('recycler_disabled')}) return end
    local identifier = getPlayerIdentifier(source)

    local recycled = fetchRecycled(data.id, identifier)
    if not recycled then notify(source, {type = 'error', description = _U('recycler_empty')}) return end

    local notifyuser = false
    local redeemed = {}
    for rewardindex, rewards in pairs(recycled) do
        for index, item in pairs(rewards) do
            local time = os.time()
            if item.canCollect > time then
                notifyuser = true
            elseif item.canCollect <= time then
                local added = addItem(source, item.name, item.count)
                if added then
                    redeemed[#redeemed+1] = item
                    recycled[rewardindex][index] = nil
                else
                    notify(source, {type = 'error', description = _U('error', item.label, item.count)})
                end
            end
        end
        if table_length(recycled[rewardindex]) == 0 then recycled[rewardindex] = nil end
    end
    if notifyuser then notify(source, {type = 'error', description = _U('recycler_processing')}) end
    if table.type(redeemed) ~= 'empty' then log(('%s [%s]'):format(GetPlayerName(source), identifier), ('Redeemed %s'):format(concatRewards(redeemed))) end
    saveRecycled(data.id, identifier, recycled)
    return true
end


local function singleRedeem(source, data)
    if not recyclers[data.id] then notify(source, {type = 'error', description = _U('recycler_disabled')}) return end
    if GlobalState.recyclingDisabled then notify(source, {type = 'error', description = _U('recycler_disabled')}) return end

    local identifier = getPlayerIdentifier(source)
    local recycled = fetchRecycled(data.id, identifier)

    if not recycled then notify(source, {type = 'error', description = _U('recycler_empty')}) return end
    local notifyuser = false

    local item = recycled?[data.index]?[data.reward]
    if not item then notify(source, {type = 'error', description = _U('recycler_empty')}) return end
    local time = os.time()
    if item.canCollect > time then
        notifyuser = true
    elseif item.canCollect <= time then
        local added = addItem(source, item.name, item.count)
        if added then
            table.remove(recycled[data.index], data.reward)
            log(('%s [%s]'):format(GetPlayerName(source), identifier), ('Redeemed %s x %s'):format(item.count, item.name))
        else
            notify(source, {type = 'error', description = _U('error', item.label, item.count)})
        end
    end

    if #recycled[data.index] == 0 then table.remove(recycled, data.index) end

    if notifyuser then notify(source, {type = 'error', description = _U('recycler_processing')}) end
    saveRecycled(data.id, identifier, recycled)
    return true
end

local function getRecycled(source, id)
    if not recyclers[id] then notify(source, {type = 'error', description = _U('recycler_disabled')}) return end
    local identifier = getPlayerIdentifier(source)
    local recycled = fetchRecycled(id, identifier)
    return recycled or {}, os.time()
end

local function getRecyclables(source)
    local search = getrecycleItems(source)
    return search
end

local function getClosestRecycler(coords, distance)
    local closest = nil
    for i = 1, #Config.Recyclers do
        local recycler = Config.Recyclers[i]
        if #(coords - recycler.coords) <= distance then
            closest = recycler.id
        end
    end
    return closest
end
exports('getClosestRecycler', getClosestRecycler)

CreateThread(function()
    while not Depsloaded do Wait(100) end

    for i = 1, #Config.Recyclers do
        local data = Config.Recyclers[i]
        recyclers[data.id] = data
    end

    lib.callback.register('OT_recycler:recycle', recycleItems)
    lib.callback.register('OT_recycler:getRecyclables', getRecyclables)
    lib.callback.register('OT_recycler:getRecycled', getRecycled)
    lib.callback.register('OT_recycler:redeem', redeemItems)
    lib.callback.register('OT_recycler:singleRedeem', singleRedeem)

    lib.addCommand({'printrecycled'}, {
        help = 'Print players recycled items',
        params = {
            { name = 'target', type = 'playerId', help = 'player to fetch recycled items for' }
        },
        restricted = 'group.admin',
    }, function(source, args)
        local identifier = getPlayerIdentifier(tonumber(args.target))
        if not identifier then return end
        for i = 1, #Config.Recyclers do print(dump(fetchRecycled(Config.Recyclers[i].id, identifier))) end
    end)

    lib.addCommand({'wiperecycled'}, {
        help = 'Wipes players recycled items',
        params = {
            { name = 'target', type = 'playerId', help = 'player to wipe recycled items for' }
        },
        restricted = 'group.admin',
    }, function(source, args)
        local identifier = getPlayerIdentifier(tonumber(args.target))
        if not identifier then return end
        for i = 1, #Config.Recyclers do saveRecycled(Config.Recyclers[i].id, identifier, {}) end
    end)

    lib.addCommand({'convertrecycleritems'}, {
        help = 'Converts players recycled items',
        params = {},
        restricted = 'group.admin',
    }, convertItems)
end)


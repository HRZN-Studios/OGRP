local function concat(table, suffix)
    local text = nil
    for k in pairs(table) do
        if not labels[k] then
            print(('Cannot find label for item: %s Defaulting to using item name'):format(k))
            text = not text and ('%s'):format(k) or ('%s%s%s'):format(text, suffix, k)
        else
            text = not text and ('%s'):format(labels[k]) or ('%s%s%s'):format(text, suffix, labels[k])
        end
    end
    return text
end

local function requestAudioBank(container)
    while not RequestScriptAudioBank(container, false) do Wait(0) end
end

local function startSound(entity)
    requestAudioBank('audiodirectory/custom_sounds')
    local soundId = GetSoundId()
    PlaySoundFromEntity(soundId, 'recycle', entity, 'special_soundset', false, 0)
    return soundId
end

local function stopSound(soundId)
    StopSound(soundId)
    ReleaseSoundId(soundId)
    ReleaseNamedScriptAudioBank('audiodirectory/custom_sounds')
end

local function recycle(data)
    return lib.callback.await('OT_recycler:recycle', 1000, data)
end

local function cancelClipboard()
    ClearPedTasks(cache.ped)
    local coords = GetEntityCoords(cache.ped)
    local entity = GetClosestObjectOfType(coords.x, coords.y, coords.z, 0.5, `p_cs_clipboard`, false, false, false)
    if DoesEntityExist(entity) then
        SetEntityAsMissionEntity(entity, false, true)
        DeleteEntity(entity)
    end
end


local function redeem(data)
    cancelClipboard()
    return data.single and lib.callback.await('OT_recycler:singleRedeem', 1000, data) or lib.callback.await('OT_recycler:redeem', 1000, data)
end

local function recycleQuantity(data)
    if not data then return end
    local recycleData = {id = data.id, item = data.item}
    if data.count > 1 then
        local input = lib.inputDialog(_U('quantity_header'), {{type = 'slider', label = _U('quantity_label'), description = _U('quantity_tooltip', data.item), required = true, min = 1, max = data.count}})
        if not input then return end
        local amount = tonumber(input[1])
        recycleData.amount = amount
    else
        recycleData.amount = data.count
    end
    recycle(recycleData)
end

function OpenRecycler(id)
    local recyclables = lib.callback.await('OT_recycler:getRecyclables', false, id)
    if table.type(recyclables) == 'empty' then Notify({type = 'inform', description = _U('no_recyclables')}) return end
    local options = {}
    for index, item in pairs(recyclables) do
        local possibleRewards = concat(Config.Items[item.name].rewards, ', ')
        options[#options + 1] = {id = ('recyclables_%s'):format(index), icon = "fa-solid fa-recycle", title = ('%s x %s'):format(item.count, item.label), description = _U('rewards',  possibleRewards), onSelect = recycleQuantity, args = {id = id, item = item.name, count = item.count}}
    end
    lib.registerContext({id = 'recycle_menu', title = _U('recycle_menu_header'), options = options})
    lib.showContext('recycle_menu')
end

function OpenList(id)
    local recycled, time = lib.callback.await('OT_recycler:getRecycled', false, id)
    if table.type(recycled) == 'empty' then Notify({type = 'inform', description = _U('no_queue')}) return end
    local options = {}
    local cancollect = false
    for rewardindex, rewards in pairs(recycled) do
        for index, item in pairs(rewards) do
            if item.canCollect <= time then
                options[#options + 1] = {id = ('recycled_%s'):format(index), icon = "fa-solid fa-check", title = ('%s x %s'):format(item.count, item.label), description = _U('finished'), onSelect = redeem, args = {id = id, index = rewardindex, reward = index, single = true}, collectTime = item.canCollect}
                cancollect = true
            elseif item.canCollect > time then
                options[#options + 1] = {id = ('recycled_%s'):format(index), icon = "fa-solid fa-hourglass-half", title = ('%s x %s'):format(item.count, item.label), description = _U('estimated_finish', timeDifference(time, item.canCollect)), collectTime = item.canCollect}
            end
        end
    end

    table.sort(options, function(a, b) return a.collectTime < b.collectTime end)

    if cancollect then options[#options + 1] = {id = 'recycled_collect', icon = "fa-solid fa-hand-holding", title = _U('collect_recyclables'), onSelect = redeem, args = {id = id, single = false}} end
    
    TaskStartScenarioInPlace(cache.ped, 'WORLD_HUMAN_CLIPBOARD', 0, true)
    lib.registerContext({id = 'recycled_menu', title = _U('recycle_queue'), onExit = function() cancelClipboard() end, options = options})
    lib.showContext('recycled_menu')
end

local function getClosestRecycler(distance)
    local playerCoords = GetEntityCoords(cache.ped)
    local closest = nil
    for i = 1, #Config.Recyclers do
        local recycler = Config.Recyclers[i]
        if #(playerCoords - recycler.coords) <= distance then
            closest = recycler.id
        end
    end
    return closest
end
exports('getClosestRecycler', getClosestRecycler)

local function openClosestRecycler(distance)
    local playerCoords = GetEntityCoords(cache.ped)
    local closest = nil
    for i = 1, #Config.Recyclers do
        local recycler = Config.Recyclers[i]
        if #(playerCoords - recycler.coords) <= distance then
            closest = recycler.id
        end
    end
    if not closest then return closest end
    OpenRecycler(closest)
end
exports('openClosestRecycler', openClosestRecycler)


CreateThread(function()
    while not Depsloaded do Wait(100) end

    for i = 1, #Config.Recyclers do
        local data = Config.Recyclers[i]
        local point = lib.points.new({coords = data.coords, distance = 90.0, recycler = data})

        function point:onEnter()
            lib.requestModel(self.recycler.model, 10000)
            self.prop = CreateObject(self.recycler.model, self.recycler.coords.x, self.recycler.coords.y, self.recycler.coords.z, false, false, false)
            SetEntityHeading(self.prop, self.recycler.heading)
            FreezeEntityPosition(self.prop, true)
            SetModelAsNoLongerNeeded(self.recycler.model)
            if Config.Target then createTarget(self.recycler.id, self.prop) end
            if Config.Sound then self.soundId = startSound(self.prop) end
        end

        function point:onExit()
            if Config.Sound then stopSound(self.soundId) end
            if DoesEntityExist(self.prop) then DeleteEntity(self.prop) end
        end

        if not Config.Target then
            local innerpoint = lib.points.new({coords = data.coords, distance = 2.0, recyclerid = data.id})

            function innerpoint:onEnter()
                lib.showTextUI(_U('textui_controls'))
            end

            function innerpoint:onExit()
                lib.hideTextUI()
            end

            function innerpoint:nearby()
                if self.currentDistance < 2.0 and IsControlJustReleased(0, 38) then
                    OpenRecycler(self.recyclerid)
                elseif self.currentDistance < 2.0 and IsControlJustReleased(0, 49) then
                    OpenList(self.recyclerid)
                end
            end
        end
    end
end)
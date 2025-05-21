
local rep = 1
local fprice = 40
local minprice = 10
local maxprice = 50

inDeal = false

local dealEdited = false

local reppercent = {
    {rep = 0.0, chance = {min= 0.01, max = 0.1}, pricemax = {min= 1, max = 10}, pricemin = {min= -10, max = 0}},
    {rep = 0.1, chance = {min= 0.1, max = 0.2}, pricemax = {min= 2, max = 10}, pricemin = {min= 0, max = 2}},
    {rep = 0.2, chance = {min= 0.2, max = 0.25}, pricemax = {min= 3, max = 10}, pricemin = {min= 0, max = 3}},
    {rep = 0.3, chance = {min= 0.25, max = 0.3}, pricemax = {min= 4, max = 20}, pricemin = {min= 0, max = 4}},
    {rep = 0.4, chance = {min= 0.3, max = 0.5}, pricemax = {min= 10, max = 30}, pricemin = {min= 0, max = 10}},
    {rep = 0.5, chance = {min= 0.5, max = 0.65}, pricemax = {min= 20, max = 40}, pricemin = {min= 5, max = 20}},
    {rep = 0.6, chance = {min= 0.65, max = 0.7}, pricemax = {min= 40, max = 70}, pricemin = {min= 10, max = 40}},
    {rep = 0.7, chance = {min= 0.7, max = 0.75}, pricemax = {min= 60, max = 90}, pricemin = {min= 20, max = 60}},
    {rep = 0.8, chance = {min= 0.75, max = 0.8}, pricemax = {min= 80, max = 120}, pricemin = {min= 30, max = 80}},
    {rep = 0.8, chance = {min= 0.8, max = 0.85}, pricemax = {min= 90, max = 180}, pricemin = {min= 40, max = 90}},
    {rep = 0.9, chance = {min= 0.85, max = 0.9}, pricemax = {min= 120, max = 200}, pricemin = {min= 60, max = 120}},
    {rep = 1, chance = {min= 0.9, max = 0.95}, pricemax = {min= 140, max = 300}, pricemin = {min= 80, max = 140}},
}

local adjustscale = {
    {index = 1, adjust = 1},
    {index = 2, adjust = 5},
    {index = 3, adjust = 10},
    {index = 4, adjust = 50},
}

dealData = {
    ia = 1,
    imax = 200,
    imin = 1,
    imined = false,
    imaxed = false,
    ichance = 0,
    price = 0,
    fprice = 40,
    pmax = 0,
    pmin = 0,
    pmined = false,
    pmaxed = false,
    pchance = 0,
    adjust = 0,
    adjustindex = 1,
    adjustindexmax = 0,
    adjustindexmin = 1,
    chance = 0,
    ochance = 0,
    nchance = 0,
    cop = {min = 50, max = 100},
}

RegisterCommand('selld', function()
    startDeal()
end)

function startDeal()
    inDeal = true
    dealData.price = dealData.fprice
    dealData.pmax = fprice + math.random(5, 50)
    dealData.pmin = fprice - math.random(5, 50)
    dealData.chance = math.random(30, 60)
    print('Chance is '..dealData.chance..'%')
    dealData.ochance = dealData.chance
    dealData.adjustindexmax = #adjustscale
    dealData.adjust = adjustscale[dealData.adjustindex].adjust

    if dealData.ia <= 0 then
        dealData.imined = true
    elseif dealData.ia >= dealData.imax then
        dealData.imaxed = true
    else
        if dealData.imaxed or dealData.imined then
            dealData.imaxed = false
            dealData.imined = false
        end
        local range = dealData.imax - dealData.imin
        local chance = (dealData.ia - dealData.imin) / range 
        dealData.ichance = chance
    end
    if dealData.price == 0 then
        dealData.pmined = true
    elseif dealData.price >= dealData.pmax then
        dealData.pmaxed = true
    else
        if dealData.pmaxed or dealData.pmined then
            dealData.pmaxed = false
            dealData.pmined = false
        end
        local rangemax = dealData.pmax - dealData.price
        local rangemin = dealData.price - dealData.pmin
        local range = dealData.pmax - dealData.pmin
        local chance = (dealData.price - dealData.pmin) / range 
        dealData.chance = chance * 100
    end
    -- if dealData.imaxed or dealData.pmaxed or dealData.imined then
    --     dealData.chance = 0
    -- elseif dealData.pmined then
    --     dealData.chance = 100
    -- else
    --     dealData.chance = (dealData.pchance * 100) + dealData.ochance
    -- end
    local isOpen, text = lib.isTextUIOpen()
    if isOpen == false then
        local uiData = 'Sell Drugs '..' \n '..'Price: $'..dealData.price..' \n '..'Amount is '..dealData.ia..' \n '..'Chance is '..string.format("%03.1f", tostring(dealData.chance))..'%'.. ' \n '..'Adjustment is '..dealData.adjust 
        local options = {}
        lib.showTextUI(uiData, options)
    else
        print('Text UI is already open')
        lib.hideTextUI()
        local uiData = 'Sell Drugs '..' \n '..'Price: $'..dealData.price..' \n '..'Amount is '..dealData.ia..' \n '..'Chance is '..string.format("%03.1f", tostring(dealData.chance))..'%'.. ' \n '..'Adjustment is '..dealData.adjust 
        local options = {}
        lib.showTextUI(uiData, options)
    end
    while inDeal do
        Wait(1)
        if IsControlJustReleased(0, 27) then -- Up Arromw Key 
            updatePrice('up', dealData)
            Wait(10)
            updateChance('down', dealData)
            Wait(10)
            updateUI(dealData)
        elseif IsControlJustReleased(0, 173) then -- Down Arromw Key 
            updatePrice('down', dealData)
            Wait(10)
            updateChance('up', dealData)
            Wait(10)
            updateUI(dealData)
        elseif IsControlJustReleased(0, 175) then -- Right Arromw Key 
            updateItem('up', dealData)
            Wait(10)
            updateChance('up', dealData)
            Wait(10)
            updateUI(dealData)
        elseif IsControlJustReleased(0, 174) then -- Left Arromw Key 
            updateItem('down', dealData)
            Wait(10)
            updateChance('down', dealData)
            Wait(10)
            updateUI(dealData)
        elseif IsControlJustReleased(0, 41) then -- [ Key 
            updateAdjust('down', dealData)
            Wait(10)
            updateChance('down', dealData)
            Wait(10)
            updateUI(dealData)
        elseif IsControlJustReleased(0, 40) then -- ] Key 
            updateAdjust('up', dealData)
            Wait(10)
            updateChance('up', dealData)
            Wait(10)
            updateUI(dealData)
        elseif IsControlJustReleased(0, 215) then -- Enter Key
            finishDeal(dealData)            
            print(json.encode(dealData))
            Wait(10)
        elseif IsControlJustReleased(0, 38) then -- E Key
            inDeal = false
            if dealEdited == true then
                dealEdited = false
            end
            local isOpen, text = lib.isTextUIOpen()
            if isOpen then
                lib.hideTextUI()
            end
        end
    end
end

function updatePrice(value, data)
    if value == 'up' then
        data.price = data.price + data.adjust
        if data.price >= data.pmax then
            data.pmaxed = true
        elseif data.price <= 0 then
            data.pmined = true
        else
            if data.pmaxed == true or data.pmined == true then
                data.pmaxed = false
                data.pmined = false
            end
        end
        
    elseif value == 'down' then
        data.price = data.price - data.adjust
        if data.price >= data.pmax then
            data.pmaxed = true
        elseif data.price <= 0 then
            data.pmined = true
        else
            if data.pmaxed == true or data.pmined == true then
                data.pmaxed = false
                data.pmined = false
            end
        end

    end  
    dealData = data  
end

function updateItem(value, data)
    if value == 'up' then
        data.ia = data.ia + data.adjust
        if data.ia >= data.imax then
            data.imaxed = true
        elseif data.ia <= 0 then
            data.imined = true
        else
            if data.imaxed == true or data.imined == true then
                data.imaxed = false
                data.imined = false
            end
        end
    elseif value == 'down' then
        data.ia = data.ia - data.adjust
        if data.ia >= data.imax then
            data.imaxed = true
        elseif data.ia <= 0 then
            data.imined = true
        else
            if data.imaxed == true or data.imined == true then
                data.imaxed = false
                data.imined = false
            end
        end
    end    
    dealData = data
end

function updateAdjust(value, data)
    if value == 'up' then
        if data.adjustindex >= data.adjustindexmax then
            data.adjustindex = data.adjustindexmax
        else
            data.adjustindex = data.adjustindex + 1
        end
    elseif value == 'down' then
        if data.adjustindex <= 1 then
            data.adjustindex = 1
        else
            data.adjustindex = data.adjustindex - 1
        end
    end
    data.adjust = adjustscale[data.adjustindex].adjust
    dealData = data
end

function updateChance(value, data)
    if data.imaxed or data.pmaxed or data.imined then
        data.chance = 0
    elseif data.pmined then
        data.chance = 100
    else
        if value == 'up' then




            data.chance = data.chance + 1





        -- local irange = data.imax - data.imin
        -- local ichance = (data.ia - data.imin) / irange
        local rangemax = data.pmax - data.price
        local rangemin = data.price - data.pmin
        local range = data.pmax - data.pmin
        local pchance = (data.price - data.pmin) / range 
        -- data.chance = (pchance * ichance) * 100
        data.chance = pchance * 100
        -- if value == 'up' then
        --     data.chance = (pchance * 100) + ochance
        -- elseif value == 'down' then
        --     data.chance = (pchance * 100) - ochance
        end
    end
    dealData = data
end

function updateUI(data)
    local isOpen, text = lib.isTextUIOpen()
    if isOpen then
        if data.chance < 0 then
            print('Chance is less than 0')
            local uiData = 'Sell Drugs '..' \n '..'Price: $'..data.price..' \n '..'Amount is '..data.ia..' \n '..'Chance is 0%'.. ' \n '..'Adjustment is '..data.adjust 
        elseif data.chance > 100 and dealEdited then
            print('Chance is greater than 0')
            local uiData = 'Sell Drugs '..' \n '..'Price: $'..data.price..' \n '..'Amount is '..data.ia..' \n '..'Chance is 100%'.. ' \n '..'Adjustment is '..data.adjust 
        else
            lib.hideTextUI()
            local uiData = 'Sell Drugs '..' \n '..'Price: $'..data.price..' \n '..'Amount is '..data.ia..' \n '..'Chance is '..string.format("%03.1f", tostring(data.chance))..'%'.. ' \n '..'Adjustment is '..data.adjust 
            local options = {            } 
            lib.showTextUI(uiData, options)
        end                
    else
        print('You shoundt see this')
    end
end

function updateDeal(thing, value, data)
    local noitem = false
    if thing == 'item' then
        if value == 'up' then
            data.ia = data.ia + data.adjust
            if data.ia >= data.imax then
                data.imaxed = true
            elseif data.ia <= 0 then
                data.imined = true
            else
                if data.imaxed == true or data.imined == true then
                    data.imaxed = false
                    data.imined = false
                end
            end
        elseif value == 'down' then
            data.ia = data.ia - data.adjust
            if data.ia >= data.imax then
                data.imaxed = true
            elseif data.ia <= 0 then
                data.imined = true
            else
                if data.imaxed == true or data.imined == true then
                    data.imaxed = false
                    data.imined = false
                end
            end
        end
    elseif thing == 'price' then
        if value == 'up' then
            data.price = data.price + data.adjust
            if data.price >= data.pmax then
                data.pmaxed = true
            elseif data.price <= 0 then
                data.pmined = true
            else
                if data.pmaxed == true or data.pmined == true then
                    data.pmaxed = false
                    data.pmined = false
                end
            end
        elseif value == 'down' then
            data.price = data.price - data.adjust
            if data.price >= data.pmax then
                data.pmaxed = true
            elseif data.price <= 0 then
                data.pmined = true
            else
                if data.pmaxed == true or data.pmined == true then
                    data.pmaxed = false
                    data.pmined = false
                end
            end
        end
    elseif thing == 'adjust' then
        if value == 'up' then
            if data.adjustindex >= data.adjustindexmax then
                data.adjustindex = data.adjustindexmax
            else
                data.adjustindex = data.adjustindex + 1
            end
        elseif value == 'down' then
            if data.adjustindex <= 1 then
                data.adjustindex = 1
            else
                data.adjustindex = data.adjustindex - 1
            end
        end
        data.adjust = adjustscale[data.adjustindex].adjust
    end
    if data.imaxed or data.pmaxed or data.imined then
        data.chance = 0
    elseif data.pmined then
        data.chance = 100
    else
        local irange = data.imax - data.imin
        local ichance = (data.ia - data.imin) / irange
        local prange = data.pmax - data.pmin
        local pchance = (data.price - data.pmin) / prange
        data.chance = (pchance * ichance) * 100
    end
    print('item is '..data.ia..' '..'Price is '..data.price..' '..'Chance is '..data.chance..'%'.. ' \n '..'Adjustment is '..data.adjust )
    dealData = data
end

function finishDeal(data)
    local isOpen, text = lib.isTextUIOpen()
    if isOpen then
        lib.hideTextUI()
    end
    local num = math.random(1, 100)
    print('Num is '..num)
    print('Chance is '..data.nchance..'%')
    if num <= data.nchance then
        local isOpen, text = lib.isTextUIOpen()
        if isOpen then
            lib.notify({
                title = 'Drugs',
                description = 'Your deal was successful!',
                type = 'success'
            })
        else
            print('You shoundt see this')
            lib.notify({
                title = 'Drugs',
                description = 'Your deal was successful!',
                type = 'success'
            })
        end
    else
        lib.notify({
            title = 'Drugs',
            description = 'Your deal Failed!',
            type = 'error'
        })
        num = math.random(1, 100)
        print('Num is '..num)
        local cop = math.random(data.cop.min, data.cop.max)
        print('Cop is '..cop)
        if num <= cop then
            lib.notify({
                title = 'Drugs',
                description = 'Get out of THERE!',
                type = 'error'
            })
        end        
    end
    print('Finish Deal')
    print(inDeal)
    inDeal = false
    if dealEdited == true then
        dealEdited = false
    end
    print(inDeal)
end

function test()
    local max = 2000
    local min = -1000
    local fprice = 40
    local price = 0
    local dif = 0
    local chance = math.random(0, 50)
    local nchance
    local cop = {min = 50, max = 100}
    print('fPrice '..fprice)
    print('Price '..price)
    print('dif '..dif)
    print('chance '..chance)
    while true do
        Wait(1)
        if IsControlJustReleased(0, 27) then -- Up Arromw Key 
            print('Loading.....')
            print('Loading.....')
            print('Loading.....')
            print('Loading.....')
            print('fPrice '..fprice)
            print('Price '..price)
            print('dif '..dif)
            print('chance '..chance)
            if dif >= max then
                print('dif > max')
                price = fprice + dif
                nchance = 0
            elseif dif <= min then
                print('dif < min')
                price = fprice + dif
                nchance = 100
            else
                dif = dif + 1
                price = fprice + dif
                nchance = (dif / max) * 100 + chance
            end
            if nchance > 100 then
                nchance = 100
            elseif nchance < 0  then
                nchance = 0
            end
            print('NChance '..nchance)
        elseif IsControlJustReleased(0, 173) then -- Down Arromw Key 
            print('Loading.....')
            print('Loading.....')
            print('Loading.....')
            print('Loading.....')
            print('fPrice '..fprice)
            print('Price '..price)
            print('dif '..dif)
            print('chance '..chance)
            if dif > max then
                price = fprice + dif
                nchance = 0
            elseif dif < min then
                price = fprice + dif
                nchance = 100
            else
                dif = dif - 1
                price = fprice + dif
                local mchance = (dif / max) * 100
                nchance  = chance - mchance
            end
            if nchance > 100 then
                nchance = 100
            elseif nchance < 0  then
                nchance = 0
            end
            print('NChance '..nchance)
        elseif IsControlJustReleased(0, 215) then -- Enter Key
            local num = math.random(1, 100)
            print('Num is '..num)
            print('Chance is '..chance..'%')
            if num <= chance then
                print('Success')
            else
                print('Failed')
                local num = math.random(1, 100)
                print('Num is '..num)
                cop = math.random(cop.min, cop.max)
                print('Cop is '..cop)
                if num <= cop then
                    print('Cop Called')
                else
                    print('Failed')
                end
            end
        end
    end
end


function Deal()
    print(inDeal)
    inDeal = true
    for k,v in pairs(reppercent) do
        if v.rep == rep then
            local chance = math.random(v.chance.min * 100, v.chance.max * 100)
            local pricemax = math.random(v.pricemax.min, v.pricemax.max)
            local pricemin = math.random(v.pricemin.min, v.pricemin.max)
            local price = fprice
            local change = 0
            while inDeal do
                Wait(1)
                if IsControlJustReleased(0, 27) then -- Up Arromw Key 
                    change = change + 1
                    price = price + 1
                    print('Price: ' .. price)
                    print('PriceMax is '..pricemax)
                    print('PriceMin is '..pricemin)
                    print('Change is '..change)
                    print('Chance is '..chance..'%')
                    local maxdif = math.abs(change - pricemax)
                    local mindif = math.abs(change - pricemin)
                    print('PriceMax is '..maxdif..' PriceMin is '..mindif)
                    chance = chance - (maxdif * 0.1)
                    print('Chance is '..chance..'%')
                elseif IsControlJustReleased(0, 173) then -- Down Arromw Key 
                    change = change - 1
                    price = price - 1
                    print('Price: ' .. price)
                    print('PriceMax is '..pricemax)
                    print('PriceMin is '..pricemin)
                    print('Change is '..change)
                    print('Chance is '..chance..'%')
                    local maxdif = math.abs(change - pricemax)
                    local mindif = math.abs(change - pricemin)
                    print('PriceMax is '..maxdif..' PriceMin is '..mindif)
                    chance = chance + (maxdif * 0.1)
                    print('Chance is '..chance..'%')
                elseif IsControlJustReleased(0, 215) then -- Enter Key
                    local num = math.random(1, 100)
                    print('Num is '..num)
                    if num <= chance then
                        print('Success')
                    else
                        print('Failed')
                    end
                    inDeal = false
                elseif IsControlJustReleased(0, 38) then -- E Key
                    print(inDeal)
                    inDeal = false
                    print(inDeal)
                end
            end
        end
    end
end


CreateThread(function()
    lib.RegisterCallback("loaf_housing:fetch_rent_balance", function(source, cb, wallet)
        MySQL.Async.fetchAll("SELECT `balance`, `rent_due` FROM `loaf_rent` WHERE `rent_wallet`=@wallet", {
            ["@wallet"] = wallet
        }, function(res)
            if not res or not res[1] then cb(false) end
            cb(res[1].balance, os.date("%Y-%m-%d @ %H:%M", res[1].rent_due))
        end)
    end)

    lib.RegisterCallback("loaf_housing:deposit_rent", function(source, cb, wallet, amount)
        if amount < 0 then return cb(false) end
        if not PayMoney(source, amount) then return cb(false) end

        MySQL.Async.execute("UPDATE `loaf_rent` SET `balance`=`balance`+@amount WHERE `rent_wallet`=@wallet", {
            ["@amount"] = amount,
            ["@wallet"] = wallet
        }, function()
            Notify(source, Strings["deposited_rent"]:format(amount))
            cb(true)
        end)
    end)

    CreateThread(function()
        Wait(10000)
        while true do
            print("^2[INFO]^7 Checking rent")
            MySQL.Async.fetchAll("SELECT `rent_wallet`, `propertyid`, `owner`, `balance`, `rent_due` FROM `loaf_rent` WHERE `rent_due`<@time", {
                ["@time"] = os.time()
            }, function(result)
                if not result then
                    return
                end

                for _, v in pairs(result) do
                    local houseData = Houses[v.propertyid]
                    local rent = houseData.rent or 0
                    if v.balance >= houseData.rent then
                        MySQL.Async.execute("UPDATE `loaf_rent` SET `balance`=`balance`-@rent, `rent_due`=@due WHERE `rent_wallet`=@wallet", {
                            ["@rent"] = rent,
                            ["@due"] = os.time() + Config.RentInterval,
                            ["@wallet"] = v.rent_wallet
                        })
                    else
                        print(("^2[INFO]^7 Property %s did not have enough money, kicking tenants"):format(v.propertyid))
                        RemoveProperty(v.owner, v.propertyid)
                    end
                end
            end)

            Wait(30 * 60 * 1000) -- Check for houses that have not paid rent every 30 minutes
        end
    end)
end)
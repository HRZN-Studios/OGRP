debugPrint = function(text)
    if not Config.Debug then return end
    print('^1[MULTICHARACTER] ^7 '..text)
end

getRandomKey = function(tbl)
    local keys = {}
    for key in pairs(tbl) do
        table.insert(keys, key)
    end
    return keys[math.random(1, #keys)]
end
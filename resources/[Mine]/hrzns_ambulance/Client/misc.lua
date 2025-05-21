RegisterCommand('debugdead', function()
    print('dead state ('..tostring(isslumped)..')'..'idk ('..tostring(isslumped)..')')
end)

function loadAnimDict(dict)
    print('loading '..dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Wait(10)
    end
end

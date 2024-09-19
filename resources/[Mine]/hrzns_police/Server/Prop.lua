
RegisterNetEvent('createprop', function(coords, rotation, prop, real)
    obj = CreateObject(prop, coords, real, false, false)
    SetEntityRotation(obj, rotation.x, rotation.y, rotation.z, 5, true)
end)

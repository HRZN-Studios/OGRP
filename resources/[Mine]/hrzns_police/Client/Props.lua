RegisterCommand('cone', function()
    local model = `prop_mp_cone_02`
    createProp('cone')
end)

function createProp(prop)
    local model = nil
    if prop == 'cone' then
        model = `prop_mp_cone_02`
    elseif prop == 'pdbarrier' then
        model = 'prop_barrier_work05'
    elseif prop == 'medicbag' then

    end
    local offset = GetEntityCoords(cache.ped) + GetEntityForwardVector(cache.ped) * 3
    lib.requestModel(model)
    local obj = CreateObject(model, offset.x, offset.y, offset.z, false, false, false)
    local data = exports.object_gizmo:useGizmo(obj)
    DeleteEntity(obj)
    lib.print.info(data)
    if data.exit == 'done' then
        TriggerServerEvent('createprop', data.position, data.rotation, model, true)
    end
end
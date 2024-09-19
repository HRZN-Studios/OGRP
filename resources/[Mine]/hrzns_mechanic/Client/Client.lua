
local orgcar
local modcar

function orderMods()
    orgcar = lib.getVehicleProperties(GetVehiclePedIsUsing(PlayerPedId()))
    TriggerServerEvent('hrzns_mechanic:openMenu', orgcar)
end
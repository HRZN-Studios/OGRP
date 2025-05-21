

RegisterNetEvent('hrzns_police:Search', function(id)
  lib.callback('hrzns_police:GetPlayerData', false, function(data)
    for _, v in pairs(Config.SearchJob) do
      if data.job.name == v or Config.SearchJob == 'any' then
        if Config.Inventory == 'ox' then
            exports.ox_inventory:openInventory('player', id)
        end
      else
        lib.notify({
          title = 'Police',
          description = 'Not allowed to search',
          type = 'error'
        })
      end
    end
  end)
end)

local pdmenu = lib.addKeybind({
  name = 'PDMenu',
  description = 'Opens PD Menu',
  defaultKey = 'F6',
  onReleased = function(self)
      TriggerEvent('hrzns_police:pdMenu')
  end
})

RegisterNetEvent('hrzns_police:pdMenu', function()
  if Config.PdMenu == true then
    lib.registerContext({
        id = 'pd_menu',
        title = 'Police Menu',
        options = {
          {
            title = 'Frisk',
            icon = 'fa-solid fa-hand',
            event = 'hrzns_police:frisk',
          },
          {
            title = 'Search',
            icon = 'fa-solid fa-magnifying-glass',
            event = 'hrzns_police:Search',
          },
          {
            title = 'Hard Cuff',
            icon = 'fa-solid fa-handcuffs',
            event = 'hrzns_police:Cuff',
            args = {
              id = nil,
              item = 'cuffs',
              cuffhard = true
            },
          },
          {
            title = 'Soft Cuff',
            icon = 'fa-solid fa-handcuffs',
            event = 'hrzns_police:Cuff',
            args = {
              id = nil,
              item = 'cuffs',
              cuffhard = false
            },
          },
          {
            title = 'Escort',
            icon = 'fa-solid fa-hands-holding',
            event = 'hrzns_police:Carry',
            args = {
              id = nil,
              kind = 'escort',
            },
          },
          {
            title = 'Carry',
            icon = 'fa-solid fa-hands-holding',
            event = 'hrzns_police:Carry',
            args = {
              id = nil,
              kind = 'carry',
            },
          },
        }
    })
  elseif Config.PdMenu == true and Config.PropMenu == true then
    lib.registerContext({
        id = 'pd_menu',
        title = 'Police Menu',
        options = {
          {
            title = 'Frisk',
            icon = 'fa-solid fa-hand',
            event = 'hrzns_police:frisk',
          },
          {
            title = 'Search',
            icon = 'fa-solid fa-magnifying-glass',
            event = 'hrzns_police:Search',
          },
          {
            title = 'Hard Cuff',
            icon = 'fa-solid fa-handcuffs',
            event = 'hrzns_police:Cuff',
            args = {
              id = nil,
              item = 'cuffs',
              cuffhard = true
            },
          },
          {
            title = 'Soft Cuff',
            icon = 'fa-solid fa-handcuffs',
            event = 'hrzns_police:Cuff',
            args = {
              id = nil,
              item = 'cuffs',
              cuffhard = false
            },
          },
          {
            title = 'Escort',
            icon = 'fa-solid fa-hands-holding',
            event = 'hrzns_police:Carry',
            args = {
              id = nil,
              kind = 'escort',
            },
          },
          {
            title = 'Carry',
            icon = 'fa-solid fa-hands-holding',
            event = 'hrzns_police:Carry',
            args = {
              id = nil,
              kind = 'carry',
            },
          },
          {
            title = 'Prop Menu',
            icon = 'fa-solid fa-hands-holding',
            event = 'hrzns_police:propmenu',
          },
        }
    })
  end
end)

RegisterNetEvent('hrzns_police:propmenu', function()
    lib.registerContext({
        id = 'prop_menu',
        title = 'Prop Menu',
        options = {
          {
            title = 'PD Barrier',
            icon = 'fa-solid fa-hands-holding',
            event = 'hrzns_police:createprop',
            args = {
              model = 'prop_barrier_work05',
            },
          },
          {
            title = 'Barrier',
            icon = 'fa-solid fa-hands-holding',
            event = 'hrzns_police:createprop',
            args = {
              model = 'prop_barrier_work06a',
            },
          },
          {
            title = 'Cone',
            icon = 'fa-solid fa-hands-holding',
            event = 'hrzns_police:createprop',
            args = {
              model = 'prop_mp_cone_02',
            },
          },
        }
    })
end)

exports.ox_target:addGlobalVehicle({
  {
    name = 'hrzns_police:piv',
    icon = 'fa-solid fa-chair',
    label = 'Put in Vehicle',
    onSelect = function(data)
      TriggerEvent("hrzns_police:pivc", nil, data.entity);     
    end
  },
  {
    name = 'hrzns_police:tov',
    icon = 'fa-solid fa-chair',
    label = 'Take out Vehicle',
    onSelect = function(data)
      TriggerEvent("hrzns_police:tov", data.entity);     
    end
  }
})


exports.ox_target:addGlobalPlayer({
  {
    name = 'hrzns_police:carry',
    icon = 'fa-solid fa-chair',
    label = 'Carry Person',
    onSelect = function(data)
      local id = GetPlayerServerId(NetworkGetPlayerIndexFromPed(data.entity));
      TriggerEvent('hrzns_police:Carry', id, 'carry');
    end
  },
  {
    name = 'hrzns_police:escort',
    icon = 'fa-solid fa-chair',
    label = 'Escort Person',
    onSelect = function(data)
      local id = GetPlayerServerId(NetworkGetPlayerIndexFromPed(data.entity));
      TriggerEvent('hrzns_police:Carry', id, 'escort');
    end
  },
  {
    name = 'hrzns_police:rob',
    icon = 'fa-solid fa-chair',
    label = 'Rob Person',
    onSelect = function(data)
      local id = GetPlayerServerId(NetworkGetPlayerIndexFromPed(data.entity));
      exports.ox_inventory:openInventory('player', id);
    end
  },
  {
    name = 'hrzns_police:search',
    icon = 'fa-solid fa-chair',
    label = 'Search Person',
    onSelect = function(data)
      local id = GetPlayerServerId(NetworkGetPlayerIndexFromPed(data.entity));
      TriggerEvent('hrzns_police:Search', id);
    end
  },
  {
    name = 'hrzns_police:frisk',
    icon = 'fa-solid fa-chair',
    label = 'Frisk Person',
    onSelect = function(data)
      local id = GetPlayerServerId(NetworkGetPlayerIndexFromPed(data.entity));
      TriggerEvent('hrzns_police:frisk', id);
    end
  },
  {
    name = 'hrzns_police:fingerprint',
    icon = 'fa-solid fa-chair',
    label = 'Fingerprint Person',
    onSelect = function(data)
      local id = GetPlayerServerId(NetworkGetPlayerIndexFromPed(data.entity));
      TriggerEvent('hrzns_police:fingerPrint', id);
    end
  },
  {
    name = 'hrzns_police:scuff',
    icon = 'fa-solid fa-chair',
    label = 'Soft Cuff Person',
    items = 'cuffs',
    onSelect = function(data)
      local id = GetPlayerServerId(NetworkGetPlayerIndexFromPed(data.entity));
      TriggerEvent('hrzns_police:Cuff', id, 'cuffs', 'soft');
    end
  },
  {
    name = 'hrzns_police:hcuff',
    icon = 'fa-solid fa-chair',
    label = 'Hard Cuff Person',
    items = 'cuffs',
    onSelect = function(data)
      local id = GetPlayerServerId(NetworkGetPlayerIndexFromPed(data.entity));
      TriggerEvent('hrzns_police:Cuff', id, 'cuffs', 'hard');
    end
  },
  {
    name = 'hrzns_police:szip',
    icon = 'fa-solid fa-chair',
    label = 'Soft Zip Person',
    items = 'zip',
    onSelect = function(data)
      local id = GetPlayerServerId(NetworkGetPlayerIndexFromPed(data.entity));
      TriggerEvent('hrzns_police:Cuff', id, 'zip', 'soft');
    end
  },
  {
    name = 'hrzns_police:hzip',
    icon = 'fa-solid fa-chair',
    label = 'Hard Zip Person',
    items = 'zip',
    onSelect = function(data)
      local id = GetPlayerServerId(NetworkGetPlayerIndexFromPed(data.entity));
      TriggerEvent('hrzns_police:Cuff', id, 'zip', 'hard');
    end
  },
  {
    name = 'hrzns_police:uncuff',
    icon = 'fa-solid fa-chair',
    label = 'UnCuff Person',
    items = 'cuffkey',
    onSelect = function(data)
      local id = GetPlayerServerId(NetworkGetPlayerIndexFromPed(data.entity));
      TriggerEvent('hrzns_police:UnCuff', id, 'cuffkey', 'soft');
    end
  },
  {
    name = 'hrzns_police:unzip',
    icon = 'fa-solid fa-chair',
    label = 'Cut Zipties',
    items = 'pliers',
    onSelect = function(data)
      local id = GetPlayerServerId(NetworkGetPlayerIndexFromPed(data.entity));
      TriggerEvent('hrzns_police:UnCuff', id, 'pliers', 'soft');
    end
  },
  {
    name = 'hrzns_police:uncuffhm',
    icon = 'fa-solid fa-chair',
    label = 'Unlock Cuffs',
    items = 'hmkey',
    onSelect = function(data)
      local id = GetPlayerServerId(NetworkGetPlayerIndexFromPed(data.entity));
      TriggerEvent('hrzns_police:UnCuff', id, 'hmkey', 'soft');
    end
  },
  {
    name = 'hrzns_police:unshackle',
    icon = 'fa-solid fa-chair',
    label = 'Cut Shackles',
    items = 'cutters',
    onSelect = function(data)
      local id = GetPlayerServerId(NetworkGetPlayerIndexFromPed(data.entity));
      TriggerEvent('hrzns_police:UnCuff', id, 'cutters', 'soft');
    end
  },
})

RegisterNetEvent("hrzns_police:pivc", function(id, vehicle)
  if id == nil then
    if CarriedId ~= nil then
      id = CarriedId
      TriggerEvent('hrzns_police:Carry', CarriedId)
    else
      local coords = GetEntityCoords(PlayerPedId());
      local closestPlayer = GetPlayerServerId(lib.getClosestPlayer(coords));
      print(closestPlayer);
      if closestPlayer == nil then
        lib.notify({
          title = "General",
          description = "No player nearby",
          type = "error"
        });
      else
        id = closestPlayer;
      end;
    end
  end
  if vehicle == nil then
    vehicle = lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3, true);
  end
  local vehicleseats = GetVehicleModelNumberOfSeats(GetEntityModel(vehicle));
  local vehicleid = NetworkGetNetworkIdFromEntity(vehicle);
  for i = 0, vehicleseats - 1 do
    if IsVehicleSeatFree(vehicle, i) then
      TriggerServerEvent('hrzns_police:piv', id, vehicleid, i);
      break  
    end
  end;
end)

RegisterNetEvent("hrzns_police:giv", function(vehicle, seat)
  local vehicle = NetworkGetEntityFromNetworkId(vehicle);
  SetPedCanRagdoll(PlayerPedId(), false);
  ClearPedTasksImmediately(PlayerPedId());
  Wait(100);
  TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, seat);
  Wait(3000);
  SetPedCanRagdoll(PlayerPedId(), true);
end)

RegisterNetEvent('hrzns_police:tov', function(vehicle)
  local vehicleseats = GetVehicleModelNumberOfSeats(GetEntityModel(vehicle));
  local vehicleid = NetworkGetNetworkIdFromEntity(vehicle);
  for i = -1, vehicleseats do
    if IsVehicleSeatFree(vehicle, i) == false then
      local id = GetPlayerServerId(NetworkGetPlayerIndexFromPed(GetPedInVehicleSeat(vehicle, i)));
      print(id)
      TriggerServerEvent('hrzns_police:tov', id, vehicleid);
      break  
    end
  end;  
end)

RegisterNetEvent('hrzns_police:gov', function(vehicle)
  local vehicle = NetworkGetEntityFromNetworkId(vehicle);
  if isDead == false then
    TaskLeaveVehicle(PlayerPedId(), vehicle, 1);
    else
      ClearPedTasksImmediately(PlayerPedId());
      TaskLeaveVehicle(PlayerPedId(), vehicle, 16);
    end
end)



-- RegisterNetEvent("hrzns_police:pivc", function(id, vehicle)
-- 	if id == nil then
-- 		lib.callback.await("hrzns_police:GetCarried", function(data)
-- 			if data == nil then
-- 				local coords = GetEntityCoords(PlayerPedId());
-- 				local closestPlayer = GetPlayerServerId(lib.getClosestPlayer(coords));
-- 				print(closestPlayer);
-- 				if closestPlayer == nil then
-- 					lib.notify({
-- 						title = "General",
-- 						description = "No player nearby",
-- 						type = "error"
-- 					});
-- 				else
-- 					id = closestPlayer;
-- 				end;
-- 			else
--         id = data;
-- 			end;
--       if vehicle == nil then
-- 				vehicle = lib.getClosestVehicle(GetEntityCoords(PlayerPedId()), 3, true);
--       end
-- 			local vehicleseats = GetVehicleModelNumberOfSeats(vehicle);
--       print(vehicleseats)
--       for i = -1, vehicleseats - 1 do
--         if IsVehicleSeatFree(vehicle, i) then
--           print(i)
--           TriggerServerEvent('hrzns_police:piv', id, vehicle, i);
--       end
--       end;
-- 		end);
-- 	end;
-- end);

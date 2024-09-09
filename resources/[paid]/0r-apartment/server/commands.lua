RegisterCommand(Config.Commands.openPanel, function(source)
    TriggerClientEvent("0r-apartment:Client:OpenTablet", source)
end)

RegisterCommand("fixapartui", function(source)
    TriggerClientEvent("0r-apartment:Client:fixapartui", source)
end)

RegisterCommand(Config.Commands.extendRental, function(source, args)
    local src = source
    local day = tonumber(args[1])
    local playerRoom = Server.Players[src]
    if not playerRoom then
        return Server.Functions.SendNotify(src, locale("game.not_in_any_apartment_room"), "error")
    end
    local soldRoom = Server.Functions.GetSoldRoom(playerRoom.apartmentId, playerRoom.roomId)
    if soldRoom.life_time then
        return Server.Functions.SendNotify(src, locale("game.no_need_extend"), "error")
    end
    local room = playerRoom.apartmentId == -1 and
        Config.MloRooms[playerRoom.roomId] or
        Server.Functions.GetConfigRoomById(playerRoom.roomId)
    if not room then
        return Server.Functions.SendNotify(src, locale("game.room_not_found"), "error")
    end
    if not Server.Functions.PlayerIsOwnerInRoom(src, playerRoom.apartmentId, playerRoom.roomId) then
        return Server.Functions.SendNotify(src, locale("game.not_own_room"), "error")
    end
    if not day then
        return TriggerClientEvent("chat:addMessage", src, {
            color = { 255, 0, 0 },
            multiline = true,
            args = { "Apartment", locale("game.desc_command_er_not", room.daily_price) }
        })
    end
    Server.Functions.ExtendRoomRental(src, playerRoom.apartmentId, playerRoom.roomId, day)
end)

function Server.Functions.SetUpAdminCommands()
    if Utils.Framework == "qb" then
        Server.Framework.Commands.Add("elevatorfix", "Elevator Fix (Admin)",
            { { name = "apartmentId", help = "apartment id" } },
            false,
            function(source, args)
                local src = source
                local apartmentId = tonumber(args[1])
                Server.Functions.ElevatorFix(src, apartmentId)
            end, "admin")
    elseif Utils.Framework == "esx" then
        Server.Framework.RegisterCommand("elevatorfix", "admin", function(xPlayer, args, showError)
                local src = xPlayer.source
                local apartmentId = tonumber(args.apartmentId)
                Server.Functions.ElevatorFix(src, apartmentId)
            end, false,
            {
                help = "Elevator Fix (Admin)",
                validate = false,
                arguments = {
                    { name = "apartmentId", help = "apartment id", type = "string" }
                }
            })
    end
end

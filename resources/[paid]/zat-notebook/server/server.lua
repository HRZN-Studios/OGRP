local QBCore = nil

local Orders = {}

CreateThread(function()
    if Config.Framework == "qbcore" then
        QBCore = exports['qb-core']:GetCoreObject()
    end
end)

CreateThread(function()
	local currentItemId = nil
	local bookData = {
		{page = 1,   title = "Dear Book",  	smalltitle = "Write Something", 	story = "Write Something", 		image = ""},
		{page = 2,   title = "Dear Book",  	smalltitle = "Write Something", 	story = "Write Something", 		image = ""},
		{page = 3,   title = "Dear Book",  	smalltitle = "Write Something", 	story = "Write Something",		image = ""},
		{page = 4,   title = "Dear Book",  	smalltitle = "Write Something", 	story = "Write Something",		image = ""},
		{page = 5,   title = "Dear Book",  	smalltitle = "Write Something", 	story = "Write Something", 		image = ""},
		{page = 6,   title = "Dear Book",  	smalltitle = "Write Something", 	story = "Write Something", 		image = ""},
		{page = 7,   title = "Dear Book",  	smalltitle = "Write Something", 	story = "Write Something", 		image = ""},
		{page = 8,   title = "Dear Book",  	smalltitle = "Write Something", 	story = "Write Something", 		image = ""},
		{page = 9,   title = "Dear Book",  	smalltitle = "Write Something", 	story = "Write Something", 		image = ""},
		{page = 10,  title = "Dear Book",  	smalltitle = "Write Something", 	story = "Write Something", 		image = ""},
		{page = 11,  title = "Dear Book",  	smalltitle = "Write Something", 	story = "Write Something", 		image = ""},
		{page = 12,  title = "Dear Book",  	smalltitle = "Write Something", 	story = "Write Something", 		image = ""},
		{page = 13,  title = "Dear Book",  	smalltitle = "Write Something", 	story = "Write Something", 		image = ""},
		{page = 14,  title = "Dear Book",  	smalltitle = "Write Something", 	story = "Write Something", 		image = ""},
		{page = 15,  title = "Dear Book",  	smalltitle = "Write Something", 	story = "Write Something", 		image = ""},
		{page = 16,  title = "Dear Book",  	smalltitle = "Write Something", 	story = "Write Something", 		image = ""},
	}

    if Config.Framework == "qbcore" then
        QBCore.Functions.CreateUseableItem("zat-notebook", function(source, item)
			local src = source
			local Player = QBCore.Functions.GetPlayer(src)
			if (item.info.id) == nil then
				currentItemId = math.random(111111,999999) 
				local info = {
					id = currentItemId
				}
				local Player = QBCore.Functions.GetPlayer(src)
				Player.Functions.RemoveItem("zat-notebook", 1, item.slot)
				Player.Functions.AddItem("zat-notebook", 1, false, info)
			else
				currentItemId = item.info.id
			end
			
			if Player.Functions.GetItemByName(item.name) ~= nil then
				local result = MySQL.Sync.fetchAll('SELECT * FROM notebook WHERE id = ?', { currentItemId })
			 	if result[1] ~= nil then
					local Data = json.decode(result[1].bookData)
			 	 	TriggerClientEvent("zat-notebook:client:OpenUi", src, currentItemId, Data)
			 	else
			 		MySQL.insert('INSERT INTO notebook (id, bookData) VALUES (?, ?)', {
						currentItemId,
			 	 		json.encode(bookData)
			 	 	})
					  TriggerClientEvent("zat-notebook:client:OpenUi", src, currentItemId, bookData)
			 	end
			end
		end)
    end
end)

RegisterNetEvent("zat-notebook:server:UseNotebook", function(metadata) -- esx
	local src = source
	local currentItemId = nil
	local bookData = {
		{page = 1,   title = "Dear Book",  	smalltitle = "Write Something", 	story = "Write Something", 		image = ""},
		{page = 2,   title = "Dear Book",  	smalltitle = "Write Something", 	story = "Write Something", 		image = ""},
		{page = 3,   title = "Dear Book",  	smalltitle = "Write Something", 	story = "Write Something",		image = ""},
		{page = 4,   title = "Dear Book",  	smalltitle = "Write Something", 	story = "Write Something",		image = ""},
		{page = 5,   title = "Dear Book",  	smalltitle = "Write Something", 	story = "Write Something", 		image = ""},
		{page = 6,   title = "Dear Book",  	smalltitle = "Write Something", 	story = "Write Something", 		image = ""},
		{page = 7,   title = "Dear Book",  	smalltitle = "Write Something", 	story = "Write Something", 		image = ""},
		{page = 8,   title = "Dear Book",  	smalltitle = "Write Something", 	story = "Write Something", 		image = ""},
		{page = 9,   title = "Dear Book",  	smalltitle = "Write Something", 	story = "Write Something", 		image = ""},
		{page = 10,  title = "Dear Book",  	smalltitle = "Write Something", 	story = "Write Something", 		image = ""},
		{page = 11,  title = "Dear Book",  	smalltitle = "Write Something", 	story = "Write Something", 		image = ""},
		{page = 12,  title = "Dear Book",  	smalltitle = "Write Something", 	story = "Write Something", 		image = ""},
		{page = 13,  title = "Dear Book",  	smalltitle = "Write Something", 	story = "Write Something", 		image = ""},
		{page = 14,  title = "Dear Book",  	smalltitle = "Write Something", 	story = "Write Something", 		image = ""},
		{page = 15,  title = "Dear Book",  	smalltitle = "Write Something", 	story = "Write Something", 		image = ""},
		{page = 16,  title = "Dear Book",  	smalltitle = "Write Something", 	story = "Write Something", 		image = ""},
	}
	if (metadata.id) == nil then
		currentItemId = math.random(111111,999999) 
		local info = {
			id = currentItemId
		}
		exports.ox_inventory:RemoveItem(source, "zat-notebook", 1, metadata)
		exports.ox_inventory:AddItem(source, "zat-notebook", 1, info)
	else
		currentItemId = metadata.id
	end

	local result = MySQL.Sync.fetchAll('SELECT * FROM notebook WHERE id = ?', { currentItemId })
	if result[1] ~= nil then
	local Data = json.decode(result[1].bookData)
		TriggerClientEvent("zat-notebook:client:OpenUi", src, currentItemId, Data)
	else
		MySQL.insert('INSERT INTO notebook (id, bookData) VALUES (?, ?)', {
		currentItemId,
			json.encode(bookData)
		})
		TriggerClientEvent("zat-notebook:client:OpenUi", src, currentItemId, bookData)
	end
end)

RegisterNetEvent("zat-notebook:server:SaveData", function(id, value)
	MySQL.update('UPDATE notebook SET bookData = ? WHERE id = ?', { json.encode(value), id })
end)
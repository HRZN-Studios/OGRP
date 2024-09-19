FRAMEWORK = {}
ESX = {}
QB = {}
CUSTOM = {}

if Config.Frameworks.ESX.enabled then
    ESX = exports[Config.Frameworks.ESX.frameworkScript][Config.Frameworks.ESX.frameworkExport]()
elseif Config.Frameworks.QB.enabled then
    QBCore = exports[Config.Frameworks.QB.frameworkScript][Config.Frameworks.QB.frameworkExport]()
else
    print('[^2INFO] ^0[^5QF-MDT^0] encountered a problem at [^5Server Framework Export^0], if you are using a [^5CUSTOM FRAMEWORK / STANDALONE^0] open a ticket on our discord server and wait for help with configuration!')
    -- CUSTOM = YOUR OWN FRAMEWORK EXPORT
end

---@class PlayerJob
---@field name string
---@field label string
---@field grade number
---@field grade_label string

---@class xPlayer
---@field source number -- playerID
---@field identifier string -- player identifier
---@field showNotification func(msg: string)
---@field job PlayerJob
---@field removeAccountMoney func(moneyType: string, amount: number, reason?: string)

FRAMEWORK.GetPlayerFromIdStandalone = function (source)
    return SERVER.Players[tonumber(source)]
end

---@param id number
---@return xPlayer | nil
FRAMEWORK.GetPlayerFromId = function(id)
    local data = nil
    if Config.Frameworks.ESX.enabled then
        local xPlayer = ESX.GetPlayerFromId(id)
        if xPlayer then
            data = {}
            data.source = id
            data.identifier = xPlayer.getIdentifier()
            data.showNotification = function(msg)
                return TriggerClientEvent('qf_mdt:showNotification', id, msg)
            end
            data.getIdentifier = function ()
                return xPlayer.getIdentifier()
            end
            data.setJob = function (jobname, grade)
                return xPlayer.setJob(jobname, grade)
            end
            data.job = {
                name = xPlayer.job.name,
                label = xPlayer.job.label,
                grade = xPlayer.job.grade,
                grade_name = xPlayer.job.grade_name,
                grade_label = xPlayer.job.grade_label
            }
            data.getName = function ()
                return xPlayer.getName()
            end
            data.getAccount = function (account)
                return xPlayer.getAccount(account)
            end
            data.addAccountMoney = function(moneyType, amount, reason)
                return xPlayer.addAccountMoney(moneyType, amount, reason)
            end
            data.removeAccountMoney = function(moneyType, amount, reason)
                return xPlayer.removeAccountMoney(moneyType, amount, reason)
            end
            data.get = function (key)
                return xPlayer.get(key)
            end
        end
    elseif Config.Frameworks.QB.enabled then
        local xPlayer = QBCore.Functions.GetPlayer(id)
        if xPlayer then
            data = {}
            data.source = id
            data.identifier = xPlayer.PlayerData.citizenid
            data.showNotification = function(msg)
                TriggerClientEvent('qf_mdt:showNotification', id, msg)
            end
            data.getIdentifier = function ()
                return xPlayer.PlayerData.citizenid
            end
            data.setJob = function (jobname, grade)
                return xPlayer.Functions.SetJob(jobname, grade)
            end
            data.job = {
                name = xPlayer.PlayerData.job.name,
                label = xPlayer.PlayerData.job.label,
                grade = xPlayer.PlayerData.job.grade.level,
                grade_name = xPlayer.PlayerData.job.grade.name,
                grade_label = xPlayer.PlayerData.job.grade.name
            }
            data.getName = function ()
                return xPlayer.PlayerData.charinfo.firstname .. ' ' ..xPlayer.PlayerData.charinfo.lastname
            end
            data.getAccount = function (account)
                return xPlayer.Functions.GetMoney(account)
            end
            data.addAccountMoney = function(moneyType, amount)
                return xPlayer.Functions.AddMoney(moneyType, amount)
            end
            data.removeAccountMoney = function(moneyType, amount)
                return xPlayer.Functions.RemoveMoney(moneyType, amount)
            end
            data.PlayerData = {
                charinfo = xPlayer.PlayerData.charinfo,
            }
        end
    else
        -- LOOK ABOVE FOR EXAMPLES FUNCTIONS FROM QB OR ESX (IF YOU HAVE SOME PROBLEMS WITH IMPLEMENT YOUR CUSTOM FRAMEWORK TO MDT OPEN A TICKET ON DISCORD)
        local xPlayer = FRAMEWORK.GetPlayerFromIdStandalone(id)

        if xPlayer then
            data = {}
            data.source = xPlayer.source
            data.identifier = FRAMEWORK.GetIdentifier(xPlayer.source) --// OR YOUR FRAMEWORK FUNCTION RETURNING PLAYER IDENTIFIER
            data.showNotification = function(msg)
                TriggerClientEvent('qf_mdt:showNotification', id, msg)
            end
            data.getIdentifier = function () 
                return FRAMEWORK.GetIdentifier(xPlayer.source) --// OR YOUR FRAMEWORK FUNCTION RETURNING PLAYER IDENTIFIER
            end
            data.setJob = function (jobname, grade)
                return xPlayer.setJob(jobname, grade)
            end
            data.job = { --// GETTING JOB FROM YOUR CUSTOM FRAMEWORK PLAYER CLASS
                name = "name", --// UNIQUE NAME OF JOB
                label = "label", --// DISPLAYED NAME OF JOB
                grade = 0, --// GRADE OF JOB
                grade_label = "grade_label" -- DISPLAYED NAME OF GRADE
            }
            data.getName = function () --// GETTING PLAYER NAME FUNCTION FROM YOUR CUSTOM FRAMEWOR
                return "John Smith"
            end

            ---@param account string
            ---@return {money = number}
            data.getAccount = function (account) --// GETTING ACCOUNT DATA FROM PLAYER CLASS ON YOUR CUSTOM FRAMEWORK
                return
            end
            ---@param moneyType string (for example: 'bank')
            ---@param amount number
            data.addAccountMoney = function(moneyType, amount) --// FUNCTION FROM YOUR FRAMEWORK THAT ADDING MONEY TO PLAYER BANK ACCOUNT
                return
            end
            ---@param moneyType string (for example: 'bank')
            ---@param amount number
            data.removeAccountMoney = function(moneyType, amount) --// FUNCTION FROM YOUR FRAMEWORK THAT REMOVING MONEY TO PLAYER BANK ACCOUNT
                return
            end
        end

        print('[^2INFO] ^0[^5QF-MDT^0] encountered a problem at [^5GetPlayerFromId^0], if you are using a [^5CUSTOM FRAMEWORK / STANDALONE^0] open a ticket on our discord server and wait for help with configuration!')
        -- OR SCRIPT IT BY OWN
    end

    return data
end

---@param identifier string
---@return xPlayer | nil
FRAMEWORK.GetPlayerFromIdentifier = function(identifier)
    if Config.Frameworks.ESX.enabled then
        return ESX.GetPlayerFromIdentifier(identifier)
    elseif Config.Frameworks.QB.enabled then
        return QBCore.Functions.GetPlayerByCitizenId(identifier)
    else
        print('[^2INFO] ^0[^5QF-MDT^0] encountered a problem at [^5GetPlayerFromIdentifier^0], if you are using a [^5CUSTOM FRAMEWORK / STANDALONE^0] open a ticket on our discord server and wait for help with configuration!')
        -- SCRIPT IT BY OWN
    end
end

local function checkTable(key, val, player, xPlayers)
	for valIndex = 1, #val do
		local value = val[valIndex]
		if not xPlayers[value] then
			xPlayers[value] = {}
		end

		if (key == 'job' and player.job.name == value) or player[key] == value then
			xPlayers[value][#xPlayers[value] + 1] = player
		end
	end
end

FRAMEWORK.GetExtendedPlayers = function (key, val)
	if not key then return SERVER.Players end

	local xPlayers = {}

	if type(val) == "table" then
		for _, v in pairs(SERVER.Players) do
			checkTable(key, val, v, xPlayers)
		end
	else
		for _, v in pairs(SERVER.Players) do
			if (key == 'job' and v.job.name == val) or v[key] == val then
				xPlayers[#xPlayers + 1] = v
			end
		end
	end

	return xPlayers
end

---@return xPlayer[]
FRAMEWORK.GetPlayers = function()
    if Config.Frameworks.ESX.enabled then
        return ESX.GetExtendedPlayers()
    elseif Config.Frameworks.QB.enabled then
        return QBCore.Functions.GetQBPlayers()
    else
        print('[^2INFO] ^0[^5QF-MDT^0] encountered a problem at [^5GetPlayers^0], if you are using a [^5CUSTOM FRAMEWORK / STANDALONE^0] open a ticket on our discord server and wait for help with configuration!')
        return FRAMEWORK.GetExtendedPlayers()
        -- OR SCRIPT IT BY OWN
    end
end

---@param player xPlayer
---@return string
FRAMEWORK.GetFirstName = function(player)
    if Config.Frameworks.ESX.enabled then
        if player.get('firstName') then
            return player.get('firstName')
        else
            return player.getName()
        end
    elseif Config.Frameworks.QB.enabled then
        return player.PlayerData.charinfo.firstname
    else
        print('[^2INFO] ^0[^5qf-mdt-lsc^0] encountered a problem at [^5GetFirstName^0], if you are using a [^5CUSTOM FRAMEWORK / STANDALONE^0] open a ticket on our discord server and wait for help with configuration!')
        return "John"
        -- SCRIPT IT BY OWN
    end
end

---@param player xPlayer
---@return string
FRAMEWORK.GetLastName = function(player)
    if Config.Frameworks.ESX.enabled then
        if player.get('lastName') then
            return player.get('lastName')
        else
            return player.getName()
        end
    elseif Config.Frameworks.QB.enabled then
        return player.PlayerData.charinfo.lastname
    else
        print('[^2INFO] ^0[^5qf-mdt-lsc^0] encountered a problem at [^5GetLastName^0], if you are using a [^5CUSTOM FRAMEWORK / STANDALONE^0] open a ticket on our discord server and wait for help with configuration!')
        return "Smith"
        -- SCRIPT IT BY OWN
    end
end

AddEventHandler('playerJoining', function()
    local playerId = source

    if not Config.Frameworks.ESX.enabled and not Config.Frameworks.QB.enabled then
        if not SERVER.Players[playerId] then
            SERVER.Players[playerId] = {source = playerId, job = {name = "name", grade = 1, label = "label"}}
        end
    end
end)

AddEventHandler('playerDropped', function()
	local playerId = source

    if not Config.Frameworks.ESX.enabled and not Config.Frameworks.QB.enabled then
        SERVER.Players[playerId] = nil
    end
end)

FRAMEWORK.GetIdentifier = function(playerId)
	for _, v in ipairs(GetPlayerIdentifiers(playerId)) do
		if string.match(v, 'license:') then
			local identifier = string.gsub(v, 'license:', '')
			return identifier
		end
	end
end

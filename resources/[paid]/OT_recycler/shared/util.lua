function _U(str, ...)
    return string.format(Locales[str], ...)
end

function round(value)
    return value % 1 >= 0.5 and math.ceil(value) or math.floor(value)
end

function timeDifference(currentTime, endEpoch)
    local differenceInSeconds = endEpoch - currentTime

    local hours = round(differenceInSeconds / 3600)
    local minutes = round((differenceInSeconds % 3600) / 60)
    local seconds = differenceInSeconds % 60

    return (hours > 0 and ('%d Hours %d Minutes'):format(hours, minutes)) or (minutes > 0 and hours <= 0 and ('%d Minutes'):format(minutes)) or ('%d Seconds'):format(seconds)
end

function dump(table, nb)
	if nb == nil then
		nb = 0
	end
	if type(table) == 'table' then
		local s = ''
		for i = 1, nb + 1, 1 do
			s = s .. "    "
		end
		s = '{\n'
		for k,v in pairs(table) do
			if type(k) ~= 'number' then k = '"'..k..'"' end
			for i = 1, nb, 1 do
				s = s .. "    "
			end
			s = s .. '['..k..'] = ' .. dump(v, nb + 1) .. ',\n'
		end
		for i = 1, nb, 1 do
			s = s .. "    "
		end
		return s .. '}'
	else
		return tostring(table)
	end
end

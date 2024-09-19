Buckets = {}
Buckets.LoggedOffPlayer = function(src)
    debugPrint('Player ['..src..'] ('..GetPlayerName(src)..') is in Multicharacter bucket.')
    SetPlayerRoutingBucket(src, src)
    SetRoutingBucketPopulationEnabled(src, Config.Buckets.PopulationEnabled)
end

Buckets.LoggedInPlayer = function(src)
    debugPrint('Player ['..src..'] ('..GetPlayerName(src)..') is no longer in Multicharacter bucket.')
    SetPlayerRoutingBucket(src, Config.Buckets.DefaultID)
end

RegisterNetEvent('ZSX_Multicharacter:Event:SetPlayerState')
AddEventHandler('ZSX_Multicharacter:Event:SetPlayerState', function(state)
    if state == 'LOG_OFF_USER' then
        Buckets.LoggedOffPlayer(source)
    elseif state == 'LOG_IN_USER' then
        Buckets.LoggedInPlayer(source)
    end
end)
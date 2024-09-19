lib.versionCheck('edwardexo/rahe-tablet-version')local function isValidLink(link)    if link:len() > 100 or link:find("[&<>\"]") then        return false    end    local host = link:match("^%a+://([^/]+)")    if host == shConfig.recommendedUploadWebsite then        return true    end    for _, allowedHost in ipairs(shConfig.allowedImageHosts) do        if host == allowedHost then            return true        end    end    return falseendlocal function isValidPresetBackground(image)    for _, v in ipairs(shConfig.defaultBackgrounds) do        if v == image then            return true        end    end    return falseendlib.callback.register('rahe-tablet:server:isValidBackgroundUrl', function(_, type, url)    if not url then        return false    end    if type == 'preset' and not isValidPresetBackground(url) then        return false    end    if type == 'custom' and (not shConfig.allowCustomBackgrounds or not isValidLink(url)) then        return false    end    return trueend)lib.callback.register('rahe-tablet:server:getPlayerIdentifier', function(source)    local playerIdentifier = getPlayerIdentifier(source)    return tostring(playerIdentifier)end)lib.callback.register('rahe-tablet:server:getAppInstallTarget', function(source)    return shConfig.appInstallTargetend)
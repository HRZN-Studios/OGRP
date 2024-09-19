CreateThread(function()
    if shConfig.appInstallTarget == 'metadata' and GetResourceState('ox_inventory') == 'missing' then
        shConfig.appInstallTarget = 'player'
    end

    if shConfig.appInstallTarget == 'player' then
        loadIdentifierInstallations()
    end
end)

local installationsByIdentifier = {}
function loadIdentifierInstallations()
    local installations = GetResourceKvpString('installations')
    installationsByIdentifier = installations and json.decode(installations) or {}
end

local function getPlayerInstalledApps(playerId)
    local playerIdentifier = getPlayerIdentifier(playerId)
    return installationsByIdentifier[playerIdentifier] or {}
end

lib.callback.register('rahe-tablet:server:getPlayerInstalledApps', function(source)
    return getPlayerInstalledApps(source)
end)

local function isApplicationInstalled(playerId, appId, itemInstalledApps)
    if shConfig.appInstallTarget == 'player' then
        local installations = getPlayerInstalledApps(playerId)

        for _, installedAppId in ipairs(installations) do
            if installedAppId == appId then
                return true
            end
        end

        return false
    end

    for _, installedApp in ipairs(itemInstalledApps) do
        if installedApp == appId then
            return true
        end
    end

    return false
end

function canStartInstallation(playerId, appId, slot)
    local item = exports.ox_inventory:GetSlot(playerId, slot)
    local installedApps = item.metadata.installedApps or {}

    if isApplicationInstalled(playerId, appId, installedApps) then
        return locale('application_already_installed')
    end

    local installSuccess = lib.callback.await('rahe-tablet:client:startAppInstall', playerId)
    if not installSuccess then
        return locale('installation_cancelled')
    end

    return true
end

function installApplication(playerId, appId, tabletSlot)
    if shConfig.appInstallTarget == 'player' then
        local playerIdentifier = getPlayerIdentifier(playerId)
        local playerInstallations = getPlayerInstalledApps(playerId)

        table.insert(playerInstallations, appId)
        installationsByIdentifier[playerIdentifier] = playerInstallations

        SetResourceKvp('installations', json.encode(installationsByIdentifier))
        return
    end

    local tabletItem = exports.ox_inventory:GetSlot(playerId, tabletSlot)
    local installedApps = tabletItem.metadata.installedApps or {}

    table.insert(installedApps, appId)
    exports.ox_inventory:SetMetadata(playerId, tabletSlot, { installedApps = installedApps })
end

exports('installApplication', installApplication)
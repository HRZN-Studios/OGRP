ConfigUpdateKeys = {}

AddEventHandler('playerConnecting', function(_, _, deferrals)
    local source = source
    local loadingScreenData = {}
    
    deferrals.defer()

    loadingScreenData.update = Config.RecentUpdate
    loadingScreenData.gallery = Config.News
    loadingScreenData.keyboard = Config.KeyboardBindings
    loadingScreenData.staffs = Config.Staffs
    loadingScreenData.rules = Config.Rules
    loadingScreenData.player = {
        id = source,
        name = GetPlayerName(source)
    }
    loadingScreenData.defaultSong = Config.DefaultSong

    deferrals.handover(loadingScreenData)

    deferrals.done()

end)
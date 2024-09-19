fx_version "cerulean"
lua54 "yes"
game "gta5"
name "0r-dlc-weed"
author "0Resmon | aliko."
version "1.0.8"
description "Fivem, DLC, Weed script | 0resmon | aliko.<Discord>"

shared_scripts {
	"@ox_lib/init.lua",
	"shared/**/*",
}

client_scripts {
	"client/utils.lua",
	"client/functions.lua",
	"client/events.lua",
	"client/nui.lua",
	"modules/bridge/**/client.lua",
}

server_scripts {
	"@oxmysql/lib/MySQL.lua",
	"server/utils.lua",
	"server/functions.lua",
	"server/events.lua",
	"modules/bridge/**/server.lua",
}

ui_page "ui/build/index.html"

files {
	"locales/*.json",
	"ui/build/index.html",
	"ui/build/**/*",
}

escrow_ignore {
	"client/utils.lua",
	"locales/**/*",
	"server/utils.lua",
	"shared/**/*",
	"modules/**/*"
}

dependencies {
	"ox_lib",
	"object_gizmo",
}

dependency '/assetpacks'
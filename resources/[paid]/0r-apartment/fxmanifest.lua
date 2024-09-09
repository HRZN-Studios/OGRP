fx_version "cerulean"
lua54 "yes"
game "gta5"
name "0r-apartment-v2"
author "0Resmon"
version "2.1.0"
description "Fivem, apartment script | 0resmon"

shared_scripts {
	"@ox_lib/init.lua",
	"shared/**/*"
}

client_scripts {
	"client/utils.lua",
	"client/functions.lua",
	"client/events.lua",
	"client/nui.lua",
	"client/threads.lua",
	"client/furnitures.lua",
	"client/exports.lua",
	"client/mlo_integration.lua",
	"modules/bridge/**/client.lua",
}

server_scripts {
	"@oxmysql/lib/MySQL.lua",
	"server/utils.lua",
	"server/functions.lua",
	"server/events.lua",
	"server/commands.lua",
	"server/furnitures.lua",
	"server/exports.lua",
	"server/mlo_integration.lua",
	"modules/bridge/**/server.lua",
}

ui_page "ui/build/index.html"

files {
	"locales/**/*",
	"ui/build/index.html",
	"ui/build/**/*",
}

dependencies {
	"ox_lib",
	"0r_lib",
	"object_gizmo",
}

escrow_ignore {
	"client/utils.lua",
	"client/exports.lua",
	"server/utils.lua",
	"server/exports.lua",
	"server/commands.lua",
	"locales/**/*",
	"shared/**/*",
	"modules/**/*"
}

dependency '/assetpacks'
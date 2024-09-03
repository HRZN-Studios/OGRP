-----------------For support, scripts, and more----------------
---------------- https://discord.gg/otstudios -----------------
---------------------------------------------------------------
fx_version "cerulean"
author "stuxxy"
version '1.5.2'
games { 'gta5' }

lua54 'yes'

ui_page 'web/build/index.html'

files {
	'web/build/index.html',
	'web/build/**/*',
	'farelogs.json'
  }

shared_scripts {
	'@ox_lib/init.lua',
	'data/*.lua',
	'shared/*.lua',
	'locales.lua',
}

server_scripts {
	'server/*.lua'
}

client_scripts {
	'client/*.lua'
}

escrow_ignore {
	'locales.lua',
	'data/*.lua',
	'shared/config.lua',
	'server/open.lua',
	'client/open.lua'
}
dependency '/assetpacks'
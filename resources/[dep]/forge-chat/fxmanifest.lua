fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'Code-Forge'
description 'Advanced CHAT'
version '3.1.0'

shared_scripts {
    'shared/*'
}

client_scripts {
    'client/main.lua'
}

server_scripts {
    'server/open.lua',
    'server/main.lua'
}

ui_page 'html/index.html'

files { 'html/*', 'html/css/*', 'html/images/*' }

escrow_ignore {
	'shared/config.lua',
    'server/open.lua'
}
dependency '/assetpacks'
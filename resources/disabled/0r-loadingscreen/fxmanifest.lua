fx_version 'cerulean'
games { 'gta5' }

author '@aw3rque'
description 'Loading screen with a modern elegant UI.'
version '1.0.0'

shared_script 'config.lua'

loadscreen 'UI/index.html'

loadscreen_cursor 'yes'

server_script 'Server/*.lua'

files {
    'UI/index.html',
    'UI/styles/*.css',
    'UI/scripts/*.js',
    'UI/images/**/*.png',
    'UI/images/**/*.svg',
}

lua54 'yes'

escrow_ignore {
    'config.lua',
    'fxmanifest.lua',
    'Server/*.lua',
    'UI/index.html',
    'UI/styles/*.css',
    'UI/scripts/*.js',
    'UI/images/**/*.png',
    'UI/images/**/*.svg',
}
dependency '/assetpacks'
fx_version 'cerulean'
game 'gta5'
author 'stuxxy'
version '2.4.1'

lua54 'yes'

files {
    'audio/data/audioexample_sounds.dat54.rel',
	'audio/audiodirectory/custom_sounds.awc'
}

shared_scripts {
    'shared/config.lua',
    'shared/util.lua',
    'shared/locales.lua'
}

client_scripts {
    'client/open.lua',
    'client/main.lua'
}

server_scripts {
    'server/open.lua',
    'server/main.lua'
}

escrow_ignore {
    'shared/*.lua',
    'client/*.lua',
	'server/*.lua'
}

data_file 'AUDIO_WAVEPACK' 'audio/audiodirectory'
data_file 'AUDIO_SOUNDDATA' 'audio/data/audioexample_sounds.dat'
dependency '/assetpacks'
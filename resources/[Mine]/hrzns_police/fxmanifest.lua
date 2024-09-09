fx_version 'cerulean'
game 'gta5'
lua54 'yes'
author 'HRZN'

version '0.0.1'

client_scripts {
	"Client/*.lua",
}

server_scripts {
    "Server/*.lua",
	'@oxmysql/lib/MySQL.lua'
}

shared_scripts {
	'@ox_lib/init.lua',
    'config.lua'
}

files {
	'client/dataview.lua',
}

dependencies {
	'ox_lib'
}

-- Credits
-- ZipTie Cuffs - FloatStreak - https://www.gta5-mods.com/misc/new-handcuffs-cable-ties

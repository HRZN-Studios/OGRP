fx_version 'bodacious'
game 'gta5'
lua54 'yes'

author 'THEadam4 & vondrs'
description 'Advanced apartments script'
version '1.0.0'

escrow_ignore {
    'config.lua',
    'server/sv_config.lua',
    'locales/*.lua',
    'import.sql',
}

client_scripts {
    'locales/*.lua',
    'client/*.lua',
}

server_script {
    'locale.lua',
    'locales/*.lua',
    'server/*.lua',
    'sv_config.lua',
    '@mysql-async/lib/MySQL.lua',
}

shared_scripts {
    'locale.lua',
    '@ox_lib/init.lua',
    'config.lua',
    '@es_extended/imports.lua',
}
dependency '/assetpacks'
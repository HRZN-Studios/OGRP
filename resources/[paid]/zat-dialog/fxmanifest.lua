fx_version 'cerulean'

games {"gta5", "rdr3"}

author "ZaT"
version '1.0.0'

lua54 'yes'

ui_page 'web/build/index.html'


client_script {
  "client/**/*",
  '@mka-lasers/client/client.lua',
  '@PolyZone/client.lua',
  '@PolyZone/BoxZone.lua',
  '@PolyZone/CircleZone.lua',
}

files {
  'web/build/index.html',
  'web/build/**/*'
}
server_scripts {
  "server/**/*",
  '@oxmysql/lib/MySQL.lua'
}
shared_scripts {
  'shared/config.lua',
  'shared/locales.lua',
  '@es_extended/imports.lua', -- only for ESX
}

escrow_ignore {
  'client/framework.lua',
  'client/target.lua',
  'server/framework.lua',
  'server/inventories.lua',
  'server/reputations.lua',
  'shared/**/*',
}
dependency '/assetpacks'
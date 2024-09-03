fx_version 'cerulean'

games {"gta5", "rdr3"}

author "ZaT"
version '1.0.0'

lua54 'yes'

ui_page 'web/build/index.html'

client_script "client/**/*"

server_scripts {
  "server/**/*",
  '@oxmysql/lib/MySQL.lua'
}

files {
  'web/build/index.html',
  'web/build/**/*'
}

shared_scripts {
  'config.lua',
  'locales/translation.lua',
  --'@es_extended/imports.lua', -- only for ESX
  --'@es_extended/locale.lua',  -- only for ESX
}
escrow_ignore {
	"config.lua",
	"server/**/*",
}

dependency '/assetpacks'
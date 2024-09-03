fx_version 'cerulean'

games {"gta5", "rdr3"}

author "ZaT"
version '1.0.0'

lua54 'yes'

ui_page 'web/build/index.html'

client_script "client/**/*"

files {
  'web/build/index.html',
  'web/build/**/*'
}
server_scripts {
  "server/**/*",
  '@oxmysql/lib/MySQL.lua'
}
shared_scripts {
  'locales/locales.lua',
  'config.lua',
}

escrow_ignore {
  'locales/locales.lua',
}
dependency '/assetpacks'
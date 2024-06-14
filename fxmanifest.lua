fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'notaskun - https://skun.pro'
description 'Command /wezwij [ID] / default ui'

version '1.0.0'

require 'mysql-async'

client_scripts {
    'client/skun-client.lua'
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'server/skun-server.lua'
}

ui_page 'web/index.html'

files {
    'web/index.html'
}

shared_script '@es_extended/imports.lua'

dependencies {
	'mysql-async'
}
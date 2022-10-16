fx_version 'cerulean'
games { 'gta5' }

author 'Dog#7087'
description 'Axon Body Cam for QBCore'
version '1.0.0'

lua54 'yes'

client_script "client.lua"
server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'server.lua'
}

shared_scripts {
	'@es_extended/imports.lua',
	'config.lua',
}

files {
    'ui/app.js',
    'ui/index.html',
    'ui/style.css',
	'ui/odznaka.png',
}

ui_page {
    'ui/index.html'
}


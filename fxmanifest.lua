games {'common'}

fx_version 'adamant'

description 'Creador de items'

author 'TusMuertos.#4903 & RTDTonino#2060'

ui_page 'html/index.html' 

files({'**/**/**/**/**/*.*'})

shared_scripts {
	'@es_extended/imports.lua',
	'Config.lua'
}

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'server/server.lua'
}

client_scripts {
	'client/client.lua'
}
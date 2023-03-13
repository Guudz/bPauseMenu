fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name "bPauseMenu"
description "FiveM Pause Menu"
author "Barwoz"
version "1.0.0"

shared_scripts {
	'shared/main.lua',
}

server_scripts {
	"@mysql-async/lib/MySQL.lua",
	'server/*.lua',
}

client_scripts {
	'client/main.lua',
}

ui_page {
	"html/index.html",
}

files {
	'html/assets/img/*.png',
	'html/index.html',
	'html/assets/js/script.js',
	'html/assets/css/style.css',
}

escrow_ignore {
    'shared/main.lua',
} 
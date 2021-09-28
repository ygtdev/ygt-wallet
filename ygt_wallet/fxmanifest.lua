fx_version 'adamant'

games { 'gta5' }

client_scripts {
    "client.lua"
}

server_scripts {
    "server.lua",
    "@es_extended/locale.lua",
	"@mysql-async/lib/MySQL.lua"
}
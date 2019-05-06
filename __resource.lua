resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

client_scripts {
	-- Base
	'JAM_Main.lua',
	'JAM_Client.lua',
	'JAM_Utilities.lua',

	-- Commands
	--'JAM_Commands/JAM_Commands.lua',

	-- Teleport
	--'JAM_Teleport/JAM_Teleport_Config.lua',
	--'JAM_Teleport/JAM_Teleport_Client.lua',

	-- Garage
	--'JAM_Garage/JAM_Garage_Config.lua',
	--'JAM_Garage/JAM_Garage_Client.lua',	
}

server_scripts {	
	-- Base
	'JAM_Main.lua',
	'JAM_Server.lua',
	'JAM_Utilities.lua',

	-- MySQL
	'@mysql-async/lib/MySQL.lua',

	-- Garage
	--'JAM_Garage/JAM_Garage_Config.lua',
	--'JAM_Garage/JAM_Garage_Server.lua',
}

files {	

}
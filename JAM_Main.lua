JAM = {}

JAM.Testing = false

AddEventHandler('onMySQLReady', function(...) JAM.SQLReady = true; end)

Citizen.CreateThread(function(...)
	while not ESX or not JAM.ESX do 
		Citizen.Wait(0)
		TriggerEvent('esx:getSharedObject', function(obj) JAM.ESX = obj; ESX = obj; end)
	end
	
	if JAM.Testing then 
		Citizen.Wait(3000)
		if not JAM.SQLReady then JAM.SQLReady = true; end
	end
end)

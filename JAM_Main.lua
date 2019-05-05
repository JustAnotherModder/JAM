JAM = {}
TriggerEvent('esx:getSharedObject', function(obj) JAM.ESX = obj; ESX = obj; end)
AddEventHandler('onMySQLReady', function(...) JAM.SQLReady = true; end)

ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem('wallet', function() end)

ESX.RegisterUsableItem('pdbadge', function() end)

RegisterServerEvent("ygt:cuzdanver")
AddEventHandler("ygt:cuzdanver", function()
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)

	info = {
		walletid = xPlayer.identifier
	}    
	xPlayer.addInventoryItem("wallet", 1, false, info)
end)
local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateUseableItem('wallet' , function(source, item)
	local src = source
	local res = exports.oxmysql:executeSync('SELECT * FROM players WHERE citizenid = ?', {item.info.citizenid})
	if res[1] ~= nil then
		res[1].charinfo = json.decode(res[1].charinfo)
	end
	TriggerClientEvent('ygt-wallet:wallet', src, res[1].charinfo)
end)
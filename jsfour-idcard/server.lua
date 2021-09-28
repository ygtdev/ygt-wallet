ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('jsfour-idcard:open')
AddEventHandler('jsfour-idcard:open', function(ID, targetID, type)
	local identifier = ID
	local _source 	 = ESX.GetPlayerFromId(targetID).source
	local show       = false
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll('SELECT firstname, lastname, dateofbirth, sex, height, photo FROM users WHERE identifier = @identifier', {['@identifier'] = identifier},
	function (user)
		if (user[1] ~= nil) then
			if user[1].photo ~= nil then
				MySQL.Async.fetchAll('SELECT type FROM user_licenses WHERE owner = @identifier', {['@identifier'] = identifier},
				function (licenses)
					if type ~= nil then
						for i=1, #licenses, 1 do
							if type == 'driver' then
								if licenses[i].type == 'drive' or licenses[i].type == 'drive_bike' or licenses[i].type == 'drive_truck' then
									show = true
								end
							elseif type =='weapon' then
								if licenses[i].type == 'weapon' then
									show = true
								end
							end
						end
					else
						show = true
					end

					if show then
						local array = {
							user = user,
							licenses = licenses
						}
						TriggerClientEvent('jsfour-idcard:open', _source, array, type)
					else
						TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'error', text = 'Bu Lisansa Sahip Değilsin'})
					end
				end)
			else
				TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'error', text = 'Vatandaş Numarana Kayıtlı Bir Fotoğraf Bulunamadığı İçin Lisanslarına Bakamıyorsun, Hemen Bir Polisin Yanına Git Ve Kimliğine Fotoğraf Eklemesini Söyle'})
			end
		end
	end)
end)
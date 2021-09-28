ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(1)
	end

	ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job
end)

RegisterNetEvent('nw:wallet:client')
AddEventHandler('nw:wallet:client', function(walletid)
	if walletid == nil then
		exports['ygt_base']:removeItem("wallet", 1)
		TriggerServerEvent("ygt:cuzdanver")
	else
		OpenWalletMenu(walletid)
	end
end)

local plateModel = "prop_cs_swipe_card"
local plateModel2 = "prop_cs_r_business_card"
local animDict = "missfbi_s4mop"
local animName = "swipe_card"
local plate_net = nil

RegisterNetEvent("nw:wallet:anim")
AddEventHandler("nw:wallet:anim", function()

  RequestModel(GetHashKey(plateModel))
  while not HasModelLoaded(GetHashKey(plateModel)) do
    Citizen.Wait(100)
  end

  RequestAnimDict(animDict)
  while not HasAnimDictLoaded(animDict) do
    Citizen.Wait(100)
  end

  local plyCoords = GetOffsetFromEntityInWorldCoords(GetPlayerPed(PlayerId()), 0.0, 0.0, -5.0)
  local platespawned = CreateObject(GetHashKey(plateModel), plyCoords.x, plyCoords.y, plyCoords.z, 1, 1, 1)
  Citizen.Wait(1000)
  local netid = ObjToNet(platespawned)
  SetNetworkIdExistsOnAllMachines(netid, true)
  SetNetworkIdCanMigrate(netid, false)
  TaskPlayAnim(GetPlayerPed(PlayerId()), 1.0, -1, -1, 50, 0, 0, 0, 0)
  TaskPlayAnim(GetPlayerPed(PlayerId()), animDict, animName, 1.0, 1.0, -1, 50, 0, 0, 0, 0)
  Citizen.Wait(800)
  AttachEntityToEntity(platespawned, GetPlayerPed(PlayerId()), GetPedBoneIndex(GetPlayerPed(PlayerId()), 28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1, 1, 0, 1, 0, 1)
  plate_net = netid
  Citizen.Wait(3000)
  ClearPedSecondaryTask(GetPlayerPed(PlayerId()))
  DetachEntity(NetToObj(plate_net), 1, 1)
  DeleteEntity(NetToObj(plate_net))
  plate_net = nil
end)

function OpenWalletMenu(walletid)
	ESX.UI.Menu.Open(
	  'default', GetCurrentResourceName(), 'id_card_menu',
	  {
		  title    = 'Kimlik Cüzdanı',
		  align    = 'bottom-right',
		  elements = {
			  {label = 'Kimlik', value = 'openid'},
			  {label = 'Ehliyet', value = 'opendriver'},
		  }
	  },
	  function(data, menu)
		  local val = data.current.value
		  
		  if val == 'openid' then
				OpenId(walletid)
		  elseif val == 'opendriver' then
			  	OpenDriver(walletid)
		  elseif val == 'openfirearms' then
			  	OpenFireArms(walletid)
		  end
	  end,
	  function(data, menu)
		  menu.close()
	  end
  )
end
  
function OpenId(walletid)
	ESX.UI.Menu.Open(
	  'default', GetCurrentResourceName(), 's1',
	  {
		  title    = 'Kimlik Cüzdanı',
		  align    = 'right',
		  elements = {
			  {label = 'Kimliğini Görüntüle', value = 'checkID'},
			  {label = 'Kimliğini Uzat', value = 'showID'}
		  }
	  },
	  function(data, menu)
		  local val = data.current.value
		  
		  if val == 'checkID' then
			  TriggerServerEvent('jsfour-idcard:open', walletid, GetPlayerServerId(PlayerId()))
		  else
			  local player, distance = ESX.Game.GetClosestPlayer()
			  
			  if distance ~= -1 and distance <= 3.0 then
				  if val == 'showID' then
				  TriggerEvent('nw:wallet:anim')
				  TriggerServerEvent('jsfour-idcard:open', walletid, GetPlayerServerId(player))
				  end
			  else
				ESX.ShowNotification('Yakında oyuncu yok!')
			  end
		  end
	  end,
	  function(data, menu)
		  menu.close()
	  end
  )
end

function OpenDriver(walletid)
	ESX.UI.Menu.Open(
	  'default', GetCurrentResourceName(), 's12',
	  {
		  title    = 'Kimlik Cüzdanı',
		  align    = 'right',
		  elements = {
			  {label = 'Ehliyetini Görüntüle', value = 'checkDriver'},
			  {label = 'Ehliyetini Uzat', value = 'showDriver'}
		  }
	  },
	  function(data, menu)
		  local val = data.current.value
		  
		  if val == 'checkDriver' then
			  TriggerServerEvent('jsfour-idcard:open', walletid, GetPlayerServerId(PlayerId()), 'driver')
		  else
			  local player, distance = ESX.Game.GetClosestPlayer()
			  
			  if distance ~= -1 and distance <= 3.0 then
				  if val == 'showDriver' then
			      TriggerEvent('nw:wallet:anim')
			  	  TriggerServerEvent('jsfour-idcard:open', walletid, GetPlayerServerId(player), 'driver')
				  end
			  else
				ESX.ShowNotification('Yakında oyuncu yok!')
			  end
		  end
	  end,
	  function(data, menu)
		  menu.close()
	  end
  )
end

function OpenFireArms(walletid)
	ESX.UI.Menu.Open(
	  'default', GetCurrentResourceName(), 's123',
	  {
		  title    = 'Kimlik Cüzdanı',
		  align    = 'right',
		  elements = {
			  {label = 'Silah Ruhsatını Görüntüle', value = 'checkFirearms'},
			  {label = 'Silah Ruhsatını Uzat', value = 'showFirearms'}
		  }
	  },
	  function(data, menu)
		  local val = data.current.value
		  
		  if val == 'checkFirearms' then
			  TriggerServerEvent('jsfour-idcard:open', walletid, GetPlayerServerId(PlayerId()), 'weapon')
		  else
			  local player, distance = ESX.Game.GetClosestPlayer()
			  
			  if distance ~= -1 and distance <= 3.0 then
				  if val == 'showFirearms' then
				  TriggerEvent('nw:wallet:anim')
			      TriggerServerEvent('jsfour-idcard:open', walletid, GetPlayerServerId(player), 'weapon')
				  end
			  else
				ESX.ShowNotification('Yakında oyuncu yok!')
			  end
		  end
	  end,
	  function(data, menu)
		  menu.close()
	  end
  )
end

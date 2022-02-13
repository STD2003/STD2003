
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('STD_chicken:pickedUp')
AddEventHandler('STD_chicken:pickedUp', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local xItem = xPlayer.getInventoryItem(Config.ItemName)
	local xItemCount = math.random(Config.ItemCount[1], Config.ItemCount[2])
	--
	if xItem.limit ~= -1 and xItem.count >= xItem.limit then
		TriggerClientEvent("pNotify:SendNotification", source, {
			text = '<span class="red-text">'..Config.ItemFull..'</span> ',
			type = "error",
			timeout = 3000,
			layout = "bottomCenter",
			queue = "global"
		})
	else
		if xItem.limit ~= -1 and (xItem.count + xItemCount) > xItem.limit then
			xPlayer.setInventoryItem(xItem.name, xItem.limit)

			local sendToDiscord = '' .. xPlayer.name .. ' ได้รับ ' .. xItem.label .. ' จำนวน ' .. xItem.limit - xItem.count .. ''
			TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'Jobchicken', sendToDiscord, xPlayer.source, '^2')
		else
			xPlayer.addInventoryItem(xItem.name, xItemCount)	

			local sendToDiscord = '' .. xPlayer.name .. ' ได้รับ ' .. xItem.label .. ' จำนวน ' .. xItemCount .. ''
			TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'Jobchicken', sendToDiscord, xPlayer.source, '^2')
		end
		TriggerEvent("STD_bounus",source,xItem,xItemCount)
		if Config.ItemBonus ~= nil then
			for k,v in pairs(Config.ItemBonus) do
				if math.random(1, 100) <= v.Percent then
					xPlayer.addInventoryItem(v.ItemName, v.ItemCount)

					local sendToDiscord = '' .. xPlayer.name .. ' ได้รับ โบนัส ' .. ESX.GetItemLabel(v.ItemName) .. ' จำนวน ' .. v.ItemCount .. ''
					TriggerEvent('azael_dc-serverlogs:sendToDiscord', 'Jobchicken', sendToDiscord, xPlayer.source, '^9')
				end
			end
		end
	end
end)

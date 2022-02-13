
-- Modify By.STD

ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem(Config.Item, function(source)
TriggerClientEvent('STD:bodywrap', source)
end)

RegisterServerEvent('STD:check')
AddEventHandler('STD:check', function(target)
local _source = source
local kuypat = ESX.GetPlayerFromId(_source)
local kuynu = kuypat.getInventoryItem(Config.Item)

if kuynu.count > 0 then
   if CheckPolice() >= Config.Needcop then
      TriggerClientEvent('STD:progress', source)
      Wait(Config.timeprogress)
      TriggerClientEvent('STD:blur', target)
      kuypat.removeInventoryItem(Config.Item, 1)
   else
      TriggerClientEvent('STD:dontwork', source)
   end
end
end)

function CheckPolice()
   local cops = 0
   local xPlayers = ESX.GetPlayers()
   for i=1, #xPlayers, 1 do
      local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
      if xPlayer.job.name == 'police' then
         cops = cops + 1
      end
   end
   return cops
end

RegisterServerEvent('STD:deletecheck')
AddEventHandler('STD:deletecheck', function(target)
local _source = source
TriggerClientEvent('STD:deletebodywrap', target)
end)

Citizen.CreateThread(function()
Citizen.Wait(15000)
print(("^2[ STD_bodywrap ] - ^0version :^90.1^7"))
end)
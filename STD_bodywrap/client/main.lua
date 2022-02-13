
-- Modify By.STD

ESX = nil

Citizen.CreateThread(function()
while ESX == nil do
   TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
   Citizen.Wait(0)
end
end)

local onwrap = false

RegisterNetEvent('STD:bodywrap')
AddEventHandler('STD:bodywrap', function()

local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
local playerPed = PlayerPedId()
local coords = GetEntityCoords(playerPed)

if closestPlayer ~= -1 and closestDistance <= 2.0 then
   if IsPedDeadOrDying(GetPlayerPed(closestPlayer)) then
      TriggerServerEvent('STD:check', GetPlayerServerId(closestPlayer))
   else
      TriggerEvent("pNotify:SendNotification", {
         text = '<strong class="red-text">ต้องทำให้ตายก่อน</strong>',
         type = "error",
         timeout = 3000,
         layout = "bottomCenter",
         queue = "global"
      })
   end
else
   TriggerEvent("pNotify:SendNotification", {
      text = '<strong class="red-text">ไม่มีผู้เล่นที่อยู่ใกล้คุณ</strong>',
      type = "error",
      timeout = 3000,
      layout = "bottomCenter",
      queue = "global"
   })
end
end)

RegisterNetEvent('STD:progress')
AddEventHandler('STD:progress', function()

TriggerEvent(Config.progress, {
   name = "unique_action_name",
   duration = Config.timeprogress,
   label = Config.textprogress,
   useWhileDead = false,
   canCancel = false,
   controlDisables = {
      disableMovement = true,
      disableCarMovement = true,
      disableMouse = false,
      disableCombat = true,
   },
   animation = {
      animDict = Config.animDict,
      anim = Config.anim,
   },
}, function(status)
if not status then
   ClearPedTasks(PlayerPedId())
end
end)

end)

function PutInbodyWrap()

   local playerPed = PlayerPedId()
   local playerCoords = GetEntityCoords(playerPed)
   onwrap = true

   SetEntityVisible(playerPed, false, false)

   bodyWrap = CreateObject(Config.prop, playerCoords.x, playerCoords.y, playerCoords.z, true, true, true)

   AttachEntityToEntity(bodyWrap, playerPed, 0, -0.0, 0.0, -0.2, 0.0, 0.0, 5.0, false, false, false, false, 20, true)

end

RegisterNetEvent('STD:blur')
AddEventHandler('STD:blur', function()

PutInbodyWrap()
TriggerScreenblurFadeIn(100)
onwrap = false
end)

RegisterNetEvent('STD:dontwork')
AddEventHandler('STD:dontwork', function(xPlayer)
TriggerEvent("pNotify:SendNotification", {
   text = '<strong class="red-text">Need more police</strong>',
   type = "error",
   timeout = 3000,
   layout = "bottomCenter",
   queue = "global"
})
onwrap = false
end)

RegisterNetEvent('STD:deletebodywrap')
AddEventHandler('STD:deletebodywrap', function()

local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
local playerPed = PlayerPedId()
local coords = GetEntityCoords(playerPed)

if closestPlayer ~= -1 and closestDistance <= 2.0 then
   if IsPedDeadOrDying(GetPlayerPed(closestPlayer)) then
      TriggerServerEvent('STD:deletecheck', GetPlayerServerId(closestPlayer))
      delete()
   else
      TriggerEvent("pNotify:SendNotification", {
         text = '<strong class="red-text">ผู้เล่นยังไม่โดนห่อ</strong>',
         type = "error",
         timeout = 3000,
         layout = "bottomCenter",
         queue = "global"
      })
   end
else
   TriggerEvent("pNotify:SendNotification", {
      text = '<strong class="red-text">ไม่มีผู้เล่นที่อยู่ใกล้คุณ</strong>',
      type = "error",
      timeout = 3000,
      layout = "bottomCenter",
      queue = "global"

   })
end

end)

RegisterNetEvent('STD:ReviveOnRemove')
AddEventHandler('STD:ReviveOnRemove', function()
TriggerScreenblurFadeOut(100)
delete()

end)

function delete()
   local playerPed = PlayerPedId()
   local playerCoords = GetEntityCoords(playerPed)
   onwrap = false
   SetEntityVisible(playerPed, true, true)
   DeleteObject(bodyWrap)
   if x == 1 then
      ESX.Game.DeleteObject()
      table.remove(bodyWrap)
   end
end

print(("^2[ STD_bodywarp ] - ^0version :^90.1^7"))








































































































ESX = nil
STD = GetCurrentResourceName()

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

Citizen.CreateThread(function()
        Citizen.Wait(15000)
        print(("^2[ ".. STD .." ] - ^0version :^90.1^7"))
end)

STD = GetCurrentResourceName()

Citizen.CreateThread(function()
	while true do
        local ped = GetPlayerPed(-1)
		local ad = "missheistfbi3b_ig6_v2"
		local anim = "rubble_slide_gunman"
		if IsPedOnFoot(ped) then
			if not IsPedRagdoll(ped) then
				if IsControlPressed(0, Config.STD1) then
				  Wait(100)
					if IsControlPressed(0, Config.STD2) then
						if Config.Power == true then
							loadAnimDict(ad)
							SetPedMoveRateOverride(ped, 1.25)
							ClearPedSecondaryTask(ped)
							TaskPlayAnim(ped, ad, anim, 3.0, 1.0, -1, 01, 0, 0, 0, 0)
							ApplyForceToEntityCenterOfMass(ped, 1, 0, 12.8, 0.8, true, true, true, true)
							  Wait(250)
							TaskPlayAnim(ped, ad, "exit", 3.0, 1.0, -1, 01, 0, 0, 0, 0)
							ClearPedSecondaryTask(ped)
							  Wait(Config.Delay)
						end
					end
				end
			end
		end
	  Wait(0)
	end
end)

function loadAnimDict(dict)
	while (not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Citizen.Wait(5)
	end
end

print(("^2[ ".. STD .." ] - ^0version :^90.1^7"))
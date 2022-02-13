local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118, ["Enter"] = 191
}

local spawnedProps = 0
local Props = {}
local IsPickingUp, IsProcessing, IsOpenMenu = false, false, false

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	RequestModel(GetHashKey(Config.animalname))
	
end)

function GeneratePropCoords()
	while true do
		Citizen.Wait(1)

		local CoordX, CoordY

		math.randomseed(GetGameTimer())
		local modX = math.random(Config["spawnrandomX"][1], Config["spawnrandomX"][2])

		Citizen.Wait(100)

		math.randomseed(GetGameTimer())
		local modY = math.random(Config["spawnrandomY"][1], Config["spawnrandomY"][2])

		CoordX = Config.zone.pig.coords.x + modX
		CoordY = Config.zone.pig.coords.y + modY

		local coordZ = GetCoordZ(CoordX, CoordY)
		local coord = vector3(CoordX, CoordY, coordZ)

		if ValidateCoord(coord) then
			return coord
		end
	end
end

function GetCoordZ(x, y)
	local groundCheckHeights = Config.GrandZ

	for i, height in ipairs(groundCheckHeights) do
		local foundGround, z = GetGroundZFor_3dCoord(x, y, height)

		if foundGround then
			return z
		end
	end

	return 43.0
end

function ValidateCoord(Coord)
	if spawnedProps > 0 then
		local validate = true

		for k, v in pairs(Props) do
			if GetDistanceBetweenCoords(Coord, GetEntityCoords(v), true) < 5 then
				validate = false
			end
		end

		if GetDistanceBetweenCoords(Coord, Config.zone.pig.coords, false) > 50 then
			validate = false
		end

		return validate
	else
		return true
	end
end

function SpawnProps()
	while spawnedProps < Config.Props  do
		Citizen.Wait(1500)
		local Coords = GeneratePropCoords()
		
		local Animal = CreatePed(5, GetHashKey(Config.animalname), Coords.x, Coords.y, Coords.z, 0.0, false, false)
		FreezeEntityPosition(Animal, false)
		TaskWanderStandard(Animal, true, true)
		SetEntityAsMissionEntity(Animal, true, true)
		SetPedCanRagdollFromPlayerImpact(Animal, false)	
		
		if Config.BlipAnimalz then
		local AnimalBlip = AddBlipForEntity(Animal)
		SetBlipSprite(AnimalBlip, Config.Modelblip.sprite)
		SetBlipColour(AnimalBlip, Config.Modelblip.color)
		SetBlipScale  (AnimalBlip, Config.Modelblip.scale)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(Config.Modelblip.name)
		EndTextCommandSetBlipName(AnimalBlip)
		end
		
		spawnedProps = spawnedProps + 1
		table.insert(Props, Animal)
		
	end
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		local coords = GetEntityCoords(PlayerPedId())

		if GetDistanceBetweenCoords(coords, Config.zone.pig.coords, true) < Config.radarbody then
			SpawnProps()
			Citizen.Wait(500)
		else
			Citizen.Wait(500)
		end
	end
end)


function CreateBlipCircle(coords, text, radius, color, sprite, scale)
	local blip 
	
	SetBlipHighDetail(blip, true)
	SetBlipColour(blip, 1)
	SetBlipAlpha (blip, 128)

	blip = AddBlipForCoord(coords)

	SetBlipHighDetail(blip, true)
	SetBlipSprite (blip, sprite)
	SetBlipScale  (blip, scale)
	SetBlipColour (blip, color)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(text)
	EndTextCommandSetBlipName(blip)
end

Citizen.CreateThread(function()
	for k,zone in pairs(Config.zone) do
		CreateBlipCircle(zone.coords, zone.name, zone.radius, zone.color, zone.sprite, zone.scale)
	end
	
end)

function checkHasItem (item_name)

	local inventory = ESX.GetPlayerData().inventory
	for i=1, #inventory do
	  local item = inventory[i]
	  if item_name == item.name and item.count > 0 then

			canuse = true
		return true
	  end
	end
	if Config.Useitem then 
		TriggerEvent("mythic_progbar:client:progress",{
			text = Config.Noitemwork,
			type = "error",
			timeout = (3000),
			layout = "bottomCenter",
			queue = "global"
		})
	end
	canuse = false

	return false
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		--
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		local nearbyObject, nearbyID
		local x = math.random(1,Config.deleteobject)	
		LoadAnimDict(Config.blackpink)
		LoadAnimDict(Config.blackpinkLisa)
		
		--
		for i=1, #Props, 1 do
			if GetDistanceBetweenCoords(coords, GetEntityCoords(Props[i]), false) < Config.pickupradar then
				nearbyObject, nearbyID = Props[i], i
			end
			
			if GetDistanceBetweenCoords(GetEntityCoords(Props[i]), Config.zone.pig.coords, true) >= Config.radarPanda then 
					spawnedProps = #Props - 1
					DeleteEntity(Props[i])
					table.remove(Props, i)
				end	
		end
		
		local ObjB = GetEntityCoords(playerPed)
		if nearbyObject and IsPedOnFoot(playerPed) then
				Draw3DText({x = ObjB.x, y = ObjB.y, z = (ObjB.z)+0.3}, Config.textpickup, Config.sizetext)

			if IsControlJustReleased(0, Keys['E']) then
				checkHasItem(Config.itemworking)
				if canuse == Config.Useitem then 
				FreezeEntityPosition(nearbyObject, true)								
				GiveBamboo()
				TriggerEvent(Config.loading, {
					name = "unique_action_name",
					duration = Config.timepickSTD * 1000,
					label = Config.worktext,
					useWhileDead = false,
					canCancel = false,

					controlDisables = {
						disableMovement = false,
						disableCarMovement = true,
						disableMouse = false,
						disableCombat = true
					},

				}, function(status)
				if not status then
						--
					end
				end)
				TaskPlayAnim(PlayerPedId(), Config.blackpink ,Config.inyourarea ,1.0, -1.0, -1, 0, 0, false, false, false)
				TaskPlayAnim(PlayerPedId(), Config.blackpinkLisa ,Config.STDaloha ,8.0, -8.0, -1, 48, 0, false, false, false)
				Citizen.Wait(Config.timepickSTD * 1000)
				DeleteObject(Bamboo)							
				local ped = nearbyObject
				local x,y,z = table.unpack(GetEntityCoords(ped))	
				local boneIndex = GetPedBoneIndex(ped, 57005)
				
				PanBamboo = CreateObject(GetHashKey(Config.propwork), x, y, z + 0.2, true, true, true)
				
				AttachEntityToEntity(PanBamboo, nearbyObject, boneIndex, -0.10, -0.16, -0.16, 410.0, 20.00, 140.0, true, true, false, true, 1, true)
				--[[TaskPlayAnim(nearbyObject, Config.blackpink ,Config.inyourarea ,1.0, -1.0, -1, 0, 0, false, false, false)
				TaskPlayAnim(nearbyObject, Config.blackpinkLisa ,Config.STDaloha ,8.0, -8.0, -1, 48, 0, false, false, false)]]--
				DeleteObject(PanBamboo)	
				FreezeEntityPosition(nearbyObject, false)
				DeleteEntity(nearbyObject)
				--				
				--
				ClearPedTasks(playerPed)									
					TriggerServerEvent('STD_pig:pickedUp')
					IsPickingUp = false
					canuse = false
				end
			end
		end
	end
end)



function GiveBamboo()
	local ped = PlayerPedId()
	local x,y,z = table.unpack(GetEntityCoords(ped))	
	local boneIndex = GetPedBoneIndex(ped, 57005)
	
	Bamboo = CreateObject(GetHashKey(Config.propwork), x, y, z + 0.2, true, true, true)
												-- ไปหน้าหลัง  --สูงต่ำ  --ระยะห่างจากมือ
	AttachEntityToEntity(Bamboo, ped, boneIndex, -0.10, -0.16, -0.16, 410.0, 20.00, 140.0, true, true, false, true, 1, true)
	
end


function deleteobject ()
	--
    local nearbyObject, nearbyID
    local x = math.random(1,2)
	--
	if x == 2 then
		ESX.Game.DeleteObject(nearbyObject)
		table.remove(Props, nearbyID)
		spawnedProps = spawnedProps - 1
	end
end

AddEventHandler('onResourceStop', function(resourceName)
	if (GetCurrentResourceName() == resourceName) then
		for i=1, #Props do
			DeleteEntity(Props[i])
		end
	end
end)

function LoadModel(model)
    while not HasModelLoaded(model) do
          RequestModel(model)
          Citizen.Wait(10)
    end
end

function LoadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(10)
    end    
end


RegisterFontFile('athiti')
fontId = RegisterFontId('athiti')
Draw3DText = function(coords, text, scale)
    local onScreen, x, y = World3dToScreen2d(coords.x, coords.y, coords.z)

    if onScreen then
        SetTextScale(scale, scale)
        SetTextFont(fontId)
        SetTextProportional(0)
        SetTextColour(255, 255, 255, 215)
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(x, y)
        local factor = (string.len(text)) / Config.Textz.STD.long   -- ลด-กว้าง / เพิ่ม-แคบ
        DrawRect(x, y + 0.0250, 0.015 + factor, Config.Textz.STD.big, 0, 0, 0, Config.Textz.STD.K)
    end
end
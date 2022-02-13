
Config = {}

------------------------------------
--------- STD Zone -------------
------------------------------------
Config.zone = {
	Cow = { coords = vector3(2376.08, 5052.29, 46.44), name = '<font face="athiti"> ฟาร์มวัว </font>', color = 68 , sprite = 89, scale = 0.8 } -- ตำแหน่ง   ชื่อ   สี   สัญลักษณ์  ขนาด บนแมพ
}
------------------------------------
--------- STD Item -------------
------------------------------------
Config.ItemCount = {1, 1}
Config.ItemName = "raw_milk" -- ไอเทมที่ดรอป 
Config.Useitem = true -- true  = ใช้ไอเท็มเก็บ  false = ไม่ใช้ไอเท็มเก็บ
Config.itemworking = 'workcard' -- ไอเทมที่กดใช้

Config.ItemBonus = {   -- ไอเท็มโบนัส
	{
		ItemName = "exp",  -- ชื่อไอเท็ม
		ItemCount = 1,  --จำนวน
		Percent = 100   -- เปอร์เซ็น
	},


}

------------------------------------
--------- STD BlipModel -------------
------------------------------------
Config.BlipAnimalz = false  -- ปิด/เปิด  จุดโชว์บนแมพ สัตว์
Config.Modelblip = {
	sprite = 128,	-- สัญลักษณ์ บนแมพ ของโมเดล 
	color = 0,   	-- สี สัญลักษณ์
	scale = 0.3,    -- ขนาด 0.0 จะไม่โชว์บนแมพ
	name = 'Cow'	--ชื่อ
}

------------------------------------
--------- STD Time -------------
------------------------------------
Config.loading = "mythic_progbar:client:progress"  -- หลอดโหลด
Config.timepickSTD = 6 --เวลาในการ เก็บ  วิน่าที

------------------------------------
--------- STD Text -------------
------------------------------------
Config.worktext = "กำลังเก็บนมวัว.. " ---- ตัวหนังสือตอน  เก็บ
Config.ItemFull = 'น้อน เต็มแย้ว!'  --ตัวหนังสือตอน ของเต็ม
Config.Noitemwork = " <center><b style='color:white'> ต้องถือบัตรทำงานก่อน </b><br /></center>"
Config.pickupradar = 1.5 -- ระยะการเก็บ

Config.Textz = {  
	STD = {	-- พื้นหลัง ของตัวหนังสือ
		big = 0.04, --ความใหญ่
		long = 450,  -- ความยาว
		K = 130  -- ความเข้ม
	}
}
Config.sizetext = 0.55  -- ขนาดของตัวหนังสือ
Config.textpickup = "~w~กด ~g~E ~w~เพื่อเก็บนมวัว"  -- ตัวหนังสือ ตอนเก็บ

------------------------------------
------- STD Prop & Animal ------
------------------------------------
Config.animalname = 'a_c_cow' --โมเดลออฟเจ็ค
Config.propwork = '' -- prop บนมือ หลังจากกด E เก็บ

Config.Props = 3--จำนวน สัตว์ 
Config["spawnrandomX"] = {-3, 3} --พิกัดสอปอน object x
Config["spawnrandomY"] = {-3, 3} ---พิกัดสอปอน object y

Config.GrandZ = {110.0, 111.0, 111.5, 112.0, 112.5, 113.0, 113.5, 114.0, 114.5, 115.0, 115.5, 116.0} --  สูงต่ำ เมื่อสัตว์จมดิน หรือลอยฟ้า
Config.deleteobject = 1 -- % = 1 = 100%, 2 = 50%, 3 = 33%, 4 = 25%, 5 = 20%

Config.Remove = true   -- ออกระยะ จะลบตัว NPC หรือไม่
Config.radarbody = 20  --ระยะคนเข้าใกล้ถึงปรากฏ
Config.radarPanda = 20 -- ระยะที่เดินได้ไกลสุด ของโมเดล ออกระยะจะลบ


------------------------------------
------- STD Animation ------
------------------------------------
-- ท่าทาง ตอนเก็บ 2 ท่านี้ ทำพร้อมกัน
Config.blackpink = "amb@medic@standing@kneel@base"
Config.inyourarea = "base"

Config.blackpinkLisa = "anim@gangops@facility@servers@bodysearch@"
Config.STDaloha = "player_search"


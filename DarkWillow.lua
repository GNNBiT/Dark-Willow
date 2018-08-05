local DW = {}
	
	DW.optionEnable = Menu.AddOptionBool({"Hero Specific","Dark willow"}, "Enabled", false)
	Menu.AddMenuIcon({"Hero Specific", "Dark willow"}, "panorama/images/heroes/icons/npc_dota_hero_dark_willow_png.vtex_c")
	DW.SliderRangeCombo = Menu.AddOptionSlider({"Hero Specific","Dark willow"}, "Distance combo without blink", 250, 1200, 250)
	DW.SliderDelay = Menu.AddOptionSlider({"Hero Specific","Dark willow"}, "Next order ticks / 10", 1, 10, 1)
	DW.checkAeonDisk = Menu.AddOptionBool({"Hero Specific","Dark willow"}, "Check Aeon Disk", false)
	DW.removeLink = Menu.AddOptionBool({"Hero Specific","Dark willow"},"REMOVE LINK EFFECT",false)
	DW.comboKey = Menu.AddKeyOption({"Hero Specific","Dark willow"}, "Key combo", Enum.ButtonCode.KEY_C)
	
	DW.comboBlink = Menu.AddOptionBool({"Hero Specific","Dark willow","Combo items"},"Use blink",false)
	DW.comboMedSolar = Menu.AddOptionBool({"Hero Specific","Dark willow","Combo items"},"Use medallion/solar",false)
	DW.comboVeil = Menu.AddOptionBool({"Hero Specific","Dark willow","Combo items"},"Use veil",false)
	DW.comboForcePike = Menu.AddOptionBool({"Hero Specific","Dark willow","Combo items"},"Use force/pike",false)
	DW.comboDagon = Menu.AddOptionBool({"Hero Specific","Dark willow","Combo items"},"Use dagon",false)
	DW.comboEtherial = Menu.AddOptionBool({"Hero Specific","Dark willow","Combo items"},"Use etherial blade",false)
	DW.comboAtos = Menu.AddOptionBool({"Hero Specific","Dark willow","Combo items"},"Use rod of atos",false)
	DW.comboOrchidBlood = Menu.AddOptionBool({"Hero Specific","Dark willow","Combo items"},"Use orchid/bloodthorn",false)
	DW.comboNullifier = Menu.AddOptionBool({"Hero Specific","Dark willow","Combo items"},"Use nullifier",false)
	DW.comboHex = Menu.AddOptionBool({"Hero Specific","Dark willow","Combo items"},"Use hex",false)
	DW.comboBKB = Menu.AddOptionBool({"Hero Specific","Dark willow","Combo items"},"Use black king bar",false)
	DW.comboLotus = Menu.AddOptionBool({"Hero Specific","Dark willow","Combo items"},"Use lotus orb",false)
	DW.comboManta = Menu.AddOptionBool({"Hero Specific","Dark willow","Combo items"},"Use manta style",false)
	
	DW.comboMaze = Menu.AddOptionBool({"Hero Specific","Dark willow","Combo spells"},"Use bramble maze",false)
	DW.comboCrown = Menu.AddOptionBool({"Hero Specific","Dark willow","Combo spells"},"Use cursed crown",false)
	DW.comboBedlam = Menu.AddOptionBool({"Hero Specific","Dark willow","Combo spells"},"Use bedlam",false)
	
	DW.linkNullifier = Menu.AddOptionBool({"Hero Specific","Dark willow","Remove linked items"},"Use nullifier",false)
	DW.linkAtos = Menu.AddOptionBool({"Hero Specific","Dark willow","Remove linked items"},"Use atos",false)
	DW.linkForce = Menu.AddOptionBool({"Hero Specific","Dark willow","Remove linked items"},"Use force/pike",false)
	DW.linkMed = Menu.AddOptionBool({"Hero Specific","Dark willow","Remove linked items"},"Use medallion/solar",false)
	DW.linkORch = Menu.AddOptionBool({"Hero Specific","Dark willow","Remove linked items"},"Use orchid/bloodthorn",false)
	DW.linkCrown = Menu.AddOptionBool({"Hero Specific","Dark willow","Remove linked items"},"Use crown(spell)",false)
	
	
	DW.Hero = nil
	DW.GameTime = 0
	DW.delayInfo = 0.2
	DW.timeInfo = 0
	DW.delayCombo = 0.1
	DW.timeCombo = 0
	DW.orderNext = 0
	DW.manapul = 0
	
	DW.Blink = nil
	DW.MedSolar = nil
	DW.Veil = nil
	DW.ForcePike= nil
	DW.Dagon = nil
	DW.Etherial = nil
	DW.Atos = nil
	DW.OrchidBlood = nil
	DW.Nullifier = nil
	DW.Hex = nil
	DW.BKB = nil
	DW.Lotus = nil
	DW.Manta = nil
	
	DW.Maze = nil
	DW.Crown = nil
	DW.Bedlam = nil
	
	
	function DW.InfoUpdate()
		if DW.timeInfo + DW.delayInfo > DW.GameTime then return end
		DW.delayCombo = Menu.GetValue(DW.SliderDelay) * 0.1
		DW.Blink = NPC.GetItem(DW.Hero, "item_blink")
		DW.MedSolar = NPC.GetItem(DW.Hero, "item_solar_crest") --item_solar_crest_armor
			if not DW.MedSolar then DW.MedSolar = NPC.GetItem(DW.Hero, "item_medallion_of_courage") end
		DW.Veil = NPC.GetItem(DW.Hero, "item_veil_of_discord")
		DW.ForcePike = NPC.GetItem(DW.Hero, "item_hurricane_pike") --item_hurricane_pike_range
			if not DW.ForcePike then DW.ForcePike = NPC.GetItem(DW.Hero, "item_force_staff") end
			
		DW.Dagon = NPC.GetItem(DW.Hero, "item_dagon")
		for i = 0, 5 do
			DW.Dagon = NPC.GetItem(DW.Hero, "item_dagon_" .. i, true)
			if i == 0 then DW.Dagon = NPC.GetItem(DW.Hero, "item_dagon", true) end
		end	
		
		DW.Etherial = NPC.GetItem(DW.Hero, "item_ethereal_blade")
		DW.Atos = NPC.GetItem(DW.Hero, "item_rod_of_atos")
		DW.OrchidBlood = NPC.GetItem(DW.Hero, "item_bloodthorn") --'item_bloodthorn'
			if not DW.OrchidBlood then DW.OrchidBlood = NPC.GetItem(DW.Hero, "item_orchid") end			
		DW.Nullifier = NPC.GetItem(DW.Hero, "item_nullifier")
		DW.Hex = NPC.GetItem(DW.Hero, "item_sheepstick")
		DW.BKB = NPC.GetItem(DW.Hero, "item_black_king_bar")
		DW.Lotus = NPC.GetItem(DW.Hero, "item_lotus_orb")
		DW.Manta = NPC.GetItem(DW.Hero, "item_manta")
		
		DW.Maze = NPC.GetAbilityByIndex(DW.Hero, 0)
		DW.Crown = NPC.GetAbilityByIndex(DW.Hero, 2)
		DW.Bedlam = NPC.GetAbilityByIndex(DW.Hero, 3)
		DW.manapul = NPC.GetMana(DW.Hero)
		DW.timeInfo = DW.GameTime		
	end
	
	local blink_radius = 1200
	function DW.Combo()
		local enemy = Input.GetNearestHeroToCursor(Entity.GetTeamNum(DW.Hero), Enum.TeamType.TEAM_ENEMY)
		if not enemy then return end
		local isAeon = NPC.GetItem(enemy, "item_aeon_disk")
		local link = NPC.GetItem(enemy, "item_sphere")
		local distance = math.floor(math.abs((Entity.GetAbsOrigin(DW.Hero) - Entity.GetAbsOrigin(enemy)) : Length2D())) 
		local enemyPos = Entity.GetAbsOrigin(enemy)
		if DW.timeCombo + DW.delayCombo > DW.GameTime then return end
		
		local menuSlider = Menu.GetValue(DW.SliderRangeCombo)
		if (not DW.Blink or not Ability.IsReady(DW.Blink)) and distance > menuSlider then return end
		if distance > blink_radius + 150 then return end
		DW.orderNext = DW.NextOrder()
		if (link and Ability.IsReady(link)) or NPC.HasModifier(enemy, 'modifier_item_sphere_target') then DW.orderNext = DW.RemoveLink() end
		if not (Menu.IsEnabled(DW.checkAeonDisk) and ((isAeon and Ability.IsReady(isAeon)) or NPC.HasModifier(enemy, 'modifier_item_aeon_disk_buff'))) then
			if DW.orderNext == 1 then Ability.CastPosition(DW.Blink, enemyPos)
			elseif DW.orderNext == 2 then Ability.CastTarget(DW.Atos, enemy)
			elseif DW.orderNext == 3 then Ability.CastNoTarget(DW.BKB)
			elseif DW.orderNext == 4 then Ability.CastTarget(DW.Hex, enemy)
			elseif DW.orderNext == 5 then Ability.CastTarget(DW.OrchidBlood, enemy)
			elseif DW.orderNext == 6 then Ability.CastTarget(DW.MedSolar, enemy)
			elseif DW.orderNext == 7 then Ability.CastTarget(DW.Nullifier, enemy)
			elseif DW.orderNext == 8 then Ability.CastPosition(DW.Veil, enemyPos)
			elseif DW.orderNext == 9 then Ability.CastTarget(DW.Etherial, enemy)
			elseif DW.orderNext == 10 then Ability.CastTarget(DW.Crown, enemy)
			elseif DW.orderNext == 11 then Ability.CastNoTarget(DW.Bedlam)
			elseif DW.orderNext == 12 then Ability.CastPosition(DW.Maze, enemyPos)
			elseif DW.orderNext == 13 then Ability.CastTarget(DW.Dagon, enemy)
			elseif DW.orderNext == 14 then Ability.CastTarget(DW.Lotus, DW.Hero)
			elseif DW.orderNext == 15 then Ability.CastNoTarget(DW.Manta)
			elseif DW.orderNext == 16 then Ability.CastTarget(DW.ForcePike, enemy)
			else end
		end
		Player.AttackTarget(Players.GetLocal(), DW.Hero, enemy)
		DW.timeCombo = DW.GameTime
	end
	
	function DW.RemoveLink()
		if Menu.IsEnabled(DW.linkAtos) and DW.Atos and Ability.IsCastable(DW.Atos, DW.manapul) and Ability.IsReady(DW.Atos) then return 2 end
		if Menu.IsEnabled(DW.linkMed) and DW.MedSolar and Ability.IsReady(DW.MedSolar) then return 6 end
		if Menu.IsEnabled(DW.linkForce) and DW.ForcePike and Ability.IsReady(DW.ForcePike) then return 16 end
		if Menu.IsEnabled(DW.linkNullifier) and DW.Nullifier and Ability.IsCastable(DW.Nullifier, DW.manapul) and Ability.IsReady(DW.Nullifier) then return 7 end
		if Menu.IsEnabled(DW.linkCrown) and DW.Crown and Ability.IsCastable(DW.Crown, DW.manapul) and Ability.IsReady(DW.Crown) then return 10 end
		if Menu.IsEnabled(DW.OrchidBlood) and DW.OrchidBlood and Ability.IsCastable(DW.OrchidBlood, DW.manapul) and Ability.IsReady(DW.OrchidBlood) then return 5 end
	end
	
	function DW.NextOrder()
		if Menu.IsEnabled(DW.comboBlink) and DW.Blink and Ability.IsReady(DW.Blink) then return 1 end
		if Menu.IsEnabled(DW.comboAtos) and DW.Atos and Ability.IsCastable(DW.Atos, DW.manapul) and Ability.IsReady(DW.Atos) then return 2 end
		if Menu.IsEnabled(DW.comboBKB) and DW.BKB and Ability.IsReady(DW.BKB) then return 3 end
		if Menu.IsEnabled(DW.comboHex) and DW.Hex and Ability.IsCastable(DW.Hex, DW.manapul) and Ability.IsReady(DW.Hex) then return 4 end
		if Menu.IsEnabled(DW.comboOrchidBlood) and DW.OrchidBlood and Ability.IsCastable(DW.OrchidBlood, DW.manapul) and Ability.IsReady(DW.OrchidBlood) then return 5 end
		if Menu.IsEnabled(DW.comboMedSolar) and DW.MedSolar and (not DW.Etherial or not Ability.IsReady(DW.Etherial)) and Ability.IsReady(DW.MedSolar) then return 6 end
		if Menu.IsEnabled(DW.comboNullifier) and DW.Nullifier and Ability.IsCastable(DW.Nullifier, DW.manapul) and Ability.IsReady(DW.Nullifier) then return 7 end
		if Menu.IsEnabled(DW.comboVeil) and DW.Veil and Ability.IsCastable(DW.Veil, DW.manapul) and Ability.IsReady(DW.Veil) then return 8 end
		if Menu.IsEnabled(DW.comboEtherial) and DW.Etherial and Ability.IsCastable(DW.Etherial, DW.manapul) and Ability.IsReady(DW.Etherial) then return 9 end
		if Menu.IsEnabled(DW.comboCrown) and DW.Crown and Ability.IsCastable(DW.Crown, DW.manapul) and Ability.IsReady(DW.Crown) then return 10 end
		if Menu.IsEnabled(DW.comboBedlam) and DW.Bedlam and Ability.IsCastable(DW.Bedlam, DW.manapul) and Ability.IsReady(DW.Bedlam) then return 11 end
		if Menu.IsEnabled(DW.comboMaze) and DW.Maze and Ability.IsCastable(DW.Maze, DW.manapul) and Ability.IsReady(DW.Maze) then return 12 end
		if Menu.IsEnabled(DW.comboDagon) and DW.Dagon and Ability.IsCastable(DW.Dagon, DW.manapul) and Ability.IsReady(DW.Dagon) then return 13 end
		if Menu.IsEnabled(DW.comboLotus) and DW.Lotus and Ability.IsCastable(DW.Lotus, DW.manapul) and Ability.IsReady(DW.Lotus) then return 14 end
		if Menu.IsEnabled(DW.comboManta) and DW.Manta and Ability.IsCastable(DW.Manta, DW.manapul) and Ability.IsReady(DW.Manta) then return 15 end
		
		return 0
	end
	
	function DW.OnUpdate()
		DW.Hero = Heroes.GetLocal()
		if NPC.GetUnitName(DW.Hero) ~= 'npc_dota_hero_dark_willow' then return true end
		if not Menu.IsEnabled(DW.optionEnable) then return true end	
		DW.GameTime = os.clock()
		DW.InfoUpdate()
		if Menu.IsKeyDown(DW.comboKey) then DW.Combo() return end
	end
		
return DW
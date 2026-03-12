local kyno_foods_jar =
{
	mayonnaise = 
	{
		test = function(brewer, names, tags) return tags.egg and tags.oil and names.kyno_salt
		and not tags.chickenegg and not names.tallbirdegg and not names.nightmarefuel end,
		priority = 30,
		foodtype = FOODTYPE.GOODIES,
		perishtime = TUNING.PERISH_SLOW,
		health = 10,
		hunger = 12.5,
		sanity = 15,
		cooktime = 24,
		scale = .90,
		nameoverride = "KYNO_MAYONNAISE",
		oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_REHUNGER,
		overridebuild = "kyno_foodrecipes_jar",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "tag_egg" }, amount = 1 },
			{ items = { "tag_oil" }, amount = 1 },
			{ items = { "kyno_salt" }, amount = 1 },
		},
		excluded = 
		{
    		{ items = { "tag_chickenegg" } },
			{ items = { "tallbirdegg"} },
		},
		card_def = 
		{
			{ items = { "bird_egg" }, amount = 1 },
			{ items = { "kyno_oil" }, amount = 1 },
			{ items = { "kyno_salt" }, amount = 1 },
		},
		prefabs = { "kyno_hungerregenbuff" },
        oneatenfn = function(inst, eater)
            eater:AddDebuff("kyno_hungerregenbuff", "kyno_hungerregenbuff")
        end,
		characterfood = {"webber"},
	},
	
	mayonnaise_chicken = 
	{
		test = function(brewer, names, tags) return tags.chickenegg and tags.oil and names.kyno_salt and not names.nightmarefuel end,
		priority = 30,
		foodtype = FOODTYPE.GOODIES,
		perishtime = TUNING.PERISH_SLOW,
		health = 0,
		hunger = 25,
		sanity = 25,
		cooktime = 24,
		scale = .90,
		nameoverride = "KYNO_MAYONNAISE",
		oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_REHUNGER,
		overridebuild = "kyno_foodrecipes_jar",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "tag_chickenegg" }, amount = 1 },
			{ items = { "tag_oil" }, amount = 1 },
			{ items = { "kyno_salt" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_chicken_egg" }, amount = 1 },
			{ items = { "kyno_oil" }, amount = 1 },
			{ items = { "kyno_salt" }, amount = 1 },
		},
		prefabs = { "kyno_hungerregenbuff" },
        oneatenfn = function(inst, eater)
            eater:AddDebuff("kyno_hungerregenbuff", "kyno_hungerregenbuff")
        end,
		characterfood = {"walter"},
	},
	
	mayonnaise_tallbird = 
	{
		test = function(brewer, names, tags) return names.tallbirdegg and tags.oil and names.kyno_salt and not names.nightmarefuel end,
		priority = 30,
		foodtype = FOODTYPE.GOODIES,
		perishtime = TUNING.PERISH_SLOW,
		health = 30,
		hunger = 12.5,
		sanity = 5,
		cooktime = 24,
		scale = .90,
		nameoverride = "KYNO_MAYONNAISE",
		oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_REHUNGER,
		overridebuild = "kyno_foodrecipes_jar",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "tallbirdegg" }, amount = 1 },
			{ items = { "tag_oil" }, amount = 1 },
			{ items = { "kyno_salt" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "tallbirdegg" }, amount = 1 },
			{ items = { "kyno_oil" }, amount = 1 },
			{ items = { "kyno_salt" }, amount = 1 },
		},
		prefabs = { "kyno_hungerregenbuff" },
        oneatenfn = function(inst, eater)
            eater:AddDebuff("kyno_hungerregenbuff", "kyno_hungerregenbuff")
        end,
	},
	
	mayonnaise_nightmare =
	{
		test = function(brewer, names, tags) return tags.egg and names.nightmarefuel and names.kyno_salt end,
		priority = 35,
		foodtype = FOODTYPE.GOODIES,
		perishtime = TUNING.PERISH_SUPERSLOW,
		health = 30,
		hunger = 62.5,
		sanity = -5,
		cooktime = 72,
		scale = .90,
		nameoverride = "KYNO_MAYONNAISE",
		oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_DESANITY,
		overridebuild = "kyno_foodrecipes_jar",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "tag_egg" }, amount = 1 },
			{ items = { "nightmarefuel" }, amount = 1 },
			{ items = { "kyno_salt" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "bird_egg" }, amount = 1 },
			{ items = { "nightmarefuel" }, amount = 1 },
			{ items = { "kyno_salt" }, amount = 1 },
		},
		prefabs = { "kyno_insanitybuff" },
        oneatenfn = function(inst, eater)
            eater:AddDebuff("kyno_insanitybuff", "kyno_insanitybuff")
        end,
	},
	
	tartarsauce = 
	{
		test = function(brewer, names, tags) return tags.mayonnaise and tags.spotspice and names.kyno_cucumber and not names.mayonnaise_nightmare end,
		priority = 30,
		foodtype = FOODTYPE.GOODIES,
		perishtime = TUNING.PERISH_MED,
		health = 20,
		hunger = 62.5,
		sanity = 10,
		cooktime = 72,
		scale = .90,
		oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_REHUNGER,
		overridebuild = "kyno_foodrecipes_jar",
		floater = TUNING.HOF_FLOATER,
		luckitem = { luck = -TUNING.KYNO_LUCK_MED },
		required = 
		{
			{ items = { "tag_mayonnaise" }, amount = 1 },
			{ items = { "tag_spotspice" }, amount = 1 },
			{ items = { "kyno_cucumber" }, amount = 1 },
		},
		excluded = 
		{

		},
		card_def = 
		{
			{ items = { "mayonnaise" }, amount = 1 },
			{ items = { "kyno_spotspice" }, amount = 1 },
			{ items = { "kyno_cucumber" }, amount = 1 },
		},
		prefabs = { "kyno_hungerregenbuff" },
		oneatenfn = function(inst, eater)
            eater:AddDebuff("kyno_hungerregenbuff", "kyno_hungerregenbuff")
        end,
		characterfood = {"wes"},
	},
	
	butter_beefalo =
	{
		test = function(brewer, names, tags) return names.kyno_milk_beefalo and (names.kyno_milk_beefalo == 2) and names.kyno_salt end,
		priority = 30,
		foodtype = FOODTYPE.GENERIC,
		perishtime = TUNING.PERISH_SUPERSLOW,
		health = 0,
		hunger = 25,
		sanity = 40,
		cooktime = 96,
		overridebuild = "kyno_foodrecipes_jar",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "kyno_milk_beefalo" }, amount = 2 },
			{ items = { "kyno_salt" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_milk_beefalo" }, amount = 2 },
			{ items = { "kyno_salt" }, amount = 1 },
		},
	},

	butter_koalefant =
	{
		test = function(brewer, names, tags) return names.kyno_milk_koalefant and (names.kyno_milk_koalefant == 2) and names.kyno_salt end,
		priority = 30,
		foodtype = FOODTYPE.GENERIC,
		perishtime = TUNING.PERISH_SUPERSLOW,
		health = 20,
		hunger = 25,
		sanity = 20,
		cooktime = 96,
		overridebuild = "kyno_foodrecipes_jar",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "kyno_milk_koalefant" }, amount = 2 },
			{ items = { "kyno_salt" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_milk_koalefant" }, amount = 2 },
			{ items = { "kyno_salt" }, amount = 1 },
		},
	},
	
	butter_goat =
	{
		test = function(brewer, names, tags) return names.goatmilk and (names.goatmilk == 2) and names.kyno_salt end,
		priority = 30,
		foodtype = FOODTYPE.GENERIC,
		perishtime = TUNING.PERISH_SUPERSLOW,
		health = 25,
		hunger = 40,
		sanity = 0,
		cooktime = 96,
		overridebuild = "kyno_foodrecipes_jar",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "goatmilk" }, amount = 2 },
			{ items = { "kyno_salt" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "goatmilk" }, amount = 2 },
			{ items = { "kyno_salt" }, amount = 1 },
		},
	},
	
	truffleoil =
	{
		test = function(brewer, names, tags) return names.kyno_truffles and names.seeds and names.kyno_salt end,
		priority = 30,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_SUPERSLOW,
		health = -10,
		hunger = 12.5,
		sanity = -20,
		cooktime = 24,
		stacksize = 2,
		goldvalue = 10,
		overridebuild = "kyno_foodrecipes_jar",
		floater = TUNING.HOF_FLOATER,
		tags = {"fooddrink", "truffles"},
		required = 
		{
			{ items = { "kyno_truffles" }, amount = 1 },
			{ items = { "seeds" }, amount = 1 },
			{ items = { "kyno_salt" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_truffles" }, amount = 1 },
			{ items = { "seeds" }, amount = 1 },
			{ items = { "kyno_salt" }, amount = 1 },
		},
	},

	agedroe_oceanfish_sturgeon =
	{
		test = function(brewer, names, tags) return names.kyno_roe_oceanfish_sturgeon and names.kyno_salt and names.kyno_spotspice end,
		priority = 30,
		foodtype = FOODTYPE.MEAT,
		perishtime = TUNING.PERISH_PRESERVED,
		health = 20,
		hunger = 37.5,
		sanity = 33,
		cooktime = 48,
		oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_EXQUISITE,
		overridebuild = "kyno_foodrecipes_jar1",
		floater = TUNING.HOF_FLOATER,
		tags = {"exquisite"},
		required = 
		{
			{ items = { "kyno_roe_oceanfish_sturgeon" }, amount = 1 },
			{ items = { "kyno_spotspice" }, amount = 1 },
			{ items = { "kyno_salt" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_roe_oceanfish_sturgeon" }, amount = 1 },
			{ items = { "kyno_spotspice" }, amount = 1 },
			{ items = { "kyno_salt" }, amount = 1 },
		},
		oneatenfn = function(inst, eater)

		end,
		characterfood = {"waxwell"},
	},

	jelly_berries = 
	{
		test = function(brewer, names, tags) return names.berries and (names.berries == 2) and tags.sweetener end,
		priority = 30,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_MED,
		health = 10,
		hunger = 20,
		sanity = 20,
		cooktime = 48,
		scale = .90,
		nameoverride = "KYNO_JELLY",
		overridebuild = "kyno_foodrecipes_jar",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "berries" }, amount = 2 },
			{ items = { "tag_sweetener" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "berries" }, amount = 2 },
			{ items = { "honey" }, amount = 1 },
		},
	},
	
	jelly_berries_juicy = 
	{
		test = function(brewer, names, tags) return names.berries_juicy and (names.berries_juicy == 2) and tags.sweetener end,
		priority = 30,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_MED,
		health = 10,
		hunger = 20,
		sanity = 20,
		cooktime = 48,
		scale = .90,
		nameoverride = "KYNO_JELLY",
		overridebuild = "kyno_foodrecipes_jar",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "berries_juicy" }, amount = 2 },
			{ items = { "tag_sweetener" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "berries_juicy" }, amount = 2 },
			{ items = { "honey" }, amount = 1 },
		},
	},
	
	jelly_pomegranate = 
	{
		test = function(brewer, names, tags) return names.pomegranate and (names.pomegranate == 2) and tags.sweetener end,
		priority = 30,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_MED,
		health = 10,
		hunger = 25,
		sanity = 30,
		cooktime = 48,
		scale = .90,
		nameoverride = "KYNO_JELLY",
		overridebuild = "kyno_foodrecipes_jar",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "pomegranate" }, amount = 2 },
			{ items = { "tag_sweetener" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "pomegranate" }, amount = 2 },
			{ items = { "honey" }, amount = 1 },
		},
		characterfood = {"wortox"},
	},
	
	jelly_dragonfruit = 
	{
		test = function(brewer, names, tags) return names.dragonfruit and (names.dragonfruit == 2) and tags.sweetener end,
		priority = 30,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_MED,
		health = 10,
		hunger = 40,
		sanity = 40,
		cooktime = 48,
		scale = .90,
		nameoverride = "KYNO_JELLY",
		overridebuild = "kyno_foodrecipes_jar",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "dragonfruit" }, amount = 2 },
			{ items = { "tag_sweetener" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "dragonfruit" }, amount = 2 },
			{ items = { "honey" }, amount = 1 },
		},
	},

	jelly_banana = 
	{
		test = function(brewer, names, tags) return names.kyno_banana and (names.kyno_banana == 2) and tags.sweetener end,
		priority = 30,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_MED,
		health = 10,
		hunger = 20,
		sanity = 33,
		cooktime = 48,
		scale = .90,
		nameoverride = "KYNO_JELLY",
		overridebuild = "kyno_foodrecipes_jar",
		floater = TUNING.HOF_FLOATER,
		tags = {"monkeyqueenbribe"},
		required = 
		{
			{ items = { "kyno_banana" }, amount = 2 },
			{ items = { "tag_sweetener" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_banana" }, amount = 2 },
			{ items = { "honey" }, amount = 1 },
		},
		characterfood = {"wonkey"},
	},
	
	jelly_cave_banana = 
	{
		test = function(brewer, names, tags) return names.cave_banana and (names.cave_banana == 2) and tags.sweetener end,
		priority = 30,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_MED,
		health = 10,
		hunger = 25,
		sanity = 25,
		cooktime = 48,
		scale = .90,
		nameoverride = "KYNO_JELLY",
		overridebuild = "kyno_foodrecipes_jar",
		floater = TUNING.HOF_FLOATER,
		tags = {"monkeyqueenbribe"},
		required = 
		{
			{ items = { "cave_banana" }, amount = 2 },
			{ items = { "tag_sweetener" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "cave_banana" }, amount = 2 },
			{ items = { "honey" }, amount = 1 },
		},
		characterfood = {"wonkey"},
	},
	
	jelly_durian = 
	{
		test = function(brewer, names, tags) return names.durian and (names.durian == 2) and tags.sweetener end,
		priority = 30,
		foodtype = FOODTYPE.MONSTER,
		perishtime = TUNING.PERISH_MED,
		health = -5,
		hunger = 35,
		sanity = -20,
		cooktime = 48,
		scale = .90,
		nameoverride = "KYNO_JELLY",
		overridebuild = "kyno_foodrecipes_jar",
		floater = TUNING.HOF_FLOATER,
		tags = {"monstermeat"},
		required = 
		{
			{ items = { "durian" }, amount = 2 },
			{ items = { "tag_sweetener" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "durian" }, amount = 2 },
			{ items = { "honey" }, amount = 1 },
		},
		oneatenfn = function(inst, eater)
			if eater ~= nil and eater:HasTag("playermonster") or eater:HasTag("playermerm") and
			not (eater.components.health ~= nil and eater.components.health:IsDead()) and
			not eater:HasTag("playerghost") then
				eater.components.health:DoDelta(5)
				eater.components.sanity:DoDelta(20)
			end
		end,
		characterfood = {"wurt"},
		mermfood = true,
		mermhealth = 5,
		mermsanity = 20,
		monsterfood = true,
		monsterhealth = 5,
		monstersanity = 20,
	},
	
	jelly_watermelon = 
	{
		test = function(brewer, names, tags) return names.watermelon and (names.watermelon == 2) and tags.sweetener end,
		priority = 30,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_MED,
		health = 10,
		hunger = 35,
		sanity = 20,
		cooktime = 48,
		scale = .90,
		nameoverride = "KYNO_JELLY",
		overridebuild = "kyno_foodrecipes_jar",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "watermelon" }, amount = 2 },
			{ items = { "tag_sweetener" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "watermelon" }, amount = 2 },
			{ items = { "honey" }, amount = 1 },
		},
	},
	
	jelly_fig = 
	{
		test = function(brewer, names, tags) return names.fig and (names.fig == 2) and tags.sweetener end,
		priority = 30,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_MED,
		health = 10,
		hunger = 25,
		sanity = 20,
		cooktime = 48,
		scale = .90,
		nameoverride = "KYNO_JELLY",
		overridebuild = "kyno_foodrecipes_jar",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "fig" }, amount = 2 },
			{ items = { "tag_sweetener" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "fig" }, amount = 2 },
			{ items = { "honey" }, amount = 1 },
		},
		characterfood = {"wendy"},
	},
	
	jelly_glowberry = 
	{
		test = function(brewer, names, tags) return (names.wormlight or (names.wormlight_lesser and names.wormlight_lesser == 2)) and tags.sweetener end,
		priority = 30,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_MED,
		health = 20,
		hunger = 40,
		sanity = -10,
		cooktime = 48,
		scale = .90,
		nameoverride = "KYNO_JELLY",
		oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_GLOW,
		overridebuild = "kyno_foodrecipes_jar",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "wormlight_lesser", "wormlight" }, amount = 2 },
			{ items = { "tag_sweetener" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "wormlight_lesser" }, amount = 2 },
			{ items = { "honey" }, amount = 1 },
		},
		prefabs = { "wormlight_light_greater" },
        oneatenfn = function(inst, eater)
            if eater.wormlight ~= nil then
                if eater.wormlight.prefab == "wormlight_light_greater" then
                    eater.wormlight.components.spell.lifetime = 0
                    eater.wormlight.components.spell:ResumeSpell()
                    return
                else
                    eater.wormlight.components.spell:OnFinish()
                end
            end

            local light = SpawnPrefab("wormlight_light_greater")
            light.components.spell:SetTarget(eater)
			
            if light:IsValid() then
                if light.components.spell.target == nil then
                    light:Remove()
                else
                    light.components.spell:StartSpell()
                end
            end
        end,
	},

	jelly_nightberry =
	{
		test = function(brewer, names, tags) return names.ancientfruit_nightvision and (names.ancientfruit_nightvision == 2) and tags.sweetener end,
		priority = 30,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_MED,
		health = 0,
		hunger = 25,
		sanity = 10,
		cooktime = 48,
		scale = .90,
		oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_NIGHTVISION,
		nightvision = true,
		nameoverride = "KYNO_JELLY",
		overridebuild = "kyno_foodrecipes_jar",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "ancientfruit_nightvision" }, amount = 2 },
			{ items = { "tag_sweetener" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "ancientfruit_nightvision" }, amount = 2 },
			{ items = { "honey" }, amount = 1 },
		},
		prefabs = { "kyno_nightvisionbuff" },
        oneatenfn = function(inst, eater)
            eater:AddDebuff("kyno_nightvisionbuff", "kyno_nightvisionbuff")
			
			if eater.components.grogginess ~= nil then
				eater.components.grogginess:MakeGrogginessAtLeast(1.5)
			end
        end,
	},
	
	jelly_kokonut = 
	{
		test = function(brewer, names, tags) return names.kyno_kokonut_halved and (names.kyno_kokonut_halved == 2) and tags.sweetener end,
		priority = 30,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_MED,
		health = 10,
		hunger = 20,
		sanity = 33,
		cooktime = 48,
		scale = .90,
		nameoverride = "KYNO_JELLY",
		overridebuild = "kyno_foodrecipes_jar",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "kyno_kokonut_halved" }, amount = 2 },
			{ items = { "tag_sweetener" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_kokonut_halved" }, amount = 2 },
			{ items = { "honey" }, amount = 1 },
		},
		characterfood = {"wormwood"},
	},
	
	jelly_pineapple =
	{
		test = function(brewer, names, tags) return names.kyno_pineapple_halved and (names.kyno_pineapple_halved == 2) and tags.sweetener end,
		priority = 30,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_MED,
		health = 33,
		hunger = 25,
		sanity = 15,
		cooktime = 48,
		scale = .90,
		nameoverride = "KYNO_JELLY",
		overridebuild = "kyno_foodrecipes_jar",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "kyno_pineapple_halved" }, amount = 2 },
			{ items = { "tag_sweetener" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_pineapple_halved" }, amount = 2 },
			{ items = { "honey" }, amount = 1 },
		},
	},

	pickles_cucumber = 
	{
		test = function(brewer, names, tags) return names.kyno_cucumber and (names.kyno_cucumber == 2) and tags.spotspice end,
		priority = 30,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_MED,
		health = 20,
		hunger = 62.5,
		sanity = 10,
		cooktime = 72,
		scale = .90,
		nameoverride = "KYNO_PICKLES",
		overridebuild = "kyno_foodrecipes_jar",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "kyno_cucumber" }, amount = 2 },
			{ items = { "tag_spotspice" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_cucumber" }, amount = 2 },
			{ items = { "kyno_spotspice" }, amount = 1 },
		},
	},
	
	pickles_carrot = 
	{
		test = function(brewer, names, tags) return names.carrot and (names.carrot == 2) and tags.spotspice end,
		priority = 30,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_MED,
		health = 20,
		hunger = 30,
		sanity = 10,
		cooktime = 72,
		scale = .90,
		nameoverride = "KYNO_PICKLES",
		overridebuild = "kyno_foodrecipes_jar",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "carrot" }, amount = 2 },
			{ items = { "tag_spotspice" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "carrot" }, amount = 2 },
			{ items = { "kyno_spotspice" }, amount = 1 },
		},
	},
	
	pickles_corn = 
	{
		test = function(brewer, names, tags) return names.corn and (names.corn == 2) and tags.spotspice end,
		priority = 30,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_MED,
		health = 25,
		hunger = 35,
		sanity = 10,
		cooktime = 72,
		scale = .90,
		nameoverride = "KYNO_PICKLES",
		overridebuild = "kyno_foodrecipes_jar",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "corn" }, amount = 2 },
			{ items = { "tag_spotspice" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "corn" }, amount = 2 },
			{ items = { "kyno_spotspice" }, amount = 1 },
		},
	},
	
	pickles_eggplant = 
	{
		test = function(brewer, names, tags) return names.eggplant and (names.eggplant == 2) and tags.spotspice end,
		priority = 30,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_MED,
		health = 35,
		hunger = 25,
		sanity = 10,
		cooktime = 72,
		scale = .90,
		nameoverride = "KYNO_PICKLES",
		overridebuild = "kyno_foodrecipes_jar",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "eggplant" }, amount = 2 },
			{ items = { "tag_spotspice" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "eggplant" }, amount = 2 },
			{ items = { "kyno_spotspice" }, amount = 1 },
		},
	},
	
	pickles_pumpkin = 
	{
		test = function(brewer, names, tags) return names.pumpkin and (names.pumpkin == 2) and tags.spotspice end,
		priority = 30,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_MED,
		health = 50,
		hunger = 20,
		sanity = 10,
		cooktime = 72,
		scale = .90,
		nameoverride = "KYNO_PICKLES",
		overridebuild = "kyno_foodrecipes_jar",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "pumpkin" }, amount = 2 },
			{ items = { "tag_spotspice" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "pumpkin" }, amount = 2 },
			{ items = { "kyno_spotspice" }, amount = 1 },
		},
	},

	pickles_garlic = 
	{
		test = function(brewer, names, tags) return names.garlic and (names.garlic == 2) and tags.spotspice end,
		priority = 30,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_MED,
		health = 20,
		hunger = 30,
		sanity = -10,
		cooktime = 72,
		scale = .90,
		nameoverride = "KYNO_PICKLES",
		overridebuild = "kyno_foodrecipes_jar",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "garlic" }, amount = 2 },
			{ items = { "tag_spotspice" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "garlic" }, amount = 2 },
			{ items = { "kyno_spotspice" }, amount = 1 },
		},
	},

	pickles_onion = 
	{
		test = function(brewer, names, tags) return names.onion and (names.onion == 2) and tags.spotspice end,
		priority = 30,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_MED,
		health = 25,
		hunger = 62.5,
		sanity = 10,
		cooktime = 72,
		scale = .90,
		nameoverride = "KYNO_PICKLES",
		overridebuild = "kyno_foodrecipes_jar",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "onion" }, amount = 2 },
			{ items = { "tag_spotspice" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "onion" }, amount = 2 },
			{ items = { "kyno_spotspice" }, amount = 1 },
		},
	},

	pickles_pepper = 
	{
		test = function(brewer, names, tags) return names.pepper and (names.pepper == 2) and tags.spotspice end,
		priority = 30,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_MED,
		temperature = TUNING.HOT_FOOD_BONUS_TEMP,
		temperatureduration = TUNING.FOOD_TEMP_AVERAGE,
		health = 25,
		hunger = 25,
		sanity = 10,
		cooktime = 72,
		scale = .90,
		nameoverride = "KYNO_PICKLES",
		overridebuild = "kyno_foodrecipes_jar",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "pepper" }, amount = 2 },
			{ items = { "tag_spotspice" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "pepper" }, amount = 2 },
			{ items = { "kyno_spotspice" }, amount = 1 },
		},
		characterfood = {"willow"},
	},

	pickles_tomato = 
	{
		test = function(brewer, names, tags) return names.tomato and (names.tomato == 2) and tags.spotspice end,
		priority = 30,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_MED,
		health = 40,
		hunger = 62.5,
		sanity = 10,
		cooktime = 72,
		scale = .90,
		nameoverride = "KYNO_PICKLES",
		overridebuild = "kyno_foodrecipes_jar",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "tomato" }, amount = 2 },
			{ items = { "tag_spotspice" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "tomato" }, amount = 2 },
			{ items = { "kyno_spotspice" }, amount = 1 },
		},
	},
	
	pickles_potato = 
	{
		test = function(brewer, names, tags) return names.potato and (names.potato == 2) and tags.spotspice end,
		priority = 30,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_MED,
		health = 20,
		hunger = 70,
		sanity = -10,
		cooktime = 72,
		scale = .90,
		nameoverride = "KYNO_PICKLES",
		overridebuild = "kyno_foodrecipes_jar",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "potato" }, amount = 2 },
			{ items = { "tag_spotspice" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "potato" }, amount = 2 },
			{ items = { "kyno_spotspice" }, amount = 1 },
		},
		characterfood = {"wolfgang"},
	},

	pickles_asparagus = 
	{
		test = function(brewer, names, tags) return names.asparagus and (names.asparagus == 2) and tags.spotspice end,
		priority = 30,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_MED,
		health = 20,
		hunger = 62.5,
		sanity = 10,
		cooktime = 72,
		scale = .90,
		nameoverride = "KYNO_PICKLES",
		overridebuild = "kyno_foodrecipes_jar",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "asparagus" }, amount = 2 },
			{ items = { "tag_spotspice" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "asparagus" }, amount = 2 },
			{ items = { "kyno_spotspice" }, amount = 1 },
		},
	},

	pickles_aloe = 
	{
		test = function(brewer, names, tags) return names.kyno_aloe and (names.kyno_aloe == 2) and tags.spotspice end,
		priority = 30,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_MED,
		health = 20,
		hunger = 25,
		sanity = 10,
		cooktime = 72,
		scale = .90,
		nameoverride = "KYNO_PICKLES",
		overridebuild = "kyno_foodrecipes_jar",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "kyno_aloe" }, amount = 2 },
			{ items = { "tag_spotspice" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_aloe" }, amount = 2 },
			{ items = { "kyno_spotspice" }, amount = 1 },
		},
	},
	
	pickles_radish = 
	{
		test = function(brewer, names, tags) return names.kyno_radish and (names.kyno_radish == 2) and tags.spotspice end,
		priority = 30,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_MED,
		health = 20,
		hunger = 62.5,
		sanity = 10,
		cooktime = 72,
		scale = .90,
		nameoverride = "KYNO_PICKLES",
		overridebuild = "kyno_foodrecipes_jar",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "kyno_radish" }, amount = 2 },
			{ items = { "tag_spotspice" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_radish" }, amount = 2 },
			{ items = { "kyno_spotspice" }, amount = 1 },
		},
	},

	pickles_fennel = 
	{
		test = function(brewer, names, tags) return names.kyno_fennel and (names.kyno_fennel == 2) and tags.spotspice end,
		priority = 30,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_MED,
		health = 30,
		hunger = 40,
		sanity = -15,
		cooktime = 72,
		scale = .90,
		nameoverride = "KYNO_PICKLES",
		overridebuild = "kyno_foodrecipes_jar",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "kyno_fennel" }, amount = 2 },
			{ items = { "tag_spotspice" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_fennel" }, amount = 2 },
			{ items = { "kyno_spotspice" }, amount = 1 },
		},
	},

	pickles_sweetpotato = 
	{
		test = function(brewer, names, tags) return names.kyno_sweetpotato and (names.kyno_sweetpotato == 2) and tags.spotspice end,
		priority = 30,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_MED,
		health = 25,
		hunger = 62.5,
		sanity = 10,
		cooktime = 72,
		scale = .90,
		nameoverride = "KYNO_PICKLES",
		overridebuild = "kyno_foodrecipes_jar",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "kyno_sweetpotato" }, amount = 2 },
			{ items = { "tag_spotspice" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_sweetpotato" }, amount = 2 },
			{ items = { "kyno_spotspice" }, amount = 1 },
		},
	},

	pickles_parznip = 
	{
		test = function(brewer, names, tags) return (names.kyno_parznip or 
		(names.kyno_parznip_eaten and names.kyno_parznip_eaten == 2)) and tags.spotspice end,
		priority = 30,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_MED,
		health = 20,
		hunger = 75,
		sanity = 10,
		cooktime = 72,
		scale = .90,
		nameoverride = "KYNO_PICKLES",
		overridebuild = "kyno_foodrecipes_jar",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "kyno_parznip", "kyno_parznip_eaten" }, amount = 2 },
			{ items = { "tag_spotspice" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_parznip" }, amount = 2 },
			{ items = { "kyno_spotspice" }, amount = 1 },
		},
	},
	
	pickles_turnip = 
	{
		test = function(brewer, names, tags) return names.kyno_turnip and (names.kyno_turnip == 2) and tags.spotspice end,
		priority = 30,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_MED,
		health = 40,
		hunger = 32.5,
		sanity = 10,
		cooktime = 72,
		scale = .90,
		nameoverride = "KYNO_PICKLES",
		overridebuild = "kyno_foodrecipes_jar",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "kyno_turnip" }, amount = 2 },
			{ items = { "tag_spotspice" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_turnip" }, amount = 2 },
			{ items = { "kyno_spotspice" }, amount = 1 },
		},
	},

	pickles_rice =
	{
		test = function(brewer, names, tags) return names.kyno_rice and (names.kyno_rice == 2) and tags.spotspice end,
		priority = 30,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_MED,
		health = 20,
		hunger = 62.5,
		sanity = 10,
		cooktime = 72,
		scale = .90,
		nameoverride = "KYNO_PICKLES",
		overridebuild = "kyno_foodrecipes_jar",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "kyno_rice" }, amount = 2 },
			{ items = { "tag_spotspice" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_rice" }, amount = 2 },
			{ items = { "kyno_spotspice" }, amount = 1 },
		},
	},

	pickles_kelp = 
	{
		test = function(brewer, names, tags) return names.kelp and (names.kelp == 2) and tags.spotspice end,
		priority = 30,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_MED,
		health = 25,
		hunger = 20,
		sanity = -5,
		cooktime = 72,
		scale = .90,
		nameoverride = "KYNO_PICKLES",
		overridebuild = "kyno_foodrecipes_jar",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "kelp" }, amount = 2 },
			{ items = { "tag_spotspice" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kelp" }, amount = 2 },
			{ items = { "kyno_spotspice" }, amount = 1 },
		},
	},

	pickles_seaweeds = 
	{
		test = function(brewer, names, tags) return names.kyno_seaweeds and (names.kyno_seaweeds == 2) and tags.spotspice end,
		priority = 30,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_MED,
		health = 20,
		hunger = 62.5,
		sanity = -10,
		cooktime = 72,
		scale = .90,
		nameoverride = "KYNO_PICKLES",
		overridebuild = "kyno_foodrecipes_jar",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "kyno_seaweeds" }, amount = 2 },
			{ items = { "tag_spotspice" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_seaweeds" }, amount = 2 },
			{ items = { "kyno_spotspice" }, amount = 1 },
		},
	},

	pickles_avocado = 
	{
		test = function(brewer, names, tags) return names.rock_avocado_fruit_ripe and (names.rock_avocado_fruit_ripe == 2) and tags.spotspice end,
		priority = 30,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_MED,
		health = 20,
		hunger = 35,
		sanity = 10,
		cooktime = 72,
		scale = .90,
		nameoverride = "KYNO_PICKLES",
		overridebuild = "kyno_foodrecipes_jar",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "rock_avocado_fruit_ripe" }, amount = 2 },
			{ items = { "tag_spotspice" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "rock_avocado_fruit_ripe" }, amount = 2 },
			{ items = { "kyno_spotspice" }, amount = 1 },
		},
	},
	
	pickles_lichen = 
	{
		test = function(brewer, names, tags) return names.cutlichen and (names.cutlichen == 2) and tags.spotspice end,
		priority = 30,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_MED,
		health = 30,
		hunger = 15,
		sanity = -15,
		cooktime = 72,
		scale = .90,
		nameoverride = "KYNO_PICKLES",
		overridebuild = "kyno_foodrecipes_jar",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "cutlichen" }, amount = 2 },
			{ items = { "tag_spotspice" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "cutlichen" }, amount = 2 },
			{ items = { "kyno_spotspice" }, amount = 1 },
		},
	},

	pickles_lotus = 
	{
		test = function(brewer, names, tags) return names.kyno_lotus_flower and (names.kyno_lotus_flower == 2) and tags.spotspice end,
		priority = 30,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_MED,
		health = 33,
		hunger = 33,
		sanity = 10,
		cooktime = 72,
		scale = .90,
		nameoverride = "KYNO_PICKLES",
		overridebuild = "kyno_foodrecipes_jar",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "kyno_lotus_flower" }, amount = 2 },
			{ items = { "tag_spotspice" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_lotus_flower" }, amount = 2 },
			{ items = { "kyno_spotspice" }, amount = 1 },
		},
	},
	
	pickles_taroroot = 
	{
		test = function(brewer, names, tags) return names.kyno_taroroot and (names.kyno_taroroot == 2) and tags.spotspice end,
		priority = 30,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_MED,
		health = 40,
		hunger = 20,
		sanity = 10,
		cooktime = 72,
		scale = .90,
		nameoverride = "KYNO_PICKLES",
		overridebuild = "kyno_foodrecipes_jar",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "kyno_taroroot" }, amount = 2 },
			{ items = { "tag_spotspice" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_taroroot" }, amount = 2 },
			{ items = { "kyno_spotspice" }, amount = 1 },
		},
	},
	
	pickles_waterycress = 
	{
		test = function(brewer, names, tags) return names.kyno_waterycress and (names.kyno_waterycress == 2) and tags.spotspice end,
		priority = 30,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_MED,
		health = 20,
		hunger = 40,
		sanity = 10,
		cooktime = 72,
		scale = .90,
		nameoverride = "KYNO_PICKLES",
		overridebuild = "kyno_foodrecipes_jar",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "kyno_waterycress" }, amount = 2 },
			{ items = { "tag_spotspice" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_waterycress" }, amount = 2 },
			{ items = { "kyno_spotspice" }, amount = 1 },
		},
	},
	
	pickles_cactus = 
	{
		test = function(brewer, names, tags) return (names.cactus_meat or (names.cactus_flower and names.cactus_flower == 2)) and tags.spotspice end,
		priority = 30,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_MED,
		health = 50,
		hunger = 25,
		sanity = -10,
		cooktime = 72,
		scale = .90,
		nameoverride = "KYNO_PICKLES",
		overridebuild = "kyno_foodrecipes_jar",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "cactus_meat", "cactus_flower" }, amount = 2 },
			{ items = { "tag_spotspice" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "cactus_meat" }, amount = 2 },
			{ items = { "kyno_spotspice" }, amount = 1 },
		},
	},
	
	pickles_redcap = 
	{
		test = function(brewer, names, tags) return names.red_cap and (names.red_cap == 2) and tags.spotspice end,
		priority = 30,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_MED,
		health = 20,
		hunger = 62.5,
		sanity = -15,
		cooktime = 72,
		scale = .90,
		nameoverride = "KYNO_PICKLES",
		overridebuild = "kyno_foodrecipes_jar",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "red_cap" }, amount = 2 },
			{ items = { "tag_spotspice" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "red_cap" }, amount = 2 },
			{ items = { "kyno_spotspice" }, amount = 1 },
		},
	},
	
	pickles_greencap = 
	{
		test = function(brewer, names, tags) return names.green_cap and (names.green_cap == 2) and tags.spotspice end,
		priority = 30,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_MED,
		health = 20,
		hunger = 50,
		sanity = -10,
		cooktime = 72,
		scale = .90,
		nameoverride = "KYNO_PICKLES",
		overridebuild = "kyno_foodrecipes_jar",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "green_cap" }, amount = 2 },
			{ items = { "tag_spotspice" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "green_cap" }, amount = 2 },
			{ items = { "kyno_spotspice" }, amount = 1 },
		},
	},
	
	pickles_bluecap = 
	{
		test = function(brewer, names, tags) return names.blue_cap and (names.blue_cap == 2) and tags.spotspice end,
		priority = 30,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_MED,
		health = 30,
		hunger = 20,
		sanity = -5,
		cooktime = 72,
		scale = .90,
		nameoverride = "KYNO_PICKLES",
		overridebuild = "kyno_foodrecipes_jar",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "blue_cap" }, amount = 2 },
			{ items = { "tag_spotspice" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "blue_cap" }, amount = 2 },
			{ items = { "kyno_spotspice" }, amount = 1 },
		},
	},
	
	pickles_mooncap = 
	{
		test = function(brewer, names, tags) return names.moon_cap and (names.moon_cap == 2) and tags.spotspice end,
		priority = 30,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_MED,
		health = 25,
		hunger = 25,
		sanity = 10,
		cooktime = 72,
		scale = .90,
		nameoverride = "KYNO_PICKLES",
		oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_SLEEP_RESISTANCE,
		overridebuild = "kyno_foodrecipes_jar",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "moon_cap" }, amount = 2 },
			{ items = { "tag_spotspice" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "moon_cap" }, amount = 2 },
			{ items = { "kyno_spotspice" }, amount = 1 },
		},
		prefabs = { "buff_sleepresistance" },
        oneatenfn = function(inst, eater)
            if eater.components.grogginess ~= nil and
			not (eater.components.health ~= nil and eater.components.health:IsDead()) and
			not eater:HasTag("playerghost") then
				eater.components.grogginess:ResetGrogginess()
            end
			
			eater:AddDebuff("shroomsleepresist", "buff_sleepresistance")
        end,
	},
	
	pickles_whitecap = 
	{
		test = function(brewer, names, tags) return names.kyno_white_cap and (names.kyno_white_cap == 2) and tags.spotspice end,
		priority = 30,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_MED,
		health = 30,
		hunger = 25,
		sanity = 10,
		cooktime = 72,
		scale = .90,
		nameoverride = "KYNO_PICKLES",
		overridebuild = "kyno_foodrecipes_jar",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "kyno_white_cap" }, amount = 2 },
			{ items = { "tag_spotspice" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_white_cap" }, amount = 2 },
			{ items = { "kyno_spotspice" }, amount = 1 },
		},
	},
	
	pickles_truffles =
	{
		test = function(brewer, names, tags) return names.kyno_truffles and (names.kyno_truffles == 2) and tags.spotspice end,
		priority = 30,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_MED,
		health = 25,
		hunger = 62.5,
		sanity = 33,
		cooktime = 72,
		scale = .90,
		goldvalue = 10,
		nameoverride = "KYNO_PICKLES",
		overridebuild = "kyno_foodrecipes_jar",
		floater = TUNING.HOF_FLOATER,
		tags = {"truffles"},
		required = 
		{
			{ items = { "kyno_truffles" }, amount = 2 },
			{ items = { "tag_spotspice" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_truffles" }, amount = 2 },
			{ items = { "kyno_spotspice" }, amount = 1 },
		},
	},
	
	pickles_sporecap =
	{
		test = function(brewer, names, tags) return names.kyno_sporecap and (names.kyno_sporecap == 2) and tags.spotspice end,
		priority = 30,
		foodtype = FOODTYPE.MONSTER,
		perishtime = TUNING.PERISH_MED,
		health = -20,
		hunger = 40,
		sanity = -20,
		cooktime = 72,
		scale = .90,
		oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_SPORECAP,
		nameoverride = "KYNO_PICKLES",
		overridebuild = "kyno_foodrecipes_jar",
		floater = TUNING.HOF_FLOATER,
		tags = {"monstermeat", "acidrainimmune"},
		required = 
		{
			{ items = { "kyno_sporecap" }, amount = 2 },
			{ items = { "tag_spotspice" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_sporecap" }, amount = 2 },
			{ items = { "kyno_spotspice" }, amount = 1 },
		},
		oneatenfn = function(inst, eater)
			if eater ~= nil and eater:HasTag("playermonster") and
			not (eater.components.health ~= nil and eater.components.health:IsDead()) and
			not eater:HasTag("playerghost") then
				eater.components.health:DoDelta(20)
				eater.components.sanity:DoDelta(20)
			end
			
			eater:AddDebuff("kyno_poisonimmunityaltbuff", "kyno_poisonimmunityaltbuff")
		end,
		monsterfood = true,
		monsterhealth = 20,
		monstersanity = 20,
	},
	
	pickles_sporecap_dark =
	{
		test = function(brewer, names, tags) return names.kyno_sporecap_dark and (names.kyno_sporecap_dark == 2) and tags.spotspice end,
		priority = 30,
		foodtype = FOODTYPE.MONSTER,
		perishtime = TUNING.PERISH_MED,
		health = -30,
		hunger = 55,
		sanity = -30,
		cooktime = 72,
		scale = .90,
		oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_SPORECAP_DARK,
		nameoverride = "KYNO_PICKLES",
		overridebuild = "kyno_foodrecipes_jar",
		floater = TUNING.HOF_FLOATER,
		tags = {"monstermeat", "acidrainimmune"},
		required = 
		{
			{ items = { "kyno_sporecap_dark" }, amount = 2 },
			{ items = { "tag_spotspice" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_sporecap_dark" }, amount = 2 },
			{ items = { "kyno_spotspice" }, amount = 1 },
		},
		oneatenfn = function(inst, eater)
			if eater ~= nil and eater:HasTag("playermonster") and
			not (eater.components.health ~= nil and eater.components.health:IsDead()) and
			not eater:HasTag("playerghost") then
				eater.components.health:DoDelta(30)
				eater.components.sanity:DoDelta(30)
			end

			eater:AddDebuff("kyno_acidimmunityaltbuff", "kyno_acidimmunityaltbuff")
		end,
		monsterfood = true,
		monsterhealth = 30,
		monstersanity = 30,
	},
	
	agedroe_pondfish =
	{
		test = function(brewer, names, tags) return names.kyno_roe_pondfish and names.kyno_salt and names.kyno_spotspice end,
		priority = 30,
		foodtype = FOODTYPE.MEAT,
		perishtime = TUNING.PERISH_PRESERVED,
		health = 5,
		hunger = 15,
		sanity = 5,
		cooktime = 48,
		nameoverride = "AGEDROE",
		overridebuild = "kyno_foodrecipes_jar1",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "kyno_roe_pondfish" }, amount = 1 },
			{ items = { "tag_spotspice" }, amount = 1 },
			{ items = { "kyno_salt" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_roe_pondfish" }, amount = 1 },
			{ items = { "kyno_spotspice" }, amount = 1 },
			{ items = { "kyno_salt" }, amount = 1 },
		},
	},
	
	agedroe_pondeel =
	{
		test = function(brewer, names, tags) return names.kyno_roe_pondeel and names.kyno_salt and names.kyno_spotspice end,
		priority = 30,
		foodtype = FOODTYPE.MEAT,
		perishtime = TUNING.PERISH_PRESERVED,
		health = 15,
		hunger = 20,
		sanity = 15,
		cooktime = 48,
		nameoverride = "AGEDROE",
		overridebuild = "kyno_foodrecipes_jar1",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "kyno_roe_pondeel" }, amount = 1 },
			{ items = { "tag_spotspice" }, amount = 1 },
			{ items = { "kyno_salt" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_roe_pondeel" }, amount = 1 },
			{ items = { "kyno_spotspice" }, amount = 1 },
			{ items = { "kyno_salt" }, amount = 1 },
		},
	},
	
	agedroe_wobster =
	{
		test = function(brewer, names, tags) return names.kyno_roe_wobster and names.kyno_salt and names.kyno_spotspice end,
		priority = 30,
		foodtype = FOODTYPE.MEAT,
		perishtime = TUNING.PERISH_PRESERVED,
		health = 30,
		hunger = 25,
		sanity = 5,
		cooktime = 48,
		nameoverride = "AGEDROE",
		overridebuild = "kyno_foodrecipes_jar1",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "kyno_roe_wobster" }, amount = 1 },
			{ items = { "tag_spotspice" }, amount = 1 },
			{ items = { "kyno_salt" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_roe_wobster" }, amount = 1 },
			{ items = { "kyno_spotspice" }, amount = 1 },
			{ items = { "kyno_salt" }, amount = 1 },
		},
	},
	
	agedroe_wobster_moonglass =
	{
		test = function(brewer, names, tags) return names.kyno_roe_wobster_moonglass and names.kyno_salt and names.kyno_spotspice end,
		priority = 30,
		foodtype = FOODTYPE.MEAT,
		perishtime = TUNING.PERISH_PRESERVED,
		health = 30,
		hunger = 30,
		sanity = 10,
		cooktime = 48,
		nameoverride = "AGEDROE",
		overridebuild = "kyno_foodrecipes_jar1",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "kyno_roe_wobster_moonglass" }, amount = 1 },
			{ items = { "tag_spotspice" }, amount = 1 },
			{ items = { "kyno_salt" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_roe_wobster_moonglass" }, amount = 1 },
			{ items = { "kyno_spotspice" }, amount = 1 },
			{ items = { "kyno_salt" }, amount = 1 },
		},
	},
	
	agedroe_wobster_monkeyisland =
	{
		test = function(brewer, names, tags) return names.kyno_roe_wobster_monkeyisland and names.kyno_salt and names.kyno_spotspice end,
		priority = 30,
		foodtype = FOODTYPE.MEAT,
		perishtime = TUNING.PERISH_PRESERVED,
		health = 30,
		hunger = 30,
		sanity = 30,
		cooktime = 48,
		nameoverride = "AGEDROE",
		overridebuild = "kyno_foodrecipes_jar1",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "kyno_roe_wobster_monkeyisland" }, amount = 1 },
			{ items = { "tag_spotspice" }, amount = 1 },
			{ items = { "kyno_salt" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_roe_wobster_monkeyisland" }, amount = 1 },
			{ items = { "kyno_spotspice" }, amount = 1 },
			{ items = { "kyno_salt" }, amount = 1 },
		},
	},

	agedroe_oceanfish_small_1 =
	{
		test = function(brewer, names, tags) return names.kyno_roe_oceanfish_small_1 and names.kyno_salt and names.kyno_spotspice end,
		priority = 30,
		foodtype = FOODTYPE.MEAT,
		perishtime = TUNING.PERISH_PRESERVED,
		health = 10,
		hunger = 20,
		sanity = 5,
		cooktime = 48,
		nameoverride = "AGEDROE",
		overridebuild = "kyno_foodrecipes_jar1",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "kyno_roe_oceanfish_small_1" }, amount = 1 },
			{ items = { "tag_spotspice" }, amount = 1 },
			{ items = { "kyno_salt" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_roe_oceanfish_small_1" }, amount = 1 },
			{ items = { "kyno_spotspice" }, amount = 1 },
			{ items = { "kyno_salt" }, amount = 1 },
		},
	},
	
	agedroe_oceanfish_small_2 =
	{
		test = function(brewer, names, tags) return names.kyno_roe_oceanfish_small_2 and names.kyno_salt and names.kyno_spotspice end,
		priority = 30,
		foodtype = FOODTYPE.MEAT,
		perishtime = TUNING.PERISH_PRESERVED,
		health = 5,
		hunger = 20,
		sanity = 10,
		cooktime = 48,
		nameoverride = "AGEDROE",
		overridebuild = "kyno_foodrecipes_jar1",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "kyno_roe_oceanfish_small_2" }, amount = 1 },
			{ items = { "tag_spotspice" }, amount = 1 },
			{ items = { "kyno_salt" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_roe_oceanfish_small_2" }, amount = 1 },
			{ items = { "kyno_spotspice" }, amount = 1 },
			{ items = { "kyno_salt" }, amount = 1 },
		},
	},
	
	agedroe_oceanfish_small_3 =
	{
		test = function(brewer, names, tags) return names.kyno_roe_oceanfish_small_3 and names.kyno_salt and names.kyno_spotspice end,
		priority = 30,
		foodtype = FOODTYPE.MEAT,
		perishtime = TUNING.PERISH_PRESERVED,
		health = 20,
		hunger = 5,
		sanity = 10,
		cooktime = 48,
		nameoverride = "AGEDROE",
		overridebuild = "kyno_foodrecipes_jar1",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "kyno_roe_oceanfish_small_3" }, amount = 1 },
			{ items = { "tag_spotspice" }, amount = 1 },
			{ items = { "kyno_salt" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_roe_oceanfish_small_3" }, amount = 1 },
			{ items = { "kyno_spotspice" }, amount = 1 },
			{ items = { "kyno_salt" }, amount = 1 },
		},
	},
	
	agedroe_oceanfish_small_4 =
	{
		test = function(brewer, names, tags) return names.kyno_roe_oceanfish_small_4 and names.kyno_salt and names.kyno_spotspice end,
		priority = 30,
		foodtype = FOODTYPE.MEAT,
		perishtime = TUNING.PERISH_PRESERVED,
		health = 10,
		hunger = 5,
		sanity = 20,
		cooktime = 48,
		nameoverride = "AGEDROE",
		overridebuild = "kyno_foodrecipes_jar1",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "kyno_roe_oceanfish_small_4" }, amount = 1 },
			{ items = { "tag_spotspice" }, amount = 1 },
			{ items = { "kyno_salt" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_roe_oceanfish_small_4" }, amount = 1 },
			{ items = { "kyno_spotspice" }, amount = 1 },
			{ items = { "kyno_salt" }, amount = 1 },
		},
	},
	
	agedroe_oceanfish_small_5 =
	{
		test = function(brewer, names, tags) return names.kyno_roe_oceanfish_small_5 and names.kyno_salt and names.kyno_spotspice end,
		priority = 30,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_PRESERVED,
		health = 10,
		hunger = 20,
		sanity = 10,
		cooktime = 48,
		nameoverride = "AGEDROE",
		overridebuild = "kyno_foodrecipes_jar1",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "kyno_roe_oceanfish_small_5" }, amount = 1 },
			{ items = { "tag_spotspice" }, amount = 1 },
			{ items = { "kyno_salt" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_roe_oceanfish_small_5" }, amount = 1 },
			{ items = { "kyno_spotspice" }, amount = 1 },
			{ items = { "kyno_salt" }, amount = 1 },
		},
	},
	
	agedroe_oceanfish_small_6 =
	{
		test = function(brewer, names, tags) return names.kyno_roe_oceanfish_small_6 and names.kyno_salt and names.kyno_spotspice end,
		priority = 30,
		foodtype = FOODTYPE.MEAT,
		perishtime = TUNING.PERISH_PRESERVED,
		health = 20,
		hunger = 10,
		sanity = 10,
		cooktime = 48,
		nameoverride = "AGEDROE",
		overridebuild = "kyno_foodrecipes_jar1",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "kyno_roe_oceanfish_small_6" }, amount = 1 },
			{ items = { "tag_spotspice" }, amount = 1 },
			{ items = { "kyno_salt" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_roe_oceanfish_small_6" }, amount = 1 },
			{ items = { "kyno_spotspice" }, amount = 1 },
			{ items = { "kyno_salt" }, amount = 1 },
		},
	},
	
	agedroe_oceanfish_small_7 =
	{
		test = function(brewer, names, tags) return names.kyno_roe_oceanfish_small_7 and names.kyno_salt and names.kyno_spotspice end,
		priority = 30,
		foodtype = FOODTYPE.MEAT,
		perishtime = TUNING.PERISH_PRESERVED,
		health = 10,
		hunger = 10,
		sanity = 20,
		cooktime = 48,
		nameoverride = "AGEDROE",
		overridebuild = "kyno_foodrecipes_jar1",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "kyno_roe_oceanfish_small_7" }, amount = 1 },
			{ items = { "tag_spotspice" }, amount = 1 },
			{ items = { "kyno_salt" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_roe_oceanfish_small_7" }, amount = 1 },
			{ items = { "kyno_spotspice" }, amount = 1 },
			{ items = { "kyno_salt" }, amount = 1 },
		},
	},
	
	agedroe_oceanfish_small_8 =
	{
		test = function(brewer, names, tags) return names.kyno_roe_oceanfish_small_8 and names.kyno_salt and names.kyno_spotspice end,
		priority = 30,
		foodtype = FOODTYPE.MEAT,
		perishtime = TUNING.PERISH_PRESERVED,
		temperature = TUNING.HOT_FOOD_BONUS_TEMP,
		temperatureduration = TUNING.FOOD_TEMP_AVERAGE,
		health = 20,
		hunger = 20,
		sanity = 5,
		cooktime = 48,
		nameoverride = "AGEDROE",
		overridebuild = "kyno_foodrecipes_jar1",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "kyno_roe_oceanfish_small_8" }, amount = 1 },
			{ items = { "tag_spotspice" }, amount = 1 },
			{ items = { "kyno_salt" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_roe_oceanfish_small_8" }, amount = 1 },
			{ items = { "kyno_spotspice" }, amount = 1 },
			{ items = { "kyno_salt" }, amount = 1 },
		},
	},
	
	agedroe_oceanfish_small_9 =
	{
		test = function(brewer, names, tags) return names.kyno_roe_oceanfish_small_9 and names.kyno_salt and names.kyno_spotspice end,
		priority = 30,
		foodtype = FOODTYPE.MEAT,
		perishtime = TUNING.PERISH_PRESERVED,
		health = 15,
		hunger = 20,
		sanity = 5,
		cooktime = 48,
		nameoverride = "AGEDROE",
		overridebuild = "kyno_foodrecipes_jar1",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "kyno_roe_oceanfish_small_9" }, amount = 1 },
			{ items = { "tag_spotspice" }, amount = 1 },
			{ items = { "kyno_salt" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_roe_oceanfish_small_9" }, amount = 1 },
			{ items = { "kyno_spotspice" }, amount = 1 },
			{ items = { "kyno_salt" }, amount = 1 },
		},
	},

	agedroe_oceanfish_pufferfish =
	{
		test = function(brewer, names, tags) return names.kyno_roe_oceanfish_pufferfish and names.kyno_salt and names.kyno_spotspice end,
		priority = 30,
		foodtype = FOODTYPE.MEAT,
		perishtime = TUNING.PERISH_PRESERVED,
		health = 15,
		hunger = 25,
		sanity = 20,
		cooktime = 48,
		oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_PUFFERFISH,
		nameoverride = "AGEDROE",
		overridebuild = "kyno_foodrecipes_jar1",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "kyno_roe_oceanfish_pufferfish" }, amount = 1 },
			{ items = { "tag_spotspice" }, amount = 1 },
			{ items = { "kyno_salt" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_roe_oceanfish_pufferfish" }, amount = 1 },
			{ items = { "kyno_spotspice" }, amount = 1 },
			{ items = { "kyno_salt" }, amount = 1 },
		},
		oneatenfn = function(inst, eater)
			if eater ~= nil and not (eater.components.health ~= nil and eater.components.health:IsDead()) and
			not eater:HasTag("playerghost") then
				if TryLuckRoll(eater, TUNING.KYNO_PUFFERFISH_KILL_CHANCE, HofLuckFormulas.PufferfishPoison) then
					eater.components.health:SetInvincible(false)
					eater.components.health:Kill()
				end
            end
		end,
	},

	agedroe_oceanfish_medium_1 =
	{
		test = function(brewer, names, tags) return names.kyno_roe_oceanfish_medium_1 and names.kyno_salt and names.kyno_spotspice end,
		priority = 30,
		foodtype = FOODTYPE.MEAT,
		perishtime = TUNING.PERISH_PRESERVED,
		health = 30,
		hunger = 15,
		sanity = 10,
		cooktime = 48,
		nameoverride = "AGEDROE",
		overridebuild = "kyno_foodrecipes_jar1",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "kyno_roe_oceanfish_medium_1" }, amount = 1 },
			{ items = { "tag_spotspice" }, amount = 1 },
			{ items = { "kyno_salt" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_roe_oceanfish_medium_1" }, amount = 1 },
			{ items = { "kyno_spotspice" }, amount = 1 },
			{ items = { "kyno_salt" }, amount = 1 },
		},
	},
	
	agedroe_oceanfish_medium_2 =
	{
		test = function(brewer, names, tags) return names.kyno_roe_oceanfish_medium_2 and names.kyno_salt and names.kyno_spotspice end,
		priority = 30,
		foodtype = FOODTYPE.MEAT,
		perishtime = TUNING.PERISH_PRESERVED,
		health = 15,
		hunger = 30,
		sanity = 10,
		cooktime = 48,
		nameoverride = "AGEDROE",
		overridebuild = "kyno_foodrecipes_jar1",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "kyno_roe_oceanfish_medium_2" }, amount = 1 },
			{ items = { "tag_spotspice" }, amount = 1 },
			{ items = { "kyno_salt" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_roe_oceanfish_medium_2" }, amount = 1 },
			{ items = { "kyno_spotspice" }, amount = 1 },
			{ items = { "kyno_salt" }, amount = 1 },
		},
	},
	
	agedroe_oceanfish_medium_3 =
	{
		test = function(brewer, names, tags) return names.kyno_roe_oceanfish_medium_3 and names.kyno_salt and names.kyno_spotspice end,
		priority = 30,
		foodtype = FOODTYPE.MEAT,
		perishtime = TUNING.PERISH_PRESERVED,
		health = 15,
		hunger = 10,
		sanity = 30,
		cooktime = 48,
		nameoverride = "AGEDROE",
		overridebuild = "kyno_foodrecipes_jar1",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "kyno_roe_oceanfish_medium_3" }, amount = 1 },
			{ items = { "tag_spotspice" }, amount = 1 },
			{ items = { "kyno_salt" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_roe_oceanfish_medium_3" }, amount = 1 },
			{ items = { "kyno_spotspice" }, amount = 1 },
			{ items = { "kyno_salt" }, amount = 1 },
		},
	},
	
	agedroe_oceanfish_medium_4 =
	{
		test = function(brewer, names, tags) return names.kyno_roe_oceanfish_medium_4 and names.kyno_salt and names.kyno_spotspice end,
		priority = 30,
		foodtype = FOODTYPE.MEAT,
		perishtime = TUNING.PERISH_PRESERVED,
		health = 15,
		hunger = 30,
		sanity = 15,
		cooktime = 48,
		nameoverride = "AGEDROE",
		overridebuild = "kyno_foodrecipes_jar1",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "kyno_roe_oceanfish_medium_4" }, amount = 1 },
			{ items = { "tag_spotspice" }, amount = 1 },
			{ items = { "kyno_salt" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_roe_oceanfish_medium_4" }, amount = 1 },
			{ items = { "kyno_spotspice" }, amount = 1 },
			{ items = { "kyno_salt" }, amount = 1 },
		},
	},
	
	agedroe_oceanfish_medium_5 =
	{
		test = function(brewer, names, tags) return names.kyno_roe_oceanfish_medium_5 and names.kyno_salt and names.kyno_spotspice end,
		priority = 30,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_PRESERVED,
		health = 10,
		hunger = 30,
		sanity = 15,
		cooktime = 48,
		nameoverride = "AGEDROE",
		overridebuild = "kyno_foodrecipes_jar1",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "kyno_roe_oceanfish_medium_5" }, amount = 1 },
			{ items = { "tag_spotspice" }, amount = 1 },
			{ items = { "kyno_salt" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_roe_oceanfish_medium_5" }, amount = 1 },
			{ items = { "kyno_spotspice" }, amount = 1 },
			{ items = { "kyno_salt" }, amount = 1 },
		},
	},
	
	agedroe_oceanfish_medium_6 =
	{
		test = function(brewer, names, tags) return names.kyno_roe_oceanfish_medium_6 and names.kyno_salt and names.kyno_spotspice end,
		priority = 30,
		foodtype = FOODTYPE.MEAT,
		perishtime = TUNING.PERISH_PRESERVED,
		health = 30,
		hunger = 15,
		sanity = 20,
		cooktime = 48,
		nameoverride = "AGEDROE",
		overridebuild = "kyno_foodrecipes_jar1",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "kyno_roe_oceanfish_medium_6" }, amount = 1 },
			{ items = { "tag_spotspice" }, amount = 1 },
			{ items = { "kyno_salt" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_roe_oceanfish_medium_6" }, amount = 1 },
			{ items = { "kyno_spotspice" }, amount = 1 },
			{ items = { "kyno_salt" }, amount = 1 },
		},
	},
	
	agedroe_oceanfish_medium_7 =
	{
		test = function(brewer, names, tags) return names.kyno_roe_oceanfish_medium_7 and names.kyno_salt and names.kyno_spotspice end,
		priority = 30,
		foodtype = FOODTYPE.MEAT,
		perishtime = TUNING.PERISH_PRESERVED,
		health = 30,
		hunger = 20,
		sanity = 15,
		cooktime = 48,
		nameoverride = "AGEDROE",
		overridebuild = "kyno_foodrecipes_jar1",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "kyno_roe_oceanfish_medium_7" }, amount = 1 },
			{ items = { "tag_spotspice" }, amount = 1 },
			{ items = { "kyno_salt" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_roe_oceanfish_medium_7" }, amount = 1 },
			{ items = { "kyno_spotspice" }, amount = 1 },
			{ items = { "kyno_salt" }, amount = 1 },
		},
	},
	
	agedroe_oceanfish_medium_8 =
	{
		test = function(brewer, names, tags) return names.kyno_roe_oceanfish_medium_8 and names.kyno_salt and names.kyno_spotspice end,
		priority = 30,
		foodtype = FOODTYPE.MEAT,
		perishtime = TUNING.PERISH_PRESERVED,
		temperature = TUNING.COLD_FOOD_BONUS_TEMP,
		temperatureduration = TUNING.FOOD_TEMP_AVERAGE,
		health = 20,
		hunger = 15,
		sanity = 30,
		cooktime = 48,
		nameoverride = "AGEDROE",
		overridebuild = "kyno_foodrecipes_jar1",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "kyno_roe_oceanfish_medium_8" }, amount = 1 },
			{ items = { "tag_spotspice" }, amount = 1 },
			{ items = { "kyno_salt" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_roe_oceanfish_medium_8" }, amount = 1 },
			{ items = { "kyno_spotspice" }, amount = 1 },
			{ items = { "kyno_salt" }, amount = 1 },
		},
	},
	
	agedroe_oceanfish_medium_9 =
	{
		test = function(brewer, names, tags) return names.kyno_roe_oceanfish_medium_9 and names.kyno_salt and names.kyno_spotspice end,
		priority = 30,
		foodtype = FOODTYPE.MEAT,
		perishtime = TUNING.PERISH_PRESERVED,
		health = 15,
		hunger = 20,
		sanity = 30,
		cooktime = 48,
		nameoverride = "AGEDROE",
		overridebuild = "kyno_foodrecipes_jar1",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "kyno_roe_oceanfish_medium_9" }, amount = 1 },
			{ items = { "tag_spotspice" }, amount = 1 },
			{ items = { "kyno_salt" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_roe_oceanfish_medium_9" }, amount = 1 },
			{ items = { "kyno_spotspice" }, amount = 1 },
			{ items = { "kyno_salt" }, amount = 1 },
		},
	},

	agedroe_oceanfish_midnight_carp =
	{
		test = function(brewer, names, tags) return names.kyno_roe_oceanfish_midnight_carp and names.kyno_salt and names.kyno_spotspice end,
		priority = 30,
		foodtype = FOODTYPE.MEAT,
		perishtime = TUNING.PERISH_PRESERVED,
		health = 33,
		hunger = 25,
		sanity = 10,
		cooktime = 48,
		oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_DARKNESS,
		nameoverride = "AGEDROE",
		overridebuild = "kyno_foodrecipes_jar1",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "kyno_roe_oceanfish_midnight_carp" }, amount = 1 },
			{ items = { "tag_spotspice" }, amount = 1 },
			{ items = { "kyno_salt" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_roe_oceanfish_midnight_carp" }, amount = 1 },
			{ items = { "kyno_spotspice" }, amount = 1 },
			{ items = { "kyno_salt" }, amount = 1 },
		},
		prefabs = { "kyno_darknessbuff" },
		oneatenfn = function(inst, eater)
			eater:AddDebuff("kyno_darknessbuff", "kyno_darknessbuff")
		end,
	},

	agedroe_tropicalfish =
	{
		test = function(brewer, names, tags) return names.kyno_roe_tropicalfish and names.kyno_salt and names.kyno_spotspice end,
		priority = 30,
		foodtype = FOODTYPE.MEAT,
		perishtime = TUNING.PERISH_PRESERVED,
		health = 10,
		hunger = 15,
		sanity = 15,
		cooktime = 48,
		nameoverride = "AGEDROE",
		overridebuild = "kyno_foodrecipes_jar1",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "kyno_roe_tropicalfish" }, amount = 1 },
			{ items = { "tag_spotspice" }, amount = 1 },
			{ items = { "kyno_salt" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_roe_tropicalfish" }, amount = 1 },
			{ items = { "kyno_spotspice" }, amount = 1 },
			{ items = { "kyno_salt" }, amount = 1 },
		},
	},
	
	agedroe_pierrotfish =
	{
		test = function(brewer, names, tags) return names.kyno_roe_pierrotfish and names.kyno_salt and names.kyno_spotspice end,
		priority = 30,
		foodtype = FOODTYPE.MEAT,
		perishtime = TUNING.PERISH_PRESERVED,
		health = 15,
		hunger = 15,
		sanity = 10,
		cooktime = 48,
		nameoverride = "AGEDROE",
		overridebuild = "kyno_foodrecipes_jar1",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "kyno_roe_pierrotfish" }, amount = 1 },
			{ items = { "tag_spotspice" }, amount = 1 },
			{ items = { "kyno_salt" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_roe_pierrotfish" }, amount = 1 },
			{ items = { "kyno_spotspice" }, amount = 1 },
			{ items = { "kyno_salt" }, amount = 1 },
		},
	},

	agedroe_neonfish =
	{
		test = function(brewer, names, tags) return names.kyno_roe_neonfish and names.kyno_salt and names.kyno_spotspice end,
		priority = 30,
		foodtype = FOODTYPE.MEAT,
		perishtime = TUNING.PERISH_PRESERVED,
		health = 25,
		hunger = 20,
		sanity = 10,
		cooktime = 48,
		nameoverride = "AGEDROE",
		overridebuild = "kyno_foodrecipes_jar1",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "kyno_roe_neonfish" }, amount = 1 },
			{ items = { "tag_spotspice" }, amount = 1 },
			{ items = { "kyno_salt" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_roe_neonfish" }, amount = 1 },
			{ items = { "kyno_spotspice" }, amount = 1 },
			{ items = { "kyno_salt" }, amount = 1 },
		},
	},
	
	agedroe_grouper =
	{
		test = function(brewer, names, tags) return names.kyno_roe_grouper and names.kyno_salt and names.kyno_spotspice end,
		priority = 30,
		foodtype = FOODTYPE.MEAT,
		perishtime = TUNING.PERISH_PRESERVED,
		health = 10,
		hunger = 20,
		sanity = 25,
		cooktime = 48,
		nameoverride = "AGEDROE",
		overridebuild = "kyno_foodrecipes_jar1",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "kyno_roe_grouper" }, amount = 1 },
			{ items = { "tag_spotspice" }, amount = 1 },
			{ items = { "kyno_salt" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_roe_grouper" }, amount = 1 },
			{ items = { "kyno_spotspice" }, amount = 1 },
			{ items = { "kyno_salt" }, amount = 1 },
		},
	},

	agedroe_koi =
	{
		test = function(brewer, names, tags) return names.kyno_roe_koi and names.kyno_salt and names.kyno_spotspice end,
		priority = 30,
		foodtype = FOODTYPE.MEAT,
		perishtime = TUNING.PERISH_PRESERVED,
		health = 15,
		hunger = 20,
		sanity = 25,
		cooktime = 48,
		nameoverride = "AGEDROE",
		overridebuild = "kyno_foodrecipes_jar1",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "kyno_roe_koi" }, amount = 1 },
			{ items = { "tag_spotspice" }, amount = 1 },
			{ items = { "kyno_salt" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_roe_koi" }, amount = 1 },
			{ items = { "kyno_spotspice" }, amount = 1 },
			{ items = { "kyno_salt" }, amount = 1 },
		},
	},
	
	agedroe_salmonfish =
	{
		test = function(brewer, names, tags) return names.kyno_roe_salmonfish and names.kyno_salt and names.kyno_spotspice end,
		priority = 30,
		foodtype = FOODTYPE.MEAT,
		perishtime = TUNING.PERISH_PRESERVED,
		health = 10,
		hunger = 15,
		sanity = 15,
		cooktime = 48,
		nameoverride = "AGEDROE",
		overridebuild = "kyno_foodrecipes_jar1",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "kyno_roe_salmonfish" }, amount = 1 },
			{ items = { "tag_spotspice" }, amount = 1 },
			{ items = { "kyno_salt" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_roe_salmonfish" }, amount = 1 },
			{ items = { "kyno_spotspice" }, amount = 1 },
			{ items = { "kyno_salt" }, amount = 1 },
		},
	},
	
	agedroe_jellyfish =
	{
		test = function(brewer, names, tags) return names.kyno_roe_jellyfish and names.kyno_salt and names.kyno_spotspice end,
		priority = 30,
		foodtype = FOODTYPE.MEAT,
		perishtime = TUNING.PERISH_PRESERVED,
		health = 15,
		hunger = 15,
		sanity = 0,
		cooktime = 48,
		nameoverride = "AGEDROE",
		overridebuild = "kyno_foodrecipes_jar1",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "kyno_roe_jellyfish" }, amount = 1 },
			{ items = { "tag_spotspice" }, amount = 1 },
			{ items = { "kyno_salt" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_roe_jellyfish" }, amount = 1 },
			{ items = { "kyno_spotspice" }, amount = 1 },
			{ items = { "kyno_salt" }, amount = 1 },
		},
	},
	
	agedroe_jellyfish_rainbow =
	{
		test = function(brewer, names, tags) return names.kyno_roe_jellyfish_rainbow and names.kyno_salt and names.kyno_spotspice end,
		priority = 30,
		foodtype = FOODTYPE.MEAT,
		perishtime = TUNING.PERISH_PRESERVED,
		health = 15,
		hunger = 15,
		sanity = 15,
		cooktime = 48,
		oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_GLOW,
		nameoverride = "AGEDROE",
		overridebuild = "kyno_foodrecipes_jar1",
		floater = TUNING.HOF_FLOATER,
		prefabs = { "kyno_jellyfish_rainbow_light_greater" },
		required = 
		{
			{ items = { "kyno_roe_jellyfish_rainbow" }, amount = 1 },
			{ items = { "tag_spotspice" }, amount = 1 },
			{ items = { "kyno_salt" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_roe_jellyfish_rainbow" }, amount = 1 },
			{ items = { "kyno_spotspice" }, amount = 1 },
			{ items = { "kyno_salt" }, amount = 1 },
		},
		oneatenfn = function(inst, eater)
            if eater.wormlight ~= nil then
                if eater.wormlight.prefab == "kyno_jellyfish_rainbow_light_greater" then
                    eater.wormlight.components.spell.lifetime = 0
                    eater.wormlight.components.spell:ResumeSpell()
                    return
                else
                    eater.wormlight.components.spell:OnFinish()
                end
            end

            local light = SpawnPrefab("kyno_jellyfish_rainbow_light_greater")
            light.components.spell:SetTarget(eater)
			
            if light:IsValid() then
                if light.components.spell.target == nil then
                    light:Remove()
                else
                    light.components.spell:StartSpell()
                end
            end
        end,
	},
	
	agedroe_antchovy =
	{
		test = function(brewer, names, tags) return names.kyno_roe_antchovy and names.kyno_salt and names.kyno_spotspice end,
		priority = 30,
		foodtype = FOODTYPE.MEAT,
		perishtime = TUNING.PERISH_PRESERVED,
		health = 5,
		hunger = 10,
		sanity = 5,
		cooktime = 48,
		nameoverride = "AGEDROE",
		overridebuild = "kyno_foodrecipes_jar1",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "kyno_roe_antchovy" }, amount = 1 },
			{ items = { "tag_spotspice" }, amount = 1 },
			{ items = { "kyno_salt" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_roe_antchovy" }, amount = 1 },
			{ items = { "kyno_spotspice" }, amount = 1 },
			{ items = { "kyno_salt" }, amount = 1 },
		},
	},
	
	agedroe_swordfish_blue =
	{
		test = function(brewer, names, tags) return names.kyno_roe_swordfish_blue and names.kyno_salt and names.kyno_spotspice end,
		priority = 30,
		foodtype = FOODTYPE.MEAT,
		perishtime = TUNING.PERISH_PRESERVED,
		temperature = TUNING.COLD_FOOD_BONUS_TEMP,
		temperatureduration = TUNING.FOOD_TEMP_AVERAGE,
		health = 20,
		hunger = 25,
		sanity = 25,
		cooktime = 48,
		nameoverride = "AGEDROE",
		overridebuild = "kyno_foodrecipes_jar1",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "kyno_roe_swordfish_blue" }, amount = 1 },
			{ items = { "tag_spotspice" }, amount = 1 },
			{ items = { "kyno_salt" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_roe_swordfish_blue" }, amount = 1 },
			{ items = { "kyno_spotspice" }, amount = 1 },
			{ items = { "kyno_salt" }, amount = 1 },
		},
	},
}

for k, recipe in pairs(kyno_foods_jar) do
	recipe.name = k
	recipe.weight = 1
	recipe.overridebuild = recipe.overridebuild or k
	recipe.brewbook_category = "jar"
	recipe.cookbook_atlas = "images/cookbookimages/hof_brewbookimages.xml"
	recipe.cookbook_tex = k..".tex"
end

return kyno_foods_jar
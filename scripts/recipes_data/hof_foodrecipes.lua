local kyno_foods =
{
	coffee =
	{
		test = function(cooker, names, tags) return names.kyno_coffeebeans_cooked and (names.kyno_coffeebeans_cooked == 4 or 
		(names.kyno_coffeebeans_cooked == 3 and (tags.dairy or tags.sweetener or tags.sugar))) and not names.kyno_coffeebeans end,
		priority = 30,
		foodtype = FOODTYPE.GOODIES,
		perishtime = TUNING.PERISH_MED,
		temperature = TUNING.HOT_FOOD_BONUS_TEMP,
		temperatureduration = TUNING.FOOD_TEMP_BRIEF,
		health = 5,
		hunger = 9.375,
		sanity = -10,
		cooktime = 0.5,
		oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_SPEED,
		potlevel = "low",
		overridebuild = "kyno_foodrecipes_sw",
		floater = TUNING.HOF_FLOATER,
		tags = {"honeyed", "fooddrink", "nospice"},
		required = 
		{
			{ items = { "kyno_coffeebeans_cooked" }, amount = 3, comparator = "morethan" },
			{ items = { "honey", "tag_dairy", "tag_sweetener", "tag_sugar" }, amount = 1 },
		},
		excluded = 
		{
    		{ items = { "kyno_coffeebeans" } },
		},
		card_def = 
		{
			{ items = { "kyno_coffeebeans_cooked" }, amount = 3 },
			{ items = { "honey" }, amount = 1 },
		},
		oneatenfn = function(inst, eater)

		end,
		characterfood = {"winona"},
	},
	
	bisque =
	{
		test = function(cooker, names, tags) return (tags.limpet and tags.limpet >= 3) and tags.frozen end,
		priority = 30,
		foodtype = FOODTYPE.MEAT,
		perishtime = TUNING.PERISH_MED,
		temperature = TUNING.COLD_FOOD_BONUS_TEMP,
		temperatureduration = TUNING.FOOD_TEMP_AVERAGE,
		health = 60,
		hunger = 18.75,
		sanity = 5,
		cooktime = 1,
		potlevel = "med",
		overridebuild = "kyno_foodrecipes_sw",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "kyno_limpets" }, amount = 3, comparator = "morethan" },
			{ items = { "ice" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_limpets" }, amount = 3 },
			{ items = { "ice" }, amount = 1},
		},
	},
	
	jellyopop = 
	{
		test = function(cooker, names, tags) return tags.jellyfish and tags.frozen and names.twigs end,
		priority = 20,
		foodtype = FOODTYPE.MEAT,
		perishtime = TUNING.PERISH_SUPERFAST,
		temperature = TUNING.COLD_FOOD_BONUS_TEMP,
		temperatureduration = TUNING.FOOD_TEMP_AVERAGE,
		health = 20,
		hunger = 18.75,
		sanity = 10,
		cooktime = 0.5,
		potlevel = "med",
		overridebuild = "kyno_foodrecipes_sw",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "tag_jellyfish" }, amount = 1 },
			{ items = { "ice" }, amount = 1 },
			{ items = { "twigs" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "jellyfish" }, amount = 1 },
			{ items = { "ice" }, amount = 1 },
			{ items = { "twigs" }, amount = 1 },
		},
	},
	
	sharkfinsoup = 
	{
		test = function(cooker, names, tags) return names.kyno_shark_fin end,
		priority = 20,
		foodtype = FOODTYPE.MEAT,
		perishtime = TUNING.PERISH_MED,
		health = 40,
		hunger = 12.5,
		sanity = -10,
		cooktime = 1,
		oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_NAUGHTINESS,
		potlevel = "med",
		overridebuild = "kyno_foodrecipes_sw",
		floater = TUNING.HOF_FLOATER,
		luckitem = { luck = -TUNING.KYNO_LUCK_MEDLARGE },
		required = 
		{
			{ items = { "kyno_shark_fin" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_shark_fin" }, amount = 1},
			{ items = { "twigs" }, amount = 3 },
		},
		oneatenfn = function(inst, eater)
			OnFoodNaughtiness(inst, eater)
		end,
		characterfood = {"wes"},
	},
	
	tropicalbouillabaisse =
	{
		test = function(cooker, names, tags) return tags.fish and (names.eel or names.eel_cooked or names.pondeel) and (tags.wobster) 
		and (names.barnacle or names.barnacle_cooked) end,
		priority = 35,
		foodtype = FOODTYPE.MEAT,
		perishtime = TUNING.PERISH_MED,
		temperature = TUNING.COLD_FOOD_BONUS_TEMP,
		temperatureduration = TUNING.FOOD_TEMP_AVERAGE,
		health = 60,
		hunger = 37.5,
		sanity = 15,
		cooktime = 2,
		oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_SPEED,
		potlevel = "med",
		overridebuild = "kyno_foodrecipes_sw",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "tag_fish" }, amount = 1 },
			{ items = { "pondeel" }, amount = 1 },
			{ items = { "tag_wobster" }, amount = 1 },
			{ items = { "barnacle" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "pondfish" }, amount = 1 },
			{ items = { "pondeel" }, amount = 1 },
			{ items = { "wobster_sheller_land" }, amount = 1 },
			{ items = { "barnacle" }, amount = 1 },
		},
		oneatenfn = function(inst, eater)

		end,
	},
	
	feijoada =
	{
		test = function(cooker, names, tags) return (tags.beanbug and tags.beanbug >= 3) and tags.meat end,
		priority = 30,
		foodtype = FOODTYPE.MEAT,
		perishtime = TUNING.PERISH_FASTISH,
		health = 20,
		hunger = 75,
		sanity = 15,
		cooktime = 3.5,
		potlevel = "med",
		overridebuild = "kyno_foodrecipes_ham",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "kyno_beanbugs" }, amount = 3, comparator = "morethan" },
			{ items = { "tag_meat" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_beanbugs" }, amount = 3 },
			{ items = { "smallmeat" }, amount = 1 },
		},
		characterfood = {"willow"},
	},
	
	gummy_cake =
	{
		test = function(cooker, names, tags) return tags.gummybug and tags.sweetener end,
		priority = 1,
		foodtype = FOODTYPE.GOODIES,
		perishtime = TUNING.PERISH_PRESERVED,
		health = -3,
		hunger = 150,
		sanity = -5,
		cooktime = 2,
		potlevel = "med",
		overridebuild = "kyno_foodrecipes_ham",
		floater = TUNING.HOF_FLOATER,
		tags = {"honeyed"},
		required = 
		{
			{ items = { "kyno_gummybug" }, amount = 1 },
			{ items = { "tag_sweetener" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_gummybug" }, amount = 1 },
			{ items = { "honey" }, amount = 3 },
		},
		characterfood = {"wormwood"},
	},
	
	hardshell_tacos =
	{
		test = function(cooker, names, tags) return (names.slurtle_shellpieces and names.slurtle_shellpieces >= 2) and tags.veggie end,
		priority = 1,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_SLOW,
		health = 20,
		hunger = 37.5,
		sanity = 5,
		cooktime = 2,
		potlevel = "med",
		overridebuild = "kyno_foodrecipes_ham",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "slurtle_shellpieces" }, amount = 2, comparator = "morethan" },
			{ items = { "tag_veggie" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "slurtle_shellpieces" }, amount = 2 },
			{ items = { "carrot" }, amount = 2 },
		},
	},
	
	icedtea = 
	{
		test = function(cooker, names, tags) return (names.kyno_tealeaf and names.kyno_tealeaf >= 2) and tags.sweetener and tags.frozen end,
		priority = 30,
		foodtype = FOODTYPE.GOODIES,
		perishtime = TUNING.PERISH_MED,
		temperature = TUNING.COLD_FOOD_BONUS_TEMP,
		temperatureduration = TUNING.FOOD_TEMP_AVERAGE,
		health = 25,
		hunger = 12.5,
		sanity = 33,
		cooktime = 0.5,
		overridebuild = "kyno_foodrecipes_ham",
		floater = TUNING.HOF_FLOATER,
		tags = {"honeyed", "fooddrink"},
		required = 
		{
			{ items = { "kyno_tealeaf" }, amount = 2, comparator = "morethan" },
			{ items = { "tag_sweetener" }, amount = 1 },
			{ items = { "ice" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_tealeaf" }, amount = 2 },
			{ items = { "honey" }, amount = 1 },
			{ items = { "ice" }, amount = 1 },
		},
		characterfood = {"wendy"},
	},
	
	tea = 
	{
		test = function(cooker, names, tags) return (names.kyno_tealeaf and names.kyno_tealeaf >= 2) and tags.sweetener and not tags.frozen end,
		priority = 25,
		foodtype = FOODTYPE.GOODIES,
		perishtime = TUNING.PERISH_FAST,
		perishproduct = "icedtea",
		temperature = TUNING.HOT_FOOD_BONUS_TEMP,
		temperatureduration = TUNING.FOOD_TEMP_AVERAGE,
		health = 25,
		hunger = 12.5,
		sanity = 33,
		cooktime = 1,
		potlevel = "low",
		overridebuild = "kyno_foodrecipes_ham",
		floater = TUNING.HOF_FLOATER,
		tags = {"honeyed", "fooddrink"},
		required = 
		{
			{ items = { "kyno_tealeaf" }, amount = 2, comparator = "morethan" },
			{ items = { "tag_sweetener" }, amount = 1 },
		},
		excluded = 
		{
    		{ items = { "ice" } },
		},
		card_def = 
		{
			{ items = { "kyno_tealeaf" }, amount = 2 },
			{ items = { "honey" }, amount = 2 },
		},
		characterfood = {"wickerbottom"},
	},
	
	nettlelosange = 
	{
		test = function(cooker, names, tags) return tags.fireweed and not tags.meat end,
		priority = 1,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_FAST,
		temperature = TUNING.HOT_FOOD_BONUS_TEMP,
		temperatureduration = TUNING.BUFF_FOOD_TEMP_DURATION,
		health = 20,
		hunger = 25,
		sanity = -10,
		cooktime = .5,
		nochill = true,
		potlevel = "med",
		overridebuild = "kyno_foodrecipes_ham",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "tag_fireweed" }, amount = 1 },
		},
		excluded = 
		{
    		{ items = { "tag_meat" } },
		},
		card_def = 
		{
			{ items = { "firenettles" }, amount = 1 },
			{ items = { "twigs" }, amount = 3 },
		},
	},
	
	nettlemeated =
	{
		test = function(cooker, names, tags) return (tags.fireweed and tags.fireweed >= 2) and (tags.meat and tags.meat >= 1) 
		and (not tags.monster or tags.monster <= 1) and not tags.inedible end,
		priority = 1,
		foodtype = FOODTYPE.MEAT,
		perishtime = TUNING.PERISH_FASTISH,
		temperature = TUNING.HOT_FOOD_BONUS_TEMP,
		temperatureduration = TUNING.BUFF_FOOD_TEMP_DURATION,
		health = 20,
		hunger = 37.5,
		sanity = -5,
		cooktime = 1,
		nochill = true,
		potlevel = "high",
		overridebuild = "kyno_foodrecipes_ham",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "tag_fireweed" }, amount = 2, comparator = "morethan" },
			{ items = { "tag_meat" } amount = 1, comparator = "morethan" },
		},
		excluded = 
		{
    		{ items = { "twigs" } },
			{ items = { "tag_monster" }, amount = 1, comparator = "lessthan" },
		},
		card_def = 
		{
			{ items = { "firenettles" }, amount = 2 },
			{ items = { "smallmeat" }, amount = 2 },
		},
	},
	
	snakebonesoup = 
	{
		test = function(cooker, names, tags) return (names.kyno_worm_bone and names.kyno_worm_bone >= 2) and (tags.meat and tags.meat >= 2) 
		and not (names.kyno_humanmeat or names.kyno_humanmeat_cooked or names.kyno_humanmeat_dried) end,
		priority = 20,
		foodtype = FOODTYPE.MEAT,
		perishtime = TUNING.PERISH_SLOW,
		health = 40,
		hunger = 80,
		sanity = 20,
		cooktime = 1,
		oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_BONESOUP,
		potlevel = "med",
		overridebuild = "kyno_foodrecipes_ham",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "kyno_worm_bone" }, amount = 2, comparator = "morethan" },
			{ items = { "tag_meat" }, amount = 2, comparator = "morethan" },
		},
		excluded = 
		{
    		{ items = { "kyno_humanmeat", "kyno_humanmeat_cooked", "kyno_humanmeat_dried" } },
		},
		card_def = 
		{
			{ items = { "kyno_worm_bone" }, amount = 2 },
			{ items = { "meat" }, amount = 2 },
		},
		prefabs = { "kyno_wormbuff" },
		oneatenfn = function(inst, eater)
			eater:AddDebuff("kyno_wormbuff", "kyno_wormbuff")
		end,
	},
	
	steamedhamsandwich = 
	{
		test = function(cooker, names, tags) return ((names.meat or 0) + (names.meat_cooked or 0) >= 2) and tags.foliage and (tags.veggie and tags.veggie >= 1) end,
		priority = 15,
		foodtype = FOODTYPE.MEAT,
		perishtime = TUNING.PERISH_FAST,
		health = 30,
		hunger = 62.5,
		sanity = 15,
		cooktime = 2,
		potlevel = "med",
		overridebuild = "kyno_foodrecipes_ham",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "meat" }, amount = 2, comparator = "morethan" },
			{ items = { "tag_foliage" }, amount = 1 },
			{ items = { "tag_veggie" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "meat" }, amount = 2 },
			{ items = { "foliage" }, amount = 1 },
			{ items = { "carrot" }, amount = 1 },
		},
	},
	
	gorge_bread = 
	{
		test = function(cooker, names, tags) return (tags.flour and tags.flour >= 3) and not tags.spotspice end,
		priority = 1,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_SUPERSLOW,
		health = 1,
		hunger = 6.375,
		sanity = 0,
		cooktime = 1,
		stacksize = 3,
		potlevel = "med",
		overridebuild = "kyno_foodrecipes_gorge",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "tag_flour" }, amount = 3, comparator = "morethan" },
		},
		excluded = 
		{
    		{ items = { "tag_spotspice" } },
		},
		card_def = 
		{
			{ items = { "kyno_flour" }, amount = 4 },
		},
	},
	
	gorge_sweet_chips = 
	{
		test = function(cooker, names, tags) return ((names.kyno_sweetpotato or 0) + (names.kyno_sweetpotato_cooked or 0) >= 2) 
		and tags.oil and tags.spotspice end,
		priority = 35,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_FAST,
		health = 25,
		hunger = 75,
		sanity = 15,
		cooktime = 1.5,
		potlevel = "med",
		overridebuild = "kyno_foodrecipes_gorge",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "kyno_sweetpotato" }, amount = 2, comparator = "morethan" },
			{ items = { "tag_oil" }, amount = 1 },
			{ items = { "tag_spotspice" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_sweetpotato" }, amount = 2 },
			{ items = { "kyno_oil" }, amount = 1 },
			{ items = { "kyno_spotspice" }, amount = 1 },
		},
	},
	
	gorge_vegetable_soup =
	{
		test = function(cooker, names, tags) return (names.carrot or names.carrot_cooked) and (names.onion or names.onion_cooked) and
		(names.corn or names.corn_cooked) and tags.foliage and not (names.potato or names.potato_cooked) end,
		priority = 35,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_SLOW,
		health = 8,
		hunger = 25,
		sanity = 10,
		cooktime = 1,
		potlevel = "med",
		overridebuild = "kyno_foodrecipes_gorge",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "carrot" }, amount = 1 },
			{ items = { "onion" }, amount = 1 },
			{ items = { "corn" }, amount = 1 },
			{ items = { "foliage" }, amount = 1 },
		},
		excluded = 
		{
    		{ items = { "potato", "potato_cooked" } },
		},
		card_def = 
		{
			{ items = { "carrot" }, amount = 1 },
			{ items = { "onion" }, amount = 1 },
			{ items = { "corn" }, amount = 1 },
			{ items = { "foliage" }, amount = 1 },
		},
	},
	
	gorge_jelly_sandwich = 
	{
		test = function(cooker, names, tags) return tags.bread and tags.berries 
		and not tags.inedible and not tags.veggie and not tags.meat and not tags.fish end,
		priority = 35,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_MED,
		health = 3,
		hunger = 37.5,
		sanity = 15,
		cooktime = .5,
		potlevel = "med",
		overridebuild = "kyno_foodrecipes_gorge",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "tag_bread" }, amount = 1 },
			{ items = { "tag_berries" }, amount = 1 },
		},
		excluded = 
		{
    		{ items = { "tag_inedible" } },
			{ items = { "tag_veggie" } },
			{ items = { "tag_meat" } },
			{ items = { "tag_fish" } },
		},
		card_def = 
		{
			{ items = { "bread" }, amount = 1 },
			{ items = { "berries", "berries_juicy" }, amount = 3 },
		},
	},
	
	gorge_fish_stew =
	{
		test = function(cooker, names, tags) return (tags.salmon and tags.salmon >= 2) and (names.asparagus or names.asparagus_cooked) 
		and tags.spotspice and not names.twigs and not tags.bread end,
		priority = 30,
		foodtype = FOODTYPE.MEAT,
		perishtime = TUNING.PERISH_FASTISH,
		health = 20,
		hunger = 100,
		sanity = 5,
		cooktime = 2,
		potlevel = "med",
		overridebuild = "kyno_foodrecipes_gorge",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "tag_salmon" }, amount = 2, comparator = "morethan" },
			{ items = { "asparagus" }, amount = 1 },
			{ items = { "tag_spotspice" }, amount = 1 },
		},
		excluded = 
		{
			{ items = { "twigs" } },
			{ items = { "tag_bread "} },
		},
		card_def = 
		{
			{ items = { "kyno_salmonfish" }, amount = 2 },
			{ items = { "asparagus" }, amount = 1 },
			{ items = { "kyno_spotspice" }, amount = 1 },
		},
	},
	
	gorge_onion_cake =
	{
		test = function(cooker, names, tags) return ((names.kyno_turnip or 0) + (names.kyno_turnip_cooked or 0) >= 2) and tags.egg
		and tags.flour and not tags.dairy end,
		priority = 35,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_MED,
		health = 20,
		hunger = 37.5,
		sanity = 10,
		cooktime = .75,
		potlevel = "med",
		overridebuild = "kyno_foodrecipes_gorge",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "kyno_turnip" }, amount = 2, comparator = "morethan" },
			{ items = { "tag_egg" }, amount = 1 },
			{ items = { "tag_flour" }, amount = 1 },
		},
		excluded = 
		{
    		{ items = { "tag_dairy" } },
		},
		card_def = 
		{
			{ items = { "kyno_turnip" }, amount = 2 },
			{ items = { "bird_egg" }, amount = 1 },
			{ items = { "kyno_flour" }, amount = 1 },
		},
	},
	
	gorge_potato_pancakes = 
	{
		test = function(cooker, names, tags) return ((names.potato or 0) + (names.potato_cooked or 0) >= 3) and tags.flour and not tags.egg and not tags.fish end,
		priority = 35,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_MED,
		health = 40,
		hunger = 40,
		sanity = 40,
		cooktime = 1.5,
		potlevel = "med",
		overridebuild = "kyno_foodrecipes_gorge",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "potato" }, amount = 3, comparator = "morethan" },
			{ items = { "tag_flour" }, amount = 1 },
		},
		excluded = 
		{
    		{ items = { "tag_egg" } },
			{ items = { "tag_fish" } },
		},
		card_def = 
		{
			{ items = { "potato" }, amount = 3 },
			{ items = { "kyno_flour" }, amount = 1 },
		},
	},
	
	gorge_potato_soup = 
	{
		test = function(cooker, names, tags) return ((names.potato or 0) + (names.potato_cooked or 0) >= 3) and tags.succulent end,
		priority = 35,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_MED,
		health = 60,
		hunger = 75,
		sanity = 15,
		cooktime = 1,
		potlevel = "med",
		overridebuild = "kyno_foodrecipes_gorge",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "potato" }, amount = 3, comparator = "morethan" },
			{ items = { "tag_succulent" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "potato" }, amount = 3 },
			{ items = { "succulent_picked" }, amount = 1 },
		},
		characterfood = {"wolfgang"},
	},
	
	gorge_fishball_skewers = 
	{
		test = function(cooker, names, tags) return tags.fish and names.twigs and tags.spotspice end,
		priority = 35,
		foodtype = FOODTYPE.MEAT,
		perishtime = TUNING.PERISH_FAST,
		health = 25,
		hunger = 37.5,
		sanity = 20,
		cooktime = 2,
		potlevel = "med",
		overridebuild = "kyno_foodrecipes_gorge",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "tag_fish" }, amount = 1 },
			{ items = { "twigs" }, amount = 1 },
			{ items = { "tag_spotspice" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "pondfish" }, amount = 2 },
			{ items = { "twigs" }, amount = 1 },
			{ items = { "kyno_spotspice" }, amount = 1 },
		},
	},
	
	gorge_meat_skewers =
	{
		test = function(cooker, names, tags) return (tags.bacon and tags.bacon >= 2) and names.twigs and tags.spotspice end,
		priority = 35,
		foodtype = FOODTYPE.MEAT,
		perishtime = TUNING.PERISH_FASTISH,
		health = 20,
		hunger = 37.5,
		sanity = 5,
		cooktime = 1,
		potlevel = "med",
		overridebuild = "kyno_foodrecipes_gorge",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "kyno_bacon" }, amount = 2, comparator = "morethan" },
			{ items = { "twigs" }, amount = 1 },
			{ items = { "tag_spotspice" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_bacon" }, amount = 2 },
			{ items = { "twigs" }, amount = 1 },
			{ items = { "kyno_spotspice" }, amount = 1 },
		},
	},
	
	gorge_stone_soup = 
	{
		test = function(cooker, names, tags) return names.rocks and tags.veggie end,
		priority = 1,
		foodtype = FOODTYPE.VEGGIE,
		secondaryfoodtype = FOODTYPE.ELEMENTAL,
		perishtime = TUNING.PERISH_SLOW,
		health = -10,
		hunger = 25,
		sanity = 5,
		cooktime = .60,
		potlevel = "med",
		overridebuild = "kyno_foodrecipes_gorge",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "rocks" }, amount = 1 },
			{ items = { "tag_veggie" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "rocks" }, amount = 3 },
			{ items = { "carrot" }, amount = 1 },
		},
	},
	
	gorge_croquette = 
	{
		test = function(cooker, names, tags) return (names.potato and names.potato >= 2) and tags.egg and tags.flour and not names.potato_cooked end,
		priority = 35,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_MED,
		health = 30,
		hunger = 50,
		sanity = 10,
		cooktime = .75,
		potlevel = "med",
		overridebuild = "kyno_foodrecipes_gorge",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "potato" }, amount = 2, comparator = "morethan" },
			{ items = { "tag_egg" }, amount = 1 },
			{ items = { "tag_flour" }, amount = 1 },
		},
		excluded = 
		{
    		{ items = { "potato_cooked" } },
		},
		card_def = 
		{
			{ items = { "potato" }, amount = 2 },
			{ items = { "bird_egg" }, amount = 1 },
			{ items = { "kyno_flour" }, amount = 1 },
		},
	},
	
	gorge_roast_vegetables = 
	{
		test = function(cooker, names, tags) return names.onion_cooked and names.asparagus_cooked and names.garlic_cooked and names.carrot_cooked end,
		priority = 30,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_FAST,
		health = 25,
		hunger = 40,
		sanity = 20,
		cooktime = 1,
		potlevel = "med",
		overridebuild = "kyno_foodrecipes_gorge",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "onion_cooked" }, amount = 1 },
			{ items = { "asparagus_cooked" }, amount = 1 },
			{ items = { "garlic_cooked" }, amount = 1 },
			{ items = { "carrot_cooked" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "onion_cooked" }, amount = 1 },
			{ items = { "asparagus_cooked" }, amount = 1 },
			{ items = { "garlic_cooked" }, amount = 1 },
			{ items = { "carrot_cooked" }, amount = 1 },
		},
	},
	
	gorge_meatloaf =
	{
		test = function(cooker, names, tags) return (tags.bacon and tags.bacon >= 2) and tags.flour and tags.veggie and not tags.foliage end,
		priority = 35,
		foodtype = FOODTYPE.MEAT,
		perishtime = TUNING.PERISH_MED,
		health = 30,
		hunger = 25,
		sanity = 5,
		cooktime = 1.5,
		potlevel = "low",
		overridebuild = "kyno_foodrecipes_gorge",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "kyno_bacon" }, amount = 2, comparator = "morethan" },
			{ items = { "tag_flour" }, amount = 1 },
			{ items = { "tag_veggie" }, amount = 1 },
		},
		excluded = 
		{
    		{ items = { "tag_foliage" } },
		},
		card_def = 
		{
			{ items = { "kyno_bacon" }, amount = 2 },
			{ items = { "kyno_flour" }, amount = 1 },
			{ items = { "carrot" }, amount = 1 },
		},
	},
	
	gorge_carrot_soup =
	{
		test = function(cooker, names, tags) return ((names.carrot or 0) + (names.carrot_cooked or 0) >= 3) and tags.spotspice end,
		priority = 15,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_MED,
		health = 10,
		hunger = 37.5,
		sanity = 10,
		cooktime = 2,
		potlevel = "med",
		overridebuild = "kyno_foodrecipes_gorge",
		floater = TUNING.HOF_FLOATER,
		tags = {"sammyfood"},
		required = 
		{
			{ items = { "carrot" }, amount = 3, comparator = "morethan" },
			{ items = { "tag_spotspice" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "carrot" }, amount = 3 },
			{ items = { "kyno_spotspice" }, amount = 1 },
		},
	},
	
	gorge_fishpie =
	{
		test = function(cooker, names, tags) return tags.salmon and tags.flour and tags.veggie 
		and not tags.bread end,
		priority = 30,
		foodtype = FOODTYPE.MEAT,
		perishtime = TUNING.PERISH_MED,
		health = 40,
		hunger = 62.5,
		sanity = 5,
		cooktime = 1.5,
		potlevel = "med",
		overridebuild = "kyno_foodrecipes_gorge",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "tag_salmon" }, amount = 1 },
			{ items = { "tag_flour" }, amount = 1 },
			{ items = { "tag_veggie" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_salmonfish" }, amount = 1 },
			{ items = { "kyno_flour" }, amount = 1 },
			{ items = { "carrot" }, amount = 2 },
		},
	},

	gorge_fishchips =
	{
		test = function(cooker, names, tags) return tags.fish and tags.flour and ((names.potato or 0) + (names.potato_cooked or 0) >= 2) end,
		priority = 35,
		foodtype = FOODTYPE.MEAT,
		perishtime = TUNING.PERISH_MED,
		health = 50,
		hunger = 85,
		sanity = 15,
		cooktime = 2,
		potlevel = "med",
		overridebuild = "kyno_foodrecipes_gorge",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "tag_fish" }, amount = 1 },
			{ items = { "tag_flour" }, amount = 1 },
			{ items = { "potato" }, amount = 2, comparator = "morethan" },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "pondfish" }, amount = 1 },
			{ items = { "kyno_flour" }, amount = 1 },
			{ items = { "potato" }, amount = 2 },
		},
	},
	
	gorge_meatpie = 
	{
		test = function(cooker, names, tags) return tags.meat and (tags.flour and tags.flour >= 2) and tags.veggie and not (names.potato or names.potato_cooked) 
		and not (names.onion or names.onion_cooked) and not tags.bacon end,
		priority = 35,
		foodtype = FOODTYPE.MEAT,
		perishtime = TUNING.PERISH_SLOW,
		health = 3,
		hunger = 50,
		sanity = 25,
		cooktime = 2,
		potlevel = "low",
		overridebuild = "kyno_foodrecipes_gorge",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "tag_meat" }, amount = 1 },
			{ items = { "tag_flour" }, amount = 2, comparator = "morethan" },
			{ items = { "tag_veggie" }, amount = 1 },
		},
		excluded = 
		{
    		{ items = { "potato", "potato_cooked" } },
			{ items = { "onion", "onion" } },
			{ items = { "kyno_bacon", "kyno_bacon_cooked" } },
		},
		card_def = 
		{
			{ items = { "meat" }, amount = 1 },
			{ items = { "kyno_flour" }, amount = 2 },
			{ items = { "carrot" }, amount = 1 },
		},
	},
	
	gorge_sliders = 
	{
		test = function(cooker, names, tags) return (tags.bacon and tags.bacon >= 2) and names.littlebread and tags.foliage end,
		priority = 35,
		foodtype = FOODTYPE.MEAT,
		perishtime = TUNING.PERISH_MED,
		health = 5,
		hunger = 12.5,
		sanity = 25,
		cooktime = 0.5,
		potlevel = "med",
		overridebuild = "kyno_foodrecipes_gorge",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "kyno_bacon" }, amount = 2, comparator = "morethan" },
			{ items = { "littlebread" }, amount = 1 },
			{ items = { "tag_foliage" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_bacon" }, amount = 2 },
			{ items = { "littlebread" }, amount = 1 },
			{ items = { "foliage" }, amount = 1 },
		},
		characterfood = {"woodie"},
	},
	
	gorge_jelly_roll = 
	{
		test = function(cooker, names, tags) return (tags.berries and tags.berries >= 3) and tags.flour 
		and not tags.syrup and not tags.sweetener and not tags.dairy and not tags.meat end,
		priority = 35,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_FAST,
		health = 8,
		hunger = 25,
		sanity = 15,
		cooktime = .5,
		potlevel = "med",
		overridebuild = "kyno_foodrecipes_gorge",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "tag_berries" }, amount = 3, comparator = "morethan" },
			{ items = { "tag_flour" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "berries" }, amount = 3 },
			{ items = { "kyno_flour" }, amount = 1 },
		},
	},
	
	gorge_carrot_cake =
	{
		test = function(cooker, names, tags) return (names.carrot and names.carrot >= 2) and tags.egg and tags.flour 
		and not tags.spotspice and not names.carrot_cooked end,
		priority = 20,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_FAST,
		health = 15,
		hunger = 37.5,
		sanity = 5,
		cooktime = .75,
		oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_CAKE,
		potlevel = "med",
		overridebuild = "kyno_foodrecipes_gorge",
		floater = TUNING.HOF_FLOATER,
		tags = {"sammyfood"},
		required = 
		{
			{ items = { "carrot" }, amount = 2, comparator = "morethan" },
			{ items = { "tag_egg" }, amount = 1 },
			{ items = { "tag_flour" }, amount = 1 },
		},
		excluded = 
		{
    		{ items = { "carrot_cooked" } },
		},
		card_def = 
		{
			{ items = { "carrot" }, amount = 2 },
			{ items = { "bird_egg" }, amount = 1 },
			{ items = { "kyno_flour" }, amount = 1 },
		},
		oneatenfn = function(inst, eater)
		
		end,
	},
	
	gorge_garlicmashed =
	{
		test = function(cooker, names, tags) return ((names.garlic or 0) + (names.garlic_cooked or 0) >= 2) and 
		(names.potato or names.potato_cooked) and tags.spotspice and not tags.bread and not tags.meat and not tags.fish end,
		priority = 35,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_MED,
		health = 30,
		hunger = 37.5,
		sanity = 15,
		cooktime = .60,
		potlevel = "med",
		overridebuild = "kyno_foodrecipes_gorge",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "garlic" }, amount = 2, comparator = "morethan" },
			{ items = { "potato" }, amount = 1 },
			{ items = { "tag_spotspice" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "garlic" }, amount = 2 },
			{ items = { "potato" }, amount = 1 },
			{ items = { "kyno_spotspice" }, amount = 1 },
		},
	},
	
	gorge_garlicbread = 
	{
		test = function(cooker, names, tags) return tags.bread and ((names.garlic or 0) + (names.garlic_cooked or 0) >= 2) 
		and not tags.meat and not tags.fish end,
		priority = 35,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_SLOW,
		health = 30,
		hunger = 37.5,
		sanity = 5,
		cooktime = 1.5,
		potlevel = "med",
		overridebuild = "kyno_foodrecipes_gorge",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "tag_bread" }, amount = 1 },
			{ items = { "garlic" }, amount = 2, comparator = "morethan" },
		},
		excluded = 
		{
    		{ items = { "tag_meat" } },
			{ items = { "tag_fish" } },
		},
		card_def = 
		{
			{ items = { "bread" }, amount = 1 },
			{ items = { "garlic" }, amount = 3 },
		},
	},
	
	gorge_tomato_soup = 
	{
		test = function(cooker, names, tags) return ((names.tomato or 0) + (names.tomato_cooked or 0) >= 3) and tags.spotspice 
		and not tags.bread and not tags.meat and not tags.dairy end,
		priority = 35,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_SLOW,
		health = 25,
		hunger = 50,
		sanity = 15,
		cooktime = 1,
		potlevel = "med",
		overridebuild = "kyno_foodrecipes_gorge",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "tomato" }, amount = 3, comparator = "morethan" },
			{ items = { "tag_spotspice" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "tomato" }, amount = 3 },
			{ items = { "kyno_spotspice" }, amount = 1 },
		},
	},
	
	gorge_sausage =
	{
		test = function(cooker, names, tags) return (tags.bacon and tags.bacon >= 3) 
		and tags.spotspice and not tags.inedible end,
		priority = 35,
		foodtype = FOODTYPE.MEAT,
		perishtime = TUNING.PERISH_MED,
		health = 30,
		hunger = 37.5,
		sanity = 10,
		cooktime = 0.8,
		potlevel = "med",
		overridebuild = "kyno_foodrecipes_gorge",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "kyno_bacon" }, amount = 3, comparator = "morethan" },
			{ items = { "tag_spotspice" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_bacon" }, amount = 3 },
			{ items = { "kyno_spotspice" }, amount = 1 },
		},
	},
	
	gorge_candiedfish =
	{
		test = function(cooker, names, tags) return tags.salmon and tags.syrup end,
		priority = 35,
		foodtype = FOODTYPE.MEAT,
		perishtime = TUNING.PERISH_MED,
		health = 5,
		hunger = 25,
		sanity = 60,
		cooktime = 1.5,
		potlevel = "low",
		overridebuild = "kyno_foodrecipes_gorge",
		floater = TUNING.HOF_FLOATER,
		tags = {"honeyed"},
		required = 
		{
			{ items = { "tag_salmon" }, amount = 1 },
			{ items = { "tag_syrup" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_salmonfish" }, amount = 2 },
			{ items = { "kyno_syrup" }, amount = 2 },
		},
	},
	
	gorge_stuffedmushroom =
	{
		test = function(cooker, names, tags) return ((names.kyno_white_cap or 0) + (names.kyno_white_cap_cooked or 0) >= 3) 
		and not tags.foliage and not tags.succulent and not tags.dairy and not names.royal_jelly end,
		priority = 35,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_MED,
		health = 15,
		hunger = 20,
		sanity = 10,
		cooktime = 0.8,
		potlevel = "low",
		overridebuild = "kyno_foodrecipes_gorge",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "kyno_white_cap" }, amount = 3, comparator = "morethan" },
		},
		excluded = 
		{
    		{ items = { "tag_foliage" } },
			{ items = { "tag_succulent" } },
			{ items = { "tag_dairy" } },
			{ items = { "royal_jelly" } },
		},
		card_def = 
		{
			{ items = { "kyno_white_cap" }, amount = 3 },
			{ items = { "carrot" }, amount = 1 },
		},
	},
	
	gorge_bruschetta = 
	{
		test = function(cooker, names, tags) return tags.bread and tags.spotspice and ((names.tomato or 0) + (names.tomato_cooked or 0) >= 2) end,
		priority = 35,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_SLOW,
		health = 50,
		hunger = 62.5,
		sanity = 10,
		cooktime = 1.7,
		potlevel = "med",
		overridebuild = "kyno_foodrecipes_gorge",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "tag_bread" }, amount = 1 },
			{ items = { "tag_spotspice" }, amount = 1 },
			{ items = { "tomato" }, amount = 2 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "bread" }, amount = 1 },
			{ items = { "kyno_spotspice" }, amount = 1 },
			{ items = { "tomato" }, amount = 2 },
		},
	},
	
	gorge_hamburger =
	{
		test = function(cooker, names, tags) return tags.bread and tags.meat and tags.bacon and 
		tags.foliage and not tags.fish and not tags.dairy and not (tags.bacon and tags.bacon > 1) end,
		priority = 35,
		foodtype = FOODTYPE.MEAT,
		perishtime = TUNING.PERISH_FASTISH,
		health = 5,
		hunger = 80,
		sanity = 5,
		cooktime = 1,
		potlevel = "med",
		overridebuild = "kyno_foodrecipes_gorge",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "tag_bread" }, amount = 1 },
			{ items = { "tag_meat" }, amount = 1 },
			{ items = { "kyno_bacon" }, amount = 1 },
			{ items = { "tag_foliage" }, amount = 1 },
		},
		excluded = 
		{
    		{ items = { "tag_fish" } },
			{ items = { "tag_dairy" } },
			{ items = { "kyno_bacon", "kyno_bacon_cooked" }, amount = 1, comparator = "morethan" },
		},
		card_def = 
		{
			{ items = { "bread" }, amount = 1 },
			{ items = { "meat" }, amount = 1 },
			{ items = { "kyno_bacon" }, amount = 1 },
			{ items = { "foliage" }, amount = 1 },
		},
	},
	
	gorge_fishburger =
	{
		test = function(cooker, names, tags) return tags.bread and tags.salmon and tags.foliage end,
		priority = 35,
		foodtype = FOODTYPE.MEAT,
		perishtime = TUNING.PERISH_FASTISH,
		health = 20,
		hunger = 80,
		sanity = 5,
		cooktime = 1.5,
		potlevel = "med",
		overridebuild = "kyno_foodrecipes_gorge",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "tag_bread" }, amount = 1 },
			{ items = { "tag_salmon" }, amount = 1 },
			{ items = { "tag_foliage" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "bread" }, amount = 1 },
			{ items = { "kyno_salmonfish" }, amount = 1 },
			{ items = { "foliage" }, amount = 2 },
		},
	},
	
	gorge_mushroomburger =
	{
		test = function(cooker, names, tags) return tags.bread and 
		((names.kyno_white_cap or 0) + (names.kyno_white_cap_cooked or 0) >= 2) and tags.foliage end,
		priority = 35,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_MED,
		health = 5,
		hunger = 80,
		sanity = 30,
		cooktime = .70,
		potlevel = "med",
		overridebuild = "kyno_foodrecipes_gorge",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "tag_bread" }, amount = 1 },
			{ items = { "kyno_white_cap" }, amount = 2, comparator = "morethan" },
			{ items = { "tag_foliage" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "bread" }, amount = 1 },
			{ items = { "kyno_white_cap" }, amount = 2 },
			{ items = { "foliage" }, amount = 1 },
		},
	},
	
	gorge_fish_steak =
	{
		test = function(cooker, names, tags) return names.kyno_salmonfish_cooked and tags.foliage and tags.spotspice and not names.kyno_salmonfish end,
		priority = 40,
		foodtype = FOODTYPE.MEAT,
		perishtime = TUNING.PERISH_MED,
		health = 15,
		hunger = 150,
		sanity = 15,
		cooktime = 1.2,
		potlevel = "med",
		overridebuild = "kyno_foodrecipes_gorge",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "kyno_salmonfish_cooked" }, amount = 1 },
			{ items = { "tag_foliage" }, amount = 1 },
			{ items = { "tag_spotspice" }, amount = 1 },
		},
		excluded = 
		{
    		{ items = { "kyno_salmonfish" } },
		},
		card_def = 
		{
			{ items = { "kyno_salmonfish_cooked" }, amount = 1 },
			{ items = { "foliage" }, amount = 1 },
			{ items = { "kyno_spotspice" }, amount = 2 },
		},
	},
	
	gorge_curry = 
	{
		test = function(cooker, names, tags) return tags.meat and tags.veggie and (tags.spotspice and tags.spotspice >= 2) end,
		priority = 15,
		foodtype = FOODTYPE.MEAT,
		secondaryfoodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_SLOW,
		health = 10,
		hunger = 75,
		sanity = 15,
		cooktime = 2,
		potlevel = "med",
		overridebuild = "kyno_foodrecipes_gorge",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "tag_meat" }, amount = 1 },
			{ items = { "tag_veggie" }, amount = 1 },
			{ items = { "tag_spotspice" }, amount = 2, comparator = "morethan" },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "meat" }, amount = 1 },
			{ items = { "carrot" }, amount = 1 },
			{ items = { "kyno_spotspice" }, amount = 2 },
		},
	},
	
	gorge_spaghetti =
	{
		test = function(cooker, names, tags) return tags.meat and tags.flour and tags.spotspice and (names.tomato or names.tomato_cooked) end,
		priority = 35,
		foodtype = FOODTYPE.MEAT,
		perishtime = TUNING.PERISH_MED,
		health = 8,
		hunger = 80,
		sanity = 25,
		cooktime = 2,
		potlevel = "med",
		overridebuild = "kyno_foodrecipes_gorge",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "meat" }, amount = 1 },
			{ items = { "tag_flour" }, amount = 1 },
			{ items = { "tag_spotspice" }, amount = 1 },
			{ items = { "tomato" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "meat" }, amount = 1 },
			{ items = { "kyno_flour" }, amount = 1 },
			{ items = { "kyno_spotspice" }, amount = 1 },
			{ items = { "tomato" }, amount = 1 },
		},
	},
	
	gorge_poachedfish =
	{
		test = function(cooker, names, tags) return tags.salmon and (tags.foliage and tags.foliage >= 2) and tags.spotspice and not names.twigs end,
		priority = 35,
		foodtype = FOODTYPE.MEAT,
		perishtime = TUNING.PERISH_FAST,
		health = 40,
		hunger = 25,
		sanity = 25,
		cooktime = 1.5,
		potlevel = "med",
		overridebuild = "kyno_foodrecipes_gorge",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "tag_salmon" }, amount = 1 },
			{ items = { "tag_foliage" }, amount = 2, comparator = "morethan" },
			{ items = { "tag_spotspice" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_salmonfish" }, amount = 1 },
			{ items = { "foliage" }, amount = 2 },
			{ items = { "kyno_spotspice" }, amount = 1 },
		},
	},
	
	gorge_shepherd_pie =
	{
		test = function(cooker, names, tags) return tags.meat and (names.onion or names.onion_cooked) 
		and (names.garlic or names.garlic_cooked) and tags.spotspice end,
		priority = 35,
		foodtype = FOODTYPE.MEAT,
		perishtime = TUNING.PERISH_SLOW,
		health = 20,
		hunger = 150,
		sanity = 10,
		cooktime = 1,
		potlevel = "med",
		overridebuild = "kyno_foodrecipes_gorge",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "tag_meat" }, amount = 1 },
			{ items = { "onion" }, amount = 1 },
			{ items = { "garlic" }, amount = 1 },
			{ items = { "tag_spotspice" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "meat" }, amount = 1 },
			{ items = { "onion" }, amount = 1 },
			{ items = { "garlic" }, amount = 1 },
			{ items = { "kyno_spotspice" }, amount = 1 },
		},
	},
	
	gorge_candy =
	{
		test = function(cooker, names, tags) return tags.syrup and (tags.sweetener and tags.sweetener >= 4) end,
		priority = 35,
		foodtype = FOODTYPE.GOODIES,
		perishtime = TUNING.PERISH_SUPERSLOW,
		health = 0,
		hunger = 20,
		sanity = 33,
		cooktime = .75,
		oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_HANDS,
		potlevel = "med",
		overridebuild = "kyno_foodrecipes_gorge",
		floater = TUNING.HOF_FLOATER,
		tags = {"honeyed"},
		required = 
		{
			{ items = { "tag_syrup" }, amount = 1 },
			{ items = { "tag_sweetener" }, amount = 3, comparator = "morethan" },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_syrup" }, amount = 1 },
			{ items = { "honey" }, amount = 3 },
		},
		prefabs = { "kyno_hastebuff" },
        oneatenfn = function(inst, eater)
            eater:AddDebuff("kyno_hastebuff", "kyno_hastebuff")
        end,
		characterfood = {"wanda"},
	},
	
	gorge_bread_pudding = 
	{
		test = function(cooker, names, tags) return tags.berries and (tags.flour and tags.flour >= 2)
		and tags.syrup end,
		priority = 20,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_SLOW,
		health = 15,
		hunger = 40,
		sanity = 40,
		cooktime = 1.2,
		potlevel = "med",
		overridebuild = "kyno_foodrecipes_gorge",
		floater = TUNING.HOF_FLOATER,
		tags = {"honeyed"},
		required = 
		{
			{ items = { "tag_berries" }, amount = 1 },
			{ items = { "tag_flour" }, amount = 2, comparator = "morethan" },
			{ items = { "tag_syrup" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "berries" }, amount = 1 },
			{ items = { "kyno_flour" }, amount = 2 },
			{ items = { "kyno_syrup" }, amount = 1 },
		},
	},
	
	gorge_berry_tart =
	{
		test = function(cooker, names, tags) return (tags.berries and tags.berries >= 2) and tags.flour
		and tags.sweetener and not tags.syrup end,
		priority = 35,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_MED,
		health = 25,
		hunger = 20,
		sanity = 15,
		cooktime = 1.2,
		potlevel = "med",
		overridebuild = "kyno_foodrecipes_gorge",
		floater = TUNING.HOF_FLOATER,
		tags = {"honeyed"},
		required = 
		{
			{ items = { "tag_berries" }, amount = 2, comparator = "morethan" },
			{ items = { "tag_flour" }, amount = 1 },
			{ items = { "tag_sweetener" }, amount = 1 },
		},
		excluded = 
		{
    		{ items = { "tag_syrup" } },
		},
		card_def = 
		{
			{ items = { "berries" }, amount = 2 },
			{ items = { "kyno_flour" }, amount = 1 },
			{ items = { "honey" }, amount = 1 },
		},
	},
	
	gorge_macaroni =
	{
		test = function(cooker, names, tags) return (tags.flour and tags.flour >= 2) and tags.milk and not tags.fish and not tags.meat 
		and not tags.bread and not tags.fruit and not tags.syrup end,
		priority = 35,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_FAST,
		health = 20,
		hunger = 37.5,
		sanity = 50,
		cooktime = 1,
		potlevel = "med",
		overridebuild = "kyno_foodrecipes_gorge",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "tag_flour" }, amount = 2, comparator = "morethan" },
			{ items = { "tag_milk" }, amount = 1 },
		},
		excluded = 
		{
    		{ items = { "tag_fish" } },
			{ items = { "tag_meat" } },
			{ items = { "tag_bread" } },
			{ items = { "tag_fruit" } },
			{ items = { "tag_syrup" } },
		},
		card_def = 
		{
			{ items = { "kyno_flour" }, amount = 2 },
			{ items = { "goatmilk" }, amount = 2 },
		},
	},
	
	gorge_bagel_and_fish = 
	{
		test = function(cooker, names, tags) return tags.bread and tags.milk and tags.salmon and tags.spotspice end,
		priority = 35,
		foodtype = FOODTYPE.MEAT,
		perishtime = TUNING.PERISH_FASTISH,
		health = 50,
		hunger = 75,
		sanity = 50,
		cooktime = 2,
		potlevel = "med",
		overridebuild = "kyno_foodrecipes_gorge",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "tag_bread" }, amount = 1 },
			{ items = { "tag_milk" }, amount = 1 },
			{ items = { "tag_salmon" }, amount = 1 },
			{ items = { "tag_spotspice"}, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "bread" }, amount = 1 },
			{ items = { "goatmilk" }, amount = 1 },
			{ items = { "kyno_salmonfish" }, amount = 1 },
			{ items = { "kyno_spotspice" }, amount = 1 },
		},
	},
	
	gorge_grilled_cheese =
	{
		test = function(cooker, names, tags) return tags.bread and (tags.dairy or tags.cheese) and not tags.fish and not tags.meat 
		and not tags.spotspice and not (tags.inedible and tags.inedible > 1) end,
		priority = 35,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_FAST,
		health = 60,
		hunger = 50,
		sanity = 40,
		cooktime = 0.5,
		potlevel = "low",
		overridebuild = "kyno_foodrecipes_gorge",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "tag_bread" }, amount = 1 },
			{ items = { "tag_dairy", "tag_cheese" }, amount = 1 },
		},
		excluded = 
		{
    		{ items = { "tag_fish" } },
			{ items = { "tag_meat" } },
			{ items = { "tag_spotspice" } },
			{ items = { "tag_inedible"}, amount = 1, comparator = "morethan" },
		},
		card_def = 
		{
			{ items = { "bread" }, amount = 2 },
			{ items = { "cheese_yellow" }, amount = 1 },
			{ items = { "twigs" }, amount = 1 },
		},
	},
	
	gorge_creammushroom = 
	{
		test = function(cooker, names, tags) return tags.milk and ((names.kyno_white_cap or 0) + (names.kyno_white_cap_cooked or 0) >= 2) 
		and tags.succulent and not tags.meat and not tags.fish end,
		priority = 35,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_MED,
		health = 30,
		hunger = 50,
		sanity = 25,
		cooktime = .75,
		potlevel = "med",
		overridebuild = "kyno_foodrecipes_gorge",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "tag_milk" }, amount = 1 },
			{ items = { "kyno_white_cap" }, amount = 2, comparator = "morethan" },
			{ items = { "tag_succulent" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "goatmilk" }, amount = 1 },
			{ items = { "kyno_white_cap" }, amount = 2 },
			{ items = { "succulent_picked" }, amount = 1 },
		},
	},
	
	gorge_manicotti =
	{
		test = function(cooker, names, tags) return tags.flour and tags.milk and tags.spotspice and (names.tomato or names.tomato_cooked) end,
		priority = 35,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_MED,
		health = 8,
		hunger = 50,
		sanity = 50,
		cooktime = 1.5,
		potlevel = "med",
		overridebuild = "kyno_foodrecipes_gorge",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "tag_flour" }, amount = 1 },
			{ items = { "tag_milk" }, amount = 1 },
			{ items = { "tag_spotspice" }, amount = 1 },
			{ items = { "tomato" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_flour" }, amount = 1 },
			{ items = { "goatmilk" }, amount = 1 },
			{ items = { "kyno_spotspice" }, amount = 1 },
			{ items = { "tomato" }, amount = 1 },
		},
	},
	
	gorge_fettuccine = 
	{
		test = function(cooker, names, tags) return tags.flour and (names.garlic or names.garlic_cooked) and tags.succulent and tags.dairy end,
		priority = 35,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_MED,
		health = 20,
		hunger = 50,
		sanity = 40,
		cooktime = 1.5,
		potlevel = "med",
		overridebuild = "kyno_foodrecipes_gorge",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "tag_flour" }, amount = 1 },
			{ items = { "garlic" }, amount = 1 },
			{ items = { "tag_succulent" }, amount = 1 },
			{ items = { "tag_dairy" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_flour" }, amount = 1 },
			{ items = { "garlic" }, amount = 1 },
			{ items = { "succulent_picked" }, amount = 1 },
			{ items = { "goatmilk" }, amount = 1 },
		},
	},
	
	gorge_onion_soup =
	{
		test = function(cooker, names, tags) return tags.flour and tags.dairy and ((names.onion or 0) + (names.onion_cooked or 0) >= 2) end,
		priority = 35,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_SLOW,
		health = 25,
		hunger = 75,
		sanity = -5,
		cooktime = 1.5,
		potlevel = "med",
		overridebuild = "kyno_foodrecipes_gorge",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "tag_flour" }, amount = 1 },
			{ items = { "tag_dairy" }, amount = 1 },
			{ items = { "onion" }, amount = 2, comparator = "morethan" },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_flour" }, amount = 1 },
			{ items = { "goatmilk" }, amount = 1 },
			{ items = { "onion" }, amount = 2 },
		},
	},
	
	gorge_breaded_cutlet =
	{
		test = function(cooker, names, tags) return (tags.meat and tags.meat >= 2) and (tags.flour and tags.flour >= 2) 
		and not (tags.monster and tags.monster > 1) end,
		priority = 35,
		foodtype = FOODTYPE.MEAT,
		perishtime = TUNING.PERISH_SLOW,
		health = 30,
		hunger = 75,
		sanity = 15,
		cooktime = 1.5,
		potlevel = "low",
		overridebuild = "kyno_foodrecipes_gorge",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "meat" }, amount = 2, comparator = "morethan" },
			{ items = { "tag_flour" }, amount = 2, comparator = "morethan" },
		},
		excluded = 
		{
    		{ items = { "tag_monster" }, amount = 1, comparator = "morethan" },
		},
		card_def = 
		{
			{ items = { "meat" }, amount = 2 },
			{ items = { "kyno_flour" }, amount = 2 },
		},
	},
	
	gorge_creamy_fish =
	{
		test = function(cooker, names, tags) return tags.milk and tags.veggie and tags.salmon and tags.spotspice and not tags.bread end,
		priority = 35,
		foodtype = FOODTYPE.MEAT,
		perishtime = TUNING.PERISH_FASTISH,
		health = 40,
		hunger = 75,
		sanity = 30,
		cooktime = 1.5,
		potlevel = "med",
		overridebuild = "kyno_foodrecipes_gorge",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "tag_milk" }, amount = 1 },
			{ items = { "tag_veggie" }, amount = 1 },
			{ items = { "tag_salmon" }, amount = 1 },
			{ items = { "tag_spotspice" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "goatmilk" }, amount = 1 },
			{ items = { "carrot" }, amount = 1 },
			{ items = { "kyno_salmonfish" }, amount = 1 },
			{ items = { "kyno_spotspice" }, amount = 1 },
		},
	},
	
	gorge_pot_roast =
	{
		test = function(cooker, names, tags) return (tags.meat and tags.meat >= 2) and tags.veggie and tags.spotspice and not tags.fish 
		and not tags.monster and not tags.chicken end,
		priority = 35,
		foodtype = FOODTYPE.MEAT,
		perishtime = TUNING.PERISH_SLOW,
		health = 30,
		hunger = 150,
		sanity = 5,
		cooktime = 1.5,
		potlevel = "med",
		overridebuild = "kyno_foodrecipes_gorge",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "tag_meat" }, amount = 2, comparator = "morethan" },
			{ items = { "tag_veggie" }, amount = 1 },
			{ items = { "tag_spotspice" }, amount = 1 },
		},
		excluded = 
		{
			{ items = { "tag_fish" } },
			{ items = { "tag_monster" } },
			{ items = { "tag_chicken" } },
		},
		card_def = 
		{
			{ items = { "meat" }, amount = 2 },
			{ items = { "carrot" }, amount = 1 },
			{ items = { "kyno_spotspice" }, amount = 1 },
		},
		characterfood = {"wathgrithr"},
	},
	
	gorge_steak_frites =
	{
		test = function(cooker, names, tags) return (tags.meat and tags.meat >= 2) and ((names.potato or 0) + (names.potato_cooked or 0) >= 2) end,
		priority = 35,
		foodtype = FOODTYPE.MEAT,
		perishtime = TUNING.PERISH_MED,
		health = 40,
		hunger = 100,
		sanity = 5,
		cooktime = 2.25,
		potlevel = "med",
		overridebuild = "kyno_foodrecipes_gorge",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "tag_meat" }, amount = 2, comparator = "morethan" },
			{ items = { "potato" }, amount = 2, comparator = "morethan" },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "meat" }, amount = 2 },
			{ items = { "potato" }, amount = 2 },
		},
		characterfood = {"wilson"},
	},
	
	gorge_shooter_sandwich =
	{
		test = function(cooker, names, tags) return tags.meat and tags.bread and tags.spotspice and not tags.fish 
		and not (names.tomato or names.tomato_cooked) end, 
		priority = 35,
		foodtype = FOODTYPE.MEAT,
		perishtime = TUNING.PERISH_SLOW,
		health = 5,
		hunger = 100,
		sanity = 15,
		cooktime = 1,
		potlevel = "med",
		overridebuild = "kyno_foodrecipes_gorge",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "tag_meat" }, amount = 1 },
			{ items = { "tag_bread" }, amount = 1 },
			{ items = { "tag_spotspice" }, amount = 1 },
		},
		excluded = 
		{
    		{ items = { "tag_fish" } },
			{ items = { "tomato" } },
		},
		card_def = 
		{
			{ items = { "meat" }, amount = 2 },
			{ items = { "bread" }, amount = 1 },
			{ items = { "kyno_spotspice" }, amount = 1 },
		},
	},
	
	gorge_bacon_wrapped =
	{
		test = function(cooker, names, tags) return (tags.meat and tags.meat > 1) and (tags.bacon and tags.bacon >= 2) 
		and not tags.inedible and not tags.bread and not tags.spotspice end,
		priority = 35,
		foodtype = FOODTYPE.MEAT,
		perishtime = TUNING.PERISH_MED,
		health = 10,
		hunger = 50,
		sanity = 0,
		cooktime = .75,
		potlevel = "med",
		overridebuild = "kyno_foodrecipes_gorge",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "tag_meat" }, amount = 1, comparator = "morethan" },
			{ items = { "kyno_bacon" }, amount = 2, comparator = "morethan" },
		},
		excluded = 
		{
    		{ items = { "tag_inedible" } },
			{ items = { "tag_bread" } },
			{ items = { "tag_spotspice" } },
		},
		card_def = 
		{
			{ items = { "meat" }, amount = 2 },
			{ items = { "kyno_bacon" }, amount = 2 },
		},
	},
	
	gorge_crab_cake = 
	{
		test = function(cooker, names, tags) return tags.crab and tags.succulent and tags.flour 
		and tags.spotspice end,
		priority = 35,
		foodtype = FOODTYPE.MEAT,
		perishtime = TUNING.PERISH_MED,
		health = 60,
		hunger = 62.5,
		sanity = 20,
		cooktime = 1,
		potlevel = "med",
		overridebuild = "kyno_foodrecipes_gorge",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "tag_crab" }, amount = 1 },
			{ items = { "tag_succulent" }, amount = 1 },
			{ items = { "tag_flour" }, amount = 1 },
			{ items = { "tag_spotspice" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_crabmeat" }, amount = 1 },
			{ items = { "succulent_picked" }, amount = 1 },
			{ items = { "kyno_flour" }, amount = 1 },
			{ items = { "kyno_spotspice" }, amount = 1 },
		},
	},
	
	gorge_crab_roll =
	{
		test = function(cooker, names, tags) return tags.crab and tags.foliage and (names.kyno_white_cap or names.kyno_white_cap_cooked) and tags.flour end,
		priority = 35,
		foodtype = FOODTYPE.MEAT,
		perishtime = TUNING.PERISH_MED,
		health = 60,
		hunger = 75,
		sanity = 25,
		cooktime = 2,
		potlevel = "med",
		overridebuild = "kyno_foodrecipes_gorge",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "tag_crab" }, amount = 1 },
			{ items = { "tag_foliage" }, amount = 1 },
			{ items = { "kyno_white_cap" }, amount = 1 },
			{ items = { "tag_flour" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_crabmeat" }, amount = 1 },
			{ items = { "foliage" }, amount = 1 },
			{ items = { "kyno_white_cap" }, amount = 1 },
			{ items = { "kyno_flour" }, amount = 1 },
		},
		characterfood = {"waxwell"},
	},
	
	gorge_crab_ravioli =
	{
		test = function(cooker, names, tags) return tags.crab and tags.flour and tags.dairy and tags.veggie end,
		priority = 35,
		foodtype = FOODTYPE.MEAT,
		perishtime = TUNING.PERISH_FAST,
		health = 60,
		hunger = 40,
		sanity = 50,
		cooktime = 1.5,
		potlevel = "med",
		overridebuild = "kyno_foodrecipes_gorge",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "tag_crab" }, amount = 1 },
			{ items = { "tag_flour" }, amount = 1 },
			{ items = { "tag_dairy" }, amount = 1 },
			{ items = { "tag_veggie" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_crabmeat" }, amount = 1 },
			{ items = { "kyno_flour" }, amount = 1 },
			{ items = { "goatmilk" }, amount = 1 },
			{ items = { "carrot" }, amount = 1 },
		},
	},
	
	gorge_caramel_cube =
	{
		test = function(cooker, names, tags) return (tags.syrup and tags.syrup >= 2) and (tags.dairy and tags.dairy >= 2) end,
		priority = 20,
		foodtype = FOODTYPE.GOODIES,
		perishtime = TUNING.PERISH_SUPERSLOW,
		health = -10,
		hunger = 20,
		sanity = 100,
		cooktime = 1,
		oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_KYNO,
		potlevel = "med",
		overridebuild = "kyno_foodrecipes_gorge",
		floater = TUNING.HOF_FLOATER,
		luckitem = { luck = TUNING.KYNO_LUCK_MEDLARGE },
		tags = {"honeyed"},
		required = 
		{
			{ items = { "tag_syrup" }, amount = 2, comparator = "morethan" },
			{ items = { "tag_dairy" }, amount = 2, comparator = "morethan" },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_syrup" }, amount = 2 },
			{ items = { "goatmilk" }, amount = 2 },
		},
	},
	
	gorge_scone =
	{
		test = function(cooker, names, tags) return tags.fruit and (tags.flour and tags.flour >= 2) and tags.dairy end,
		priority = 35,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_FASTISH,
		health = 5,
		hunger = 37.5,
		sanity = 40,
		cooktime = 0.5,
		potlevel = "med",
		overridebuild = "kyno_foodrecipes_gorge",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "tag_fruit" }, amount = 1 },
			{ items = { "tag_flour" }, amount = 2, comparator = "morethan" },
			{ items = { "tag_dairy" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "berries" }, amount = 1 },
			{ items = { "kyno_flour" }, amount = 2 },
			{ items = { "goatmilk" }, amount = 1 },
		},
	},
	
	gorge_cheesecake =
	{
		test = function(cooker, names, tags) return (tags.berries and tags.berries >= 2) and tags.flour and tags.dairy end,
		priority = 20,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_SUPERSLOW,
		health = 20,
		hunger = 75,
		sanity = 60,
		cooktime = 2,
		potlevel = "med",
		overridebuild = "kyno_foodrecipes_gorge",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "tag_berries" }, amount = 2, comparator = "morethan" },
			{ items = { "tag_flour" }, amount = 1 },
			{ items = { "tag_dairy" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "berries" }, amount = 2 },
			{ items = { "kyno_flour" }, amount = 1 },
			{ items = { "goatmilk" }, amount = 1 },
		},
	},
	
	gorge_waffles =
	{
		test = function(cooker, names, tags) return tags.butter and tags.egg and tags.syrup end,
		priority = 30,
		foodtype = FOODTYPE.GOODIES,
		perishtime = TUNING.PERISH_MED,
		health = 5,
		hunger = 37.5,
		sanity = 60,
		cooktime = .5,
		nameoverride = "WAFFLES",
		potlevel = "high",
		overridebuild = "kyno_foodrecipes_gorge",
		floater = TUNING.HOF_FLOATER,
		tags = {"honeyed"},
		required = 
		{
			{ items = { "tag_butter" }, amount = 1 },
			{ items = { "tag_egg" }, amount = 1 },
			{ items = { "tag_syrup" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "butter" }, amount = 1 },
			{ items = { "bird_egg" }, amount = 1 },
			{ items = { "kyno_syrup" }, amount = 2 },
		},
	},
	
	kyno_syrup =
	{
		test = function(cooker, names, tags) return names.kyno_sap and (names.kyno_sap == 4 or 
		(names.kyno_sap == 3 and (tags.dairy or tags.sweetener))) and not tags.monster end,
		priority = 35,
		foodtype = FOODTYPE.GOODIES,
		perishtime = TUNING.PERISH_SUPERSLOW,
		health = 0,
		hunger = 6.375,
		sanity = 3,
		cooktime = 1,
		potlevel = "med",
		overridebuild = "kyno_foodrecipes_gorge",
		floater = TUNING.HOF_FLOATER,
		tags = {"honeyed", "fooddrink"},
		required = 
		{
			{ items = { "kyno_sap" }, amount = 3, comparator = "morethan" },
			{ items = { "tag_dairy", "tag_sweetener" }, amount = 1 },
		},
		excluded = 
		{
    		{ items = { "tag_monster" } },
		},
		card_def = 
		{
			{ items = { "kyno_sap" }, amount = 4 },
		},
	},
	
	slaw = 
	{
		test = function(cooker, names, tags) return ((names.kyno_fennel or 0) + (names.kyno_fennel_cooked or 0) >= 2) 
		and (names.kyno_radish or names.kyno_radish_cooked) end,
		priority = 20,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_MED,
		health = 20,
		hunger = 25,
		sanity = 10,
		cooktime = 1.5,
		potlevel = "high",
		overridebuild = "kyno_foodrecipes_cookpot",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "kyno_fennel" }, amount = 2, comparator = "morethan" },
			{ items = { "kyno_radish" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_fennel" }, amount = 2 },
			{ items = { "kyno_radish" }, amount = 2 },
		},
	},
	
	lotusbowl = 
	{
		test = function(cooker, names, tags) return ((names.kyno_lotus_flower or 0) + (names.kyno_lotus_flower_cooked or 0) >= 3) end,
		priority = 30,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_FASTISH,
		health = 8,
		hunger = 12.5,
		sanity = 50,
		cooktime = 0.5,
		potlevel = "med",
		overridebuild = "kyno_foodrecipes_cookpot",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "kyno_lotus_flower" }, amount = 3, comparator = "morethan" },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_lotus_flower" }, amount = 4 },
		},
	},
	
	poi = 
	{
		test = function(cooker, names, tags) return ((names.kyno_taroroot or 0) + (names.kyno_taroroot_cooked or 0) >= 3) and not tags.inedible end,
		priority = 30,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_MED,
		health = 30,
		hunger = 62.5,
		sanity = 10,
		cooktime = 1,
		potlevel = "med",
		overridebuild = "kyno_foodrecipes_cookpot",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "kyno_taroroot" }, amount = 3, comparator = "morethan" },
		},
		excluded = 
		{
    		{ items = { "tag_inedible" } },
		},
		card_def = 
		{
			{ items = { "kyno_taroroot" }, amount = 4 },
		},
	},
	
	cucumbersalad =
	{
		test = function(cooker, names, tags) return ((names.kyno_cucumber or 0) + (names.kyno_cucumber_cooked or 0) >= 3)
		and not (names.kyno_taroroot or names.kyno_taroroot_cooked) end,
		priority = 30,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_MED,
		health = 10,
		hunger = 25,
		sanity = 15,
		cooktime = 1.2,
		oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_DRY,
		potlevel = "med",
		overridebuild = "kyno_foodrecipes_cookpot",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "kyno_cucumber" }, amount = 3, comparator = "morethan" },
		},
		excluded = 
		{
			{ items = { "kyno_taroroot", "kyno_taroroot_cooked" } },
		},
		card_def = 
		{
			{ items = { "kyno_cucumber" }, amount = 4 },
		},
		prefabs = { "buff_moistureimmunity" },
        oneatenfn = function(inst, eater)
            eater:AddDebuff("buff_moistureimmunity", "buff_moistureimmunity")
       	end,
	},
	
	waterycressbowl =
	{
		test = function(cooker, names, tags) return (names.kyno_waterycress and names.kyno_waterycress >= 2) and tags.succulent and
		(tags.veggie and tags.veggie >= 3) and not tags.inedible and not tags.egg and not tags.sweetener and not tags.fruit and not tags.meat end,
		priority = 35,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_SLOW,
		temperature = TUNING.COLD_FOOD_BONUS_TEMP,
		temperatureduration = TUNING.FOOD_TEMP_AVERAGE,
		health = 20,
		hunger = 37.5,
		sanity = 5,
		cooktime = 1,
		potlevel = "med",
		overridebuild = "kyno_foodrecipes_cookpot",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "kyno_waterycress" }, amount = 2, comparator = "morethan" },
			{ items = { "tag_succulent" }, amount = 1 },
			{ items = { "tag_veggie" }, amount = 3, comparator = "morethan" },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_waterycress" }, amount = 2 },
			{ items = { "succulent_picked" }, amount = 2 },
		},
	},
	
	bowlofgears = 
	{
		test = function(cooker, names, tags) return (names.gears and names.gears >= 2) and (names.wagpunk_bits and names.wagpunk_bits >= 2) end,
		priority = 1,
		foodtype = FOODTYPE.GEARS,
		perishtime = nil,
		fireproof = true,
		health = 150,
		hunger = 200,
		sanity = 150,
		cooktime = 2,
		oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_GEARS,
		potlevel = "low",
		pickupsound = "metal",
		overridebuild = "kyno_foodrecipes_cookpot",
		floater = TUNING.HOF_FLOATER,
		tags = {"preparedgears"},
		required = 
		{
			{ items = { "gears" }, amount = 2, comparator = "morethan" },
			{ items = { "wagpunk_bits" }, amount = 2, comparator = "morethan" },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "gears" }, amount = 2 },
			{ items = { "wagpunk_bits" }, amount = 2 },
		},
		oneatenfn = function(inst, eater)

		end,
		characterfood = {"wx78"},
	},
	
	longpigmeal = 
	{
		test = function(cooker, names, tags) return ((names.kyno_humanmeat or 0) + (names.kyno_humanmeat_cooked or 0) + (names.kyno_humanmeat_dried or 0) >= 3)
		and names.boneshard end,
		priority = 1,
		foodtype = FOODTYPE.MEAT,
		secondaryfoodtype = FOODTYPE.MONSTER,
		perishtime = TUNING.PERISH_MED,
		health = -100,
		hunger = 150,
		sanity = -300,
		cooktime = 1,
		oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_HURT,
		potlevel = "med",
		overridebuild = "kyno_foodrecipes_cookpot",
		floater = TUNING.HOF_FLOATER,
		luckitem = { luck = -TUNING.KYNO_LUCK_HUGE },
		required = 
		{
			{ items = { "kyno_humanmeat", "kyno_humanmeat_cooked", "kyno_humanmeat_dried" }, amount = 3, comparator = "morethan" },
			{ items = { "boneshard" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_humanmeat" }, amount = 3 },
			{ items = { "boneshard" }, amount = 1 },
		},
		oneatenfn = function(inst, eater)

		end,
	},

	duckyouglermz =
	{
		test = function(cooker, names, tags) return names.poop and names.guano and names.glommerfuel and names.kyno_salt end,
		priority = 100,
		foodtype = FOODTYPE.PREPAREDPOOP,
		perishtime = nil,
		health = 60,
		hunger = 12.5,
		sanity = 33,
		cooktime = 5,
		oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_GLERMZ,
		potlevel = "med",
		scale = .95,
		overridebuild = "kyno_foodrecipes_cookpot",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "poop" }, amount = 1 },
			{ items = { "guano" }, amount = 1 },
			{ items = { "glommerfuel" }, amount = 1 },
			{ items = { "kyno_salt" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "poop" }, amount = 1 },
			{ items = { "guano" }, amount = 1 },
			{ items = { "glommerfuel" }, amount = 1 },
			{ items = { "kyno_salt" }, amount = 1 },
		},
		tags = {"preparedpoop"},
		oneatenfn = function(inst, eater)
            if eater.components.bloomness ~= nil and eater:HasTag("plantkin")
			and not (eater.components.health ~= nil and eater.components.health:IsDead()) and not eater:HasTag("playerghost") then
                if eater.components.bloomness ~= nil then
					eater.components.health:DoDelta(60)
                    eater.components.bloomness:Fertilize(3)
                end
            end
        end,
	},
	
	catfood =
	{
		test = function(cooker, names, tags) return tags.fish and tags.flour and (tags.spotspice and tags.spotspice >= 2) end,
		priority = 35,
		foodtype = FOODTYPE.MEAT,
		perishtime = TUNING.PERISH_FASTISH,
		health = 20,
		hunger = 25,
		sanity = 15,
		cooktime = 1,
		potlevel = "low",
		overridebuild = "kyno_foodrecipes_cookpot",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "tag_fish" }, amount = 1 },
			{ items = { "tag_flour" }, amount = 1 },
			{ items = { "tag_spotspice" }, amount = 2, comparator = "morethan" },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "pondfish" }, amount = 1 },
			{ items = { "kyno_flour" }, amount = 1 },
			{ items = { "kyno_spotspice" }, amount = 2 },
		},
	},
	
	katfood =
	{
		test = function(cooker, names, tags) return tags.dairy and tags.syrup and (tags.flour and tags.flour >= 2) and not tags.fish end,
		priority = 30,
		foodtype = FOODTYPE.GOODIES,
		perishtime = TUNING.PERISH_MED,
		health = 60,
		hunger = 15,
		sanity = 30,
		cooktime = 1.5,
		potlevel = "low",
		overridebuild = "kyno_foodrecipes_cookpot",
		floater = TUNING.HOF_FLOATER,
		tags = {"honeyed"},
		required = 
		{
			{ items = { "tag_dairy" }, amount = 1 },
			{ items = { "tag_syrup" }, amount = 1 },
			{ items = { "tag_flour" }, amount = 2, comparator = "morethan" },
		},
		excluded = 
		{
    		{ items = { "tag_fish" } },
		},
		card_def = 
		{
			{ items = { "goatmilk" }, amount = 1 },
			{ items = { "kyno_syrup" }, amount = 1 },
			{ items = { "kyno_flour" }, amount = 2 },
		},
	},
	
	bowlofpopcorn =
	{
		test = function(cooker, names, tags) return (names.corn and names.corn == 3) and names.kyno_salt and not names.corn_cooked end,
		priority = 35,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_SLOW,
		health = 5,
		hunger = 75,
		sanity = 33,
		cooktime = 1.2,
		potlevel = "med",
		overridebuild = "kyno_foodrecipes_cookpot",
		floater = TUNING.HOF_FLOATER,
		tags = {"popcorn"},
		required = 
		{
			{ items = { "corn" }, amount = 3 },
			{ items = { "kyno_salt" }, amount = 1 },
		},
		excluded = 
		{
    		{ items = { "corn_cooked" } },
		},
		card_def = 
		{
			{ items = { "corn" }, amount = 3 },
			{ items = { "kyno_salt" }, amount = 1 },
		},
	},
	
	figjuice =
	{
		test = function(cooker, names, tags) return (names.fig or names.fig_cooked) and (tags.frozen and tags.frozen >= 2) and not tags.meat 
		and not tags.fish and not tags.inedible end,
		priority = 30,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_FAST,
		temperature = TUNING.COLD_FOOD_BONUS_TEMP,
        temperatureduration = TUNING.FOOD_TEMP_AVERAGE,
		health = 0,
		hunger = 15,
		sanity = 50,
		cooktime = .5,
		potlevel = "med",
		overridebuild = "kyno_foodrecipes_cookpot",
		floater = TUNING.HOF_FLOATER,
		tags = {"fooddrink"},
		required = 
		{
			{ items = { "fig" }, amount = 1 },
			{ items = { "ice" }, amount = 2, comparator = "morethan" },
		},
		excluded = 
		{
    		{ items = { "tag_fish" } },
			{ items = { "tag_meat" } },
			{ items = { "tag_inedible" } },
		},
		card_def = 
		{
			{ items = { "fig" }, amount = 1 },
			{ items = { "ice" }, amount = 2 },
		},
	},
	
	coconutwater =
	{
		test = function(cooker, names, tags) return (names.kyno_kokonut_halved and names.kyno_kokonut_halved == 1) and (tags.frozen and tags.frozen >= 2) 
		and names.twigs and not names.kyno_kokonut_cooked and not tags.meat and not tags.fish end,
		priority = 20,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_SLOW,
		temperature = TUNING.COLD_FOOD_BONUS_TEMP,
        temperatureduration = TUNING.FOOD_TEMP_AVERAGE,
		health = 20,
		hunger = 0,
		sanity = 0,
		cooktime = .5,
		potlevel = "med",
		overridebuild = "kyno_foodrecipes_cookpot",
		floater = TUNING.HOF_FLOATER,
		tags = {"fooddrink"},
		required = 
		{
			{ items = { "kyno_kokonut_halved" }, amount = 1 },
			{ items = { "ice" }, amount = 2, comparator = "morethan" },
			{ items = { "twigs" }, amount = 1 },
		},
		excluded = 
		{
    		{ items = { "kyno_kokonut_halved_cooked" } },
			{ items = { "tag_meat" } },
			{ items = { "tag_fish" } },
		},
		card_def = 
		{
			{ items = { "kyno_kokonut_halved" }, amount = 1 },
			{ items = { "ice" }, amount = 2 },
			{ items = { "twigs" }, amount = 1 },
		},
	},
	
	eyeballspaghetti =
	{
		test = function(cooker, names, tags) return names.deerclops_eyeball and (names.tomato or names.tomato_cooked) and tags.flour end,
		priority = 30,
		foodtype = FOODTYPE.MEAT,
		perishtime = nil,
		health = 150,
		hunger = 150,
		sanity = -150,
		oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_BOSS,
		cooktime = 2,
		potlevel = "med",
		overridebuild = "kyno_foodrecipes_cookpot",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "deerclops_eyeball" }, amount = 1 },
			{ items = { "tomato" }, amount = 1 },
			{ items = { "tag_flour" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "deerclops_eyeball" }, amount = 1 },
			{ items = { "tomato" }, amount = 2 },
			{ items = { "kyno_flour" }, amount = 1 },
		},
		oneatenfn = function(inst, eater)
		
		end,
	},
	
	soulstew = 
	{
		test = function(cooker, names, tags) return (names.kyno_bottle_soul and names.kyno_bottle_soul >= 2) and names.boneshard end,
		priority = 10,
		foodtype = FOODTYPE.PREPAREDSOUL,
		perishtime = nil,
		fireproof = true,
		health = 30,
		hunger = 75,
		sanity = 15,
		cooktime = 1.2,
		bottlesize = 2,
		potlevel = "med",
		overridebuild = "kyno_foodrecipes_cookpot",
		floater = TUNING.HOF_FLOATER,
		tags = {"preparedsoul", "bottled"},
		required = 
		{
			{ items = { "kyno_bottle_soul" }, amount = 2, comparator = "morethan" },
			{ items = { "boneshard" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_bottle_soul" }, amount = 2 },
			{ items = { "boneshard" }, amount = 1 },
			{ items = { "twigs" }, amount = 1 },
		},
		oneatenfn = function(inst, eater)
			if eater:HasTag("soulstealer") and eater.components.health ~= nil and not eater.components.health:IsDead() and
			not eater:HasTag("playerghost") and eater.components.hunger ~= nil and eater.components.sanity ~= nil then
				eater.components.hunger:DoDelta(TUNING.SOULSTEW_HUNGER)
				
				if eater.wortox_inclination == "nice" then
					eater.components.health:DoDelta(TUNING.SOULSTEW_HEALTH_NICE)
					eater.components.sanity:DoDelta(TUNING.SOULSTEW_SANITY_NICE)
				elseif eater.wortox_inclination == "naughty" then
					eater.components.health:DoDelta(TUNING.SOULSTEW_HEALTH_NAUGHTY)
					eater.components.sanity:DoDelta(TUNING.SOULSTEW_SANITY_NAUGHTY)
				else
					eater.components.health:DoDelta(TUNING.SOULSTEW_HEALTH)
					eater.components.sanity:DoDelta(TUNING.SOULSTEW_SANITY)
				end
			end
		end,
	},
	
	fortunecookie =
	{
		test = function(cooker, names, tags) return tags.flour and tags.sweetener and names.papyrus end,
		priority = 35,
		foodtype = FOODTYPE.GOODIES,
		perishtime = TUNING.PERISH_SUPERSLOW,
		health = 3, 
		hunger = 20,
		sanity = 5,
		cooktime = 1,
		oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_FORTUNE,
		potlevel = "high",
		overridebuild = "kyno_foodrecipes_cookpot",
		floater = TUNING.HOF_FLOATER,
		tags = {"honeyed"},
		required = 
		{
			{ items = { "tag_flour" }, amount = 1 },
			{ items = { "tag_sweetener" }, amount = 1 },
			{ items = { "papyrus" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_flour" }, amount = 1 },
			{ items = { "honey" }, amount = 2 },
			{ items = { "papyrus" }, amount = 1 },
		},
		oneatenfn = function(inst, eater)
			OnFoodRollFortune(inst, eater)
		end,
	},
	
	hornocupia =
	{
		test = function(cooker, names, tags) return tags.meat and tags.veggie and tags.fruit and names.horn end,
		priority = 30,
		foodtype = FOODTYPE.GOODIES,
		perishtime = TUNING.PERISH_SLOW,
		health = 12,
		hunger = 75,
		sanity = 25,
		cooktime = 1.6,
		potlevel = "high",
		overridebuild = "kyno_foodrecipes_cookpot",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "tag_meat" }, amount = 1 },
			{ items = { "tag_veggie" }, amount = 1 },
			{ items = { "tag_fruit" }, amount = 1 },
			{ items = { "horn" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "meat" }, amount = 1 },
			{ items = { "carrot" }, amount = 1 },
			{ items = { "berries" }, amount = 1 },
			{ items = { "horn" }, amount = 1 },
		},
		prefabs = { "boneshard" },
		oneatenfn = function(inst, eater)
			local bones = SpawnPrefab("boneshard")
			bones.components.stackable.stacksize = 2
			if eater.components.inventory ~= nil and eater:HasTag("player") and not eater.components.health:IsDead() 
			and not eater:HasTag("playerghost") then 
				eater.components.inventory:GiveItem(bones)
			end
		end,
	},
	
	cheese_yellow = 
	{
		test = function(cooker, names, tags) return (tags.milk and tags.milk == 2) and tags.spotspice and not tags.meat 
		and not (names.garlic or names.garlic_cooked) and not names.kyno_milk_koalefant and not tags.cheese end,
		priority = 30,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_PRESERVED,
		health = 10,
		hunger = 25,
		sanity = 5,
		cooktime = 2.3,
		potlevel = "med",
		overridebuild = "kyno_foodrecipes_cookpot",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "tag_milk" }, amount = 2 },
			{ items = { "tag_spotspice" }, amount = 1 },
		},
		excluded = 
		{
    		{ items = { "tag_meat" } },
			{ items = { "garlic", "garlic_cooked" } },
			{ items = { "kyno_milk_koalefant" } },
			{ items = { "tag_cheese" } },
		},
		card_def = 
		{
			{ items = { "goatmilk" }, amount = 2 },
			{ items = { "kyno_spotspice" }, amount = 2 },
		},
	},
	
	cheese_white = 
	{
		test = function(cooker, names, tags) return (tags.milk and tags.milk == 2) and tags.spotspice and (names.garlic or names.garlic_cooked)
		and not tags.meat and not tags.cheese end,
		priority = 30,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_PRESERVED,
		health = 15,
		hunger = 25,
		sanity = 20,
		cooktime = 2.3,
		potlevel = "med",
		overridebuild = "kyno_foodrecipes_cookpot",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "tag_milk" }, amount = 2 },
			{ items = { "tag_spotspice" }, amount = 1 },
			{ items = { "garlic" }, amount = 1 },
		},
		excluded = 
		{
    		{ items = { "tag_meat" } },
			{ items = { "tag_cheese" } },
		},
		card_def = 
		{
			{ items = { "goatmilk" }, amount = 2 },
			{ items = { "kyno_spotspice" }, amount = 1 },
			{ items = { "garlic" }, amount = 1 },
		},
	},
	
	cheese_koalefant =
	{
		test = function(cooker, names, tags) return (names.kyno_milk_koalefant and names.kyno_milk_koalefant == 2) and tags.spotspice
		and not (names.garlic or names.garlic_cooked) and not names.kyno_milk_beefalo and not names.goatmilk and not tags.meat and not tags.cheese end,
		priority = 30,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_PRESERVED,
		health = 20,
		hunger = 25,
		sanity = 5,
		cooktime = 2.3,
		potlevel = "low",
		overridebuild = "kyno_foodrecipes_cookpot",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "kyno_milk_koalefant" }, amount = 2 },
			{ items = { "tag_spotspice" }, amount = 1 },
		},
		excluded = 
		{
    		{ items = { "garlic", "garlic_cooked" } },
			{ items = { "goatmilk" } },
			{ items = { "kyno_milk_beefalo" } },
			{ items = { "tag_meat" } },
			{ items = { "tag_cheese" } },
		},
		card_def = 
		{
			{ items = { "kyno_milk_koalefant" }, amount = 1 },
			{ items = { "kyno_spotspice" }, amount = 2 },
		},
	},

	milk_box = 
	{
		test = function(cooker, names, tags) return (tags.frozen and tags.frozen >= 2) and (tags.milk and tags.milk >= 2) and not names.milk_box end,
		priority = 1,
		foodtype = FOODTYPE.GOODIES,
		perishtime = TUNING.PERISH_PRESERVED,
		health = 25,
		hunger = 0,
		sanity = 20,
		cooktime = 1.1,
		potlevel = "med",
		overridebuild = "kyno_foodrecipes_cookpot",
		floater = TUNING.HOF_FLOATER,
		tags = {"fooddrink"},
		required = 
		{
			{ items = { "ice" }, amount = 2, comparator = "morethan" },
			{ items = { "tag_milk" }, amount = 2, comparator = "morethan" },
		},
		excluded = 
		{
    		{ items = { "milk_box" } },
		},
		card_def = 
		{
			{ items = { "ice" }, amount = 2 },
			{ items = { "goatmilk" }, amount = 2 },
		},
		card_def = {ingredients = {{"ice", 2}, {"goatmilk", 2}}},
	},
	
	honeyjar =
	{
		test = function(cooker, names, tags) return (names.honey and names.honey >= 2) and tags.sugar end,
		priority = 30,
		foodtype = FOODTYPE.GOODIES,
		perishtime = TUNING.PERISH_SUPERSLOW,
		health = 25,
		hunger = 45,
		sanity = 10,
		cooktime = 1.6,
		oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_BEEFRIENDLY,
		potlevel = "med",
		overridebuild = "kyno_foodrecipes_cookpot",
		floater = TUNING.HOF_FLOATER,
		tags = {"honeyed"},
		required = 
		{
			{ items = { "honey" }, amount = 2, comparator = "morethan" },
			{ items = { "tag_sugar" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "honey" }, amount = 2 },
			{ items = { "kyno_sugar" }, amount = 2 },
		},
		prefabs = { "kyno_beefriendlybuff" },
        oneatenfn = function(inst, eater)
			eater:AddDebuff("kyno_beefriendlybuff", "kyno_beefriendlybuff")
       	end,
	},
	
	watercup =
	{
		test = function(cooker, names, tags) return (tags.frozen and tags.frozen >= 2) and not tags.meat and not tags.fish and not tags.veggie 
		and not tags.fruit and not tags.milk and not tags.sweetener end,
		priority = -5,
		foodtype = FOODTYPE.GOODIES,
		perishtime = 9000000,
		fireproof = true,
		temperature = TUNING.COLD_FOOD_BONUS_TEMP,
		temperatureduration = TUNING.FOOD_TEMP_AVERAGE,
		health = 1,
		hunger = 1,
		sanity = 1,
		cooktime = .1,
		oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_CLEAR,
		potlevel = "low",
		overridebuild = "kyno_foodrecipes_cookpot",
		floater = TUNING.HOF_FLOATER,
		tags = {"fooddrink", "nospice"},
		required = 
		{
			{ items = { "ice" }, amount = 2, comparator = "morethan" },
		},
		excluded = 
		{
    		{ items = { "tag_fish" } },
			{ items = { "tag_meat" } },
			{ items = { "tag_veggie" } },
			{ items = { "tag_fruit" } },
			{ items = { "tag_milk" } },
			{ items = { "tag_sweetener" } },
		},
		card_def = 
		{
			{ items = { "ice" }, amount = 4 },
		},
		oneatenfn = function(inst, eater)
			if eater.components.debuffable ~= nil then 
				eater.components.debuffable:RemoveAllDebuffs()	
			end
		end
	},
	
	crab_artichoke =
	{
		test = function(cooker, names, tags) return (tags.crab and tags.crab >= 2) and (tags.algae and tags.algae >= 1) and tags.spotspice end,
		priority = 25,
		foodtype = FOODTYPE.MEAT,
		perishtime = TUNING.PERISH_FAST,
		health = 40,
		hunger = 12.5,
		sanity = 60,
		cooktime = 2.2,
		potlevel = "med",
		overridebuild = "kyno_foodrecipes_cookpot",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "tag_crab" }, amount = 2, comparator = "morethan" },
			{ items = { "tag_algae" }, amount = 1, comparator = "morethan" },
			{ items = { "tag_spotspice" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_crabmeat" }, amount = 2 },
			{ items = { "kyno_seaweeds" }, amount = 1 },
			{ items = { "kyno_spotspice" }, amount = 1 },
		},
	},
	
	poisonfrogglebunwich =
	{
		test = function(cooker, names, tags) return (names.kyno_poison_froglegs or names.kyno_poison_froglegs_cooked) and tags.veggie and tags.veggie >= 0.5 
		and not (names.froglegs or names.froglegs_cooked) end,
		priority = 1,
		foodtype = FOODTYPE.MEAT,
		perishtime = TUNING.PERISH_SLOW,
		health = -20,
		hunger = 62.5,
		sanity = 10,
		cooktime = 2,
		oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_FROG,
        potlevel = "low",
		overridebuild = "kyno_foodrecipes_cookpot",
        floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "kyno_poison_froglegs" }, amount = 1 },
			{ items = { "tag_veggie" }, amount = 1, comparator = "morethan" },
		},
		excluded = 
		{
    		{ items = { "froglegs", "froglegs_cooked" } },
		},
		card_def = 
		{
			{ items = { "kyno_poison_froglegs" }, amount = 1 },
			{ items = { "kelp" }, amount = 1 },
			{ items = { "twigs" }, amount = 2 },
		},
		prefabs = { "kyno_frogbuff" },
        oneatenfn = function(inst, eater)
			eater:AddDebuff("kyno_frogbuff", "kyno_frogbuff")
       	end,
	},
	
	pepperrolls = 
	{
		test = function(cooker, names, tags) return tags.flour and tags.spotspice and ((names.pepper or 0) + (names.pepper_cooked or 0) >= 2) end,
		priority = 30,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_MED,
		temperature = TUNING.HOT_FOOD_BONUS_TEMP,
		temperatureduration = TUNING.FOOD_TEMP_LONG,
		health = 40,
		hunger = 32.5,
		sanity = -15,
		cooktime = 1.6,
		potlevel = "med",
		overridebuild = "kyno_foodrecipes_cookpot",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "tag_flour" }, amount = 1 },
			{ items = { "tag_spotspice" }, amount = 1 },
			{ items = { "pepper" }, amount = 2, comparator = "morethan" },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_flour" }, amount = 1 },
			{ items = { "kyno_spotspice" }, amount = 1 },
			{ items = { "pepper" }, amount = 2 },
		},
	},
	
	chocolate_black =
	{
		test = function(cooker, names, tags) return tags.milk and tags.sugar and (names.kyno_twiggynuts and names.kyno_twiggynuts >= 2)
		and not tags.meat and not tags.fish and not tags.veggie and not tags.frozen and not names.kyno_milk_beefalo end,
		priority = 30,
		foodtype = FOODTYPE.GOODIES,
		perishtime = TUNING.PERISH_SLOW,
		health = -5,
		hunger = 12.5,
		sanity = 33,
		cooktime = 2,
		potlevel = "med",
		overridebuild = "kyno_foodrecipes_cookpot",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "tag_milk" }, amount = 1 },
			{ items = { "tag_sugar" }, amount = 1 },
			{ items = { "kyno_twiggynuts" }, amount = 2, comparator = "morethan" },			
		},
		excluded = 
		{
    		{ items = { "kyno_milk_beefalo" } },
		},
		card_def = 
		{
			{ items = { "goatmilk" }, amount = 1 },
			{ items = { "kyno_sugar" }, amount = 1 },
			{ items = { "kyno_twiggynuts" }, amount = 2 },
		},
	},
	
	chocolate_white =
	{
		test = function(cooker, names, tags) return names.kyno_milk_beefalo and tags.sugar and (names.kyno_twiggynuts and names.kyno_twiggynuts >= 2)
		and not tags.meat and not tags.fish and not tags.veggie and not tags.frozen and not names.goatmilk end,
		priority = 30,
		foodtype = FOODTYPE.GOODIES,
		perishtime = TUNING.PERISH_SLOW,
		health = -5,
		hunger = 33,
		sanity = 12.5,
		cooktime = 2,
		potlevel = "med",
		overridebuild = "kyno_foodrecipes_cookpot",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "kyno_milk_beefalo" }, amount = 1 },
			{ items = { "tag_sugar" }, amount = 1 },
			{ items = { "kyno_twiggynuts" }, amount = 2, comparator = "morethan" },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_milk_beefalo" }, amount = 1 },
			{ items = { "kyno_sugar" }, amount = 1 },
			{ items = { "kyno_twiggynuts" }, amount = 2 },
		},
	},
	
	tricolordango =
	{
		test = function(cooker, names, tags) return tags.milk and tags.sugar and tags.flour and names.twigs end,
		priority = 30,
		foodtype = FOODTYPE.GOODIES,
		perishtime = TUNING.PERISH_SUPERSLOW,
		health = 30,
		hunger = 12.5,
		sanity = 5,
		cooktime = 1,
		potlevel = "high",
		overridebuild = "kyno_foodrecipes_cookpot",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "tag_milk" }, amount = 1 },
			{ items = { "tag_sugar" }, amount = 1 },
			{ items = { "tag_flour" }, amount = 1 },
			{ items = { "twigs" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "goatmilk" }, amount = 1 },
			{ items = { "kyno_sugar" }, amount = 1 },
			{ items = { "kyno_flour" }, amount = 1 },
			{ items = { "twigs"}, amount = 1 },
		},
	},
	
	friesfrench =
	{
		test = function(cooker, names, tags) return ((names.potato or 0) + (names.potato_cooked or 0) >= 2) and tags.oil and names.kyno_salt end,
		priority = 30,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_SUPERSLOW,
		health = 30,
		hunger = 32.5,
		sanity = 10,
		cooktime = 1,
		potlevel = "med",
		overridebuild = "kyno_foodrecipes_cookpot",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "potato" }, amount = 2, comparator = "morethan" },
			{ items = { "tag_oil" }, amount = 1 },
			{ items = { "kyno_salt" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "potato" }, amount = 2 },
			{ items = { "kyno_oil" }, amount = 1 },
			{ items = { "kyno_salt"}, amount = 1 },
		},
	},
	
	onionrings =
	{
		test = function(cooker, names, tags) return ((names.onion or 0) + (names.onion_cooked or 0) >= 2) and tags.oil and tags.flour 
		and not names.twigs and not tags.frozen and not tags.sweetener end,
		priority = 30,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_MED,
		health = 15,
		hunger = 25,
		sanity = 20,
		cooktime = 1,
		potlevel = "med",
		overridebuild = "kyno_foodrecipes_cookpot",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "onion" }, amount = 2, comparator = "morethan" },
			{ items = { "tag_oil" }, amount = 1 },
			{ items = { "tag_flour" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "onion" }, amount = 2 },
			{ items = { "kyno_oil" }, amount = 1 },
			{ items = { "kyno_flour" }, amount = 1 },
		},
	},
	
	donuts =
	{
		test = function(cooker, names, tags) return (tags.flour and tags.flour >= 2) and names.kyno_sugar and tags.oil end,
		priority = 30,
		foodtype = FOODTYPE.GOODIES,
		perishtime = TUNING.PERISH_SLOW,
		health = -3,
		hunger = 50,
		sanity = 10,
		cooktime = 1,
		potlevel = "med",
		overridebuild = "kyno_foodrecipes_cookpot",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "tag_flour" }, amount = 2, comparator = "morethan" },
			{ items = { "kyno_sugar" }, amount = 1 },
			{ items = { "tag_oil" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_flour" }, amount = 2 },
			{ items = { "kyno_sugar" }, amount = 1 },
			{ items = { "kyno_oil" }, amount = 1 },
		},
	},
	
	donuts_chocolate_black =
	{
		test = function(cooker, names, tags) return tags.flour and names.kyno_sugar and tags.oil and names.chocolate_black end,
		priority = 30,
		foodtype = FOODTYPE.GOODIES,
		perishtime = TUNING.PERISH_SLOW,
		health = -5,
		hunger = 55,
		sanity = 40,
		cooktime = 1.5,
		potlevel = "med",
		overridebuild = "kyno_foodrecipes_cookpot",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "tag_flour" }, amount = 1 },
			{ items = { "kyno_sugar" }, amount = 1 },
			{ items = { "tag_oil" }, amount = 1 },
			{ items = { "chocolate_black" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_flour" }, amount = 1 },
			{ items = { "kyno_sugar" }, amount = 1 },
			{ items = { "kyno_oil" }, amount = 1 },
			{ items = { "chocolate_black" }, amount = 1 },
		},
	},
	
	donuts_chocolate_white =
	{
		test = function(cooker, names, tags) return tags.flour and names.kyno_sugar and tags.oil and names.chocolate_white end,
		priority = 30,
		foodtype = FOODTYPE.GOODIES,
		perishtime = TUNING.PERISH_SLOW,
		health = -5,
		hunger = 75,
		sanity = 15,
		cooktime = 1.5,
		potlevel = "med",
		overridebuild = "kyno_foodrecipes_cookpot",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "tag_flour" }, amount = 1 },
			{ items = { "kyno_sugar" }, amount = 1 },
			{ items = { "tag_oil" }, amount = 1 },
			{ items = { "chocolate_white" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_flour" }, amount = 1 },
			{ items = { "kyno_sugar" }, amount = 1 },
			{ items = { "kyno_oil" }, amount = 1 },
			{ items = { "chocolate_white" }, amount = 1 },
		},
	},
	
	gummybeargers =
	{
		test = function(cooker, names, tags) return names.bearger_fur and tags.gummybug and (tags.sweetener and tags.sweetener >= 2) end,
		priority = 30,
		foodtype = FOODTYPE.GOODIES,
		perishtime = nil,
		health = 5,
		hunger = 30,
		sanity = -5,
		oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_BOSS,
		cooktime = 1.5,
		potlevel = "low",
		overridebuild = "kyno_foodrecipes_cookpot",
		floater = TUNING.HOF_FLOATER,
		tags = {"honeyed"},
		required = 
		{
			{ items = { "bearger_fur" }, amount = 1 },
			{ items = { "kyno_gummybug" }, amount = 1 },
			{ items = { "tag_sweetener" }, amount = 2, comparator = "morethan" },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "bearger_fur" }, amount = 1 },
			{ items = { "kyno_gummybug" }, amount = 1 },
			{ items = { "honey" }, amount = 2 },
		},
		oneatenfn = function(inst, eater)

		end,
	},
	
	gummyworms =
	{
		test = function(cooker, names, tags) return tags.gummybug and names.kyno_sugar and names.ancientfruit_nightvision end,
		priority = 30,
		foodtype = FOODTYPE.GOODIES,
		perishtime = TUNING.PERISH_SLOW,
		health = 10,
		hunger = 25,
		sanity = -5,
		cooktime = 1,
		oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_NIGHTVISION,
		nightvision = true,
		potlevel = "low",
		overridebuild = "kyno_foodrecipes_cookpot",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "kyno_gummybug" }, amount = 1 },
			{ items = { "kyno_sugar" }, amount = 1 },
			{ items = { "ancientfruit_nightvision" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_gummybug" }, amount = 1 },
			{ items = { "kyno_sugar" }, amount = 2 },
			{ items = { "ancientfruit_nightvision" }, amount = 1 },
		},
		prefabs = { "kyno_nightvisionbuff" },
        oneatenfn = function(inst, eater)
            eater:AddDebuff("kyno_nightvisionbuff", "kyno_nightvisionbuff")

			if eater.components.grogginess ~= nil then
				eater.components.grogginess:MakeGrogginessAtLeast(1.5)
			end
        end,
	},
	
	pretzel =
	{
		test = function(cooker, names, tags) return tags.butter and names.kyno_salt and (tags.flour and tags.flour >= 2) end,
		priority = 30,
		foodtype = FOODTYPE.GOODIES,
		perishtime = TUNING.PERISH_MED,
		health = 40,
		hunger = 60,
		sanity = 15,
		cooktime = 2.5,
		potlevel = "low",
		overridebuild = "kyno_foodrecipes_cookpot",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "tag_butter" }, amount = 1 },
			{ items = { "kyno_salt" }, amount = 1 },
			{ items = { "tag_flour" }, amount = 2, comparator = "morethan" },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "butter" }, amount = 1 },
			{ items = { "kyno_salt" }, amount = 1 },
			{ items = { "kyno_flour" }, amount = 2 },
		},
	},
	
	cornincup =
	{
		test = function(cooker, names, tags) return names.kyno_salt and (tags.butter or tags.cheese) and (names.pepper or names.pepper_cooked) and
		(names.corn or names.corn_cooked) end,
		priority = 30,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_MED,
		temperature = TUNING.HOT_FOOD_BONUS_TEMP,
		temperatureduration = TUNING.FOOD_TEMP_AVERAGE,
		health = 50,
		hunger = 50,
		sanity = 50,
		cooktime = 0.5,
		potlevel = "low",
		overridebuild = "kyno_foodrecipes_cookpot",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "kyno_salt" }, amount = 1 },
			{ items = { "tag_butter", "tag_cheese" }, amount = 1 },
			{ items = { "pepper" }, amount = 1 },
			{ items = { "corn" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_salt" }, amount = 1 },
			{ items = { "butter" }, amount = 1 },
			{ items = { "pepper" }, amount = 1 },
			{ items = { "corn" }, amount = 1 },
		},
	},
	
	cottoncandy =
	{
		test = function(cooker, names, tags) return (tags.sugar and tags.sugar >= 3) and names.twigs end,
		priority = 30,
		foodtype = FOODTYPE.GOODIES,
		perishtime = TUNING.PERISH_SLOW,
		health = -5,
		hunger = 12.5,
		sanity = 33,
		cooktime = 1.5,
		potlevel = "med",
		overridebuild = "kyno_foodrecipes_cookpot",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "tag_sugar" }, amount = 3, comparator = "morethan" },
			{ items = { "twigs" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_sugar" }, amount = 3 },
			{ items = { "twigs" }, amount = 1 },
		},
		characterfood = {"webber"},
	},
	
	roastedhazelnuts =
	{
		test = function(cooker, names, tags) return (names.kyno_twiggynuts and names.kyno_twiggynuts >= 2) 
		and (names.acorn_cooked and names.acorn_cooked >= 2) end,
		priority = 35,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_SUPERSLOW,
		health = 10,
		hunger = 25,
		sanity = 10,
		cooktime = 1.2,
		potlevel = "low",
		overridebuild = "kyno_foodrecipes_cookpot",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "kyno_twiggynuts" }, amount = 2, comparator = "morethan" },
			{ items = { "acorn_cooked" }, amount = 2, comparator = "morethan" },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_twiggynuts" }, amount = 2 },
			{ items = { "acorn_cooked" }, amount = 2 },
		},
	},
	
	monstermuffin =
	{
		test = function(cooker, names, tags) return tags.flour and names.nightmarefuel and (tags.sweetener and tags.sweetener >= 2) end,
		priority = 30,
		foodtype = FOODTYPE.MONSTER,
		perishtime = TUNING.PERISH_SUPERSLOW,
		health = -10,
		hunger = 50,
		sanity = -15,
		cooktime = 2,
		potlevel = "low",
		overridebuild = "kyno_foodrecipes_cookpot",
		floater = TUNING.HOF_FLOATER,
		tags = {"honeyed", "monstermeat"},
		required = 
		{
			{ items = { "tag_flour" }, amount = 1 },
			{ items = { "nightmarefuel" }, amount = 1 },
			{ items = { "tag_sweetener" }, amount = 2, comparator = "morethan" },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_flour" }, amount = 1 },
			{ items = { "nightmarefuel" }, amount = 1 },
			{ items = { "honey" }, amount = 2 },
		},
		oneatenfn = function(inst, eater)
			if eater ~= nil and eater:HasTag("playermonster") or eater:HasTag("playermerm") and
			not (eater.components.health ~= nil and eater.components.health:IsDead()) and
			not eater:HasTag("playerghost") then
				eater.components.health:DoDelta(10)
				eater.components.sanity:DoDelta(15)
			end
		end,
		monsterfood = true,
		monsterhealth = 10,
		monstersanity = 15,
	},
	
	pinkcake =
	{
		test = function(cooker, names, tags) return (tags.sugar and tags.sugar >= 2) and tags.flour and tags.egg end,
		priority = 30,
		foodtype = FOODTYPE.GOODIES,
		perishtime = TUNING.PERISH_SLOW,
		health = 5,
		hunger = 62.5,
		sanity = 20,
		cooktime = 1.5,
		potlevel = "med",
		overridebuild = "kyno_foodrecipes_cookpot",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "tag_sugar" }, amount = 2, comparator = "morethan" },
			{ items = { "tag_flour" }, amount = 1 },
			{ items = { "tag_egg" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_sugar" }, amount = 2 },
			{ items = { "kyno_flour" }, amount = 1 },
			{ items = { "bird_egg" }, amount = 1 },
		},
	},
	
	chipsbag =
	{
		test = function(cooker, names, tags) return ((names.potato or 0) + (names.potato_cooked or 0) >= 2) and tags.oil and tags.spotspice end,
		priority = 30,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_MED,
		health = 40,
		hunger = 62.5,
		sanity = 5,
		cooktime = 2,
		potlevel = "low",
		overridebuild = "kyno_foodrecipes_cookpot",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "potato" }, amount = 2, comparator = "morethan" },
			{ items = { "tag_oil" }, amount = 1 },
			{ items = { "tag_spotspice" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "potato" }, amount = 2 },
			{ items = { "kyno_oil" }, amount = 1 },
			{ items = { "kyno_spotspice" }, amount = 1 },
		},
	},
	
	littlebread =
	{
		test = function(cooker, names, tags) return (tags.flour and tags.flour == 3) and tags.spotspice end,
		priority = 1,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_SUPERSLOW,
		health = 0,
		hunger = 6.375,
		sanity = 1,
		cooktime = 1,
		stacksize = 3,
		potlevel = "low",
		overridebuild = "kyno_foodrecipes_cookpot",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "tag_flour" }, amount = 3 },
			{ items = { "tag_spotspice" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_flour" }, amount = 3 },
			{ items = { "kyno_spotspice" }, amount = 1 },
		},
	},
	
	hothound =
	{
		test = function(cooker, names, tags) return names.littlebread and tags.meat and (names.tomato or names.tomato_cooked) and 
		tags.spotspice and not tags.fish end,
		priority = 30,
		foodtype = FOODTYPE.MEAT,
		perishtime = TUNING.PERISH_MED,
		health = 60,
		hunger = 32.5,
		sanity = 10,
		cooktime = 2,
		potlevel = "low",
		overridebuild = "kyno_foodrecipes_cookpot",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "littlebread" }, amount = 1 },
			{ items = { "tag_meat" }, amount = 1 },
			{ items = { "tomato" }, amount = 1 },
			{ items = { "tag_spotspice" }, amount = 1 },
		},
		excluded = 
		{
    		{ items = { "tag_fish" }, amount = 1 },
		},
		card_def = 
		{
			{ items = { "littlebread" }, amount = 1 },
			{ items = { "meat" }, amount = 1 },
			{ items = { "tomato" }, amount = 1 },
			{ items = { "kyno_spotspice" }, amount = 1 },
		},
	},
	
	milkshake =
	{
		test = function(cooker, names, tags) return tags.milk and tags.berries and tags.sweetener and tags.frozen and not tags.syrup end,
		priority = 30,
		foodtype = FOODTYPE.GOODIES,
		perishtime = TUNING.PERISH_FAST,
		temperature = TUNING.COLD_FOOD_BONUS_TEMP,
        temperatureduration = TUNING.FOOD_TEMP_AVERAGE,
		health = 30,
		hunger = 12.5,
		sanity = 30,
		cooktime = 1,
		potlevel = "med",
		overridebuild = "kyno_foodrecipes_cookpot",
		floater = TUNING.HOF_FLOATER,
		tags = {"honeyed"},
		required = 
		{
			{ items = { "tag_milk" }, amount = 1 },
			{ items = { "tag_berries" }, amount = 1 },
			{ items = { "tag_sweetener" }, amount = 1 },
			{ items = { "ice" }, amount = 1 },
		},
		excluded = 
		{
    		{ items = { "tag_syrup" } }
		},
		card_def = 
		{
			{ items = { "goatmilk" }, amount = 1 },
			{ items = { "berries" }, amount = 1 },
			{ items = { "honey" }, amount = 1 },
			{ items = { "ice" }, amount = 1 },
		},
	},
	
	banana_pudding =
	{
		test = function(cooker, names, tags) return (tags.banana and tags.banana >= 2) and tags.milk and tags.sweetener end,
		priority = 35,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_FAST,
		health = 20,
		hunger = 12.5,
		sanity = 50,
		cooktime = .8,
		potlevel = "low",
		overridebuild = "kyno_foodrecipes_cookpot",
		floater = TUNING.HOF_FLOATER,
		tags = {"honeyed", "monkeyqueenbribe"},
		required = 
		{
			{ items = { "tag_banana" }, amount = 2, comparator = "morethan" },
			{ items = { "tag_milk" }, amount = 1 },
			{ items = { "tag_sweetener" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_banana" }, amount = 2 },
			{ items = { "goatmilk" }, amount = 1 },
			{ items = { "honey" }, amount = 1 },
		},
		characterfood = {"wonkey"},
	},
	
	sea_pudding =
	{
		test = function(cooker, names, tags) return (names.eel or names.eel_cooked or names.pondeel) and tags.mussel
		and names.kyno_grouper and tags.algae end,
		priority = 30,
		foodtype = FOODTYPE.MEAT,
		perishtime = TUNING.PERISH_SUPERFAST,
		health = 60,
		hunger = 150,
		sanity = 5,
		cooktime = 1,
		oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_FISHING,
		potlevel = "low",
		overridebuild = "kyno_foodrecipes_cookpot",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "pondeel" }, amount = 1 },
			{ items = { "kyno_mussel" }, amount = 1 },
			{ items = { "kyno_grouper" }, amount = 1 },
			{ items = { "tag_algae" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "pondeel" }, amount = 1 },
			{ items = { "kyno_mussel" }, amount = 1 },
			{ items = { "kyno_grouper" }, amount = 1 },
			{ items = { "kelp" }, amount = 1 },
		},
		prefabs = { "kyno_fishingbuff" },
		oneatenfn = function(inst, eater)
			eater:AddDebuff("kyno_fishingbuff", "kyno_fishingbuff")
		end,
	},
	
	minertreat =
	{
		test = function(cooker, names, tags) return tags.fruit and (tags.sweetener and tags.sweetener >= 2) and names.twigs end,
		priority = 35,
		foodtype = FOODTYPE.GOODIES,
		perishtime = TUNING.PERISH_MED,
		health = -3,
		hunger = 12.5,
		sanity = 15,
		cooktime = 0.8,
		potlevel = "med",
		overridebuild = "kyno_foodrecipes_cookpot",
		floater = TUNING.HOF_FLOATER,
		tags = {"honeyed"},
		required = 
		{
			{ items = { "tag_fruit" }, amount = 1 },
			{ items = { "tag_sweetener" }, amount = 2, comparator = "morethan" },
			{ items = { "twigs" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "pomegranate" }, amount = 1 },
			{ items = { "honey" }, amount = 2 },
			{ items = { "twigs" }, amount = 1 },
		},
	},
	
	radishsalad =
	{
		test = function(cooker, names, tags) return ((names.kyno_radish or 0) + (names.kyno_radish_cooked or 0) >= 3) and tags.spotspice end,
		priority = 30,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_MED,
		health = 15,
		hunger = 62.5,
		sanity = 5,
		cooktime = 1.2,
		potlevel = "med",
		overridebuild = "kyno_foodrecipes_cookpot",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "kyno_radish" }, amount = 3, comparator = "morethan" },
			{ items = { "tag_spotspice" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_radish" }, amount = 3 },
			{ items = { "kyno_spotspice" }, amount = 1 },
		},
	},
	
	pumpkin_soup =
	{
		test = function(cooker, names, tags) return ((names.pumpkin or 0) + (names.pumpkin_cooked or 0) >= 2) and tags.butter and tags.spotspice end,
		priority = 30,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_MED,
		health = 40,
		hunger = 100,
		sanity = 33,
		cooktime = 2,
		potlevel = "low",
		overridebuild = "kyno_foodrecipes_cookpot",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "pumpkin" }, amount = 2, comparator = "morethan" },
			{ items = { "tag_butter" }, amount = 1 },
			{ items = { "tag_spotspice" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "pumpkin" }, amount = 2 },
			{ items = { "butter" }, amount = 1 },
			{ items = { "kyno_spotspice" }, amount = 1 },
		},
	},
	
	parznip_soup =
	{
		test = function(cooker, names, tags) return ((names.kyno_parznip or 0) + (names.kyno_parznip_cooked or 0) + (names.kyno_parznip_eaten or 0) >= 3) and
		tags.succulent end,
		priority = 30,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_MED,
		health = 15,
		hunger = 32.5,
		sanity = 5,
		cooktime = 1,
		oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_EATER,
		potlevel = "med",
		overridebuild = "kyno_foodrecipes_cookpot1",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "kyno_parznip", "kyno_parznip_eaten", "kyno_parznip_cooked" }, amount = 3, comparator = "morethan" },
			{ items = { "tag_succulent" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_parznip" }, amount = 3 },
			{ items = { "succulent_picked" }, amount = 1 },
		},
		oneatenfn = function(inst, eater)
		prefabs = { "kyno_eaterbuff" },
            eater:AddDebuff("kyno_eaterbuff", "kyno_eaterbuff")
        end,
	},
	
	algae_soup =
	{
		test = function(cooker, names, tags) return (tags.algae and tags.algae >= 3) and not tags.meat and not tags.fish end,
		priority = 30,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_MED,
		health = 10,
		hunger = 75,
		sanity = 25,
		cooktime = 1.5,
		potlevel = "med",
		overridebuild = "kyno_foodrecipes_cookpot",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "tag_algae" }, amount = 3, comparator = "morethan" },
		},
		excluded = 
		{
    		{ items = { "tag_fish" } },
			{ items = { "tag_meat" } },
		},
		card_def = 
		{
			{ items = { "kelp" }, amount = 2 },
			{ items = { "kyno_waterycress" }, amount = 1 },
			{ items = { "kyno_seaweeds" }, amount = 1 },
		},
	},
	
	duriansplit =
	{
		test = function(cooker, names, tags) return (names.durian or names.durian_cooked) and tags.banana and tags.frozen and tags.fruit end,
		priority = 30,
		foodtype = FOODTYPE.MONSTER,
		perishtime = TUNING.PERISH_FAST,
		temperature = TUNING.COLD_FOOD_BONUS_TEMP,
		temperatureduration = TUNING.FOOD_TEMP_AVERAGE,
		health = -5,
		hunger = 32.5,
		sanity = -15,
		cooktime = 1,
		potlevel = "med",
		overridebuild = "kyno_foodrecipes_cookpot",
		floater = TUNING.HOF_FLOATER,
		tags = {"monstermeat"},
		required = 
		{
			{ items = { "durian" }, amount = 1 },
			{ items = { "tag_banana" }, amount = 1 },
			{ items = { "ice" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "durian" }, amount = 1 },
			{ items = { "kyno_banana" }, amount = 2 },
			{ items = { "ice" }, amount = 1 },
		},
		oneatenfn = function(inst, eater)
			if eater ~= nil and eater:HasTag("playermonster") or eater:HasTag("playermerm") and
			not (eater.components.health ~= nil and eater.components.health:IsDead()) and
			not eater:HasTag("playerghost") then
				eater.components.health:DoDelta(5)
				eater.components.sanity:DoDelta(15)
			end
		end,
		monsterfood = true,
		monsterhealth = 5,
		monstersanity = 15,
	},
	
	duriansoup =
	{
		test = function(cooker, names, tags) return (names.durian or names.durian_cooked) and (tags.veggie and tags.veggie >= 3) and not tags.inedible end,
		priority = 35,
		foodtype = FOODTYPE.MONSTER,
		perishtime = TUNING.PERISH_MED,
		temperature = TUNING.HOT_FOOD_BONUS_TEMP,
		temperatureduration = TUNING.FOOD_TEMP_AVERAGE,
		health = -15,
		hunger = 37.5,
		sanity = 0,
		cooktime = 1.5,
		potlevel = "high",
		overridebuild = "kyno_foodrecipes_cookpot",
		floater = TUNING.HOF_FLOATER,
		tags = {"monstermeat"},
		required = 
		{
			{ items = { "durian" }, amount = 1 },
			{ items = { "tag_veggie" }, amount = 3, comparator = "morethan" },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "durian" }, amount = 1 },
			{ items = { "carrot" }, amount = 3 },
		},
		oneatenfn = function(inst, eater)
			if eater ~= nil and eater:HasTag("playermonster") or eater:HasTag("playermerm") and
			not (eater.components.health ~= nil and eater.components.health:IsDead()) and
			not eater:HasTag("playerghost") then
				eater.components.health:DoDelta(15)
			end
		end,
		monsterfood = true,
		monsterhealth = 15,
		monstersanity = 0,
	},
	
	durianmeated =
	{
		test = function(cooker, names, tags) return (names.monstermeat or names.monstermeat_cooked or names.monstermeat_dried) 
		and (names.durian or names.durian_cooked) end,
		priority = 40,
		foodtype = FOODTYPE.MONSTER,
		perishtime = TUNING.PERISH_SLOW,
		health = -20,
		hunger = 37.5,
		sanity = -5,
		cooktime = 1.2,
		overridebuild = "kyno_foodrecipes_cookpot",
		floater = TUNING.HOF_FLOATER,
		tags = {"monstermeat"},
		required = 
		{
			{ items = { "tag_monster" }, amount = 1 },
			{ items = { "durian" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "monstermeat" }, amount = 1 },
			{ items = { "durian" }, amount = 1 },
			{ items = { "twigs" }, amount = 2 },
		},
		oneatenfn = function(inst, eater)
			if eater ~= nil and eater:HasTag("playermonster") and
			not (eater.components.health ~= nil and eater.components.health:IsDead()) and
			not eater:HasTag("playerghost") then
				eater.components.health:DoDelta(20)
				eater.components.sanity:DoDelta(5)
			end
		end,
		monsterfood = true,
		monsterhealth = 20,
		monstersanity = 5,
	},
	
	durianchicken =
	{
		test = function(cooker, names, tags) return names.durian and (names.cactus_meat and names.cactus_meat >= 2) 
		and names.cactus_flower and not names.durian_cooked and not names.cactus_meat_cooked end,
		priority = 30,
		foodtype = FOODTYPE.MONSTER,
		perishtime = TUNING.PERISH_FASTISH,
		health = -10,
		hunger = 45,
		sanity = -30,
		cooktime = 1,
		scale = 1.8,
		overridebuild = "kyno_foodrecipes_cookpot",
		floater = TUNING.HOF_FLOATER,
		tags = {"monstermeat"},
		required = 
		{
			{ items = { "durian" }, amount = 1 },
			{ items = { "cactus_meat" }, amount = 2, comparator = "morethan" },
			{ items = { "cactus_flower" }, amount = 1 },
		},
		excluded = 
		{
			{ items = { "durian_cooked" } },
    		{ items = { "cactus_meat_cooked" } },
		},
		card_def = 
		{
			{ items = { "durian" }, amount = 1 },
			{ items = { "cactus_meat" }, amount = 2 },
			{ items = { "cactus_flower" }, amount = 1 },
		},
		oneatenfn = function(inst, eater)
			if eater ~= nil and eater:HasTag("playermonster") or eater:HasTag("playermerm") and
			not (eater.components.health ~= nil and eater.components.health:IsDead()) and
			not eater:HasTag("playerghost") then
				eater.components.health:DoDelta(10)
				eater.components.sanity:DoDelta(30)
			end
		end,
		characterfood = {"wurt"},
		mermfood = true,
		mermhealth = 10,
		mermsanity = 30,
		monsterfood = true,
		monsterhealth = 10,
		monstersanity = 30,
	},
	
	berrybombs =
	{
		test = function(cooker, names, tags) return (tags.berries and tags.berries >= 2) and names.twigs end,
		priority = 35,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_MED,
		health = 12,
		hunger = 18.25,
		sanity = 5,
		cooktime = 1,
		overridebuild = "kyno_foodrecipes_cookpot",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "tag_berries" }, amount = 2, comparator = "morethan" },
			{ items = { "twigs" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "berries" }, amount = 3 },
			{ items = { "twigs" }, amount = 1 },
		},
	},
	
	chimas =
	{
		test = function(cooker, names, tags) return (tags.tillweed and tags.tillweed >= 2) and tags.frozen end,
		priority = 35,
		foodtype = FOODTYPE.GOODIES,
		perishtime = TUNING.PERISH_SLOW,
		temperature = TUNING.HOT_FOOD_BONUS_TEMP,
		temperatureduration = TUNING.FOOD_TEMP_AVERAGE,
		health = 5,
		hunger = 12.5,
		sanity = 33,
		cooktime = 1.2,
		overridebuild = "kyno_foodrecipes_cookpot",
		floater = TUNING.HOF_FLOATER,
		tags = {"fooddrink"},
		required = 
		{
			{ items = { "tag_tillweed" }, amount = 2, comparator = "morethan" },
			{ items = { "ice" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "tillweed" }, amount = 2 },
			{ items = { "ice" }, amount = 2 },
		},
	},
	
	antslog =
	{
		test = function(cooker, names, tags) return names.livinglog and (names.kyno_twiggynuts and names.kyno_twiggynuts >= 2) and
		(names.fig or names.fig_cooked) end,
		priority = 35,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_FAST,
		health = 15,
		hunger = 25,
		sanity = 15,
		cooktime = 1.1,
		potlevel = "med",
		overridebuild = "kyno_foodrecipes_cookpot",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "livinglog" }, amount = 1 },
			{ items = { "kyno_twiggynuts" }, amount = 2, comparator = "morethan" },
			{ items = { "fig" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "livinglog" }, amount = 1 },
			{ items = { "kyno_twiggynuts" }, amount = 2 },
			{ items = { "fig" }, amount = 1 },
		},
		oneatenfn = function(inst, eater)
			if eater ~= nil and eater.SoundEmitter ~= nil then
				eater.SoundEmitter:PlaySound("dontstarve/creatures/leif/livinglog_burn")
			else
				inst.SoundEmitter:PlaySound("dontstarve/creatures/leif/livinglog_burn")
			end
		end,
	},
	
	eeltacos =
	{
		test = function(cooker, names, tags) return (names.eel or names.pondeel or names.eel_cooked) and 
		(names.corn or names.corn_cooked or names.oceanfish_small_5_inv or names.oceanfish_medium_5_inv) and names.cutlichen end,
		priority = 30,
		foodtype = FOODTYPE.MEAT,
		perishtime = TUNING.PERISH_FAST,
		health = 5,
		hunger = 37.5,
		sanity = 20,
		cooktime = .5,
		overridebuild = "kyno_foodrecipes_cookpot",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "pondeel" }, amount = 1 },
			{ items = { "corn" }, amount = 1 },
			{ items = { "cutlichen" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "pondeel" }, amount = 1 },
			{ items = { "corn" }, amount = 1 },
			{ items = { "cutlichen" }, amount = 2 },
		},
	},
	
	livingsandwich =
	{
		test = function(cooker, names, tags) return (names.livinglog and names.livinglog >= 2) and 
		((names.monstermeat or 0) + (names.monstermeat_cooked or 0) >= 2) end,
		priority = 1,
		isfuel = true,
		foodtype = FOODTYPE.MEAT,
		secondaryfoodtype = FOODTYPE.MONSTER,
		perishtime = TUNING.PERISH_SUPERSLOW,
		health = 10,
		hunger = 40,
		sanity = -5,
		cooktime = 1,
		oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_CURSE,
		potlevel = "low",
		pickupsound = "wood",
		overridebuild = "kyno_foodrecipes_cookpot1",
		floater = TUNING.HOF_FLOATER,
		tags = {"wereitem"},
		required = 
		{
			{ items = { "livinglog" }, amount = 2, comparator = "morethan" },
			{ items = { "tag_monster" }, amount = 2, comparator = "morethan" },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "livinglog" }, amount = 2 },
			{ items = { "monstermeat" }, amount = 2 },
		},
		oneatenfn = function(inst, eater)
			local WEREMODE_NAMES =
			{
				"beaver",
				"moose",
				"goose",
			}
			
			if eater ~= nil and eater.components.wereeater ~= nil 
			and not (eater.components.health ~= nil and eater.components.health:IsDead()) and not eater:HasTag("playerghost") then
				eater.components.wereeater:ForceTransformToWere(math.random(#WEREMODE_NAMES))
			end
				
			if eater ~= nil and eater.SoundEmitter ~= nil then
				eater.SoundEmitter:PlaySound("dontstarve/creatures/leif/livinglog_burn")
			else
				inst.SoundEmitter:PlaySound("dontstarve/creatures/leif/livinglog_burn")
			end
		end,
	},
	
	lunarsoup =
	{
		test = function(cooker, names, tags) return (names.carrot or names.carrot_cooked) and (names.moon_cap or names.moon_cap_cooked
		or names.kyno_moon_cap_dried) and ((names.rock_avocado_fruit_ripe or 0) + (names.rock_avocado_fruit_ripe_cooked or 0) >= 2) 
		and not tags.meat end,
		priority = 35,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_MED,
		health = 25,
		hunger = 18.75,
		sanity = 0,
		cooktime = 1,
		oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_FEARSLEEP,
		overridebuild = "kyno_foodrecipes_cookpot1",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "carrot" }, amount = 1 },
			{ items = { "moon_cap" }, amount = 1 },
			{ items = { "rock_avocado_fruit_ripe" }, amount = 2, comparator = "morethan" },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "carrot" }, amount = 1 },
			{ items = { "moon_cap" }, amount = 1 },
			{ items = { "rock_avocado_fruit_ripe" }, amount = 2 },
		},
		prefabs = { "buff_sleepresistance", "kyno_fearbuff" },
		oneatenfn = function(inst, eater)
            if eater.components.grogginess ~= nil and
			not (eater.components.health ~= nil and eater.components.health:IsDead()) and
			not eater:HasTag("playerghost") then
				eater.components.grogginess:ResetGrogginess()
            end

			eater:AddDebuff("shroomsleepresist", "buff_sleepresistance")
			eater:AddDebuff("kyno_fearbuff", "kyno_fearbuff")
        end,
	},
	
	purplewobstersoup =
	{
		test = function(cooker, names, tags) return tags.wobster and names.kyno_grouper and (names.kyno_turnip or names.kyno_turnip_cooked) end,
		priority = 30,
		foodtype = FOODTYPE.MONSTER,
		perishtime = TUNING.PERISH_SLOW,
		health = -60,
		hunger = 62.5,
		sanity = -5,
		cooktime = 2,
		overridebuild = "kyno_foodrecipes_cookpot1",
		floater = TUNING.HOF_FLOATER,
		tags = {"monstermeat"},
		required = 
		{
			{ items = { "tag_wobster" }, amount = 1 },
			{ items = { "kyno_grouper" }, amount = 1 },
			{ items = { "kyno_turnip" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "wobster_sheller_land" }, amount = 1 },
			{ items = { "kyno_grouper" }, amount = 1 },
			{ items = { "kyno_turnip" }, amount = 2 },
		},
		oneatenfn = function(inst, eater)
			if eater ~= nil and eater:HasTag("playermonster") and
			not (eater.components.health ~= nil and eater.components.health:IsDead()) and
			not eater:HasTag("playerghost") then
				eater.components.health:DoDelta(60)
				eater.components.sanity:DoDelta(5)
			end
		end,
		monsterfood = true,
		monsterhealth = 60,
		monstersanity = 5,
	},
	
	wobstermonster =
	{
		test = function(cooker, names, tags) return tags.wobster and (names.monstermeat or names.monstermeat_cooked
		or names.monstermeat_dried) and (tags.veggie and tags.veggie >= 2) end,
		priority = 35,
		foodtype = FOODTYPE.MONSTER,
		perishtime = TUNING.PERISH_MED,
		temperature = TUNING.HOT_FOOD_BONUS_TEMP,
		temperatureduration = TUNING.FOOD_TEMP_AVERAGE,
		health = -60,
		hunger = 37.5,
		sanity = -20,
		cooktime = 2,
		potlevel = "high",
		overridebuild = "kyno_foodrecipes_cookpot1",
		floater = TUNING.HOF_FLOATER,
		tags = {"monstermeat"},
		required = 
		{
			{ items = { "tag_wobster" }, amount = 1 },
			{ items = { "tag_monster" }, amount = 1 },
			{ items = { "tag_veggie" }, amount = 2, comparator = "morethan" },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "wobster_sheller_land" }, amount = 1 },
			{ items = { "monstermeat" }, amount = 1 },
			{ items = { "carrot" }, amount = 2 },
		},
		oneatenfn = function(inst, eater)
			if eater ~= nil and eater:HasTag("playermonster") and
			not (eater.components.health ~= nil and eater.components.health:IsDead()) and
			not eater:HasTag("playerghost") then
				eater.components.health:DoDelta(60)
				eater.components.sanity:DoDelta(20)
			end
		end,
		monsterfood = true,
		monsterhealth = 60,
		monstersanity = 20,
	},
	
	spidercake =
	{
		test = function(cooker, names, tags) return names.spider and (names.monstermeat or names.monstermeat_cooked 
		or names.monstermeat_dried) and tags.egg and tags.flour end,
		priority = 1,
		foodtype = FOODTYPE.MONSTER,
		perishtime = TUNING.PERISH_SUPERSLOW,
		health = -20,
		hunger = 37.5,
		sanity = -20,
		cooktime = 2,
		potlevel = "high",
		overridebuild = "kyno_foodrecipes_cookpot1",
		floater = TUNING.HOF_FLOATER,
		tags = {"monstermeat"},
		required = 
		{
			{ items = { "spider" }, amount = 1 },
			{ items = { "tag_monster" }, amount = 1 },
			{ items = { "tag_egg" }, amount = 1 },
			{ items = { "tag_flour" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "spider" }, amount = 1 },
			{ items = { "monstermeat" }, amount = 1 },
			{ items = { "bird_egg" }, amount = 1 },
			{ items = { "kyno_flour" }, amount = 1 },
		},
		oneatenfn = function(inst, eater)
			if eater ~= nil and eater:HasTag("playermonster") and
			not (eater.components.health ~= nil and eater.components.health:IsDead()) and
			not eater:HasTag("playerghost") then
				eater.components.health:DoDelta(20)
				eater.components.sanity:DoDelta(20)
			end
		end,
		monsterfood = true,
		monsterhealth = 20,
		monstersanity = 20,
	},
	
	sugarbombs =
	{
		test = function(cooker, names, tags) return (tags.sugar and tags.sugar >= 2) and ((names.kyno_wheat or 0) + (names.kyno_wheat_cooked or 0) >= 2) end,
		priority = 30,
		foodtype = FOODTYPE.GOODIES,
		perishtime = 9000000,
		health = 5,
		hunger = 20,
		sanity = 15,
		cooktime = 1.5,
		oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_SUGARBOMBS,
		potlevel = "low",
		overridebuild = "kyno_foodrecipes_cookpot1",
		floater = TUNING.HOF_FLOATER,
		luckitem = { luck = TUNING.KYNO_LUCK_SUPERTINY },
		required = 
		{
			{ items = { "tag_sugar" }, amount = 2, comparator = "morethan" },
			{ items = { "kyno_wheat" }, amount = 2 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_sugar" }, amount = 2 },
			{ items = { "kyno_wheat" }, amount = 2 },
		},
	},
	
	onigiris =
	{
		test = function(cooker, names, tags) return ((names.kyno_rice or 0) + (names.kyno_rice_cooked or 0) >= 2) and tags.spotspice and tags.algae end,
		priority = 35,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_MED,
		health = 8,
		hunger = 20,
		sanity = 8,
		cooktime = 1.1,
		stacksize = 2,
		potlevel = "high",
		overridebuild = "kyno_foodrecipes_cookpot1",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "kyno_rice" }, amount = 2, comparator = "morethan" },
			{ items = { "tag_spotspice" }, amount = 1 },
			{ items = { "tag_algae" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_rice" }, amount = 2 },
			{ items = { "kyno_spotspice" }, amount = 1 },
			{ items = { "kyno_seaweeds" }, amount = 1 },
		},
	},
	
	omurice =
	{
		test = function(cooker, names, tags) return tags.egg and ((names.kyno_rice or 0) + (names.kyno_rice_cooked or 0) >= 2) 
		and (names.tomato or names.tomato_cooked) end,
		priority = 35,
		foodtype = FOODTYPE.MEAT,
		perishtime = TUNING.PERISH_SLOW,
		health = 30,
		hunger = 32.5,
		sanity = 10,
		cooktime = 1.5,
		potlevel = "med",
		overridebuild = "kyno_foodrecipes_cookpot1",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "tag_egg" }, amount = 1 },
			{ items = { "kyno_rice" }, amount = 2, comparator = "morethan" },
			{ items = { "tomato" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "bird_egg" }, amount = 1 },
			{ items = { "kyno_rice" }, amount = 2 },
			{ items = { "tomato" }, amount = 1 },
		},
	},
	
	paella =
	{
		test = function(cooker, names, tags) return (names.kyno_rice or names.kyno_rice_cooked) and (names.kyno_mussel or names.kyno_mussel_cooked)
		and tags.spotspice and tags.fish end,
		priority = 30,
		foodtype = FOODTYPE.MEAT,
		perishtime = TUNING.PERISH_FASTISH,
		temperature = TUNING.HOT_FOOD_BONUS_TEMP,
		temperatureduration = TUNING.FOOD_TEMP_BRIEF,
		health = 20,
		hunger = 50,
		sanity = 10,
		cooktime = 2.0,
		stacksize = 2,
		overridebuild = "kyno_foodrecipes_cookpot1",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "kyno_rice" }, amount = 1 },
			{ items = { "kyno_mussel" }, amount = 1 },
			{ items = { "tag_spotspice" }, amount = 1 },
			{ items = { "tag_fish" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_rice" }, amount = 1 },
			{ items = { "kyno_mussel" }, amount = 1 },
			{ items = { "kyno_spotspice" }, amount = 1 },
			{ items = { "pondfish" }, amount = 1 },
		},
	},
	
	pizza_tropical =
	{
		test = function(cooker, names, tags) return tags.fish and tags.flour and tags.dairy and 
		(names.kyno_pineapple_halved or names.kyno_pineapple_cooked) end,
		priority = 35,
		foodtype = FOODTYPE.MEAT,
		perishtime = TUNING.PERISH_MED,
		health = 60,
		hunger = 75,
		sanity = 15,
		cooktime = 2.5,
		potlevel = "high",
		overridebuild = "kyno_foodrecipes_cookpot1",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "tag_fish" }, amount = 1 },
			{ items = { "tag_flour" }, amount = 1 },
			{ items = { "tag_dairy" }, amount = 1 },
			{ items = { "kyno_pineapple_halved", "kyno_pineapple_halved_cooked" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "pondfish" }, amount = 1 },
			{ items = { "kyno_flour" }, amount = 1 },
			{ items = { "goatmilk" }, amount = 1 },
			{ items = { "kyno_pineapple_halved" }, amount = 1 },
		},
	},
	
	pinacolada = 
	{
		test = function(cooker, names, tags) return names.kyno_pineapple_halved and names.kyno_kokonut_halved and tags.sweetener and tags.frozen
		and not names.kyno_pineapple_cooked and not names.kyno_kokonut_cooked end,
		priority = 30,
		foodtype = FOODTYPE.GOODIES,
		perishtime = TUNING.PERISH_MED,
		temperature = TUNING.COLD_FOOD_BONUS_TEMP,
		temperatureduration = TUNING.FOOD_TEMP_AVERAGE,
		health = 25,
		hunger = 25,
		sanity = 10,
		cooktime = 0.5,
		potlevel = "med",
		overridebuild = "kyno_foodrecipes_cookpot1",
		floater = TUNING.HOF_FLOATER,
		tags = {"honeyed", "fooddrink"},
		required = 
		{
			{ items = { "kyno_pineapple_halved" }, amount = 1 },
			{ items = { "kyno_kokonut_halved" }, amount = 1 },
			{ items = { "tag_sweetener" }, amount = 1 },
			{ items = { "ice" }, amount = 1 },
		},
		excluded = 
		{
    		{ items = { "kyno_pineapple_halved_cooked" } },
			{ items = { "kyno_kokonut_halved_cooked" } },
		},
		card_def = 
		{
			{ items = { "kyno_pineapple_halved" }, amount = 1 },
			{ items = { "kyno_kokonut_halved" }, amount = 1 },
			{ items = { "honey" }, amount = 1 },
			{ items = { "ice" }, amount = 1 },
		},
	},
	
	smores =
	{
		test = function(cooker, names, tags) return (names.kyno_sugar and names.kyno_sugar  >= 2) and tags.flour and tags.chocolate end,
		priority = 30,
		foodtype = FOODTYPE.GOODIES,
		perishtime = TUNING.PERISH_SLOW,
		health = 15,
		hunger = 65,
		sanity = 65,
		cooktime = 2,
		potlevel = "low",
		overridebuild = "kyno_foodrecipes_cookpot1",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "kyno_sugar" }, amount = 2, comparator = "morethan" },
			{ items = { "tag_flour" }, amount = 1 },
			{ items = { "tag_chocolate" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_sugar" }, amount = 2 },
			{ items = { "kyno_flour" }, amount = 1 },
			{ items = { "chocolate_black" }, amount = 1 },
		},
		characterfood = {"walter"},
	},
	
	moonbutterflymuffin =
	{
		test = function(cooker, names, tags) return names.moonbutterflywings and not tags.meat and (tags.veggie and tags.veggie >= 0.5) end,
		priority = 1,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_MED,
		health = 5,
		hunger = 37.5,
		sanity = 20,
		cooktime = 2,
		potlevel = "low",
		nameoverride = "BUTTERFLYMUFFIN",
		overridebuild = "kyno_foodrecipes_cookpot1",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "moonbutterflywings" }, amount = 1},
			{ items = { "tag_veggie" }, amount = 1, comparator = "morethan" },
		},
		excluded = 
		{
    		{ items = { "tag_meat" } },
		},
		card_def = 
		{
			{ items = { "moonbutterflywings" }, amount = 1 },
			{ items = { "carrot" }, amount = 1 },
			{ items = { "twigs" }, amount = 2 },
		},
	},
	
	sugarflymuffin =
	{
		test = function(cooker, names, tags) return names.kyno_sugarflywings and not tags.meat and (tags.veggie and tags.veggie >= 0.5) end,
		priority = 1,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_MED,
		health = 20,
		hunger = 18.75,
		sanity = 20,
		cooktime = 2,
		potlevel = "low",
		overridebuild = "kyno_foodrecipes_cookpot1",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "kyno_sugarflywings" }, amount = 1 },
			{ items = { "tag_veggie" }, amount = 1, comparator = "morethan" },
		},
		excluded = 
		{
    		{ items = { "tag_meat" } },
		},
		card_def = 
		{
			{ items = { "kyno_sugarflywings" }, amount = 1 },
			{ items = { "carrot" }, amount = 1 },
			{ items = { "twigs" }, amount = 2 },
		},
	},
	
	meatwaltz =
	{
		test = function(cooker, names, tags) return tags.meat and tags.bread and 
		(names.tomato or names.tomato_cooked) and (names.onion or names.onion_cooked) end,
		priority = 35,
		foodtype = FOODTYPE.MEAT,
		perishtime = TUNING.PERISH_MED,
		health = 30,
		hunger = 37.5,
		sanity = 5,
		cooktime = .7,
		oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_INSPIRATION,
		overridebuild = "kyno_foodrecipes_cookpot1",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "tag_meat" }, amount = 1 },
			{ items = { "tag_bread" }, amount = 1 },
			{ items = { "tomato" }, amount = 1 },
			{ items = { "onion" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "meat" }, amount = 1 },
			{ items = { "bread" }, amount = 1 },
			{ items = { "tomato" }, amount = 1 },
			{ items = { "onion" }, amount = 1 },
		},
		oneatenfn = function(inst, eater)
			if eater ~= nil and eater.components.singinginspiration ~= nil then
				eater.components.singinginspiration:DoDelta(TUNING.KYNO_INSPIRATIONBUFF)
			end
		end,
	},
	
	completebreakfast = 
	{
		test = function(cooker, names, tags) return names.baconeggs and tags.flour and tags.butter and tags.syrup end,
		priority = 30,
		foodtype = FOODTYPE.MEAT,
		secondaryfoodtype = FOODTYPE.GOODIES,
		perishtime = TUNING.PERISH_PRESERVED,
		health = 60,
		hunger = 150,
		sanity = 5,
		cooktime = 3,
		oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_MIGHTINESS,
		potlevel = "high",
		scale = 1.3,
		overridebuild = "kyno_foodrecipes_cookpot1",
		floater = TUNING.HOF_FLOATER,
		tags = {"honeyed"},
		required = 
		{
			{ items = { "baconeggs" }, amount = 1 },
			{ items = { "tag_flour" }, amount = 1 },
			{ items = { "tag_butter" }, amount = 1 },
			{ items = { "tag_syrup" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "baconeggs" }, amount = 1 },
			{ items = { "kyno_flour" }, amount = 1 },
			{ items = { "butter" }, amount = 1 },
			{ items = { "kyno_syrup" }, amount = 1 },
		},
		oneatenfn = function(inst, eater)
			if eater ~= nil and eater.components.mightiness ~= nil then
				eater.components.mightiness:DoDelta(TUNING.KYNO_MIGHTINESSBUFF)
			end
		end,
	},
	
	dumplings =
	{
		test = function(cooker, names, tags) return tags.flour and (tags.veggie and tags.veggie >= 1) and (tags.meat and tags.meat < 1) and tags.oil end,
		priority = 25,
		foodtype = FOODTYPE.MEAT,
		perishtime = TUNING.PERISH_MED,
		health = 15,
		hunger = 25,
		sanity = 10,
		cooktime = 1.3,
		potlevel = "high",
		overridebuild = "kyno_foodrecipes_cookpot1",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "tag_flour" }, amount = 1 },
			{ items = { "tag_veggie" }, amount = 1, comparator = "morethan" },
			{ items = { "tag_meat" }, amount = 1, comparator = "lessthan" },
			{ items = { "tag_oil" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_flour" }, amount = 1 },
			{ items = { "carrot" }, amount = 1 },
			{ items = { "smallmeat" }, amount = 1 },
			{ items = { "kyno_oil" }, amount = 1 },
		},
	},
	
	coxinha =
	{
		test = function(cooker, names, tags) return (names.drumstick or names.drumstick_cooked) and tags.flour and tags.oil
		and (names.garlic or names.garlic_cooked) end,
		priority = 30,
		foodtype = FOODTYPE.MEAT,
		perishtime = TUNING.PERISH_MED,
		health = 15,
		hunger = 32.5,
		sanity = 0,
		cooktime = 1.5,
		overridebuild = "kyno_foodrecipes_cookpot1",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "drumstick" }, amount = 1 },
			{ items = { "tag_flour" }, amount = 1 },
			{ items = { "tag_oil" }, amount = 1 },
			{ items = { "garlic" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "drumstick" }, amount = 1 },
			{ items = { "kyno_flour" }, amount = 1 },
			{ items = { "kyno_oil" }, amount = 1 },
			{ items = { "garlic" }, amount = 1 },
		},
	},
	
	crabkingfeast =
	{
		test = function(cooker, names, tags) return (names.kyno_crabkingmeat or names.kyno_crabkingmeat_cooked or names.kyno_crabkingmeat_dried)
		and tags.spotspice and names.corn and (names.onion or names.onion_cooked) and not names.corn_cooked end,
		priority = 30,
		foodtype = FOODTYPE.MEAT,
		perishtime = TUNING.PERISH_PRESERVED,
		health = 40,
		hunger = 62.5,
		sanity = 33,
		cooktime = 2,
		scale = 2,
		oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_CRAB,
		overridebuild = "kyno_foodrecipes_cookpot1",
		floater = TUNING.HOF_FLOATER,
		tags = {"masterfood"},
		required = 
		{
			{ items = { "kyno_crabkingmeat" }, amount = 1 },
			{ items = { "tag_spotspice" }, amount = 1 },
			{ items = { "corn" }, amount = 1 },
			{ items = { "onion" }, amount = 1 },
		},
		excluded = 
		{
    		{ items = { "corn_cooked" } },
		},
		card_def = 
		{
			{ items = { "kyno_crabkingmeat" }, amount = 1 },
			{ items = { "kyno_spotspice" }, amount = 1 },
			{ items = { "corn" }, amount = 1 },
			{ items = { "onion" }, amount = 1 },
		},
		prefabs = { "kyno_crabbuff" },
		oneatenfn = function(inst, eater)
			eater:AddDebuff("kyno_crabbuff", "kyno_crabbuff")
		end,
	},
	
	pienapple =
	{
		test = function(cooker, names, tags) return (names.kyno_pineapple_halved or names.kyno_pineapple_cooked) and not tags.meat end,
		priority = 15,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_MED,
		health = 40,
		hunger = 25,
		sanity = 5,
		cooktime = 2,
		potlevel = "high",
		overridebuild = "kyno_foodrecipes_cookpot1",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "kyno_pineapple_halved", "kyno_pineapple_halved_cooked" }, amount = 1 },
		},
		excluded = 
		{
    		{ items = { "tag_meat" } },
		},
		card_def = 
		{
			{ items = { "kyno_pineapple_halved" }, amount = 1 },
			{ items = { "twigs" }, amount = 3 },
		},
	},
	
	avocadotoast =
	{
		test = function(cooker, names, tags) return ((names.rock_avocado_fruit_ripe or 0) + (names.rock_avocado_fruit_ripe_cooked or 0) >= 2)
		and tags.bread end,
		priority = 30,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_PRESERVED,
		health = 5,
		hunger = 37.5,
		sanity = 5,
		cooktime = 1.3,
		overridebuild = "kyno_foodrecipes_cookpot1",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "rock_avocado_fruit_ripe" }, amount = 2, comparator = "morethan" },
			{ items = { "tag_bread" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "rock_avocado_fruit_ripe" }, amount = 2 },
			{ items = { "bread" }, amount = 1 },
			{ items = { "twigs" }, amount = 1 },
		},
	},
	
	ricepudding =
	{
		test = function(cooker, names, tags) return ((names.kyno_rice or 0) + (names.kyno_rice_cooked or 0) >= 2) 
		and tags.dairy and tags.spotspice end,
		priority = 30,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_FASTISH,
		health = 5,
		hunger = 15, 
		sanity = 33,
		cooktime = 0.8,
		overridebuild = "kyno_foodrecipes_cookpot1",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "kyno_rice" }, amount = 2, comparator = "morethan" },
			{ items = { "tag_dairy" }, amount = 1 },
			{ items = { "tag_spotspice" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_rice" }, amount = 2 },
			{ items = { "goatmilk" }, amount = 1 },
			{ items = { "kyno_spotspice" }, amount = 1 },
		},
	},
	
	sharksushi =
	{
		test = function(cooker, names, tags) return names.kyno_shark_fin and ((names.kyno_rice or 0) + (names.kyno_rice_cooked or 0) >= 2) end,
		priority = 35,
		foodtype = FOODTYPE.MEAT,
		perishtime = TUNING.PERISH_MED,
		health = 20,
		hunger = 40,
		sanity = -10,
		cooktime = 0.5,
		oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_NAUGHTINESS,
		overridebuild = "kyno_foodrecipes_cookpot1",
		floater = TUNING.HOF_FLOATER,
		luckitem = { luck = -TUNING.KYNO_LUCK_MEDLARGE },
		required = 
		{
			{ items = { "kyno_shark_fin" }, amount = 1 },
			{ items = { "kyno_rice" }, amount = 2, comparator = "morethan" },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_shark_fin" }, amount = 1 },
			{ items = { "kyno_rice" }, amount = 3 },
		},
		oneatenfn = function(inst, eater)
			OnFoodNaughtiness(inst, eater)
		end,
	},
	
	wobsterbreaded =
	{
		test = function(cooker, names, tags) return tags.wobster and tags.spotspice and tags.flour and tags.oil end,
		priority = 35,
		foodtype = FOODTYPE.MEAT,
		perishtime = TUNING.PERISH_PRESERVED,
		health = 60,
		hunger = 50,
		sanity = 10,
		cooktime = 0.7,
		overridebuild = "kyno_foodrecipes_cookpot1",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "tag_wobster" }, amount = 1 },
			{ items = { "tag_spotspice" }, amount = 1 },
			{ items = { "tag_flour" }, amount = 1 },
			{ items = { "tag_oil" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "wobster_sheller_land" }, amount = 1 },
			{ items = { "kyno_spotspice" }, amount = 1 },
			{ items = { "kyno_flour" }, amount = 1 },
			{ items = { "kyno_oil" }, amount = 1 },
		},
	},
	
	lazypurrito =
	{
		test = function(cooker, names, tags) return tags.beanbug and (names.kyno_rice or names.kyno_rice_cooked) and tags.flour end,
		priority = 30,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_SLOW,
		health = 20,
		hunger = 62.5,
		sanity = -15,
		cooktime = 1.3,
		overridebuild = "kyno_foodrecipes_cookpot1",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "kyno_beanbugs" }, amount = 1 },
			{ items = { "kyno_rice" }, amount = 1 },
			{ items = { "tag_flour" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_beanbugs" }, amount = 1 },
			{ items = { "kyno_rice" }, amount = 2 },
			{ items = { "kyno_flour" }, amount = 1 },
		},
	},
	
	horchata = 
	{
		test = function(cooker, names, tags) return (names.kyno_rice or names.kyno_rice_cooked) and tags.dairy and tags.sweetener
		and tags.frozen end,
		priority = 35,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_FAST,
		temperature = TUNING.COLD_FOOD_BONUS_TEMP,
		temperatureduration = TUNING.FOOD_TEMP_AVERAGE,
		health = 40,
		hunger = 20,
		sanity = 5,
		cooktime = 1,
		overridebuild = "kyno_foodrecipes_cookpot1",
		floater = TUNING.HOF_FLOATER,
		tags = {"honeyed", "fooddrink"},
		required = 
		{
			{ items = { "kyno_rice" }, amount = 1 },
			{ items = { "tag_dairy" }, amount = 1 },
			{ items = { "tag_sweetener" }, amount = 1 },
			{ items = { "ice" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_rice" }, amount = 1 },
			{ items = { "goatmilk" }, amount = 1 },
			{ items = { "honey" }, amount = 1 },
			{ items = { "ice" }, amount = 1 },
		},
	},
	
	wobstercocktail =
	{
		test = function(cooker, names, tags) return tags.wobster and (names.tomato or names.tomato_cooked) and
		(names.pepper or names.pepper_cooked) and not tags.inedible end,
		priority = 30,
		foodtype = FOODTYPE.MEAT,
		perishtime = TUNING.PERISH_FASTISH,
		temperature = TUNING.HOT_FOOD_BONUS_TEMP,
		temperatureduration = TUNING.FOOD_TEMP_AVERAGE,
		health = 20,
		hunger = 32.5,
		sanity = 60,
		cooktime = 1.1,
		overridebuild = "kyno_foodrecipes_cookpot1",
		floater = TUNING.HOF_FLOATER,
		tags = {"fooddrink"},
		required = 
		{
			{ items = { "tag_wobster" }, amount = 1 },
			{ items = { "tomato" }, amount = 1 },
			{ items = { "pepper" }, amount = 1 },
		},
		excluded = 
		{
    		{ items = { "tag_inedible" } },
		},
		card_def = 
		{
			{ items = { "wobster_sheller_land" }, amount = 1 },
			{ items = { "tomato" }, amount = 1 },
			{ items = { "pepper" }, amount = 2 },
		},
	},
	
	pomegranatetea =
	{
		test = function(cooker, names, tags) return (names.pomegranate or names.pomegranate_cooked) and tags.frozen and tags.sweetener end,
		priority = 30,
		foodtype = FOODTYPE.GOODIES,
		perishtime = TUNING.PERISH_MED,
		temperature = TUNING.COLD_FOOD_BONUS_TEMP,
		temperatureduration = TUNING.FOOD_TEMP_AVERAGE,
		health = 25,
		hunger = 12.5,
		sanity = 10,
		cooktime = 0.5,
		overridebuild = "kyno_foodrecipes_cookpot1",
		floater = TUNING.HOF_FLOATER,
		tags = {"honeyed", "fooddrink"},
		required = 
		{
			{ items = { "pomegranate" }, amount = 1 },
			{ items = { "ice" }, amount = 1 },
			{ items = { "tag_sweetener" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "pomegranate" }, amount = 1 },
			{ items = { "ice" }, amount = 1 },
			{ items = { "honey" }, amount = 2 },
		},
	},
	
	pomegranatepie =
	{
		test = function(cooker, names, tags) return (names.pomegranate or names.pomegranate_cooked) and tags.sweetener and tags.flour end,
		priority = 30,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_SUPERSLOW,
		health = 40,
		hunger = 32.5,
		sanity = 20,
		cooktime = 1.6,
		potlevel = "high",
		overridebuild = "kyno_foodrecipes_cookpot1",
		floater = TUNING.HOF_FLOATER,
		tags = {"honeyed"},
		required = 
		{
			{ items = { "pomegranate" }, amount = 1 },
			{ items = { "tag_sweetener" }, amount = 1 },
			{ items = { "tag_flour" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "pomegranate" }, amount = 1 },
			{ items = { "honey" }, amount = 1 },
			{ items = { "kyno_flour" }, amount = 1 },
			{ items = { "twigs" }, amount = 1 },
		},
		characterfood = {"wortox"},
	},
	
	pineapplecake =
	{
		test = function(cooker, names, tags) return (names.kyno_pineapple_halved or names.kyno_pineapple_cooked) and tags.egg
		and tags.flour and tags.sweetener end,
		priority = 35,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_PRESERVED,
		health = 20,
		hunger = 25,
		sanity = 40,
		cooktime = 1.8,
		overridebuild = "kyno_foodrecipes_cookpot1",
		floater = TUNING.HOF_FLOATER,
		tags = {"honeyed"},
		required = 
		{
			{ items = { "kyno_pineapple_halved", "kyno_pineapple_halved_cooked" }, amount = 1 },
			{ items = { "tag_egg" }, amount = 1 },
			{ items = { "tag_flour" }, amount = 1 },
			{ items = { "tag_sweetener" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_pineapple_halved" }, amount = 1 },
			{ items = { "bird_egg" }, amount = 1 },
			{ items = { "kyno_flour" }, amount = 1 },
			{ items = { "honey" }, amount = 1 },
		},
	},
	
	pasty_meat =
	{
		test = function(cooker, names, tags) return (tags.meat and tags.meat >= 1) and tags.flour 
		and tags.veggie and tags.oil and not tags.wobster end,
		priority = 35,
		foodtype = FOODTYPE.MEAT,
		perishtime = TUNING.PERISH_MED,
		health = 20,
		hunger = 62.5,
		sanity = 5,
		cooktime = .7,
		overridebuild = "kyno_foodrecipes_cookpot1",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "tag_meat" }, amount = 1, comparator = "morethan" },
			{ items = { "tag_flour" }, amount = 1 },
			{ items = { "tag_veggie" }, amount = 1 },
			{ items = { "tag_oil" }, amount = 1 },
		},
		excluded = 
		{
    		{ items = { "tag_wobster" } },
		},
		card_def = 
		{
			{ items = { "meat" }, amount = 1 },
			{ items = { "kyno_flour" }, amount = 1 },
			{ items = { "carrot" }, amount = 1 },
			{ items = { "kyno_oil" }, amount = 1 },
		},
	},
	
	pasty_cheese =
	{
		test = function(cooker, names, tags) return tags.cheese and tags.flour and tags.spotspice and tags.oil end,
		priority = 35,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_MED,
		health = 40,
		hunger = 37.5,
		sanity = 33,
		cooktime = .7,
		overridebuild = "kyno_foodrecipes_cookpot1",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "tag_cheese" }, amount = 1 },
			{ items = { "tag_flour" }, amount = 1 },
			{ items = { "tag_spotspice" }, amount = 1 },
			{ items = { "tag_oil" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "cheese_yellow" }, amount = 1 },
			{ items = { "kyno_flour" }, amount = 1 },
			{ items = { "kyno_spotspice" }, amount = 1 },
			{ items = { "kyno_oil" }, amount = 1 },
		},
	},
	
	brigadeiro =
	{
		test = function(cooker, names, tags) return names.chocolate_black and tags.sugar and names.kyno_twiggynuts end,
		priority = 35,
		foodtype = FOODTYPE.GOODIES,
		perishtime = TUNING.PERISH_FASTISH,
		health = 25,
		hunger = 32.5,
		sanity = 50,
		cooktime = 1,
		overridebuild = "kyno_foodrecipes_cookpot1",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "chocolate_black" }, amount = 1 },
			{ items = { "tag_sugar" }, amount = 1 },
			{ items = { "kyno_twiggynuts" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "chocolate_black" }, amount = 1 },
			{ items = { "kyno_sugar" }, amount = 1 },
			{ items = { "kyno_twiggynuts" }, amount = 2 },
		},
	},
	
	regularlasagna =
	{
		test = function(cooker, names, tags) return tags.meat and (names.tomato or names.tomato_cooked) and tags.flour
		and not tags.monster and not tags.spotspice and not tags.wobster and not tags.dairy end,
		priority = 35,
		foodtype = FOODTYPE.MEAT,
		perishtime = TUNING.PERISH_FAST,
		health = 30,
		hunger = 37.5,
		sanity = 30,
		cooktime = .5,
		overridebuild = "kyno_foodrecipes_cookpot1",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "tag_meat" }, amount = 1 },
			{ items = { "tomato" }, amount = 1 },
			{ items = { "tag_flour" }, amount = 1 },
		},
		excluded = 
		{
    		{ items = { "tag_monster" } },
			{ items = { "tag_spotspice" } },
			{ items = { "tag_wobster" } },
			{ items = { "tag_dairy" } },
		},
		card_def = 
		{
			{ items = { "meat" }, amount = 1 },
			{ items = { "tomato" }, amount = 2 },
			{ items = { "kyno_flour" }, amount = 1 },
		},
	},
	
	fltsandwich =
	{
		test = function(cooker, names, tags) return (names.kyno_moon_froglegs or names.kyno_moon_froglegs_cooked) and 
		(names.tomato or names.tomato_cooked) and tags.algae and tags.foliage end,
		priority = 30,
		foodtype = FOODTYPE.MEAT,
		perishtime = TUNING.PERISH_MED,
		health = 15,
		hunger = 32.5, 
		sanity = 33,
		cooktime = 1.3,
		oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_PLANARDEFENSE,
		potlevel = "high",
		overridebuild = "kyno_foodrecipes_cookpot1",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "kyno_moon_froglegs" }, amount = 1 },
			{ items = { "tomato" }, amount = 1 },
			{ items = { "tag_algae" }, amount = 1 },
			{ items = { "tag_foliage" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_moon_froglegs" }, amount = 1 },
			{ items = { "tomato" }, amount = 1 },
			{ items = { "kelp" }, amount = 1 },
			{ items = { "foliage" }, amount = 1 },
		},
		oneatenfn = function(inst, eater)
			eater:AddDebuff("kyno_planardefensebuff", "kyno_planardefensebuff")
		end,
	},
	
	riceandbeans =
	{
		test = function(cooker, names, tags) return (names.kyno_rice or names.kyno_rice_cooked) and (tags.beanbug and tags.beanbug >= 2) end,
		priority = 35,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_PRESERVED,
		temperature = TUNING.HOT_FOOD_BONUS_TEMP,
		temperatureduration = TUNING.FOOD_TEMP_AVERAGE,
		health = 5,
		hunger = 62.5,
		sanity = 20,
		cooktime = 1,
		potlevel = "high",
		overridebuild = "kyno_foodrecipes_cookpot1",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "kyno_rice" }, amount = 1},
			{ items = { "kyno_beanbugs" }, amount = 2, comparator = "morethan" },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_rice" }, amount = 2 },
			{ items = { "kyno_beanbugs" }, amount = 2 },
		},
	},

	trufflesgrinder =
	{
		test = function(cooker, names, tags) return (tags.meat and tags.meat >= 1) and (names.kyno_truffles or names.kyno_truffles_cooked)
		and tags.flour end,
		priority = 30,
		foodtype = FOODTYPE.MEAT,
		perishtime = TUNING.PERISH_PRESERVED,
		health = 30,
		hunger = 62.5,
		sanity = 0,
		cooktime = 1.5,
		goldvalue = 5,
		potlevel = "high",
		oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_TRUFFLES,
		overridebuild = "kyno_foodrecipes_cookpot1",
		floater = TUNING.HOF_FLOATER,
		tags = {"truffles"},
		required = 
		{
			{ items = { "tag_meat" }, amount = 1 },
			{ items = { "kyno_truffles" }, amount = 1 },
			{ items = { "tag_flour" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "tag_meat" }, amount = 1 },
			{ items = { "kyno_truffles" }, amount = 2 },
			{ items = { "kyno_flour" }, amount = 1 },
		},
		prefabs = { "kyno_trufflesbuff" },
		oneatenfn = function(inst, eater)
			eater:AddDebuff("kyno_trufflesbuff", "kyno_trufflesbuff")
		end,
	},
	
	sporecappie =
	{
		test = function(cooker, names, tags) return ((names.kyno_sporecap or 0) + (names.kyno_sporecap_cooked or 0) >= 2) and
		tags.flour and tags.sweetener end,
		priority = 35,
		foodtype = FOODTYPE.MONSTER,
		perishtime = TUNING.PERISH_PRESERVED,
		health = -20,
		hunger = 37.5,
		sanity = -10,
		cooktime = 2,
		potlevel = "high",
		oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_SPORECAP,
		overridebuild = "kyno_foodrecipes_cookpot1",
		floater = TUNING.HOF_FLOATER,
		tags = {"monstermeat", "acidrainimmune"},
		required = 
		{
			{ items = { "kyno_sporecap" }, amount = 2, comparator = "morethan" },
			{ items = { "tag_flour" }, amount = 1 },
			{ items = { "tag_sweetener" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_sporecap" }, amount = 2 },
			{ items = { "kyno_flour" }, amount = 1 },
			{ items = { "honey" }, amount = 1 },
		},
		oneatenfn = function(inst, eater)
			if eater ~= nil and eater:HasTag("playermonster") and
			not (eater.components.health ~= nil and eater.components.health:IsDead()) and
			not eater:HasTag("playerghost") then
				eater.components.health:DoDelta(20)
				eater.components.sanity:DoDelta(10)
			end
			
			eater:AddDebuff("kyno_poisonimmunitybuff", "kyno_poisonimmunitybuff")
		end,
		monsterfood = true,
		monsterhealth = 20,
		monstersanity = 10,
	},
	
	sporecap_skewers =
	{
		test = function(cooker, names, tags) return ((names.kyno_sporecap_dark or 0) + (names.kyno_sporecap_dark_cooked or 0) >= 2) and
		tags.veggie and names.twigs end,
		priority = 35,
		foodtype = FOODTYPE.MONSTER,
		perishtime = TUNING.PERISH_MED,
		health = -30,
		hunger = 45,
		sanity = -20,
		cooktime = 1,
		oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_SPORECAP_DARK,
		overridebuild = "kyno_foodrecipes_cookpot1",
		floater = TUNING.HOF_FLOATER,
		tags = {"monstermeat", "acidrainimmune"},
		required = 
		{
			{ items = { "kyno_sporecap_dark" }, amount = 2, comparator = "morethan" },
			{ items = { "tag_veggie" }, amount = 1 },
			{ items = { "twigs" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_sporecap_dark" }, amount = 2 },
			{ items = { "carrot" }, amount = 1 },
			{ items = { "twigs" }, amount = 1 },
		},
		oneatenfn = function(inst, eater)
			if eater ~= nil and eater:HasTag("playermonster") and
			not (eater.components.health ~= nil and eater.components.health:IsDead()) and
			not eater:HasTag("playerghost") then
				eater.components.health:DoDelta(30)
				eater.components.sanity:DoDelta(20)
			end
			
			eater:AddDebuff("kyno_acidimmunitybuff", "kyno_acidimmunitybuff")
		end,
		monsterfood = true,
		monsterhealth = 30,
		monstersanity = 20,
	},
	
	swordfishfeast =
	{
		test = function(cooker, names, tags) return tags.swordfish and tags.cheese and (names.fig or names.fig_cooked) and tags.sweetener end,
		priority = 30,
		foodtype = FOODTYPE.MEAT,
		perishtime = TUNING.PERISH_MED,
		health = 100,
		hunger = 150,
		sanity = 25,
		cooktime = 2,
		oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_EXQUISITE,
		scale = 1.5,
		overridebuild = "kyno_foodrecipes_cookpot1",
		floater = TUNING.HOF_FLOATER,
		tags = {"sharkboifood", "exquisite"},
		required = 
		{
			{ items = { "tag_swordfish" }, amount = 1 },
			{ items = { "tag_cheese" }, amount = 1 },
			{ items = { "fig" }, amount = 1 },
			{ items = { "tag_sweetener" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_swordfish_dead" }, amount = 1 },
			{ items = { "cheese_yellow" }, amount = 1 },
			{ items = { "fig" }, amount = 1 },
			{ items = { "honey" }, amount = 1 },
		},
		oneatenfn = function(inst, eater)

		end,
	},
	
	monkeyislandmeal =
	{
		test = function(cooker, names, tags) return names.wobster_monkeyisland_land and tags.banana end,
		priority = 35,
		foodtype = FOODTYPE.GOODIES,
		perishtime = TUNING.PERISH_MED,
		health = 20,
		hunger = 25,
		sanity = 20,
		cooktime = .15,
		oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_CURSE_MONKEY,
		overridebuild = "kyno_foodrecipes_cookpot1",
		floater = TUNING.HOF_FLOATER,
		tags = {"monkeyqueenbribe"},
		required = 
		{
			{ items = { "wobster_monkeyisland_land" }, amount = 1 },
			{ items = { "tag_banana" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "wobster_monkeyisland_land" }, amount = 1 },
			{ items = { "kyno_banana" }, amount = 1 },
			{ items = { "twigs" }, amount = 2 },
		},
		oneatenfn = function(inst, eater)
			if eater.components.inventory ~= nil and eater.components.cursable ~= nil
			and not (eater.components.health ~= nil and eater.components.health:IsDead()) and 
			not eater:HasTag("playerghost") then
				local prop = eater.components.inventory:FindItem(function(item) return item.prefab == "cursed_monkey_token" end)
				
				if prop ~= nil then
					eater.components.cursable:RemoveCurse("MONKEY", 10)
				end
			end
		end,
	},
	
	brainmettersoup =
	{
		test = function(cooker, names, tags) return names.kyno_brainrock_coral and tags.jellyfish and tags.algae and not tags.inedible end,
		priority = 35,
		foodtype = FOODTYPE.MEAT,
		perishtime = TUNING.PERISH_FAST,
		health = -15,
		hunger = 18.75,
		sanity = 50,
		cooktime = 1,
		potlevel = "high",
		oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_CRAFTING,
		overridebuild = "kyno_foodrecipes_cookpot1",
		floater = TUNING.HOF_FLOATER,
		prefabs = { "kyno_craftingbuff" },
		required = 
		{
			{ items = { "kyno_brainrock_coral" }, amount = 1 },
			{ items = { "tag_jellyfish" }, amount = 1 },
			{ items = { "tag_algae" }, amount = 1 },
		},
		excluded = 
		{
    		{ items = { "tag_inedible" } },
		},
		card_def = 
		{
			{ items = { "kyno_brainrock_coral" }, amount = 1 },
			{ items = { "kyno_jellyfish" }, amount = 1 },
			{ items = { "kyno_seaweeds" }, amount = 2 },
		},
		oneatenfn = function(inst, eater)
			eater:AddDebuff("kyno_craftingbuff", "kyno_craftingbuff")
		end,
	},
	
	chickennuggets =
	{
		test = function(cooker, names, tags) return (names.drumstick or names.drumstick_cooked) and tags.flour and tags.oil and tags.spotspice end,
		priority = 35,
		foodtype = FOODTYPE.MEAT,
		perishtime = TUNING.PERISH_FASTISH,
		health = 15,
		hunger = 32.5,
		sanity = 5,
		cooktime = .5,
		potlevel = "low",
		overridebuild = "kyno_foodrecipes_cookpot1",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "drumstick" }, amount = 1 },
			{ items = { "tag_flour" }, amount = 1 },
			{ items = { "tag_oil" }, amount = 1 },
			{ items = { "tag_spotspice" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "drumstick" }, amount = 1 },
			{ items = { "kyno_flour" }, amount = 1 },
			{ items = { "kyno_oil" }, amount = 1 },
			{ items = { "tag_spotspice" }, amount = 1 },
		},
	},
	
	chickenwings =
	{
		test = function(cooker, names, tags) return (names.drumstick or names.drumstick_cooked) and tags.oil and tags.spotspice and tags.fireweed end,
		priority = 35,
		foodtype = FOODTYPE.MEAT,
		perishtime = TUNING.PERISH_FASTISH,
		temperature = TUNING.HOT_FOOD_BONUS_TEMP,
		temperatureduration = TUNING.BUFF_FOOD_TEMP_DURATION,
		health = -15,
		hunger = 42.5,
		sanity = 10,
		cooktime = 1,
		potlevel = "med",
		oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_BERSERKER,
		overridebuild = "kyno_foodrecipes_cookpot1",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "drumstick" }, amount = 1 },
			{ items = { "tag_oil" }, amount = 1 },
			{ items = { "tag_spotspice" }, amount = 1 },
			{ items = { "tag_fireweed" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "drumstick" }, amount = 1 },
			{ items = { "kyno_oil" }, amount = 1 },
			{ items = { "kyno_spotspice" }, amount = 1 },
			{ items = { "firenettles" }, amount = 1 },
		},
		prefabs = { "kyno_berserkerbuff" },
		oneatenfn = function(inst, eater)
			eater:AddDebuff("kyno_berserkerbuff", "kyno_berserkerbuff")
		end,
	},
	
	chickenburger =
	{
		test = function(cooker, names, tags) return (names.drumstick or names.drumstick_cooked) and tags.foliage and tags.chickenegg and tags.bread end,
		priority = 35,
		foodtype = FOODTYPE.MEAT,
		perishtime = TUNING.PERISH_MED,
		health = 15,
		hunger = 62.5,
		sanity = 10,
		cooktime = 1,
		overridebuild = "kyno_foodrecipes_cookpot1",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "drumstick" }, amount = 1 },
			{ items = { "tag_foliage" }, amount = 1 },
			{ items = { "tag_chickenegg" }, amount = 1 },
			{ items = { "tag_bread" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "drumstick" }, amount = 1 },
			{ items = { "foliage" }, amount = 1 },
			{ items = { "kyno_chicken_egg" }, amount = 1 },
			{ items = { "bread" }, amount = 1 },
		},
	},
	
	chickeneggsoup =
	{
		test = function(cooker, names, tags) return tags.chickenegg and tags.succulent and tags.spotspice and (names.onion or names.onion_cooked) end,
		priority = 35,
		foodtype = FOODTYPE.MEAT,
		perishtime = TUNING.PERISH_SLOW,
		temperature = TUNING.HOT_FOOD_BONUS_TEMP,
		temperatureduration = TUNING.FOOD_TEMP_AVERAGE,
		health = 5,
		hunger = 25,
		sanity = 25,
		cooktime = 1.2,
		overridebuild = "kyno_foodrecipes_cookpot1",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "tag_chickenegg" }, amount = 1 },
			{ items = { "tag_succulent" }, amount = 1 },
			{ items = { "tag_spotspice" }, amount = 1 },
			{ items = { "onion" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_chicken_egg" }, amount = 1 },
			{ items = { "succulent_picked" }, amount = 1 },
			{ items = { "kyno_spotspice" }, amount = 1 },
			{ items = { "onion" }, amount = 1 },
		},
	},
	
	chickeneggstew =
	{
		test = function(cooker, names, tags) return (names.drumstick or names.drumstick_cooked) and tags.chickenegg and tags.spotspice
		and (names.kyno_aloe or names.kyno_aloe_cooked) end,
		priority = 35,
		foodtype = FOODTYPE.MEAT,
		perishtime = TUNING.PERISH_MED,
		health = 30,
		hunger = 62.5,
		sanity = 5,
		cooktime = 1.3,
		overridebuild = "kyno_foodrecipes_cookpot1",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "drumstick" }, amount = 1 },
			{ items = { "tag_chickenegg" }, amount = 1 },
			{ items = { "tag_spotspice" }, amount = 1 },
			{ items = { "kyno_aloe" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "drumstick" }, amount = 1 },
			{ items = { "kyno_chicken_egg" }, amount = 1 },
			{ items = { "kyno_spotspice" }, amount = 1 },
			{ items = { "kyno_aloe" }, amount = 1 },
		},
	},
	
	chickenrotisserie =
	{
		test = function(cooker, names, tags) return tags.chicken and tags.spotspice and tags.veggie and not tags.inedible end,
		priority = 35,
		foodtype = FOODTYPE.MEAT,
		perishtime = TUNING.PERISH_PRESERVED,
		health = 30,
		hunger = 150,
		sanity = 10,
		cooktime = 2.5,
		oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_HUNGERRATE,
		overridebuild = "kyno_foodrecipes_cookpot1",
		floater = TUNING.HOF_FLOATER,
		required = 
		{
			{ items = { "tag_chicken" }, amount = 1 },
			{ items = { "tag_spotspice" }, amount = 1 },
			{ items = { "tag_veggie" }, amount = 1 },
		},
		excluded = 
		{
    		{ items = { "tag_inedible" } },
		},
		card_def = 
		{
			{ items = { "kyno_chicken2" }, amount = 1 },
			{ items = { "kyno_spotspice" }, amount = 1 },
			{ items = { "carrot" }, amount = 2 },
		},
		prefabs = { "kyno_hungerratebuff" },
		oneatenfn = function(inst, eater)
			eater:AddDebuff("kyno_hungerratebuff", "kyno_hungerratebuff")
		end,
	},

	jawsbreaker =
	{
		test = function(cooker, names, tags) return names.kyno_shark_fin and tags.sugar and (tags.sweetener and tags.sweetener >= 2) end,
		priority = 100,
		foodtype = FOODTYPE.GOODIES,
		secondaryfoodtype = FOODTYPE.MEAT, 
		perishtime = nil,
		health = -30,
		hunger = 12.5,
		sanity = 33,
		cooktime = 1,
		stacksize = 2,
		oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_JAWSBREAKER,
		potlevel = "low",
		luckitem = { luck = TUNING.KYNO_LUCK_MEDLARGE },
		tags = {"nospice", "itemshowcaser_valid"},
		required = 
		{
			{ items = { "kyno_shark_fin" }, amount = 1 },
			{ items = { "tag_sugar" }, amount = 1 },
			{ items = { "tag_sweetener" }, amount = 2, comparator = "morethan" },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_shark_fin" }, amount = 1 },
			{ items = { "kyno_sugar" }, amount = 1 },
			{ items = { "honey" }, amount = 2 },
		},
		oneatenfn = function(inst, eater)

		end,
	},
}

for k, recipe in pairs(kyno_foods) do
	recipe.name = k
	recipe.weight = 1
	recipe.overridebuild = recipe.overridebuild or k
	recipe.cookbook_atlas = "images/cookbookimages/hof_cookbookimages.xml"
	recipe.cookbook_tex = k..".tex"
end

return kyno_foods
local kyno_foods_seasonal =
{
	festive_berrysauce =
	{
		test = function(cooker, names, tags) return (tags.berries and tags.berries >= 2) and tags.sweetener == 2 
		and (TUNING.HOF_SEASONALFOOD or IsSpecialEventActive(SPECIAL_EVENTS.WINTERS_FEAST)) end,
		priority = 35,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_FAST,
		health = 10,
		hunger = 25,
		sanity = 15,
		cooktime = 1,
		potlevel = "med",
		scale = 1,
		nameoverride = "BERRYSAUCE",
		overridebuild = "kyno_foodrecipes_seasonal_xmas",
		floater = TUNING.HOF_FLOATER,
		tags = {"honeyed", "xmas"},
		required = 
		{
			{ items = { "tag_berries" }, amount = 2, comparator = "morethan" },
			{ items = { "tag_sweetener" }, amount = 2 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "berries" }, amount = 2 },
			{ items = { "honey" }, amount = 2 },
		},
	},
	
	festive_bibingka =
	{
		test = function(cooker, names, tags) return (tags.succulent and tags.succulent >= 2) and tags.foliage and tags.veggie 
		and (TUNING.HOF_SEASONALFOOD or IsSpecialEventActive(SPECIAL_EVENTS.WINTERS_FEAST)) and not tags.fish end,
		priority = 35,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_MED,
		health = 20,
		hunger = 20,
		sanity = 0,
		cooktime = 1.3,
		potlevel = "med",
		scale = 1,
		nameoverride = "BIBINGKA",
		overridebuild = "kyno_foodrecipes_seasonal_xmas",
		floater = TUNING.HOF_FLOATER,
		tags = {"xmas"},
		required = 
		{
			{ items = { "tag_succulent" }, amount = 2, comparator = "morethan" },
			{ items = { "tag_foliage" }, amount = 1 },
			{ items = { "tag_veggie" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "succulent_picked" }, amount = 2 },
			{ items = { "foliage" }, amount = 1 },
			{ items = { "carrot" }, amount = 1 },
		},
	},
	
	festive_cabbagerolls =
	{
		test = function(cooker, names, tags) return (names.kyno_waterycress and names.kyno_waterycress >= 2) and tags.syrup and not tags.flour 
		and (TUNING.HOF_SEASONALFOOD or IsSpecialEventActive(SPECIAL_EVENTS.WINTERS_FEAST)) end,
		priority = 30,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_MED,
		health = 5,
		hunger = 32.5,
		sanity = 15,
		cooktime = 1.5,
		potlevel = "med",
		scale = 1,
		nameoverride = "CABBAGEROLLS",
		overridebuild = "kyno_foodrecipes_seasonal_xmas",
		floater = TUNING.HOF_FLOATER,
		tags = {"xmas"},
		required = 
		{
			{ items = { "kyno_waterycress" }, amount = 2, comparator = "morethan" },
			{ items = { "tag_syrup" }, amount = 1 },
		},
		excluded = 
		{
    		{ items = { "tag_flour" } },
		},
		card_def = 
		{
			{ items = { "kyno_waterycress" }, amount = 2 },
			{ items = { "kyno_syrup" }, amount = 2 },
		},
	},
	
	festive_fishdish =
	{
		test = function(cooker, names, tags) return tags.fish and tags.succulent and not tags.sweetener and not tags.wobster
		and (TUNING.HOF_SEASONALFOOD or IsSpecialEventActive(SPECIAL_EVENTS.WINTERS_FEAST)) end,
		priority = 35,
		foodtype = FOODTYPE.MEAT,
		perishtime = TUNING.PERISH_FASTISH,
		health = 30,
		hunger = 62.5,
		sanity = 1,
		cooktime = 2,
		potlevel = "med",
		scale = 1,
		nameoverride = "FESTIVEFISH",
		overridebuild = "kyno_foodrecipes_seasonal_xmas",
		floater = TUNING.HOF_FLOATER,
		tags = {"xmas"},
		required = 
		{
			{ items = { "tag_fish" }, amount = 1 },
			{ items = { "tag_succulent" }, amount = 1 },
		},
		excluded = 
		{
    		{ items = { "tag_sweetener" } },
			{ items = { "tag_wobster" } },
		},
		card_def = 
		{
			{ items = { "pondfish" }, amount = 2 },
			{ items = { "succulent_picked" }, amount = 2 },
		},
	},
	
	festive_goodgravy =
	{
		test = function(cooker, names, tags) return tags.syrup and tags.flour and tags.meat 
		and (TUNING.HOF_SEASONALFOOD or IsSpecialEventActive(SPECIAL_EVENTS.WINTERS_FEAST)) end,
		priority = 35,
		foodtype = FOODTYPE.MEAT,
		perishtime = TUNING.PERISH_SLOW,
		health = 5,
		hunger = 32.5,
		sanity = 15,
		cooktime = 1.5,
		potlevel = "med",
		scale = 1,
		nameoverride = "GRAVY",
		overridebuild = "kyno_foodrecipes_seasonal_xmas",
		floater = TUNING.HOF_FLOATER,
		tags = {"honeyed", "xmas"},
		required = 
		{
			{ items = { "tag_syrup" }, amount = 1 },
			{ items = { "tag_flour" }, amount = 1 },
			{ items = { "tag_meat" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_syrup" }, amount = 2 },
			{ items = { "kyno_flour" }, amount = 1 },
			{ items = { "meat" }, amount = 1 },
		},
	},
	
	festive_latkes =
	{
		test = function(cooker, names, tags) return ((names.potato or 0) + (names.potato_cooked or 0) >= 2) and tags.dairy 
		and (TUNING.HOF_SEASONALFOOD or IsSpecialEventActive(SPECIAL_EVENTS.WINTERS_FEAST)) end,
		priority = 30,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_FAST,
		health = 5,
		hunger = 50,
		sanity = 20,
		cooktime = .8,
		potlevel = "med",
		scale = 1,
		nameoverride = "LATKES",
		overridebuild = "kyno_foodrecipes_seasonal_xmas",
		floater = TUNING.HOF_FLOATER,
		tags = {"xmas"},
		required = 
		{
			{ items = { "potato" }, amount = 2, comparator = "morethan" },
			{ items = { "tag_dairy" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "potato" }, amount = 3 },
			{ items = { "goatmilk" }, amount = 1 },
		},
	},
	
	festive_lutefisk =
	{
		test = function(cooker, names, tags) return (tags.fish and tags.fish >= 2) and (names.pepper or names.pepper_cooked) and tags.foliage 
		and (TUNING.HOF_SEASONALFOOD or IsSpecialEventActive(SPECIAL_EVENTS.WINTERS_FEAST)) end,
		priority = 30,
		foodtype = FOODTYPE.MEAT,
		perishtime = TUNING.PERISH_FASTISH,
		temperature = TUNING.HOT_FOOD_BONUS_TEMP,
		temperatureduration = TUNING.FOOD_TEMP_AVERAGE,
		health = 5,
		hunger = 75,
		sanity = 5,
		cooktime = 1.5,
		potlevel = "med",
		scale = 1,
		nameoverride = "LUTEFISK",
		overridebuild = "kyno_foodrecipes_seasonal_xmas",
		floater = TUNING.HOF_FLOATER,
		tags = {"xmas"},
		required = 
		{
			{ items = { "tag_fish" }, amount = 2, comparator = "morethan" },
			{ items = { "pepper" }, amount = 1 },
			{ items = { "tag_foliage" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "pondeel" }, amount = 2 },
			{ items = { "pepper" }, amount = 1 },
			{ items = { "foliage" }, amount = 1 },
		},
	},
	
	festive_mulledpunch = 
	{
		test = function(cooker, names, tags) return tags.syrup and tags.sweetener and tags.frozen and not names.forgetweed 
		and not tags.meat and not tags.berries and not tags.fruit and not names.cutlichen and (TUNING.HOF_SEASONALFOOD or IsSpecialEventActive(SPECIAL_EVENTS.WINTERS_FEAST)) end,
		priority = 35,
		foodtype = FOODTYPE.GOODIES,
		perishtime = TUNING.PERISH_MED,
		temperature = TUNING.COLD_FOOD_BONUS_TEMP,
		temperatureduration = TUNING.FOOD_TEMP_AVERAGE,
		health = 15,
		hunger = 12.5,
		sanity = 33,
		cooktime = 2,
		potlevel = "med",
		scale = 1,
		nameoverride = "MULLEDDRINK",
		overridebuild = "kyno_foodrecipes_seasonal_xmas",
		floater = TUNING.HOF_FLOATER,
		tags = {"honeyed", "xmas"},
		required = 
		{
			{ items = { "tag_syrup" }, amount = 1 },
			{ items = { "tag_sweetener" }, amount = 1 },
			{ items = { "ice" }, amount = 1 },
		},
		excluded = 
		{
    		{ items = { "tag_forgetweed" } },
			{ items = { "tag_meat" } },
			{ items = { "tag_berries" } },
			{ items = { "tag_fruit" } },
			{ items = { "cutlichen" } },
		},
		card_def = 
		{
			{ items = { "kyno_syrup" }, amount = 2 },
			{ items = { "honey" }, amount = 1 },
			{ items = { "ice" }, amount = 1 },
		},
	},
	
	festive_panettone = 
	{
		test = function(cooker, names, tags) return (tags.flour and tags.flour >= 2) and (tags.fruit and tags.fruit >= 2) 
		and (TUNING.HOF_SEASONALFOOD or IsSpecialEventActive(SPECIAL_EVENTS.WINTERS_FEAST)) end,
		priority = 30,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_SUPERSLOW,
		health = 20,
		hunger = 32.5,
		sanity = 15,
		cooktime = 2,
		potlevel = "med",
		scale = 1,
		nameoverride = "PANETTONE",
		overridebuild = "kyno_foodrecipes_seasonal_xmas",
		floater = TUNING.HOF_FLOATER,
		tags = {"xmas"},
		required = 
		{
			{ items = { "tag_flour" }, amount = 2, comparator = "morethan" },
			{ items = { "tag_fruit" }, amount = 2, comparator = "morethan" },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_flour" }, amount = 2 },
			{ items = { "pomegranate" }, amount = 2 },
		},
	},
	
	festive_pavlova =
	{
		test = function(cooker, names, tags) return tags.flour and (tags.fruit and tags.fruit >= 2) and tags.sweetener 
		and (TUNING.HOF_SEASONALFOOD or IsSpecialEventActive(SPECIAL_EVENTS.WINTERS_FEAST)) end,
		priority = 30,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_MED,
		health = 40,
		hunger = 25,
		sanity = 5,
		cooktime = 1.5,
		potlevel = "med",
		scale = 1,
		nameoverride = "PAVLOVA",
		overridebuild = "kyno_foodrecipes_seasonal_xmas",
		floater = TUNING.HOF_FLOATER,
		tags = {"honeyed", "xmas"},
		required = 
		{
			{ items = { "tag_flour" }, amount = 1 },
			{ items = { "tag_fruit" }, amount = 2, comparator = "morethan" },
			{ items = { "tag_sweetener" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_flour" }, amount = 1 },
			{ items = { "kyno_banana" }, amount = 2 },
			{ items = { "honey" }, amount = 1 },
		},
	},
	
	festive_pickledherring =
	{
		test = function(cooker, names, tags) return tags.fish and (tags.spotspice and tags.spotspice >= 2) and not tags.flour 
		and (TUNING.HOF_SEASONALFOOD or IsSpecialEventActive(SPECIAL_EVENTS.WINTERS_FEAST)) end,
		priority = 35,
		foodtype = FOODTYPE.MEAT,
		perishtime = TUNING.PERISH_FASTISH,
		health = 40,
		hunger = 37.5,
		sanity = 0,
		cooktime = 1.5,
		potlevel = "med",
		scale = 1,
		nameoverride = "PICKLEDHERRING",
		overridebuild = "kyno_foodrecipes_seasonal_xmas",
		floater = TUNING.HOF_FLOATER,
		tags = {"xmas"},
		required = 
		{
			{ items = { "tag_fish" }, amount = 1 },
			{ items = { "tag_spotspice" }, amount = 2, comparator = "morethan" },
		},
		excluded = 
		{
    		{ items = { "tag_flour" } },
		},
		card_def = 
		{
			{ items = { "pondfish" }, amount = 2 },
			{ items = { "kyno_spotspice" }, amount = 2 },
		},
	},
	
	festive_polishcookies = 
	{ 
		test = function(cooker, names, tags) return tags.flour and tags.dairy and (tags.sweetener and tags.sweetener >= 2) 
		and (TUNING.HOF_SEASONALFOOD or IsSpecialEventActive(SPECIAL_EVENTS.WINTERS_FEAST)) end,
		priority = 35,
		foodtype = FOODTYPE.GOODIES,
		perishtime = TUNING.PERISH_MED,
		health = 40,
		hunger = 12.5,
		sanity = 5,
		cooktime = .8,
		potlevel = "med",
		scale = 1,
		nameoverride = "POLISHCOOKIE",
		overridebuild = "kyno_foodrecipes_seasonal_xmas",
		floater = TUNING.HOF_FLOATER,
		tags = {"honeyed", "xmas"},
		required = 
		{
			{ items = { "tag_flour" }, amount = 1 },
			{ items = { "tag_dairy" }, amount = 1 },
			{ items = { "tag_sweetener" }, amount = 2, comparator = "morethan" },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_flour" }, amount = 1 },
			{ items = { "goatmilk" }, amount = 1 },
			{ items = { "honey" }, amount = 2 },
		},
	},
	
	festive_pumpkinpie =
	{
		test = function(cooker, names, tags) return (names.pumpkin or names.pumpkin_cooked) and tags.flour and tags.sweetener 
		and (TUNING.HOF_SEASONALFOOD or IsSpecialEventActive(SPECIAL_EVENTS.WINTERS_FEAST)) end,
		priority = 30,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_SLOW,
		health = 20,
		hunger = 62.5,
		sanity = 10,
		cooktime = 1.8,
		potlevel = "med",
		scale = 1,
		nameoverride = "PUMPKINPIE",
		overridebuild = "kyno_foodrecipes_seasonal_xmas",
		floater = TUNING.HOF_FLOATER,
		tags = {"honeyed", "xmas"},
		required = 
		{
			{ items = { "pumpkin" }, amount = 1 },
			{ items = { "tag_flour" }, amount = 1 },
			{ items = { "tag_sweetener" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "pumpkin" }, amount = 2 },
			{ items = { "kyno_flour" }, amount = 1 },
			{ items = { "honey" }, amount = 1 },
		},
	},
	
	festive_roastedturkey =
	{
		test = function(cooker, names, tags) return (names.drumstick or names.drumstick_cooked) 
		and (tags.spotspice and tags.spotspice >= 2) and tags.succulent and not tags.fruit and (TUNING.HOF_SEASONALFOOD or IsSpecialEventActive(SPECIAL_EVENTS.WINTERS_FEAST)) end,
		priority = 35,
		foodtype = FOODTYPE.MEAT,
		perishtime = TUNING.PERISH_MED,
		health = 10,
		hunger = 80,
		sanity = 20,
		cooktime = 1,
		potlevel = "med",
		scale = 1,
		nameoverride = "ROASTTURKEY",
		overridebuild = "kyno_foodrecipes_seasonal_xmas",
		floater = TUNING.HOF_FLOATER,
		tags = {"xmas"},
		required = 
		{
			{ items = { "drumstick" }, amount = 1 },
			{ items = { "tag_spotspice" }, amount = 2, comparator = "morethan" },
			{ items = { "tag_succulent" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "drumstick" }, amount = 1 },
			{ items = { "kyno_spotspice" }, amount = 2 },
			{ items = { "succulent_picked" }, amount = 1 },
		},
	},
	
	festive_stuffing =
	{
		test = function(cooker, names, tags) return tags.flour and (tags.veggie and tags.veggie >= 2) and tags.fruit 
		and (TUNING.HOF_SEASONALFOOD or IsSpecialEventActive(SPECIAL_EVENTS.WINTERS_FEAST)) end,
		priority = 30,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_SLOW,
		health = 15,
		hunger = 32.5,
		sanity = 20,
		cooktime = 1.5,
		potlevel = "med",
		scale = 1,
		nameoverride = "STUFFING",
		overridebuild = "kyno_foodrecipes_seasonal_xmas",
		floater = TUNING.HOF_FLOATER,
		tags = {"xmas"},
		required = 
		{
			{ items = { "tag_flour" }, amount = 1 },
			{ items = { "tag_veggie" }, amount = 2, comparator = "morethan" },
			{ items = { "tag_fruit" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_flour" }, amount = 1 },
			{ items = { "carrot" }, amount = 2 },
			{ items = { "berries" }, amount = 1 },
		},
	},
	
	festive_sweetpotato =
	{
		test = function(cooker, names, tags) return tags.flour and ((names.kyno_sweetpotato or 0) + (names.kyno_sweetpotato_cooked or 0) >= 2)
		and not tags.meat and (TUNING.HOF_SEASONALFOOD or IsSpecialEventActive(SPECIAL_EVENTS.WINTERS_FEAST)) end,
		priority = 35,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_MED,
		health = 20,
		hunger = 37.5,
		sanity = 20,
		cooktime = 1,
		potlevel = "med",
		scale = 1,
		nameoverride = "SWEETPOTATO",
		overridebuild = "kyno_foodrecipes_seasonal_xmas",
		floater = TUNING.HOF_FLOATER,
		tags = {"xmas"},
		required = 
		{
			{ items = { "tag_flour" }, amount = 1 },
			{ items = { "kyno_sweetpotato" }, amount = 2, comparator = "morethan" },
		},
		excluded = 
		{
    		{ items = { "tag_meat" } },
		},
		card_def = 
		{
			{ items = { "kyno_flour" }, amount = 2 },
			{ items = { "kyno_sweetpotato" }, amount = 2 },
		},
	},
	
	festive_tamales =
	{
		test = function(cooker, names, tags) return tags.flour and ((names.corn or 0) + (names.corn_cooked or 0) >= 2) and tags.dairy 
		and (TUNING.HOF_SEASONALFOOD or IsSpecialEventActive(SPECIAL_EVENTS.WINTERS_FEAST)) end,
		priority = 30,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_SLOW,
		health = 5,
		hunger = 20,
		sanity = 50,
		cooktime = 2,
		potlevel = "med",
		scale = 1,
		nameoverride = "TAMALES",
		overridebuild = "kyno_foodrecipes_seasonal_xmas",
		floater = TUNING.HOF_FLOATER,
		tags = {"xmas"},
		required = 
		{
			{ items = { "tag_flour" }, amount = 1 },
			{ items = { "corn" }, amount = 2, comparator = "morethan" },
			{ items = { "tag_dairy" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_flour" }, amount = 1 },
			{ items = { "corn" }, amount = 2 },
			{ items = { "goatmilk" }, amount = 1 },
		},
	},
	
	festive_tourtiere =
	{
		test = function(cooker, names, tags) return tags.meat and tags.flour and (names.kyno_bacon or names.kyno_bacon_cooked) 
		and (names.potato or names.potato_cooked) and (TUNING.HOF_SEASONALFOOD or IsSpecialEventActive(SPECIAL_EVENTS.WINTERS_FEAST)) end,
		priority = 35,
		foodtype = FOODTYPE.MEAT,
		perishtime = TUNING.PERISH_SUPERSLOW,
		health = 25,
		hunger = 50,
		sanity = 15,
		cooktime = 2,
		potlevel = "med",
		scale = 1,
		nameoverride = "TOURTIERE",
		overridebuild = "kyno_foodrecipes_seasonal_xmas",
		floater = TUNING.HOF_FLOATER,
		tags = {"xmas"},
		required = 
		{
			{ items = { "tag_meat" }, amount = 1 },
			{ items = { "tag_flour" }, amount = 1 },
			{ items = { "kyno_bacon" }, amount = 1 },
			{ items = { "potato" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "meat" }, amount = 1 },
			{ items = { "kyno_flour" }, amount = 1 },
			{ items = { "kyno_bacon" }, amount = 1 },
			{ items = { "potato" }, amount = 1 },
		},
	},

	spooky_brain_noodles =
	{
		test = function(cooker, names, tags) return tags.flour and tags.spotspice and tags.beanbug and tags.meat 
		and (TUNING.HOF_SEASONALFOOD or IsSpecialEventActive(SPECIAL_EVENTS.HALLOWED_NIGHTS)) end,
		priority = 35,
		foodtype = FOODTYPE.MEAT,
		perishtime = TUNING.PERISH_SLOW,
		health = 10,
		hunger = 32.5,
		sanity = 30,
		cooktime = 1.2,
		potlevel = "med",
		overridebuild = "kyno_foodrecipes_seasonal_spooky",
		floater = TUNING.HOF_FLOATER,
		tags = {"halloween"},
		required = 
		{
			{ items = { "tag_flour" }, amount = 1 },
			{ items = { "tag_spotspice" }, amount = 1 },
			{ items = { "kyno_beanbugs" }, amount = 1 },
			{ items  = { "tag_meat" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_flour" }, amount = 1 },
			{ items = { "kyno_spotspice" }, amount = 1 },
			{ items = { "kyno_beanbugs" }, amount = 1 },
			{ items = { "meat" }, amount = 1 },
		},
	},
	
	spooky_burgerzilla =
	{
		test = function(cooker, names, tags) return tags.bread and (names.monstermeat or names.monstermeat_cooked or names.monstermeat_dried) and
		(names.onion or names.onion_cooked) and (names.kyno_cucumber or names.kyno_cucumber_cooked) and not tags.foliage and not tags.bacon 
		and (TUNING.HOF_SEASONALFOOD or IsSpecialEventActive(SPECIAL_EVENTS.HALLOWED_NIGHTS)) end,
		priority = 30,
		foodtype = FOODTYPE.MONSTER,
		perishtime = TUNING.PERISH_FASTISH,
		health = -20,
		hunger = 80,
		sanity = -20,
		cooktime = 1.5,
		potlevel = "med",
		overridebuild = "kyno_foodrecipes_seasonal_spooky",
		floater = TUNING.HOF_FLOATER,
		tags = {"halloween", "monstermeat"},
		required =
		{
			{ items = { "tag_bread" }, amount = 1 },
			{ items = { "tag_monster" }, amount = 1 },
			{ items = { "onion" }, amount = 1 },
			{ items = { "kyno_cucumber" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "bread" }, amount = 1 },
			{ items = { "monstermeat" }, amount = 1 },
			{ items = { "onion" }, amount = 1 },
			{ items = { "kyno_cucumber" }, amount = 1 },
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
	
	spooky_deadbread =
	{
		test = function(cooker, names, tags) return names.boneshard and names.kyno_sugar and tags.flour and tags.butter 
		and (TUNING.HOF_SEASONALFOOD or IsSpecialEventActive(SPECIAL_EVENTS.HALLOWED_NIGHTS)) end,
		priority = 35,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_SUPERSLOW,
		health = 40,
		hunger = 65,
		sanity = -30,
		cooktime = 2,
		potlevel = "low",
		overridebuild = "kyno_foodrecipes_seasonal_spooky",
		floater = TUNING.HOF_FLOATER,
		tags = {"halloween"},
		required =
		{
			{ items = { "boneshard" }, amount = 1 },
			{ items = { "kyno_sugar" }, amount = 1 },
			{ items = { "tag_flour" }, amount = 1 },
			{ items = { "tag_butter" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "boneshard" }, amount = 1 },
			{ items = { "kyno_sugar" }, amount = 1 },
			{ items = { "kyno_flour" }, amount = 1 },
			{ items = { "butter" }, amount = 1 },
		},
	},
	
	spooky_jellybeans =
	{
		test = function(cooker, names, tags) return names.royal_jelly and tags.sugar and 
		(names.nightmarefuel and names.nightmarefuel >= 2) and not tags.monster 
		and (TUNING.HOF_SEASONALFOOD or IsSpecialEventActive(SPECIAL_EVENTS.HALLOWED_NIGHTS)) end,
		priority = 35,
		foodtype = FOODTYPE.GOODIES,
		perishtime = nil,
		health = 15,
		hunger = 15,
		sanity = 0,
		cooktime = 2.5,
		stacksize = 3,
		oneat_desc = STRINGS.UI.COOKBOOK.FOOD_EFFECTS_DESANITY,
		potlevel = "med",
		overridebuild = "kyno_foodrecipes_seasonal_spooky",
		floater = TUNING.HOF_FLOATER,
		tags = {"halloween", "honeyed"},
		required = 
		{
			{ items = { "royal_jelly" }, amount = 1 },
			{ items = { "tag_sugar" }, amount = 1 },
			{ items = { "nightmarefuel" }, amount = 2, comparator = "morethan" },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "royal_jelly" }, amount = 1 },
			{ items = { "kyno_sugar" }, amount = 1 },
			{ items = { "nightmarefuel" }, amount = 2 },
		},
		prefabs = { "kyno_insanitybuff" },
        oneatenfn = function(inst, eater)
            eater:AddDebuff("kyno_insanitybuff", "kyno_insanitybuff")
        end,
	},
	
	spooky_popsicle =
	{
		test = function(cooker, names, tags) return names.livinglog and tags.dairy and tags.frozen and tags.sugar 
		and (TUNING.HOF_SEASONALFOOD or IsSpecialEventActive(SPECIAL_EVENTS.HALLOWED_NIGHTS)) end,
		priority = 35,
		foodtype = FOODTYPE.GOODIES,
		perishtime = TUNING.PERISH_FAST,
		temperature = TUNING.COLD_FOOD_BONUS_TEMP,
        temperatureduration = TUNING.BUFF_FOOD_TEMP_DURATION,
		health = 40,
		hunger = 12.5,
		sanity = -20,
		cooktime = 1.0,
		potlevel = "med",
		overridebuild = "kyno_foodrecipes_seasonal_spooky",
		floater = TUNING.HOF_FLOATER,
		tags = {"halloween"},
		required = 
		{
			{ items = { "livinglog" }, amount = 1 },
			{ items = { "tag_dairy" }, amount = 1 },
			{ items = { "ice" }, amount = 1 },
			{ items = { "tag_sugar" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "livinglog" }, amount = 1 },
			{ items = { "goatmilk" }, amount = 1 },
			{ items = { "ice" }, amount = 1 },
			{ items = { "kyno_sugar" }, amount = 1 },
		},
		oneatenfn = function(inst, eater)
			if eater ~= nil and eater.SoundEmitter ~= nil then
				eater.SoundEmitter:PlaySound("dontstarve/creatures/leif/livinglog_burn")
			else
				inst.SoundEmitter:PlaySound("dontstarve/creatures/leif/livinglog_burn")
			end
		end,
	},
	
	spooky_pumpkincream =
	{
		test = function(cooker, names, tags) return names.pumpkin and (names.kyno_pineapple_halved or names.kyno_pineapple_cooked) 
		and (names.pomegranate or names.pomegranate_cooked) and tags.dairy 
		and not names.pumpkin_cooked and (TUNING.HOF_SEASONALFOOD or IsSpecialEventActive(SPECIAL_EVENTS.HALLOWED_NIGHTS)) end,
		priority = 30,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_MED,
		health = 40,
		hunger = 62.5,
		sanity = 25,
		cooktime = 2,
		potlevel = "med",
		overridebuild = "kyno_foodrecipes_seasonal_spooky",
		floater = TUNING.HOF_FLOATER,
		tags = {"halloween"},
		required = 
		{
			{ items = { "pumpkin" }, amount = 1 },
			{ items = { "kyno_pineapple_halved" }, amount = 1 },
			{ items = { "pomegranate" }, amount = 1 },
			{ items = { "tag_dairy" }, amount = 1 },
		},
		excluded = 
		{
    		{ items = { "pumpkin_cooked" } },
		},
		card_def = 
		{
			{ items = { "pumpkin" }, amount = 1 },
			{ items = { "kyno_pineapple_halved" }, amount = 1 },
			{ items = { "pomegranate" }, amount = 1 },
			{ items = { "goatmilk" }, amount = 1 },
		},
	},
	
	spooky_skullcandy =
	{
		test = function(cooker, names, tags) return names.boneshard and (names.kyno_sugar and names.kyno_sugar >= 2) and names.nightmarefuel 
		and (TUNING.HOF_SEASONALFOOD or IsSpecialEventActive(SPECIAL_EVENTS.HALLOWED_NIGHTS)) end,
		priority = 35,
		foodtype = FOODTYPE.GOODIES,
		perishtime = nil,
		health = 5,
		hunger = 15,
		sanity = -15,
		cooktime = 1.5,
		stacksize = 2,
		potlevel = "low",
		fireproof = true,
		overridebuild = "kyno_foodrecipes_seasonal_spooky",
		floater = TUNING.HOF_FLOATER,
		tags = {"halloween"},
		required = 
		{
			{ items = { "boneshard" }, amount = 1 },
			{ items = { "kyno_sugar" }, amount = 2, comparator = "morethan" },
			{ items = { "nightmarefuel" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "boneshard" }, amount = 2 },
			{ items = { "kyno_sugar" }, amount = 2 },
			{ items = { "nightmarefuel" }, amount = 1 },
		},
	},
	
	spooky_tacodile =
	{
		test = function(cooker, names, tags) return tags.flour and (names.pepper or names.pepper_cooked) and
		(names.onion or names.onion_cooked) and tags.spotspice and (TUNING.HOF_SEASONALFOOD or IsSpecialEventActive(SPECIAL_EVENTS.HALLOWED_NIGHTS)) end,
		priority = 35,
		foodtype = FOODTYPE.VEGGIE,
		perishtime = TUNING.PERISH_SLOW,
		temperature = TUNING.HOT_FOOD_BONUS_TEMP,
		temperatureduration = TUNING.BUFF_FOOD_TEMP_DURATION,
		health = 15,
		hunger = 50,
		sanity = 10,
		cooktime = 1.7,
		potlevel = "med",
		overridebuild = "kyno_foodrecipes_seasonal_spooky",
		floater = TUNING.HOF_FLOATER,
		tags = {"halloween"},
		required = 
		{
			{ items = { "tag_flour" }, amount = 1 },
			{ items = { "pepper" }, amount = 1 },
			{ items = { "onion" }, amount = 1 },
			{ items = { "tag_spotspice" }, amount = 1 },
		},
		excluded = 
		{
    		
		},
		card_def = 
		{
			{ items = { "kyno_flour" }, amount = 1 },
			{ items = { "pepper" }, amount = 1 },
			{ items = { "onion" }, amount = 1 },
			{ items = { "kyno_spotspice" }, amount = 1 },
		},
	},
}

for k, recipe in pairs(kyno_foods_seasonal) do
	recipe.name = k
	recipe.weight = 1
	recipe.cookbook_atlas = "images/cookbookimages/hof_cookbookimages_seasonal.xml"
	recipe.cookbook_tex = k..".tex"
end

return kyno_foods_seasonal
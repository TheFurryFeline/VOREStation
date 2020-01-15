/mob/living/simple_mob/hostile/piranhaplant
	name = "Piranha Plant"
	desc = "It's a plant, that eats people!"
	tt_desc = "Packun Flower"

	//Mob icon/appearance settings
	icon = 'icons/mob/plantmobs32x32_vr.dmi' //Thanks to vorebound mod and Estelle
	icon_living = "piranha-plant"
	icon_state = "piranha-plant"
	icon_dead = "piranha-plant_dead"
	icon_gib = "generic_gib"	// The iconstate for being gibbed, optional. Defaults to a generic gib animation.
	//icon_rest = null		// The iconstate for resting, optional
	attack_icon = 'icons/effects/effects.dmi' //Just the default, played like the weapon attack anim
	attack_icon_state = "slash" 	//Just the default //gonna have to make teeth chomping version

	mob_class = MOB_CLASS_PLANT

	faction = "plants"
	maxHealth = 50
	health = 50
	movement_cooldown = 4
	entangle_immunity = 1

	response_help  = "prods"
	response_disarm = "pushes aside"
	response_harm   = "smacks"

	melee_damage_lower = 1		// Lower bound of randomized melee damage
	melee_damage_upper = 25		// Upper bound of randomized melee damage
	melee_miss_chance = 1		// percent chance to miss a melee attack.
	melee_attack_delay = 4 SECONDS
	attack_armor_type = "bio"	// What armor does this check?
	attack_armor_pen = 50		// How much armor pen this attack has.
	attack_sharp = TRUE			// Is the attack sharp?
	attack_edge = FALSE			// Does the attack have an edge?
	attacktext = list("chomped","bit","hompfed","crunched","cronched") // "You are [attacktext] by the mob!"
	friendly = list("nuzzles")	// "The mob [friendly] the person."
	grab_resist = 100
	taser_kill = 1

	ai_holder_type = /datum/ai_holder/simple_mob/guard/give_chase/piranhaplant

	meat_type = null

	//Vore stuff
	vore_active = 1
	vore_capacity = 1
	vore_pounce_chance = 10
	vore_standing_too = 1
	vore_ignores_undigestable = 0
	vore_default_mode = DM_DIGEST
	vore_digest_chance = 99
	vore_absorb_chance = 0
	vore_escape_chance = 5
	vore_icons = SA_ICON_LIVING
	swallowTime = 10 SECONDS //CHOMPED

	//Stuff for people wanting to be a fucking plant. Weirdos
	show_stat_health = 1	// Does the percentage health show in the stat panel for the mob
	has_hands = 1		// Set to 1 to enable the use of hands and the hands hud
	humanoid_hands = 1	// Can a player in this mob use things like guns or AI cards?
	player_msg = "PLANT GO CHOMP" // Message to print to players about 'how' to play this mob on login.

//TFF 9/1/20 - Add custom AI defines for pitcher plant mobs ported from CHOMPStation
/datum/ai_holder/simple_mob/guard/give_chase/piranhaplant
	cooperative = TRUE
	call_distance = 2
	can_breakthrough = FALSE
	vision_range = 2
	wander = FALSE
	max_home_distance = 0
	autopilot = 0 	// Set to 1 to turn off most AI actions
	wander_when_pulled = 0

//Ranged variation
/mob/living/simple_mob/hostile/piranhaplant/spitter
	name = "Piranha Spitter"
	projectiletype	= /obj/item/projectile/energy/piranhaspit	// The projectiles I shoot
	projectilesound = 'sound/weapons/thudswoosh.ogg' // The sound I make when I do it
	attack_armor_pen = 0
	special_attack_min_range = 1
	special_attack_max_range = 6
	base_attack_cooldown = 90
	ai_holder_type = /datum/ai_holder/simple_mob/ranged/kiting/spitterplant

/datum/ai_holder/simple_mob/ranged/kiting/spitterplant
	cooperative = TRUE
	call_distance = 2
	can_breakthrough = FALSE
	wander = FALSE
	max_home_distance = 0
	autopilot = 0
	wander_when_pulled = 0
	firing_lanes = FALSE
	vision_range = 5
	run_if_this_close = 0
	pointblank = FALSE

/datum/ai_holder/simple_mob/ranged/spitterplant/max_range(atom/movable/AM)
	if(isliving(AM))
		var/mob/living/L = AM
		if(L.incapacitated(INCAPACITATION_DISABLED) || L.stat == UNCONSCIOUS) // If our target is stunned, go in for the kill.
			return 1
	return ..() // Do ranged if possible otherwise.

//mob/living/simple_mob/hostile/piranhaplant/spitter/proc/Shoot()
	//TOX/HALLOSS swap code goes here //TODO

//Piranha unique projectile
/obj/item/projectile/energy/piranhaspit
    name = "piranha spit"
    icon_state = "neurotoxin"
    damage = 10
    damage_type = HALLOSS
    check_armour = "bio" //yup biohazard protection works here
    flash_strength = 0
    agony = 10
    combustion = FALSE

/obj/item/weapon/reagent_containers/food/snacks/soylentgreen/piranha
	name = "Soylent"
	desc = "This was spat out by a strange plant that eats people."
	icon_state = "soylent_green"
	filling_color = "#B8E6B5"
	center_of_mass = list("x"=15, "y"=11)

/obj/item/projectile/energy/piranhaspit/on_hit(var/atom/soyled)
    if(prob(5))
        soyl(soyled)
    ..()

/obj/item/projectile/energy/piranhaspit/proc/soyl(var/mob/M)
	var/location = get_turf(M)
	new /obj/item/weapon/reagent_containers/food/snacks/soylentgreen/piranha(location)

//VORE FLUFF section and extended gut settings
/mob/living/simple_mob/hostile/piranhaplant/init_vore()
	..()
	var/obj/belly/B = vore_selected
	B.vore_verb = "chomp up"
	B.name = "stomach"
	B.desc	= "You're pulled into the tight mouth of the plant. The teeth and walls gnash harshly on you!"
	B.digest_burn = 0
	B.digest_brute = 5

/mob/living/simple_mob/hostile/piranhaplant/spitter/init_vore()
	..()
	var/obj/belly/B = vore_selected
	B.vore_verb = "slurp up"
	B.desc	= "You're pulled into the tight mouth of the plant. The tongue mulls you about and squishes you around, coating you in a slurry of digestive fluides that burn hotly and smell foul."
	B.digest_burn = 5
	B.digest_brute = 0

/mob/living/simple_mob/hostile/piranhaplant/pitcher
	icon_state = "pitcher-plant"
	icon_living = "pitcher-plant"
	icon_dead = "pitcher-plant_dead"
	name = "Pitcher Plant"
	desc = "It's a plant! How pretty"
	tt_desc = "Brig Flower"
	health = 500
	maxHealth = 500
	var/antispam = 0
	swallowTime = 3 SECONDS //If you get to close to a pitcher, its your own fault ;p
	ai_holder_type = /datum/ai_holder/simple_mob/guard/pitcherplant

/datum/ai_holder/simple_mob/guard/pitcherplant
	cooperative = TRUE
	call_distance = 2
	can_breakthrough = FALSE
	vision_range = 2
	wander = FALSE
	max_home_distance = 0
	autopilot = 0 	// Set to 1 to turn off most AI actions
	wander_when_pulled = 0
	stand_ground = TRUE

/mob/living/simple_mob/hostile/piranhaplant/pitcher/death()
	..()
	new /obj/item/weapon/reagent_containers/food/snacks/aesirsalad(src.loc)
	new /obj/item/weapon/reagent_containers/food/snacks/aesirsalad(src.loc)
	new /obj/item/weapon/reagent_containers/food/snacks/aesirsalad(src.loc)
	new /obj/item/weapon/reagent_containers/food/snacks/aesirsalad(src.loc)
	qdel(src)

/mob/living/simple_mob/hostile/piranhaplant/pitcher/Life()
	..()
	if(!anchored)
		anchored=1
	if(vore_fullness && !antispam)
		antispam = 1
		spawn(10)
			if(bruteloss >= 1)
				bruteloss -= 1
			antispam = !antispam
			if(prob(3))
				new /obj/item/weapon/reagent_containers/food/snacks/soylentgreen/piranha(src.loc)

	if(size_multiplier!=1*health/100 && health >= 50 && health <= 300)
		size_multiplier=1*health/100
		update_icons()

/mob/living/simple_mob/hostile/piranhaplant/pitcher/New()
    ..()
    bruteloss = 400

/mob/living/simple_mob/hostile/piranhaplant/pitcher/init_vore()
	..()
	var/obj/belly/B = vore_selected
	B.desc	= "You're pulled into the tight stomach of the plant. The walls knead weakly around you, coating you in thick, viscous fluids that cling to your body, that soon starts to tingle and burn..."
	B.digest_burn = 0.5
	B.digest_brute = 0
	B.vore_verb = "slurp up"
	B.name = "pitcher"
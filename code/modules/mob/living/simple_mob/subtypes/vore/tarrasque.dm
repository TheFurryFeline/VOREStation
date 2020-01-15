/mob/living/simple_mob/vore/aggressive/tarrasque
	name = "T'rasq"
	desc = "The most dreaded monster. Its purpose is to devour the worlds 1 waking cycle at a time, all it knows is, eat, sleep, repeat."

	icon_dead = "terrasque-dead"
	icon_living = "terrasque"
	icon_state = "terrasque"
	icon = 'icons/mob/vore32x32.dmi'

	response_help   = "sacrifices self to"
	response_disarm = "futilely pushes at"
	response_harm   = "Weakly flails at"

	movement_cooldown = 4
//	speed = 5
	maxHealth = 1000
	health = 1000

	harm_intent_damage = 1
	melee_damage_lower = 10 //huh not so bad
	melee_damage_upper = 45 //oh, oh no
	attacktext = list("bites","claws","slashes")

	//say_list_type = null	//TFF 8/1/20 - Apparently there's nothing from the old code.
	ai_holder_type = /datum/ai_holder/simple_mob/destructive

	min_oxy = 0
	max_tox = 0
	max_co2 = 0
	minbodytemp = 0
	maxbodytemp = 100000
	unsuitable_atoms_damage = 0

	grab_resist = 100 //It's a collosal creature... you arent just grabbing that...
	taser_kill = 0 //It's lethals or nothing
	attack_sharp = 1
	shock_resist = 1
	resistance = 99
	attack_armor_pen = 20
	melee_miss_chance = 0

/mob/living/simple_mob/vore/aggressive/tarrasque/death()
	..()
	visible_message("<span class='notice'>\The [src] is annoyed with your continued resistance and burrows into the ground!</span>")
	qdel(src)

/mob/living/simple_mob/vore/aggressive/tarrasque/mrx
	name = "Entity X"
	desc = "The call of the abyss manifested. Doors have proven ineffective against it."
	tt_desc = "Unknown Specimen"
	pixel_x = -15
	health = 2000
	maxHealth = 2000
	icon = 'icons/mob/vore64x64.dmi'
	icon_state = "arachnid"
	icon_living = "arachnid"
	icon_dead = "arachnid_stunned" //Same as dead but no blood
	icon_rest = "arachnid_sleeping"
	attack_sharp = 0
	size_multiplier = 1
	melee_damage_lower = 0
	melee_damage_upper = 50
	attacktext = list("whacked","slashed","smashed")
	var/alang = LANGUAGE_GALCOM
	var/active_sound = 'sound/effects/vore_mob_sounds/kefka.ogg'
	armor = list(
				"melee" = 99,
				"bullet" = 99,
				"laser" = 99,
				"energy" = 99,
				"bomb" = 99,
				"bio" = 100,
				"rad" = 100)

//Vore stuff
	vore_active = 1
	vore_capacity = 2
	vore_pounce_chance = 10 //Rare
	vore_default_flags = 0
	vore_default_mode = DM_DIGEST
	vore_standing_too = 1
	vore_icons = SA_ICON_LIVING

/mob/living/simple_mob/vore/aggressive/tarrasque/mrx/init_vore()
	..()
	var/obj/belly/B = vore_selected
	B.digest_burn = 10 //Normally this can only be 6 but since we are in code we can override this to be 10 so we dont need brute.
	B.digest_brute = 0

/mob/living/simple_mob/vore/aggressive/tarrasque/mrx/New()
	..()
	update_icon()
	seedarkness = 0
	src.sight |= SEE_TURFS|SEE_MOBS|SEE_OBJS
	add_language("Xenomorph")
	verbs |= /mob/living/simple_mob/vore/aggressive/tarrasque/mrx/proc/hackervoice
	verbs |= /mob/living/simple_mob/vore/aggressive/tarrasque/mrx/proc/scarethelights
	verbs |= /mob/living/simple_mob/vore/aggressive/tarrasque/mrx/proc/knocktheirfaces

/mob/living/simple_mob/vore/aggressive/tarrasque/mrx/Life()
	..()
	if(!pixel_x)
		pixel_x = -15
	if(resting && !client)
		resting = !resting
		update_icon()
	if (anchored)
		melee_damage_upper = 0 //hacky way to stop attacks
		set_light(l_range = 10, l_power = 5, l_color = COLOR_RED) //RUN BITCHES
	if(!anchored)
		melee_damage_upper = 50
	if(!client)
		opensesame()
	if(buckled)
		resist()
		buckled = null
	if(active_sound)
		while(anchored)
			playsound(src.loc, "[active_sound]", 100, 0, 4)
			sleep(60)

//time for special MR X kick you in the shins and stands there code
/mob/living/simple_mob/vore/aggressive/tarrasque/mrx/proc/DoPunch(var/atom/A)
	. = ..()
	if(.) // If we succeeded in hitting.
		if(alang==LANGUAGE_GALCOM)
			alang="Xenomorph"
		else if(alang=="Xenomorph")
			alang=LANGUAGE_GALCOM
		flicker()
		if(istype(A,/turf/simulated/wall))
			var/turf/simulated/wall/wall = A
			wall.dismantle_wall(null,null,1)
		if(isliving(A) && !anchored)
			src.say("Run tasty treat, run~", alang,"chitters") //may hiss may not, balanced
			var/mob/living/L = A
			L.Weaken(5)
			//stop_automated_movement = 1
			anchored = 1
			melee_damage_upper = 0
			spawn(150)
				//stop_automated_movement = 0
				anchored = 0
				melee_damage_upper = 50

/mob/living/simple_mob/vore/aggressive/tarrasque/mrx/handle_regular_hud_updates()
	..()
	sight |= SEE_TURFS|SEE_MOBS|SEE_OBJS
	see_in_dark = 8
	see_invisible = SEE_INVISIBLE_LEVEL_TWO
/////////////////////////////////////////
//////////////Special EX PRocs go here // Mostly for playercontrolled stuff
/////////////////////////////////////////
/mob/living/simple_mob/vore/aggressive/tarrasque/mrx/proc/opensesame()
	for(var/obj/machinery/door/airlock/door in range(5, src))
		door.open(1)
		door.lock(1)
/mob/living/simple_mob/vore/aggressive/tarrasque/mrx/proc/flicker()
	for(var/obj/machinery/light/light in range(5, src))
		light.flicker(2)
/mob/living/simple_mob/vore/aggressive/tarrasque/mrx/proc/stopfuckingkitingme()
	for(var/mob/living/carbon/human/peasant in range(2, src))
		DoPunch(peasant)
/mob/living/simple_mob/vore/aggressive/tarrasque/mrx/proc/knocktheirfaces()
	set name = "Anti Kite"
	set desc = "Fuck them up"
	set category = "X Powers"
	stopfuckingkitingme()
/mob/living/simple_mob/vore/aggressive/tarrasque/mrx/proc/hackervoice()
	set name = "Door Override"
	set desc = "Hacker Voice: Im in"
	set category = "X Powers"
	opensesame()
/mob/living/simple_mob/vore/aggressive/tarrasque/mrx/proc/scarethelights()
	set name = "Light Flicker"
	set desc = "Hacker Voice: Im in"
	set category = "X Powers"
	flicker()
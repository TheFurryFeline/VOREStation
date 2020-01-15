//TFF 9/12/19 - Ports panda mobs from CHOMPStation.
/mob/living/simple_mob/redpanda/alt
	icon = 'icons/mob/vore48x48.dmi'
	icon_state = "wah_alt"
	icon_living = "wah_alt"
	icon_dead = "wah_alt_dead"

	pixel_x = -7

/mob/living/simple_mob/redpanda/alt/waaah
	name = "waaah"
	desc = "It's a waaah! Waaaaaaaaaah!"
	tt_desc = "Ailurus waaahius"
	icon_state = "wah_altwaaah"
	icon_living = "wah_altwaaah"
	icon_dead = "wah_altwaaah_dead"

	maxHealth = 150
	health = 150

	response_help = "pats"
	response_disarm = "gently pushes aside"
	response_harm = "hits"

	harm_intent_damage = 5
	melee_damage_lower = 5
	melee_damage_upper = 2
	attacktext = list("bapped rapidly!")

	turns_per_move = 1

	speak_chance = 25
	speak = list("Waaah!",
				"Waaah?",
				"Waaaaaaaaaah!")
	emote_hear = list("wahs!","wahs even more!")
	emote_see = list("trundles around wahing","rears up onto their hind legs and wahs at everyone!")
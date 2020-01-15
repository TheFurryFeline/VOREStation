/mob
	var/muffled = 0 					// Used by muffling belly

/mob/living
	var/ooc_notes = null
	var/obj/structure/mob_spawner/source_spawner = null
	//TFF 9/1/20 pitcher plant CHOMPStation port
	var/entangle_immunity = 0

//custom say verbs
	var/custom_say = null
	var/custom_ask = null
	var/custom_exclaim = null
	var/custom_whisper = null
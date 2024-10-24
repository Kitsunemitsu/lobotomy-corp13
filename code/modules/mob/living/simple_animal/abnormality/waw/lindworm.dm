/mob/living/simple_animal/hostile/abnormality/lindworm
	name = "Weaving Lindworm"
	desc = "An abnormality taking form of a lindworm with metal rake in place of its hand."
	icon = 'ModularTegustation/Teguicons/32x48.dmi'
	icon_state = "lindworm"
	icon_living = "lindworm"
	icon_dead = "lindworm_dead"
	portrait = "lindworm"
	del_on_death = FALSE
	maxHealth = 700
	health = 700
	rapid_melee = 1
	move_to_delay = 3
	damage_coeff = list(RED_DAMAGE = 1, WHITE_DAMAGE = 1, BLACK_DAMAGE = 1, PALE_DAMAGE = 1)
	melee_damage_lower = 60
	melee_damage_upper = 70
	melee_damage_type = RED_DAMAGE
	stat_attack = DEAD
//	attack_sound = 'sound/abnormalities/lindworm/attack.ogg'
	attack_verb_continuous = "gores"
	attack_verb_simple = "gore"
	can_breach = TRUE
	threat_level = WAW_LEVEL
	start_qliphoth = 2
	work_chances = list(
		ABNORMALITY_WORK_INSTINCT = 60,
		ABNORMALITY_WORK_INSIGHT = 60,
		ABNORMALITY_WORK_ATTACHMENT = 60,
		ABNORMALITY_WORK_REPRESSION = 60,
	)
	work_damage_amount = 10
	work_damage_type = list(WHITE_DAMAGE, RED_DAMAGE)	//Deals both red and white
//	death_message = "stops moving, with its torso rotating forwards."
//	death_sound = 'sound/abnormalities/lindworm/death.ogg'

	ego_list = list(
//		/datum/ego_datum/weapon/harvest,
//		/datum/ego_datum/armor/harvest,
	)
//	gift_type =  /datum/ego_gifts/harvest
	abnormality_origin = ABNORMALITY_ORIGIN_ORIGINAL

	color = "#234e99"
	var/layers_left = 5
	var/mob/living/carbon/human/red_weak
	var/mob/living/carbon/human/white_weak
	var/mob/living/carbon/human/black_weak
	var/mob/living/carbon/human/pale_weak

/mob/living/simple_animal/hostile/abnormality/lindworm/death(gibbed)
	for(var/turf/open/T in view(5, src))
		if(locate(/obj/structure/turf_confetti) in T)
			for(var/obj/structure/turf_confetti/floor_fire in T)
				qdel(floor_fire)
		new /obj/structure/turf_confetti(T)

	playsound(get_turf(src), 'sound/abnormalities/bigbird/bite.ogg', 50, 1, 2)
	new /obj/effect/gibspawner/generic/silent(get_turf(src))


	if(layers_left)
		layers_left-=1
		HandleLayers()
		revive(full_heal = TRUE, admin_revive = TRUE)
		return

	CleanupDefense()
	density = FALSE
	animate(src, alpha = 0, time = 10 SECONDS)
	QDEL_IN(src, 10 SECONDS)
	..()

/mob/living/simple_animal/hostile/abnormality/lindworm/AttackingTarget()
	..()
	for(var/turf/open/T in view(1, target))
		if(locate(/obj/structure/turf_confetti) in T)
			for(var/obj/structure/turf_confetti/floor_fire in T)
				qdel(floor_fire)
		new /obj/structure/turf_confetti(T)

	if(ishuman(target))
		var/mob/living/H = target
		if(H.health < 0)
			layers_left+=1
			HandleLayers()
			H.gib()

/mob/living/simple_animal/hostile/abnormality/lindworm/proc/HandleLayers()
	switch(layers_left)
		if(0)
			color = "#FFFFFF"
		if(1)
			color = "#a1b9e3"
		if(2)
			color = "#6e90cc"
		if(3)
			color = "#4e73b5"
		else
			color = "#234e99"

//Work shit

/mob/living/simple_animal/hostile/abnormality/lindworm/PostWorkEffect(mob/living/carbon/human/user, work_type, pe, work_time)
	switch(work_type)
		if(ABNORMALITY_WORK_INSTINCT)
			if(!red_weak)	//Decrease red mod, store who's being worked on and lower a layer.
				red_weak = user
				user.physiology.red_mod *= 1.3
				layers_left-=1
				to_chat(user, span_userdanger("You feel your armor shed; and a layer falls away from the lindworm."))
				playsound(get_turf(src), 'sound/abnormalities/bigbird/bite.ogg', 50, 1, 2)
				new /obj/effect/gibspawner/generic/silent(get_turf(src))
				HandleLayers()

		if(ABNORMALITY_WORK_INSIGHT)
			if(!white_weak)
				white_weak = user
				user.physiology.white_mod *= 1.3
				layers_left-=1
				to_chat(user, span_userdanger("You feel your armor shed; and a layer falls away from the lindworm."))
				playsound(get_turf(src), 'sound/abnormalities/bigbird/bite.ogg', 50, 1, 2)
				new /obj/effect/gibspawner/generic/silent(get_turf(src))
				HandleLayers()

		if(ABNORMALITY_WORK_ATTACHMENT)
			if(!black_weak)
				black_weak = user
				user.physiology.black_mod *= 1.3
				layers_left-=1
				to_chat(user, span_userdanger("You feel your armor shed; and a layer falls away from the lindworm."))
				playsound(get_turf(src), 'sound/abnormalities/bigbird/bite.ogg', 50, 1, 2)
				new /obj/effect/gibspawner/generic/silent(get_turf(src))
				HandleLayers()

		if(ABNORMALITY_WORK_REPRESSION)
			if(!pale_weak)
				pale_weak = user
				user.physiology.pale_mod *= 1.3
				layers_left-=1
				to_chat(user, span_userdanger("You feel your armor shed; and a layer falls away from the lindworm."))
				playsound(get_turf(src), 'sound/abnormalities/bigbird/bite.ogg', 50, 1, 2)
				new /obj/effect/gibspawner/generic/silent(get_turf(src))
				HandleLayers()



/mob/living/simple_animal/hostile/abnormality/lindworm/proc/CleanupDefense()
	if(red_weak)
		red_weak.physiology.red_mod /= 1.3
		to_chat(red_weak, span_notice("You feel your natural body hardening again."))

	if(white_weak)
		white_weak.physiology.white_mod /= 1.3
		to_chat(white_weak, span_notice("You feel your natural body hardening again."))

	if(black_weak)
		black_weak.physiology.black_mod /= 1.3
		to_chat(black_weak, span_notice("You feel your natural body hardening again."))

	if(pale_weak)
		pale_weak.physiology.pale_mod /= 1.3
		to_chat(pale_weak, span_notice("You feel your natural body hardening again."))


// Turf effect
/obj/structure/turf_confetti
	gender = PLURAL
	name = "confetti"
	desc = "a burning pyre."
	icon = 'icons/effects/effects.dmi'
	icon_state = "dancing_lights"
	anchored = TRUE
	density = FALSE
	layer = TURF_LAYER
	plane = FLOOR_PLANE
	base_icon_state = "dancing_lights"

/obj/structure/turf_confetti/Initialize()
	. = ..()
	QDEL_IN(src, 15 SECONDS)

//Red and not burn, burn is a special damage type.
/obj/structure/turf_confetti/Crossed(atom/movable/AM)
	. = ..()
	if(ishuman(AM))
		var/mob/living/carbon/human/H = AM
		H.apply_damage(15, RED_DAMAGE, null, H.run_armor_check(null, RED_DAMAGE), spread_damage = TRUE)
		H.apply_damage(15, WHITE_DAMAGE, null, H.run_armor_check(null, WHITE_DAMAGE), spread_damage = TRUE)

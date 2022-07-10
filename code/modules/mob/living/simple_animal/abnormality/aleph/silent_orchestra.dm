/mob/living/simple_animal/hostile/abnormality/silentorchestra
	name = "Silent orchestra"
	desc = "From break and ruin, the most beautiful performance begins."
	health = 4000
	maxHealth = 4000
	icon = 'ModularTegustation/Teguicons/32x48.dmi'
	icon_state = "silent"
	icon_living = "silent"
	damage_coeff = list(BRUTE = 1, RED_DAMAGE = 0, WHITE_DAMAGE = 0, BLACK_DAMAGE = 0, PALE_DAMAGE = 0)
	can_breach = TRUE
	threat_level = ALEPH_LEVEL
	start_qliphoth = 2
	work_chances = list(
						ABNORMALITY_WORK_INSTINCT = 0,
						ABNORMALITY_WORK_INSIGHT = list(0, 0, 30, 30, 40),
						ABNORMALITY_WORK_ATTACHMENT = list(0, 0, 40, 40, 50),
						ABNORMALITY_WORK_REPRESSION = list(0, 0, 10, 20, 30)
						)
	work_damage_amount = 16
	work_damage_type = WHITE_DAMAGE

	wander = FALSE
	light_system = MOVABLE_LIGHT
	light_color = COLOR_VERY_LIGHT_GRAY
	light_range = 7
	light_power = 2

	/// Range of the damage
	var/symphony_range = 7
	/// Amount of white damage
	var/symphony_damage = 5
	/// When to perform next movement
	var/next_movement_time
	/// Current movement
	var/current_movement_num = -1
	/// List of effects currently spawned
	var/list/performers = list()

/mob/living/simple_animal/hostile/abnormality/silentorchestra/Move()
	return FALSE

/mob/living/simple_animal/hostile/abnormality/silentorchestra/Life()
	. = ..()
	if(!.) // Dead
		return FALSE
	if(!(status_flags & GODMODE))
		DamagePulse()

/mob/living/simple_animal/hostile/abnormality/silentorchestra/Destroy()
	for(var/obj/effect/silent_orchestra_singer/O in performers)
		O.fade_out()
	return ..()

/mob/living/simple_animal/hostile/abnormality/silentorchestra/CanAttack(atom/the_target)
	return FALSE

/mob/living/simple_animal/hostile/abnormality/silentorchestra/proc/DamagePulse()
	for(var/mob/living/carbon/human/H in urange(symphony_range, get_turf(src)))
		H.apply_damage(symphony_damage - round(get_dist(src, H) * 0.5), WHITE_DAMAGE, null, H.run_armor_check(null, WHITE_DAMAGE), spread_damage = TRUE, forced = TRUE)

	if(world.time >= next_movement_time) // Next movement
		var/movement_volume = 50
		current_movement_num += 1
		symphony_range += 5
		switch(current_movement_num)
			if(0)
				next_movement_time = world.time + 5 SECONDS
			if(1)
				next_movement_time = world.time + 22 SECONDS
				damage_coeff = list(BRUTE = 1, RED_DAMAGE = 0, WHITE_DAMAGE = 0, BLACK_DAMAGE = 0, PALE_DAMAGE = 0.2)
				spawn_performer(1, WEST)
			if(2)
				next_movement_time = world.time + 14.5 SECONDS
				damage_coeff = list(BRUTE = 1, RED_DAMAGE = 0, WHITE_DAMAGE = 0, BLACK_DAMAGE = 1, PALE_DAMAGE = 0)
				spawn_performer(2, WEST)
			if(3)
				next_movement_time = world.time + 11.5 SECONDS
				damage_coeff = list(BRUTE = 1, RED_DAMAGE = 0, WHITE_DAMAGE = 1, BLACK_DAMAGE = 0, PALE_DAMAGE = 0)
				symphony_damage = 15
				movement_volume = 10 // No more tinnitus
				spawn_performer(1, EAST)
			if(4)
				next_movement_time = world.time + 23 SECONDS
				damage_coeff = list(BRUTE = 1, RED_DAMAGE = 1, WHITE_DAMAGE = 0, BLACK_DAMAGE = 0, PALE_DAMAGE = 0)
				symphony_damage = 10
				spawn_performer(2, EAST)
			if(5)
				next_movement_time = world.time + 999 SECONDS // Never
				damage_coeff = list(BRUTE = 1, RED_DAMAGE = 0, WHITE_DAMAGE = 0, BLACK_DAMAGE = 0, PALE_DAMAGE = 0)
				movement_volume = 75 // TA-DA!!!
		if(current_movement_num < 6)
			for(var/mob/M in GLOB.player_list)
				if(M.z == z && M.client)
					M.playsound_local(get_turf(M), "sound/abnormalities/silentorchestra/movement[current_movement_num].ogg", movement_volume, 0)
			if(current_movement_num == 5)
				for(var/mob/living/carbon/human/H in urange(symphony_range, get_turf(src)))
					if(H.sanity_lost || (H.sanityhealth < H.maxSanity * 0.5))
						var/obj/item/bodypart/head/head = H.get_bodypart("head")
						if(QDELETED(head))
							continue
						head.dismember()
						QDEL_NULL(head)
						H.regenerate_icons()
						H.visible_message("<span class='danger'>[H]'s head explodes!</span>")
						new /obj/effect/gibspawner/generic/silent(get_turf(H))
						playsound(get_turf(H), 'sound/abnormalities/silentorchestra/headbomb.ogg', 35, 1)
				SLEEP_CHECK_DEATH(4 SECONDS)
				animate(src, alpha = 0, time = 2 SECONDS)
				QDEL_IN(src, 2 SECONDS)

/mob/living/simple_animal/hostile/abnormality/silentorchestra/proc/spawn_performer(distance = 1, direction = EAST)
	var/turf/T = get_turf(src)
	for(var/i = 1 to distance)
		T = get_step(T, direction)
	var/obj/effect/silent_orchestra_singer/O = new(T)
	var/performer_icon_num = clamp(current_movement_num, 1, 4)
	O.icon_state = "silent_[performer_icon_num]"
	O.update_icon()
	performers += O
	return

/mob/living/simple_animal/hostile/abnormality/silentorchestra/success_effect(mob/living/carbon/human/user, work_type, pe)
	datum_reference.qliphoth_change(-1)
	return

/mob/living/simple_animal/hostile/abnormality/silentorchestra/failure_effect(mob/living/carbon/human/user, work_type, pe)
	datum_reference.qliphoth_change(-1)
	return

/mob/living/simple_animal/hostile/abnormality/silentorchestra/breach_effect(mob/living/carbon/human/user)
	..()
	var/turf/T = pick(GLOB.department_centers)
	forceMove(T)
	DamagePulse()
	return

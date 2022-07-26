/mob/living/simple_animal/hostile/ordeal/indigo_noon
	name = "sweeper"
	desc = "A humanoid creature wearing metallic armor. It has bloodied hooks in its hands."
	icon = 'ModularTegustation/Teguicons/tegumobs.dmi'
	icon_state = "sweeper_1"
	icon_living = "sweeper_1"
	icon_dead = "sweeper_dead"
	faction = list("indigo_ordeal")
	maxHealth = 500
	health = 500
	move_to_delay = 4
	stat_attack = DEAD
	melee_damage_type = BLACK_DAMAGE
	armortype = BLACK_DAMAGE
	melee_damage_lower = 20
	melee_damage_upper = 24
	attack_verb_continuous = "stabs"
	attack_verb_simple = "stab"
	attack_sound = 'sound/effects/ordeals/indigo/stab_1.ogg'
	damage_coeff = list(BRUTE = 1, RED_DAMAGE = 1, WHITE_DAMAGE = 1.5, BLACK_DAMAGE = 0.5, PALE_DAMAGE = 1)
	blood_volume = BLOOD_VOLUME_NORMAL

/mob/living/simple_animal/hostile/ordeal/sweeper/Initialize()
	..()
	attack_sound = "sound/effects/ordeals/indigo/stab_[pick(1,2)].ogg"
	icon_living = "sweeper_[pick(1,2)]"
	icon_state = icon_living

/mob/living/simple_animal/hostile/ordeal/sweeper/AttackingTarget()
	. = ..()
	if(. && isliving(target))
		var/mob/living/L = target
		if(L.stat != DEAD)
			if(L.health <= HEALTH_THRESHOLD_DEAD && HAS_TRAIT(L, TRAIT_NODEATH))
				devour(L)
		else
			devour(L)

/mob/living/simple_animal/hostile/ordeal/sweeper/proc/devour(mob/living/L)
	if(!L)
		return FALSE
	visible_message(
		"<span class='danger'>[src] devours [L]!</span>",
		"<span class='userdanger'>You feast on [L], restoring your health!</span>")
	adjustBruteLoss(-(maxHealth/2))
	L.gib()
	return TRUE


/mob/living/simple_animal/hostile/ordeal/indigo_midnight
	name = "The Matriarch"
	desc = "A humanoid creature wearing metallic armor. The Queen of sweepers."
	icon = 'ModularTegustation/Teguicons/64x64.dmi'
	icon_state = "matriarch"
	icon_living = "matriarch"
	icon_dead = "matriarch_dead"
	faction = list("indigo_ordeal")
	maxHealth = 2000
	health = 2000
	stat_attack = DEAD
	pixel_x = -16
	base_pixel_x = -16
	melee_damage_type = BLACK_DAMAGE
	armortype = BLACK_DAMAGE
	rapid_melee = 2
	melee_damage_lower = 60
	melee_damage_upper = 60
	attack_verb_continuous = "stabs"
	attack_verb_simple = "stab"
	attack_sound = 'sound/effects/ordeals/indigo/stab_1.ogg'
	damage_coeff = list(BRUTE = 0.2, RED_DAMAGE = 0.3, WHITE_DAMAGE = 0.4, BLACK_DAMAGE = 0.2, PALE_DAMAGE = 0.05)
	blood_volume = BLOOD_VOLUME_NORMAL
	move_resist = MOVE_FORCE_OVERPOWERING

	//How many people has she eaten
	var/belly = 0

	var/pulse_cooldown
	var/pulse_cooldown_time = 10 SECONDS
	var/pulse_damage = 10 // More over time


/mob/living/simple_animal/hostile/ordeal/indigo_midnight/AttackingTarget()
	. = ..()
	if(. && isliving(target))
		var/mob/living/L = target
		if(L.stat != DEAD)
			if(L.health <= HEALTH_THRESHOLD_DEAD && HAS_TRAIT(L, TRAIT_NODEATH))
				devour(L)
		else
			devour(L)


/mob/living/simple_animal/hostile/ordeal/indigo_midnight/proc/devour(mob/living/L)
	if(!L)
		return FALSE
	visible_message(
		"<span class='danger'>[src] devours [L]!</span>",
		"<span class='userdanger'>You feast on [L], restoring your health!</span>")
	adjustBruteLoss(-(maxHealth))
	L.gib()


	//Increase the Vore counter by 1
	belly += 1
	pulse_damage += 2


	//She gets faster but not as protected or as strong
	if(belly == 5)
		//animation!
		icon_state = "phasechange"
		SLEEP_CHECK_DEATH(5)

		damage_coeff = list(BRUTE = 0.4, RED_DAMAGE = 0.4, WHITE_DAMAGE = 0.6, BLACK_DAMAGE = 0.25, PALE_DAMAGE = 0.1)
		move_to_delay -= move_to_delay*0.4
		speed += speed*0.4
		rapid_melee +=2
		melee_damage_lower -= 10
		melee_damage_upper -= 10

		pulse_cooldown_time = 6 SECONDS

		icon_state = "matriarch_slim"
		icon_living = "matriarch_slim"


	if(belly == 10)
		icon_state = "sicko_mode"
		SLEEP_CHECK_DEATH(5)

		damage_coeff = list(BRUTE = 0.5, RED_DAMAGE = 0.5, WHITE_DAMAGE = 0.8, BLACK_DAMAGE = 0.3, PALE_DAMAGE = 0.2)
		move_to_delay -= move_to_delay*0.4
		speed += speed*0.4
		rapid_melee += 2
		melee_damage_lower -= 10
		melee_damage_upper -= 10

		pulse_cooldown_time = 4 SECONDS
		icon_state = "matriarch_fast"
		icon_living = "matriarch_fast"

	return TRUE


/mob/living/simple_animal/hostile/ordeal/indigo_midnight/Life()
	. = ..()
	if(!.) // Dead
		return FALSE
	if(pulse_cooldown < world.time)
		BlackPulse()


/mob/living/simple_animal/hostile/ordeal/indigo_midnight/proc/BlackPulse()
	pulse_cooldown = world.time + pulse_cooldown_time

	playsound(src, 'sound/weapons/resonator_blast.ogg', 100, FALSE, 90)

	for(var/mob/living/L in urange(90, src))
		if(faction_check_mob(L))
			continue

		//don't kill if you're too close.
		var/distance = round(get_dist(src, L))
		if(distance <= 10)
			continue

		L.apply_damage(((pulse_damage + distance - 10)*0.5), BLACK_DAMAGE, null, L.run_armor_check(null, BLACK_DAMAGE), spread_damage = TRUE)

	SLEEP_CHECK_DEATH(3)


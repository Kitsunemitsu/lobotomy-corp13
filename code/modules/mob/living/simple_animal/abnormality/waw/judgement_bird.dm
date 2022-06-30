/mob/living/simple_animal/hostile/abnormality/judgement_bird
	name = "Judgement bird"
	desc = "A bird that used to judge the living in the dark forest, carrying around an unbalanced scale."
	icon = 'ModularTegustation/Teguicons/48x64.dmi'
	icon_state = "judgement_bird"
	icon_living = "judgement_bird"
	faction = list("hostile")
	speak_emote = list("chirps")

	pixel_x = -16
	base_pixel_x = -16

	ranged = TRUE
	retreat_distance = 1
	minimum_distance = 4

	maxHealth = 1500
	health = 1500
	damage_coeff = list(BRUTE = 1, RED_DAMAGE = 0.8, WHITE_DAMAGE = 0.8, BLACK_DAMAGE = 0.8, PALE_DAMAGE = 2)
	see_in_dark = 10

	speed = 4
	threat_level = WAW_LEVEL
	can_breach = TRUE
	start_qliphoth = 2
	work_chances = list(
						ABNORMALITY_WORK_INSTINCT = 45,
						ABNORMALITY_WORK_INSIGHT = 50,
						ABNORMALITY_WORK_ATTACHMENT = 45,
						ABNORMALITY_WORK_REPRESSION = 0
						)
	work_damage_amount = 8
	work_damage_type = PALE_DAMAGE

	var/judgement_cooldown = 10 SECONDS
	var/judgement_cooldown_base = 10 SECONDS
	var/judgement_damage = 70
	var/judgement_range = 7

/datum/action/innate/abnormality_attack/judgement
	name = "Judgement"
	icon_icon = 'icons/obj/wizard.dmi'
	button_icon_state = "magicm"
	chosen_message = "<span class='colossus'>You will now damage all enemies around you.</span>"
	chosen_attack_num = 1

/mob/living/simple_animal/hostile/abnormality/judgement_bird/AttackingTarget(atom/attacked_target)
	return

/mob/living/simple_animal/hostile/abnormality/judgement_bird/OpenFire()
	if(client)
		switch(chosen_attack)
			if(1)
				judgement()
		return

	if(get_dist(src, target) <= judgement_range && judgement_cooldown <= world.time)
		judgement()

/mob/living/simple_animal/hostile/abnormality/judgement_bird/proc/judgement()
	if(judgement_cooldown > world.time)
		return
	judgement_cooldown = (world.time + judgement_cooldown_base)
	playsound(get_turf(src), 'sound/abnormalities/judgementbird/pre_ability.ogg', 50, 0, 2)
	SLEEP_CHECK_DEATH(2 SECONDS)
	playsound(get_turf(src), 'sound/abnormalities/judgementbird/ability.ogg', 75, 0, 4)
	for(var/mob/living/L in view(judgement_range))
		if(faction_check_mob(L, TRUE))
			continue
		new /obj/effect/temp_visual/judgement(get_turf(L))
		L.apply_damage(judgement_damage, PALE_DAMAGE, null, L.run_armor_check(null, PALE_DAMAGE), spread_damage = TRUE)

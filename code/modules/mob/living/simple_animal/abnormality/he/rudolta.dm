/mob/living/simple_animal/hostile/abnormality/rudolta
	name = "Rudolta Of The Sleigh"
	desc = "An abnormality taking form of a black ball covered by 'hearts' of different colors."
	icon = 'ModularTegustation/Teguicons/64x48.dmi'
	icon_state = "rudolta"
	icon_living = "rudolta"
	icon_dead = "rudolta_dead"
	maxHealth = 1200
	health = 1200
	pixel_x = -16
	base_pixel_x = -16
	damage_coeff = list(BRUTE = 1, RED_DAMAGE = 1.5, WHITE_DAMAGE = 0.5, BLACK_DAMAGE = 1, PALE_DAMAGE = 2)
	stat_attack = HARD_CRIT
	attack_verb_continuous = "nudges"
	attack_verb_simple = "nudges"
	faction = list("hostile")
	can_breach = TRUE
	threat_level = HE_LEVEL
	start_qliphoth = 2
	speed = 4
	move_to_delay = 5
	work_chances = list(
						ABNORMALITY_WORK_INSTINCT = list(20, 40, 40, 35, 0),
						ABNORMALITY_WORK_INSIGHT = list(50, 60, 60, 55, 50),
						ABNORMALITY_WORK_ATTACHMENT = list(40, 50, 50, 45, 40),
						ABNORMALITY_WORK_REPRESSION = 0
						)
	work_damage_amount = 10
	work_damage_type = WHITE_DAMAGE

	ego_list = list(
		/datum/ego_datum/weapon/infinitehatred,
		/datum/ego_datum/armor/infinitehatred
		)

	var/pulse_cooldown
	var/pulse_cooldown_time = 3 SECONDS
	var/pulse_damage = 15 // Scales with distance

/mob/living/simple_animal/hostile/abnormality/rudolta/neutral_effect(mob/living/carbon/human/user, work_type, pe)
	if(prob(40))
		datum_reference.qliphoth_change(-1)
	return

/mob/living/simple_animal/hostile/abnormality/rudolta/failure_effect(mob/living/carbon/human/user, work_type, pe)
	if(prob(80))
		datum_reference.qliphoth_change(-1)
	return

/mob/living/simple_animal/hostile/abnormality/rudolta/Life()
	. = ..()
	if(!.) // Dead
		return FALSE
	if((pulse_cooldown < world.time) && !(status_flags & GODMODE))
		WhitePulse()

/mob/living/simple_animal/hostile/abnormality/rudolta/CanAttack(atom/the_target)
	if(ishuman(the_target))
		return TRUE
	return FALSE

/mob/living/simple_animal/hostile/abnormality/rudolta/proc/WhitePulse()
	pulse_cooldown = world.time + pulse_cooldown_time
	playsound(src, 'sound/misc/desecration-02.ogg', 50, FALSE, 8)
	for(var/mob/living/L in livinginrange(8, src))
		if(faction_check_mob(L))
			continue
		L.apply_damage(pulse_damage, WHITE_DAMAGE, null, L.run_armor_check(null, WHITE_DAMAGE), spread_damage = TRUE)


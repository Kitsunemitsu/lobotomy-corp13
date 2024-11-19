/mob/living/simple_animal/hostile/abnormality/wraith
	name = "Forgotten Wraith"
	desc = "A shadowy, floating figure."
	icon = 'ModularTegustation/Teguicons/32x32.dmi'
	icon_state = "wraith"
	icon_living = "wraith"
	portrait = "wraith"
	maxHealth = 1200
	health = 1200
	ranged = TRUE
	density = FALSE
	attack_verb_continuous = "scorns"
	attack_verb_simple = "scorn"
	stat_attack = SOFT_CRIT
	melee_damage_lower = 11
	melee_damage_upper = 12
	damage_coeff = list(BRUTE = 1, RED_DAMAGE = 0.0, WHITE_DAMAGE = 2, BLACK_DAMAGE = 0.5, PALE_DAMAGE = 2)
	speak_emote = list("states")
	vision_range = 14
	aggro_vision_range = 20

	can_breach = TRUE
	threat_level = HE_LEVEL
	faction = list("neutral", "hostile")
	start_qliphoth = 2

	alpha = 100

	//Do this shit
	work_chances = list(
		ABNORMALITY_WORK_INSTINCT = list(50, 55, 55, 50, 45),
		ABNORMALITY_WORK_INSIGHT = list(35, 40, 40, 35, 35),
		ABNORMALITY_WORK_ATTACHMENT = list(35, 40, 40, 35, 35),
		ABNORMALITY_WORK_REPRESSION = list(0, 0, -30, -60, -90),
	)
	work_damage_amount = 8
	work_damage_type = BLACK_DAMAGE
	chem_type = /datum/reagent/abnormality/abno_oil

	ego_list = list(
	//	/datum/ego_datum/weapon/sanitizer,
	//	/datum/ego_datum/armor/sanitizer,
	)
//	gift_type =  /datum/ego_gifts/sanitizer
	abnormality_origin = ABNORMALITY_ORIGIN_ORIGINAL
	var/turf/spawnlocale


/mob/living/simple_animal/hostile/abnormality/wraith/Initialize()
	.=..()
	spawnlocale = get_turf(src)


/mob/living/simple_animal/hostile/abnormality/wraith/CanAttack(atom/the_target)
	//If he GETS YOU then you get slept and move back to his container
	if(istype(/mob/living/carbon/human, target))
		var/mob/living/carbon/human/H = target
		H.Sleeping(30 SECONDS)
		H.drowsyness += 30
		//Teleport them
		if(spawnlocale)
			H.forceMove(spawnlocale)
		//chance to die when you do this
		if(prob(40))
			qdel(src)

/* Work effects */
/mob/living/simple_animal/hostile/abnormality/wraith/SuccessEffect(mob/living/carbon/human/user, work_type, pe)
	. = ..()
	if(alpha>0)
		alpha-=10
		return

/mob/living/simple_animal/hostile/abnormality/wraith/NeutralEffect(mob/living/carbon/human/user, work_type, pe)
	. = ..()
	datum_reference.qliphoth_change(-1)
	return

/mob/living/simple_animal/hostile/abnormality/wraith/FailureEffect(mob/living/carbon/human/user, work_type, pe)
	. = ..()
	datum_reference.qliphoth_change(-1)
	return


/mob/living/simple_animal/hostile/abnormality/old_lady
	name = "Old Lady"
	desc = "An old, decrepit lady sitting in a worn-out rocking chair"
	icon = 'ModularTegustation/Teguicons/32x32.dmi'
	icon_state = "old_lady"
	maxHealth = 400
	health = 400
	threat_level = TETH_LEVEL
	work_chances = list(
		ABNORMALITY_WORK_INSTINCT = list(45, 45, 40, 40, 40),
		ABNORMALITY_WORK_INSIGHT = list(45, 45, 50, 50, 50),
		ABNORMALITY_WORK_ATTACHMENT = list(65, 65, 60, 60, 60),
		ABNORMALITY_WORK_REPRESSION = 30,
		"Clear Solitude" = -100)
	start_qliphoth = 4
	work_damage_amount = 6
	work_damage_type = WHITE_DAMAGE
	ego_list = list(
		/datum/ego_datum/weapon/solitude,
//		/datum/ego_datum/armor/solitude
		)
//	gift_type =  /datum/ego_gifts/solitude
	var/meltdown_cooldown_time = 120 SECONDS
	var/meltdown_cooldown

/mob/living/simple_animal/hostile/abnormality/old_lady/Initialize()
	meltdown_cooldown = world.time + meltdown_cooldown_time

/mob/living/simple_animal/hostile/abnormality/old_lady/Life()
	. = ..()
	if(meltdown_cooldown < world.time)
		meltdown_cooldown = world.time + meltdown_cooldown_time
		datum_reference.qliphoth_change(-1)

/mob/living/simple_animal/hostile/abnormality/old_lady/attempt_work(mob/living/carbon/human/user, work_type)
	if(work_type == "Clear Solitude" && datum_reference.qliphoth_meter == 0)
		return TRUE
	else if(datum_reference.qliphoth_meter == 0 || work_type == "Clear Solitude")
		return FALSE
	return TRUE

/mob/living/simple_animal/hostile/abnormality/old_lady/work_complete(mob/living/carbon/human/user, work_type, pe)
	if(work_type == "Clear Solitude")
		datum_reference.qliphoth_change(4)
	return ..()

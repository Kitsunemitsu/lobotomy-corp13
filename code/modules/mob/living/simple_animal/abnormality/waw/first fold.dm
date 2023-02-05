//Coded by me, Kirie Saito!
/mob/living/simple_animal/hostile/abnormality/firstfold
	name = "First Fold to Infinity"
	desc = "A man with a flaming head sitting behind a desk."
	icon = 'ModularTegustation/Teguicons/64x48.dmi'
	icon_state = "firstfold"
	threat_level = WAW_LEVEL
	work_chances = list(
		ABNORMALITY_WORK_INSTINCT = list(0, 0, 40, 50, 50),
		ABNORMALITY_WORK_INSIGHT = 0,
		ABNORMALITY_WORK_ATTACHMENT = list(0, 0, 30, 40, 40),
		ABNORMALITY_WORK_REPRESSION = list(0, 0, 50, 45, 45),
		"Contract" = 100
			)
	start_qliphoth = 2
	work_damage_amount = 10
	work_damage_type = PALE_DAMAGE

	ego_list = list(
//		/datum/ego_datum/weapon/eight,
//		/datum/ego_datum/armor/eight,
		)
//	gift_type = /datum/ego_gifts/eight

	var/list/spawnables = list()

/mob/living/simple_animal/hostile/abnormality/firstfold/Initialize()
	. = ..()
	//We need a list of all abnormalities that are HE level and Can breach.

	var/list/queue = subtypesof(/mob/living/simple_animal/hostile/abnormality)
	for(var/mob/living/simple_animal/hostile/abnormality/processing in queue)
		if(threat_level != TETH_LEVEL || threat_level != HE_LEVEL)
			continue
		if(!can_breach)
			continue
		spawnables += processing


//Meltdown
/mob/living/simple_animal/hostile/abnormality/firstfold/ZeroQliphoth(mob/living/carbon/human/user)
	..()

//This is a joke abnormality that is stupid. It is painfully designed to be as painful as possible.
/mob/living/simple_animal/hostile/abnormality/killsyou
	name = "The Thing That Kills You"
	desc = "Study groups have shown that Lobotomy Corporation fans love this abnormality."
	icon = 'ModularTegustation/Teguicons/32x32.dmi'
	icon_state = "trollface"
	maxHealth = 650
	health = 650
	threat_level = ALEPH_LEVEL
	work_chances = list(
		ABNORMALITY_WORK_INSTINCT = 60,
		ABNORMALITY_WORK_INSIGHT = 60,
		ABNORMALITY_WORK_ATTACHMENT = 60,
		ABNORMALITY_WORK_REPRESSION = 60
		)
	work_damage_amount = 10
	work_damage_type = PALE_DAMAGE
	can_spawn = FALSE //Can't be chosen

	ego_list = list(
	//No ego, sorry nothing
		)
	max_boxes = 10
	var/liked
	abnormality_origin = ABNORMALITY_ORIGIN_MEME

/mob/living/simple_animal/hostile/abnormality/killsyou/Initialize(mapload)
	. = ..()
	//What does it like
	liked = rand(1,10)

/mob/living/simple_animal/hostile/abnormality/killsyou/WorkComplete(mob/living/carbon/human/user, work_type, pe)
	..()
	var/death = FALSE
	switch(liked)
		if(1)
			var/mob/living/carbon/human/unlucky = user
			var/obj/item/ego_weapon/Y = unlucky.get_item_by_slot(ITEM_SLOT_BELT)
			if(istype(Y))
				death = TRUE
		if(2)
			var/mob/living/carbon/human/unlucky = user
			var/obj/item/ego_weapon/Y = unlucky.get_item_by_slot(ITEM_SLOT_BELT)
			if(!istype(Y))
				death = TRUE
		if(3)
			if(user.hairstyle == "Bald")
				death = TRUE

		if(4)
			if(user.hairstyle != "Bald")
				death = TRUE

		if(5)
			if(user.mind.assigned_role != "Clerk")
				death = TRUE

		if(6)
			if(world.time >= 60 MINUTES)
				death = TRUE

		if(7)
			if(world.time <= 60 MINUTES)
				death = TRUE

		if(8)
			var/cubeliked = pick(ABNORMALITY_WORK_INSTINCT, ABNORMALITY_WORK_INSIGHT, ABNORMALITY_WORK_ATTACHMENT, ABNORMALITY_WORK_REPRESSION)
			if(work_type != cubeliked)
				death = TRUE

		if(9)
			if(user.health != user.maxHealth)
				death = TRUE

		if(10)
			death = TRUE //Fuck you.

	if(death == TRUE)
		user.gib()


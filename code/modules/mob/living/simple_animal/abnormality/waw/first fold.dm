//Coded by me, Kirie Saito!
/mob/living/simple_animal/hostile/abnormality/firstfold
	name = "First Fold to Infinity"
	desc = "A man sitting behind a desk."
	icon = 'ModularTegustation/Teguicons/64x48.dmi'
	icon_state = "silence"
	threat_level = WAW_LEVEL
	work_chances = list(
		ABNORMALITY_WORK_INSTINCT = list(0, 0, 40, 50, 50),
		ABNORMALITY_WORK_INSIGHT = 0,
		ABNORMALITY_WORK_ATTACHMENT = list(0, 0, 30, 40, 40),
		ABNORMALITY_WORK_REPRESSION = list(0, 0, 50, 45, 45)
			)
	start_qliphoth = 2
	work_damage_amount = 10
	work_damage_type = WHITE_DAMAGE

	ego_list = list(
		/datum/ego_datum/weapon/eight,
		/datum/ego_datum/armor/eight,
		)
//	gift_type = /datum/ego_gifts/eight

	var/list/spawnables = list()


/mob/living/simple_animal/hostile/abnormality/silence/SuccessEffect(mob/living/carbon/human/user, work_type, pe)
	to_chat(user, "<span class='nicegreen'>The bells do not toll for thee. Not yet.</span>")
	return

/mob/living/simple_animal/hostile/abnormality/silence/Life()
	. = ..()
	if(meltdown_cooldown < world.time)
		meltdown_cooldown = world.time + meltdown_cooldown_time
		sound_to_playing_players_on_level('sound/abnormalities/silence/ambience.ogg', 50, zlevel = z)
		if(!safe)
			datum_reference.qliphoth_change(-1)
		safe = FALSE
	return

//Meltdown
/mob/living/simple_animal/hostile/abnormality/silence/ZeroQliphoth(mob/living/carbon/human/user)
	// You have mere seconds to live
	SLEEP_CHECK_DEATH(5 SECONDS)
	sound_to_playing_players_on_level('sound/abnormalities/silence/price.ogg', 50, zlevel = z)
	for(var/mob/living/carbon/human/H in GLOB.player_list)
		if(faction_check_mob(H, FALSE) || H.z != z || H.stat == DEAD)
			continue

		new /obj/effect/temp_visual/thirteen(get_turf(H))	//A visual effect if it hits
		H.apply_damage(worldwide_damage, PALE_DAMAGE, null, H.run_armor_check(null, PALE_DAMAGE), spread_damage = TRUE)
	addtimer(CALLBACK(src, .proc/Reset), reset_time)
	return

/mob/living/simple_animal/hostile/abnormality/silence/proc/Reset()
	datum_reference.qliphoth_change(1)

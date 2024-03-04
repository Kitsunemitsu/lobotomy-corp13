//Sephirah
/datum/job/command/sephirah
	title = "Sephirah"
	outfit = /datum/outfit/job/sephirah
	total_positions = 3
	spawn_positions = 3
	display_order = JOB_DISPLAY_ORDER_SEPHIRAH
	trusted_only = TRUE
	access = list(ACCESS_NETWORK, ACCESS_COMMAND, ACCESS_MANAGER) // Network is the trusted chat gamer access
	minimal_access = list(ACCESS_NETWORK, ACCESS_COMMAND, ACCESS_MANAGER)
	mapexclude = list("wonderlabs", "mini")
	job_important = "You are a roleplay role, and may not partake in combat. Assist the manager and roleplay with the agents and clerks"
	job_notice = "In the gamemaster tab, you may adjust game perimeters. \
		This is an OOC tool. Do not bring alert to the fact that you can do this IC. Alert any administrators if any IC action is taken against you. \
		Abusing this will result in a loss of whitelist."

	job_abbreviation = "SEPH"

/datum/job/command/sephirah/after_spawn(mob/living/carbon/human/H, mob/M)
	. = ..()
	//You're a fucking robot.
	ADD_TRAIT(H, TRAIT_SANITYIMMUNE, JOB_TRAIT)

	//Let'em Grief
	add_verb(H, /mob/living/carbon/human/proc/randomabno)
	add_verb(H, /mob/living/carbon/human/proc/nextabno)
	add_verb(H, /mob/living/carbon/human/proc/slowgame)
	add_verb(H, /mob/living/carbon/human/proc/quickengame)
	add_verb(H, /mob/living/carbon/human/proc/workmeltincrease)
	add_verb(H, /mob/living/carbon/human/proc/workmeltdecrease)
	add_verb(H, /mob/living/carbon/human/proc/meltincrease)
	add_verb(H, /mob/living/carbon/human/proc/meltdecrease)

	H.apply_pref_name("sephirah", M.client)
	H.name += " - [M.client.prefs.prefered_sephirah_department]"
	H.real_name += " - [M.client.prefs.prefered_sephirah_department]"
	for(var/obj/item/card/id/Y in H.contents)
		Y.registered_name = H.name
		Y.update_label()

	//You're a robot, man
	if(M.client.prefs.prefered_sephirah_bodytype == "Box")
		H.set_species(/datum/species/sephirah)
		H.dna.features["mcolor"] = sanitize_hexcolor(M.client.prefs.prefered_sephirah_boxcolor)
		H.update_body()
		H.update_body_parts()
		H.update_mutations_overlay() // no hulk lizard

	else
		H.set_species(/datum/species/synth)

	H.speech_span = SPAN_ROBOT

	//Adding huds, blame some guy from at least 3 years ago.
	var/datum/atom_hud/secsensor = GLOB.huds[DATA_HUD_SECURITY_ADVANCED]
	var/datum/atom_hud/medsensor = GLOB.huds[DATA_HUD_MEDICAL_ADVANCED]
	secsensor.add_hud_to(H)
	medsensor.add_hud_to(H)

/datum/outfit/job/sephirah
	name = "Sephirah"
	jobtype = /datum/job/command/sephirah

	belt = /obj/item/pda/security
	ears = /obj/item/radio/headset/heads/manager/alt
	uniform = /obj/item/clothing/under/rank/rnd/scientist
	backpack_contents = list()
	shoes = /obj/item/clothing/shoes/laceup
	r_pocket = /obj/item/modular_computer/tablet/preset/advanced/command
	l_pocket = /obj/item/commandprojector

GLOBAL_LIST_INIT(sephirah_names, list(
	"Job", "Lot", "Isaac", "Lazarus", "Gaius", "Abel", "Enoch", "Jescha",))




/*************************************************/
//Sephirah Gamemaster commands.

/mob/living/carbon/human/proc/randomabno()
	set name = "Randomize Current Abnormality"
	set category = "Gamemaster"
	for(var/obj/machinery/computer/abnormality_queue/Q in GLOB.lobotomy_devices)
		var/mob/living/simple_animal/hostile/abnormality/target_type = SSabnormality_queue.GetRandomPossibleAbnormality()
		if(Q.locked)
			to_chat(src, span_danger("The abnormality was already randomized."))
			return
		Q.UpdateAnomaly(target_type, "fucked it lets rolled", TRUE)
		SSabnormality_queue.AnnounceLock()
		SSabnormality_queue.ClearChoices()

		//Literally being griefed.
		SSlobotomy_corp.available_box += 500
		minor_announce("Due to a lack of resources; a random abnormality has been chosen and PE has been deposited in your account. \
				Extraction Headquarters apologizes for the inconvenience", "Extraction Alert:", TRUE)
		return

//See next abnormality
/mob/living/carbon/human/proc/nextabno()
	set name = "Next Abnormality Check"
	set category = "Gamemaster"
	//Abno stuff, so you can grief more effectively.
	var/mob/living/simple_animal/hostile/abnormality/queued_abno = SSabnormality_queue.queued_abnormality
	to_chat(src, span_notice("Current Status:"))
	to_chat(src, span_notice("Number of Abnormalities: [SSabnormality_queue.spawned_abnos]."))
	to_chat(src, span_notice("Next Abnormality: [initial(queued_abno.name)]."))

//Speed stuff
GLOBAL_VAR_INIT(Sephirahspeed, 0)

/mob/living/carbon/human/proc/slowgame()
	set name = "Abnormality Time Slow"
	set category = "Gamemaster"
	if(GLOB.Sephirahspeed > -3)
		SSabnormality_queue.next_abno_spawn_time *= 1.2
		GLOB.Sephirahspeed --
		to_chat(src, span_notice("You have now slowed down when abnormalities arrive."))
		message_admins("<span class='notice'>A sephirah ([src.ckey]) has slowed down the abnormality rate.</span>")
	else
		to_chat(src, span_notice("Abnormality extraction cannot be slower."))

/mob/living/carbon/human/proc/quickengame()
	set name = "Abnormality Time Quicken"
	set category = "Gamemaster"

	if(GLOB.Sephirahspeed < 3)
		SSabnormality_queue.next_abno_spawn_time /= 1.2
		GLOB.Sephirahspeed ++
		to_chat(src, span_notice("You have now sped up when abnormalities arrive."))
		message_admins("<span class='notice'>A sephirah ([src.ckey]) has sped up the abnormality rate.</span>")
	else
		to_chat(src, span_notice("Abnormality extraction cannot be faster."))

//Ordeal Stuff
GLOBAL_VAR_INIT(Sephirahordealspeed, 0)

/mob/living/carbon/human/proc/workmeltincrease()
	set name = "Works Per Melt Increase"
	set category = "Gamemaster"

	if(GLOB.Sephirahordealspeed > 5)
		to_chat(src, span_notice("Meltdowns are already taking too long!"))
		return

	GLOB.Sephirahordealspeed ++
	to_chat(src, span_notice("All meltdowns will take one more work."))
	message_admins("<span class='notice'>A sephirah ([src.ckey]) has made works per melt longer.</span>")


/mob/living/carbon/human/proc/workmeltdecrease()
	set name = "Works Per Melt Decrease"
	set category = "Gamemaster"

	if(GLOB.Sephirahordealspeed < -3 )
		to_chat(src, span_notice("Meltdowns are already too fast!"))
		return

	GLOB.Sephirahordealspeed --
	to_chat(src, span_notice("All meltdowns will take one less work."))
	message_admins("<span class='notice'>A sephirah ([src.ckey]) has made works per melt shorter.</span>")


GLOBAL_VAR_INIT(Sephirahmeltmodifier, 0)

/mob/living/carbon/human/proc/meltincrease()
	set name = "Abno Melts Per Event Increase"
	set category = "Gamemaster"

	if(GLOB.Sephirahmeltmodifier > 5)
		to_chat(src, span_notice("Too many abnormalities are melting!"))
		return

	GLOB.Sephirahmeltmodifier ++
	to_chat(src, span_notice("One more abnormality will melt per event."))
	message_admins("<span class='notice'>A sephirah ([src.ckey]) has made more abnormalities melt per event.</span>")


/mob/living/carbon/human/proc/meltdecrease()
	set name = "Abno Melts Per Event Decrease"
	set category = "Gamemaster"

	if(GLOB.Sephirahmeltmodifier < -1*SSlobotomy_corp.qliphoth_meltdown_amount+2)
		to_chat(src, span_notice("Too little abnormalities are melting!"))
		return

	GLOB.Sephirahmeltmodifier --
	to_chat(src, span_notice("One less abnormality will melt per event."))
	message_admins("<span class='notice'>A sephirah ([src.ckey]) has made less abnormalities melt per event.</span>")



//See next abnormality
/mob/living/carbon/human/proc/gameinfo()
	set name = "Check Game Info"
	set category = "Gamemaster"
	//So you can see what the others have done
	var/mob/living/simple_animal/hostile/abnormality/queued_abno = SSabnormality_queue.queued_abnormality
	to_chat(src, span_notice("Current Status:"))
	to_chat(src, span_notice("Sephirah Meltdown Modifier: [GLOB.Sephirahmeltmodifier]."))
	to_chat(src, span_notice("Sephirah Workmelt Modifier: [GLOB.Sephirahordealspeed]."))
	to_chat(src, span_notice("Abnormality Extraction Speed Modifier: [GLOB.Sephirahordealspeed]."))

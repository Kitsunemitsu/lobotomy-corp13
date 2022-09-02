SUBSYSTEM_DEF(abnormality_queue)
	name = "Abnormality Queue"
	flags = SS_KEEP_TIMING | SS_BACKGROUND
	wait = 5 MINUTES

	/// List of(preferably) 3 abnormalities available for manager to choose from.
	var/list/picking_abnormalities = list()
	/// The abnormality that will spawn on the next fire.
	var/mob/living/simple_animal/hostile/abnormality/queued_abnormality
	/// The subsystem will pick abnormalities of these threat levels.
	var/list/available_levels = list(ZAYIN_LEVEL, TETH_LEVEL)
	/// An associative list of potential abnormalities.
	var/list/possible_abnormalities = list(ZAYIN_LEVEL = list(), TETH_LEVEL = list(), HE_LEVEL = list(), WAW_LEVEL = list(), ALEPH_LEVEL = list())
	/// Amount of abnormality room spawners at the round-start.
	var/rooms_start = 0
	/// Amount of times postspawn() proc has been called. Kept separate from spawned_abnos because admins love to call fire() manually
	var/spawned_abnos = 0

/datum/controller/subsystem/abnormality_queue/Initialize(timeofday)
	var/list/all_abnos = subtypesof(/mob/living/simple_animal/hostile/abnormality)
	for(var/i in all_abnos)
		var/mob/living/simple_animal/hostile/abnormality/abno = i
		if(initial(abno.can_spawn))
			possible_abnormalities[initial(abno.threat_level)] += abno
	if(LAZYLEN(possible_abnormalities))
		pick_abno()
	addtimer(CALLBACK(src, .proc/HandleStartingAbnormalities), 180 SECONDS)
	rooms_start = GLOB.abnormality_room_spawners.len
	wait -= min(30, rooms_start * 0.05) MINUTES // 20 rooms will decrease wait time by 1 minute
	wait -= min(30, GLOB.clients.len * 0.05) MINUTES // 20 players will ALSO decrease wait time by 1 minute
	..()

/datum/controller/subsystem/abnormality_queue/fire()
	// HE enabled, ZAYIN disabled
	if(spawned_abnos > rooms_start * 0.2)
		if(ZAYIN_LEVEL in available_levels)
			available_levels -= ZAYIN_LEVEL
		if(!(HE_LEVEL in available_levels) && spawned_abnos <= rooms_start * 0.75)
			available_levels += HE_LEVEL
	// WAW enabled, TETH disabled
	if(spawned_abnos > rooms_start * 0.4)
		if(TETH_LEVEL in available_levels)
			available_levels -= TETH_LEVEL
		if(!(WAW_LEVEL in available_levels))
			available_levels += WAW_LEVEL
	// ALEPH enabled
	if(spawned_abnos > rooms_start * 0.6)
		if(!(ALEPH_LEVEL in available_levels))
			available_levels += ALEPH_LEVEL

	// HE getting disabled conditionally
	if(spawned_abnos > rooms_start * 0.75)
		if(LAZYLEN(possible_abnormalities[WAW_LEVEL]) || LAZYLEN(possible_abnormalities[ALEPH_LEVEL])) // HE abnos are gone if there are WAW and ALEPHs
			available_levels -= HE_LEVEL
		else // Otherwise, if we run out of ALEPHs and WAWs, HEs are back on the menu
			available_levels |= HE_LEVEL

	if(!ispath(queued_abnormality) && LAZYLEN(possible_abnormalities))
		pick_abno()

	if(!LAZYLEN(GLOB.abnormality_room_spawners))
		return

	var/obj/effect/spawner/abnormality_room/choice = pick(GLOB.abnormality_room_spawners)
	if(istype(choice) && ispath(queued_abnormality))
		addtimer(CALLBACK(choice, .obj/effect/spawner/abnormality_room/proc/SpawnRoom))

/datum/controller/subsystem/abnormality_queue/proc/postspawn()
	if(queued_abnormality)
		possible_abnormalities[initial(queued_abnormality.threat_level)] -= queued_abnormality
		for(var/obj/machinery/computer/abnormality_queue/Q in GLOB.abnormality_queue_consoles)
			Q.audible_message("<span class='notice'>[initial(queued_abnormality.name)] has arrived at the facility!</span>")
			playsound(get_turf(Q), 'sound/machines/dun_don_alert.ogg', 50, TRUE)
			Q.updateUsrDialog()
		queued_abnormality = null
		spawned_abnos++
		pick_abno()

/datum/controller/subsystem/abnormality_queue/proc/pick_abno()
	var/list/picking_abno = list()
	picking_abnormalities = list()
	for(var/lev in available_levels)
		if(!LAZYLEN(possible_abnormalities[lev]))
			continue
		picking_abno |= possible_abnormalities[lev]
	for(var/i = 1 to 3)
		if(!LAZYLEN(picking_abno))
			break
		var/chosen_abno = pick(picking_abno)
		picking_abnormalities += chosen_abno
		picking_abno -= chosen_abno
	if(!LAZYLEN(picking_abnormalities))
		return
	queued_abnormality = pick(picking_abnormalities)

/datum/controller/subsystem/abnormality_queue/proc/HandleStartingAbnormalities()
	var/player_count = GLOB.clients.len
	if(player_count < 6)
		return
	var/i
	for(i=1 to round(player_count / 6))
		fire()
		sleep(10 SECONDS) // Allows manager to select abnormalities if he is fast enough.
	message_admins("[i] round-start abnormalities have been spawned.")
	return

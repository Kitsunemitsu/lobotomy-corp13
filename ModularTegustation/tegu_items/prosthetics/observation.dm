/obj/item/bodypart/head/robot/observation
	name = "observation braincasing"
	desc = "A braincase that's full of cameras. Looks very delicate."
	icon = 'ModularTegustation/tegu_items/prosthetics/icons/observation_head.dmi'
	brute_reduction = -8	//Take more damage, robotic fuck

/obj/item/bodypart/head/robot/observation/on_limb_gain()
	..()
	var/datum/atom_hud/medsensor = GLOB.huds[DATA_HUD_MEDICAL_ADVANCED]
	medsensor.add_hud_to(owner)

/obj/item/bodypart/head/robot/observation/on_dismember()
	..()
	var/datum/atom_hud/medsensor = GLOB.huds[DATA_HUD_MEDICAL_ADVANCED]
	medsensor.remove_hud_from(owner)


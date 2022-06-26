/obj/item/gun/ego_gun
	name = "ego gun"
	desc = "Some sort of weapon..?"
	icon = 'icons/obj/ego_weapons.dmi'
	lefthand_file = 'icons/mob/inhands/weapons/ego_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/ego_righthand.dmi'
	fire_sound = 'sound/weapons/emitter.ogg'
	w_class = WEIGHT_CLASS_NORMAL
	trigger_guard = TRIGGER_GUARD_ALLOW_ALL
	pin = /obj/item/firing_pin/magic
	var/ammo_type
	var/list/attribute_requirements = list(
							FORTITUDE_ATTRIBUTE = 0,
							PRUDENCE_ATTRIBUTE = 0,
							TEMPERANCE_ATTRIBUTE = 0,
							JUSTICE_ATTRIBUTE = 0
							)

/obj/item/gun/ego_gun/Initialize()
	. = ..()
	chambered = new ammo_type(src)

/obj/item/gun/ego_gun/mob_can_equip(mob/living/M, mob/living/equipper, slot, disable_warning = FALSE, bypass_equip_delay_self = FALSE)
	if(!ishuman(M))
		return FALSE
	var/mob/living/carbon/human/H = M
	for(var/atr in attribute_requirements)
		if(attribute_requirements[atr] > get_attribute_level(H, atr))
			to_chat(H, "<span class='notice'>You cannot equip [src]!</span>")
			return FALSE
	if(!special_ego_check(H))
		return FALSE
	return ..()

/obj/item/gun/ego_gun/proc/special_ego_check(mob/living/carbon/human/H)
	return TRUE

/obj/item/gun/ego_gun/can_shoot()
	return TRUE

/obj/item/gun/ego_gun/process_chamber()
	if(chambered && !chambered.BB)
		recharge_newshot()

/obj/item/gun/ego_gun/recharge_newshot()
	if(chambered && !chambered.BB)
		chambered.newshot()

/obj/item/organ/cyberimp/arm/grappler
	name = "Chaingrab implants"
	desc = "An implant with a long range that can grab targets from afar."
	contents = newlist(/obj/item/ego_weapon/city/grappler)
	syndicate_implant = TRUE

/obj/item/organ/cyberimp/arm/grappler/l
	zone = BODY_ZONE_L_ARM

/obj/item/ego_weapon/city/grappler
	name = "ranged grappler"
	desc = "A pair of prongs on a chain. Used to grab enemies and pull them towards you."
	icon = 'ModularTegustation/tegu_items/prosthetics/icons/generic.dmi'
	icon_state = "chaingrab"
	hitsound = 'sound/weapons/bladeslice.ogg'
	force = 7
	reach = 4		//Grab from afar
	stuntime = 5	//Stuns you in exchange.
	attack_speed = 1.2
	damtype = RED_DAMAGE
	w_class = WEIGHT_CLASS_NORMAL
	attack_verb_continuous = list("attacks", "slashes", "stabs", "slices", "tears", "lacerates", "rips", "dices", "cuts")
	attack_verb_simple = list("attack", "slash", "stab", "slice", "tear", "lacerate", "rip", "dice", "cut")


/obj/item/ego_weapon/city/grappler/equipped(mob/user, slot, initial)
	. = ..()
	if(slot != ITEM_SLOT_HANDS)
		return
	var/side = user.get_held_index_of_item(src)

	if(side == LEFT_HANDS)
		transform = null
	else
		transform = matrix(-1, 0, 0, 0, 1, 0)
	//little bit of stam loss
	var/mob/living/carbon/human/H = user
	H.adjustStaminaLoss(H.maxHealth*0.5, TRUE, TRUE)

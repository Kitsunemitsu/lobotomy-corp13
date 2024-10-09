/obj/item/organ/cyberimp/arm/mantis
	name = "Mantis blade implants"
	desc = "Mantis blades designed by some sicko in district."
	contents = newlist(/obj/item/mantis/blade)
	syndicate_implant = TRUE

/obj/item/organ/cyberimp/arm/mantis/l
	zone = BODY_ZONE_L_ARM
	syndicate_implant = TRUE

/obj/item/mantis/blade
	name = "mantis blade"
	desc = "A blade designed to be hidden just beneath the skin. The brain is directly linked to this bad boy, allowing it to spring into action. Deals damage when equipped."
	icon = 'ModularTegustation/tegu_items/prosthetics/icons/generic.dmi'
	icon_state = "mantis"
	hitsound = 'sound/weapons/bladeslice.ogg'
	flags_1 = CONDUCT_1
	force = 30
	damtype = RED_DAMAGE
	w_class = WEIGHT_CLASS_NORMAL
	attack_verb_continuous = list("attacks", "slashes", "stabs", "slices", "tears", "lacerates", "rips", "dices", "cuts")
	attack_verb_simple = list("attack", "slash", "stab", "slice", "tear", "lacerate", "rip", "dice", "cut")


/obj/item/mantis/blade/equipped(mob/user, slot, initial)
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


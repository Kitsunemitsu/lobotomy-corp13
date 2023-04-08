/obj/item/ego_weapon/city/kcorp
	name = "K corp baton"
	desc = "A green baton used by K corp employees."
	icon_state = "kbatong"
	inhand_icon_state = "kbatong"
	force = 22
	damtype = RED_DAMAGE
	armortype = RED_DAMAGE
	attack_verb_continuous = list("bashes", "crushes")
	attack_verb_simple = list("bash", "crush")

//High level Kcorp weapons are grade 5
/obj/item/ego_weapon/city/kcorp/spear
	name = "K corp spear"
	desc = "A green spear used by K corp Code 3 employees."
	icon_state = "kspear"
	inhand_icon_state = "kspear"
	force = 44
	reach = 2
	damtype = RED_DAMAGE
	armortype = RED_DAMAGE
	attack_verb_continuous = list("whacks", "slashes")
	attack_verb_simple = list("whack", "slash")
	attribute_requirements = list(
							FORTITUDE_ATTRIBUTE = 60,
							PRUDENCE_ATTRIBUTE = 60,
							TEMPERANCE_ATTRIBUTE = 60,
							JUSTICE_ATTRIBUTE = 80
							)

//Slows you to half but has really good defenses. This is Kcorp Bread and butter, because it's really good
/obj/item/ego_weapon/shield/kcorp
	name = "K corp riot shield"
	desc = "A riot shield used by K corp employees."
	special = "Slows down the user significantly."
	icon = 'ModularTegustation/Teguicons/lc13_weapons.dmi'
	icon_state = "kshield"
	inhand_icon_state = "flashshield"
	lefthand_file = 'icons/mob/inhands/equipment/shields_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/shields_righthand.dmi'
	force = 15
	slowdown = 0.5
	damtype = RED_DAMAGE
	armortype = RED_DAMAGE
	attack_verb_continuous = list("shoves", "bashes")
	attack_verb_simple = list("shove", "bash")
	hitsound = 'sound/weapons/genhit2.ogg'
	reductions = list(60, 60, 60, 20)
	recovery_time = 5 SECONDS
	block_time = 2 SECONDS
	block_recovery = 2 SECONDS
	item_flags = SLOWS_WHILE_IN_HAND


// Guns below
/obj/item/gun/ego_gun/pistol/kcorp
	name = "Kcorp pistol"
	desc = "A lime green pistol used by Kcorp."
	icon_state = "kpistol"
	icon = 'ModularTegustation/Teguicons/lc13_weapons.dmi'
	inhand_icon_state = "gun"
	worn_icon_state = "gun"
	lefthand_file = 'icons/mob/inhands/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/guns_righthand.dmi'
	projectile_damage_multiplier = 10
	ammo_type = /obj/item/ammo_casing/caseless/ego_red
	fire_delay = 5
	fire_sound = 'sound/weapons/gun/pistol/shot.ogg'
	vary_fire_sound = FALSE
	fire_sound_volume = 70

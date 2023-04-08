/obj/structure/lootcrate
	name = "Crate"
	desc = "A crate recieved from a company"
	icon = 'ModularTegustation/Teguicons/refiner.dmi'
	icon_state = "crate_lcb"
	anchored = FALSE
	density = TRUE
	resistance_flags = INDESTRUCTIBLE
	var/lootlist =	list(
		/obj/item/toy/plush/blank,
		/obj/item/toy/plush/yisang,
		/obj/item/toy/plush/faust,
		/obj/item/toy/plush/don,
		/obj/item/toy/plush/ryoshu,
		/obj/item/toy/plush/meursault,
		/obj/item/toy/plush/honglu,
		/obj/item/toy/plush/heathcliff,
		/obj/item/toy/plush/ishmael,
		/obj/item/toy/plush/rodion,
		/obj/item/toy/plush/sinclair,
		/obj/item/toy/plush/outis,
		/obj/item/toy/plush/gregor,
		/obj/item/toy/plush/yuri)

	var/rareloot =	list(/obj/item/toy/plush/dante,)
	var/veryrareloot =	list()	//Only Kcorp uses these atm, because It's important that they have 3 tiers of weapons
	var/rarechance = 20
	var/veryrarechance


/obj/structure/lootcrate/attackby(obj/item/I, mob/living/user, params)
	..()
	var/loot
	if(I.tool_behaviour != TOOL_CROWBAR)
		return
	if(veryrarechance && prob(veryrarechance))
		loot = pick(veryrareloot)

	else if(prob(rarechance))
		loot = pick(rareloot)

	else
		loot = pick(lootlist)

	to_chat(user, "<span class='notice'>You open the crate!</span>")
	new loot(get_turf(src))
	qdel(src)


//Limbus Company
/obj/structure/lootcrate/limbus
	name = "Limbus Company Crate"
	desc = "A crate recieved from limbus company. Open with a Crowbar."
	icon_state = "crate_lcb"
	rarechance = 10
	lootlist =	list(
		/obj/item/ego_weapon/mini/hayong,
		/obj/item/ego_weapon/shield/walpurgisnacht,
		/obj/item/ego_weapon/lance/suenoimpossible,
		/obj/item/ego_weapon/shield/sangria,
		/obj/item/ego_weapon/mini/soleil,
		/obj/item/ego_weapon/taixuhuanjing,
		/obj/item/ego_weapon/revenge,
		/obj/item/ego_weapon/shield/hearse,
		/obj/item/ego_weapon/mini/hearse,
		/obj/item/ego_weapon/raskolot,
		/obj/item/ego_weapon/vogel,
		/obj/item/ego_weapon/nobody,
		/obj/item/ego_weapon/ungezifer,
		/obj/item/clothing/suit/armor/ego_gear/limbus/limbus_coat,
		/obj/item/clothing/suit/armor/ego_gear/limbus/limbus_coat_short,
		/obj/item/clothing/under/limbus/shirt,
		/obj/item/clothing/accessory/limbusvest,
		/obj/item/clothing/under/limbus/prison,
		/obj/item/clothing/neck/limbus_tie)

	rareloot =	list(/obj/item/clothing/suit/armor/ego_gear/limbus/durante,
		/obj/item/ego_weapon/lance/sangre)


//K Corporation
/obj/structure/lootcrate/k_corp
	name = "K Corp Crate"
	desc = "A crate recieved from K-Corp. Open with a Crowbar."
	icon_state = "crate_kcorp"
	rarechance = 30
	veryrarechance = 5
	lootlist =	list(
		/obj/item/managerbullet)

	rareloot =	list(
		/obj/item/ego_weapon/city/kcorp,
		/obj/item/ego_weapon/shield/kcorp)

	veryrareloot =	list(/obj/item/clothing/under/rank/k_corporation/intern)


//R Corporation
/obj/structure/lootcrate/r_corp
	name = "R Corp Crate"
	desc = "A crate recieved from R-Corp. Open with a Crowbar."
	icon_state = "crate_rcorp"
	lootlist =	list(
		/obj/item/clothing/under/suit/lobotomy/rabbit,
		/obj/item/powered_gadget/detector_gadget/ordeal,
		/obj/item/toy/plush/myo,
		/obj/item/toy/plush/rabbit,
		/obj/item/clothing/suit/space/hardsuit/rabbit,
		/obj/item/clothing/suit/space/hardsuit/rabbit/leader
		)

	rareloot =	list(
		/obj/item/ego_weapon/rabbit_blade)


//S Corporation
/obj/structure/lootcrate/s_corp
	name = "S Corp Crate"
	desc = "A crate recieved from the mysterious S-Corp. Open with a Crowbar."
	icon_state = "crate_shrimp"
	lootlist =	list(
		/obj/item/reagent_containers/food/drinks/soda_cans/wellcheers_red,
		/obj/item/reagent_containers/food/drinks/soda_cans/wellcheers_white,
		/obj/item/reagent_containers/food/drinks/soda_cans/wellcheers_purple,
		/obj/item/gun/ego_gun/shrimp/shotty,
		/obj/item/gun/ego_gun/shrimp,
		/obj/item/gun/ego_gun/shrimp/smg
		)

	rareloot =	list(
		/mob/living/simple_animal/hostile/shrimp,
		/obj/item/grenade/spawnergrenade/shrimp,
		/obj/item/gun/ego_gun/shrimp/minigun)


//W Corporation
/obj/structure/lootcrate/w_corp
	name = "W Corp Crate"
	desc = "A crate recieved from W-Corp. Open with a Crowbar."
	icon_state = "crate_wcorp"
	lootlist =	list(
		/obj/item/ego_weapon/city/wcorp,
		/obj/item/clothing/head/wcorp,
		/obj/item/clothing/under/suit/lobotomy/wcorp,
		/obj/item/clothing/suit/armor/ego_gear/wcorp,
		/obj/item/powered_gadget/teleporter)

	rareloot =	list(/obj/item/ego_weapon/city/wcorp/fist,
		/obj/item/ego_weapon/city/wcorp/axe,
		/obj/item/ego_weapon/city/wcorp/spear,
		/obj/item/ego_weapon/city/wcorp/dagger,
		)


//N Corporation
/obj/structure/lootcrate/n_corp
	name = "N Corp Crate"
	desc = "A crate recieved from N-Corp. Open with a Crowbar."
	icon_state = "crate_ncorp"
	veryrarechance = 5
	lootlist =	list(
		/obj/item/ego_weapon/city/ncorp_mark,
		/obj/item/ego_weapon/city/ncorp_mark/white,
		/obj/item/ego_weapon/city/ncorp_mark/black,
		/obj/item/ego_weapon/city/ncorp_nail,
		/obj/item/ego_weapon/city/ncorp_hammer
		)

	rareloot =	list(
		/obj/item/ego_weapon/city/ncorp_mark/pale,
		/obj/item/ego_weapon/city/ncorp_nail/big,

		/obj/item/ego_weapon/city/ncorp_hammer/big

		)

	veryrareloot =	list(
		/obj/item/ego_weapon/city/ncorp_hammer/grippy,
		/obj/item/ego_weapon/city/ncorp_nail/huge)


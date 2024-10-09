
//Mechandrites for the Mechanicus

/obj/item/extra_arm
	name = "\improper Extra Arm Prosthetics"
	desc = "An implanter for mechandrites, allowing a follower of the Omnissiah to gain newly found dexterity and handiness"
	icon = 'icons/obj/device.dmi'
	icon_state = "autoimplanter"
	var/uses = 1

/obj/item/extra_arm/attack_self(mob/user)
	if(!uses)
		to_chat(user, "<span class='alert'>[src] has already been used. The tools are dull and won't reactivate.</span>")
		return
	var/limbs = user.held_items.len
	user.change_number_of_hands(limbs+1)
	user.visible_message("<span class='notice'>[user] presses a button on [src], and you hear a short mechanical noise.</span>", "<span class='notice'>You feel a sharp sting as [src] plunges into your body.</span>")
	to_chat(user, "Your mechandrites whirr with life")
	playsound(get_turf(user), 'sound/weapons/circsawhit.ogg', 50, TRUE)
	if(uses == 1)
		uses--
	if(!uses)
		desc = "[initial(desc)] Looks like it's been used up."

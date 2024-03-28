#define BREADIFY_TIME (5 SECONDS)

/// Turns the target into bread (Bongbread if they are Bong Bong)
/datum/smite/bread
	name = "Bread"

/datum/smite/bread/effect(client/user, mob/living/target)
	. = ..()
	var/mutable_appearance/bread_appearance
	if(target.name == "Bong Bong")
		bread_appearance = mutable_appearance('icons/obj/food/burgerbread.dmi', "bongbread")
	else
		bread_appearance = mutable_appearance('icons/obj/food/burgerbread.dmi', "bread")
	var/mutable_appearance/transform_scanline = mutable_appearance('icons/effects/effects.dmi', "transform_effect")
	target.transformation_animation(bread_appearance,time = BREADIFY_TIME, transform_overlay=transform_scanline, reset_after=TRUE)
	addtimer(CALLBACK(GLOBAL_PROC, GLOBAL_PROC_REF(breadify), target), BREADIFY_TIME)

#undef BREADIFY_TIME

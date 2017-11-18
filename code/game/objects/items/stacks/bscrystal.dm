//Bluespace crystals, used in telescience and when crushed it will blink you to a random turf.

//Polycrystals, aka stacks
/obj/item/stack/sheet/bluespace_crystal
	name = "bluespace polycrystal"
	icon = 'icons/obj/telescience.dmi'
	icon_state = "polycrystal"
	desc = "A stable polycrystal, made of fused-together bluespace crystals. You could probably break one off."
	origin_tech = "bluespace=6;materials=3"
	materials = list(MAT_BLUESPACE=MINERAL_MATERIAL_AMOUNT)
	attack_verb = list("bluespace polybashed", "bluespace polybattered", "bluespace polybludgeoned", "bluespace polythrashed", "bluespace polysmashed")
	novariants = TRUE

/obj/item/stack/sheet/bluespace_crystal/attack_self(mob/user)// to prevent the construction menu from ever happening
	to_chat(user, "<span class='warning'>You cannot crush the polycrystal in-hand, try breaking one off.</span>")
//Cloaks. No, not THAT kind of cloak.

/obj/item/clothing/neck/cloak
	name = "brown cloak"
	desc = "It's a cape that can be worn around your neck."
	icon = 'icons/obj/clothing/cloaks.dmi'
	icon_state = "qmcloak"
	item_state = "qmcloak"
	w_class = WEIGHT_CLASS_SMALL
	body_parts_covered = CHEST|GROIN|LEGS|ARMS

/obj/item/clothing/head/cloakhood
	name = "cloak hood"
	icon = 'icons/obj/clothing/hats.dmi'
	icon_state = "golhood"
	desc = "A hood for a cloak."
	body_parts_covered = HEAD
	flags_1 = NODROP_1
	flags_inv = HIDEHAIR|HIDEEARS

/obj/item/clothing/neck/cloak/suicide_act(mob/user)
	user.visible_message("<span class='suicide'>[user] is strangling [user.p_them()]self with [src]! It looks like [user.p_theyre()] trying to commit suicide!</span>")
	return(OXYLOSS)

/obj/item/clothing/neck/cloak/hos
	name = "head of security's cloak"
	desc = "Worn by Securistan, ruling the station with an iron fist."
	icon_state = "hoscloak"

/obj/item/clothing/neck/cloak/qm
	name = "quartermaster's cloak"
	desc = "Worn by Cargonia, supplying the station with the necessary tools for survival."

/obj/item/clothing/neck/cloak/cmo
	name = "chief medical officer's cloak"
	desc = "Worn by Meditopia, the valiant men and women keeping pestilence at bay."
	icon_state = "cmocloak"

/obj/item/clothing/neck/cloak/ce
	name = "chief engineer's cloak"
	desc = "Worn by Engitopia, wielders of an unlimited power."
	icon_state = "cecloak"

/obj/item/clothing/neck/cloak/rd
	name = "research director's cloak"
	desc = "Worn by Sciencia, thaumaturges and researchers of the universe."
	icon_state = "rdcloak"

/obj/item/clothing/neck/cloak/cap
	name = "captain's cloak"
	desc = "Worn by the commander of Space Station 13."
	icon_state = "capcloak"

/obj/item/clothing/neck/cloak/hop
	name = "head of personnel's cloak"
	desc = "Worn by the Head of Personnel. It smells faintly of bureaucracy."
	icon_state = "hopcloak"
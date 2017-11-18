/**********************Mining Scanners**********************/
/obj/item/device/mining_scanner
	desc = "A scanner that checks surrounding rock for useful minerals; it can also be used to stop gibtonite detonations."
	name = "manual mining scanner"
	icon_state = "mining1"
	item_state = "analyzer"
	lefthand_file = 'icons/mob/inhands/equipment/tools_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/tools_righthand.dmi'
	w_class = WEIGHT_CLASS_SMALL
	flags_1 = CONDUCT_1
	slot_flags = SLOT_BELT
	var/cooldown = 35
	var/current_cooldown = 0
	origin_tech = "engineering=1;magnets=1"

/obj/item/device/mining_scanner/attack_self(mob/user)
	if(!user.client)
		return
	if(current_cooldown <= world.time)
		current_cooldown = world.time + cooldown

//Debug item to identify all ore spread quickly
/obj/item/device/t_scanner/adv_mining_scanner
	desc = "A scanner that automatically checks surrounding rock for useful minerals; it can also be used to stop gibtonite detonations. This one has an extended range."
	name = "advanced automatic mining scanner"
	icon_state = "mining0"
	item_state = "analyzer"
	lefthand_file = 'icons/mob/inhands/equipment/tools_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/tools_righthand.dmi'
	w_class = WEIGHT_CLASS_SMALL
	flags_1 = CONDUCT_1
	slot_flags = SLOT_BELT
	var/cooldown = 35
	var/current_cooldown = 0
	var/range = 7
	origin_tech = "engineering=3;magnets=3"

/obj/item/device/t_scanner/adv_mining_scanner/lesser
	name = "automatic mining scanner"
	desc = "A scanner that automatically checks surrounding rock for useful minerals; it can also be used to stop gibtonite detonations."
	range = 4
	cooldown = 50

/obj/item/device/t_scanner/adv_mining_scanner/scan()
	if(current_cooldown <= world.time)
		current_cooldown = world.time + cooldown

/obj/effect/temp_visual/mining_overlay
	plane = FULLSCREEN_PLANE
	layer = FLASH_LAYER
	icon = 'icons/effects/ore_visuals.dmi'
	appearance_flags = 0 //to avoid having TILE_BOUND in the flags, so that the 480x480 icon states let you see it no matter where you are
	duration = 35
	pixel_x = -224
	pixel_y = -224

/obj/effect/temp_visual/mining_overlay/Initialize()
	. = ..()
	animate(src, alpha = 0, time = duration, easing = EASE_IN)

/obj/effect/fun_balloon
	name = "fun balloon"
	desc = "This is going to be a laugh riot."
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "syndballoon"
	anchored = TRUE
	var/popped = FALSE

/obj/effect/fun_balloon/New()
	. = ..()
	SSobj.processing |= src

/obj/effect/fun_balloon/Destroy()
	SSobj.processing -= src
	. = ..()

/obj/effect/fun_balloon/process()
	if(!popped && check() && !QDELETED(src))
		popped = TRUE
		effect()
		pop()

/obj/effect/fun_balloon/proc/check()
	return FALSE

/obj/effect/fun_balloon/proc/effect()
	return

/obj/effect/fun_balloon/proc/pop()
	visible_message("[src] pops!")
	playsound(get_turf(src), 'sound/items/party_horn.ogg', 50, 1, -1)
	qdel(src)

/obj/effect/fun_balloon/attack_ghost(mob/user)
	if(!user.client || !user.client.holder || popped)
		return
	switch(alert("Pop [src]?","Fun Balloon","Yes","No"))
		if("Yes")
			effect()
			pop()

/obj/effect/fun_balloon/sentience
	name = "sentience fun balloon"
	desc = "When this pops, things are gonna get more aware around here."
	var/effect_range = 3
	var/group_name = "a bunch of giant spiders"

/obj/effect/fun_balloon/sentience/effect()
	var/list/bodies = list()
	for(var/mob/living/M in range(effect_range, get_turf(src)))
		bodies += M

	var/question = "Would you like to be [group_name]?"
	var/list/candidates = pollCandidatesForMobs(question, "pAI", null, FALSE, 100, bodies)
	while(candidates.len && bodies.len)
		var/mob/dead/observer/ghost = pick_n_take(candidates)
		var/mob/living/body = pick_n_take(bodies)

		to_chat(body, "Your mob has been taken over by a ghost!")
		message_admins("[key_name_admin(ghost)] has taken control of ([key_name_admin(body)])")
		body.ghostize(0)
		body.key = ghost.key
		new /obj/effect/temp_visual/gravpush(get_turf(body))

/obj/effect/fun_balloon/scatter
	name = "scatter fun balloon"
	desc = "When this pops, you're not going to be around here anymore."
	var/effect_range = 5

/obj/effect/fun_balloon/scatter/effect()
	for(var/mob/living/M in range(effect_range, get_turf(src)))
		var/turf/T = find_safe_turf()
		new /obj/effect/temp_visual/gravpush(get_turf(M))
		M.forceMove(T)
		to_chat(M, "<span class='notice'>Pop!</span>")

/obj/effect/station_crash
	name = "station crash"
	desc = "With no survivors!"
	icon = 'icons/obj/items_and_weapons.dmi'
	icon_state = "syndballoon"
	anchored = TRUE

/obj/effect/station_crash/New()
	qdel(src)
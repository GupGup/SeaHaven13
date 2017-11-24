/obj/item/antag_spawner
	throw_speed = 1
	throw_range = 5
	w_class = WEIGHT_CLASS_TINY
	var/used = 0

/obj/item/antag_spawner/proc/spawn_antag(client/C, turf/T, type = "")
	return

/obj/item/antag_spawner/proc/equip_antag(mob/target)
	return


///////////WIZARD

/obj/item/antag_spawner/contract
	name = "contract"
	desc = "A magic contract previously signed by an apprentice. In exchange for instruction in the magical arts, they are bound to answer your call for aid."
	icon = 'icons/obj/wizard.dmi'
	icon_state ="scroll2"

/obj/item/antag_spawner/contract/attack_self(mob/user)
	user.set_machine(src)
	var/dat
	if(used)
		dat = "<B>You have already summoned your apprentice.</B><BR>"
	else
		dat = "<B>Contract of Apprenticeship:</B><BR>"
		dat += "<I>Using this contract, you may summon an apprentice to aid you on your mission.</I><BR>"
		dat += "<I>If you are unable to establish contact with your apprentice, you can feed the contract back to the spellbook to refund your points.</I><BR>"
		dat += "<B>Which school of magic is your apprentice studying?:</B><BR>"
		dat += "<A href='byond://?src=[REF(src)];school=[APPRENTICE_DESTRUCTION]'>Destruction</A><BR>"
		dat += "<I>Your apprentice is skilled in offensive magic. They know Magic Missile and Fireball.</I><BR>"
		dat += "<A href='byond://?src=[REF(src)];school=[APPRENTICE_BLUESPACE]'>Bluespace Manipulation</A><BR>"
		dat += "<I>Your apprentice is able to defy physics, melting through solid objects and travelling great distances in the blink of an eye. They know Teleport and Ethereal Jaunt.</I><BR>"
		dat += "<A href='byond://?src=[REF(src)];school=[APPRENTICE_HEALING]'>Healing</A><BR>"
		dat += "<I>Your apprentice is training to cast spells that will aid your survival. They know Forcewall and Charge and come with a Staff of Healing.</I><BR>"
		dat += "<A href='byond://?src=[REF(src)];school=[APPRENTICE_ROBELESS]'>Robeless</A><BR>"
		dat += "<I>Your apprentice is training to cast spells without their robes. They know Knock and Mindswap.</I><BR>"
	user << browse(dat, "window=radio")
	onclose(user, "radio")
	return

/obj/item/antag_spawner/contract/Topic(href, href_list)
	..()
	var/mob/living/carbon/human/H = usr

	if(H.stat || H.restrained())
		return
	if(!ishuman(H))
		return 1

	if(loc == H || (in_range(src, H) && isturf(loc)))
		H.set_machine(src)
		if(href_list["school"])
			if(used)
				to_chat(H, "You already used this contract!")
				return
			var/list/candidates = pollCandidatesForMob("Do you want to play as a wizard's [href_list["school"]] apprentice?", ROLE_WIZARD, null, ROLE_WIZARD, 150, src)
			if(candidates.len)
				if(used)
					to_chat(H, "You already used this contract!")
					return
				used = 1
				var/mob/dead/observer/theghost = pick(candidates)
				spawn_antag(theghost.client, get_turf(src), href_list["school"],H.mind)
			else
				to_chat(H, "Unable to reach your apprentice! You can either attack the spellbook with the contract to refund your points, or wait and try again later.")

/obj/item/antag_spawner/contract/spawn_antag(client/C, turf/T, school,datum/mind/user)
	new /obj/effect/particle_effect/smoke(T)
	var/mob/living/carbon/human/M = new/mob/living/carbon/human(T)
	C.prefs.copy_to(M)
	M.key = C.key
	var/datum/mind/app_mind = M.mind



	var/datum/antagonist/wizard/apprentice/app = new(app_mind)
	app.master = user
	app.school = school

	var/datum/antagonist/wizard/master_wizard = user.has_antag_datum(/datum/antagonist/wizard)
	if(master_wizard)
		if(!master_wizard.wiz_team)
			master_wizard.create_wiz_team()
		app.wiz_team = master_wizard.wiz_team
		master_wizard.wiz_team.add_member(app_mind)
	app_mind.add_antag_datum(app)
	//TODO Kill these if possible
	app_mind.assigned_role = "Apprentice"
	app_mind.special_role = "apprentice"
	//
	SEND_SOUND(M, sound('sound/effects/magic.ogg'))

///////////BORGS AND OPERATIVES


/obj/item/antag_spawner/nuke_ops
	name = "syndicate operative teleporter"
	desc = "A single-use teleporter designed to quickly reinforce operatives in the field."
	icon = 'icons/obj/device.dmi'
	icon_state = "locator"
	var/borg_to_spawn

/obj/item/antag_spawner/nuke_ops/proc/check_usability(mob/user)
	if(used)
		to_chat(user, "<span class='warning'>[src] is out of power!</span>")
		return FALSE
	if(!(user.mind in SSticker.mode.syndicates))
		to_chat(user, "<span class='danger'>AUTHENTICATION FAILURE. ACCESS DENIED.</span>")
		return FALSE
	if(user.z != ZLEVEL_CENTCOM)
		to_chat(user, "<span class='warning'>[src] is out of range! It can only be used at your base!</span>")
		return FALSE
	return TRUE


/obj/item/antag_spawner/nuke_ops/attack_self(mob/user)
	if(!(check_usability(user)))
		return

	to_chat(user, "<span class='notice'>You activate [src] and wait for confirmation.</span>")
	var/list/nuke_candidates = pollGhostCandidates("Do you want to play as a syndicate [borg_to_spawn ? "[lowertext(borg_to_spawn)] cyborg":"operative"]?", ROLE_OPERATIVE, null, ROLE_OPERATIVE, 150, POLL_IGNORE_SYNDICATE)
	if(nuke_candidates.len)
		if(!(check_usability(user)))
			return
		used = TRUE
		var/mob/dead/observer/theghost = pick(nuke_candidates)
		spawn_antag(theghost.client, get_turf(src), "syndieborg")
		do_sparks(4, TRUE, src)
		qdel(src)
	else
		to_chat(user, "<span class='warning'>Unable to connect to Syndicate command. Please wait and try again later or use the teleporter on your uplink to get your points refunded.</span>")

/obj/item/antag_spawner/nuke_ops/spawn_antag(client/C, turf/T)
	var/mob/living/carbon/human/M = new/mob/living/carbon/human(T)
	C.prefs.copy_to(M)
	M.key = C.key
	var/code = "BOMB-NOT-FOUND"
	var/obj/machinery/nuclearbomb/nuke = locate("syndienuke") in GLOB.nuke_list
	if(nuke)
		code = nuke.r_code
	M.mind.make_Nuke(null, code, 0, FALSE)
	var/newname = M.dna.species.random_name(M.gender,0,SSticker.mode.nukeops_lastname)
	M.mind.name = newname
	M.real_name = newname
	M.name = newname

//////SYNDICATE BORG
/obj/item/antag_spawner/nuke_ops/borg_tele
	name = "syndicate cyborg teleporter"
	desc = "A single-use teleporter designed to quickly reinforce operatives in the field.."
	icon = 'icons/obj/device.dmi'
	icon_state = "locator"

/obj/item/antag_spawner/nuke_ops/borg_tele/assault
	name = "syndicate assault cyborg teleporter"
	borg_to_spawn = "Assault"

/obj/item/antag_spawner/nuke_ops/borg_tele/medical
	name = "syndicate medical teleporter"
	borg_to_spawn = "Medical"

/obj/item/antag_spawner/nuke_ops/borg_tele/spawn_antag(client/C, turf/T)
	var/mob/living/silicon/robot/R
	switch(borg_to_spawn)
		if("Medical")
			R = new /mob/living/silicon/robot/modules/syndicate/medical(T)
		else
			R = new /mob/living/silicon/robot/modules/syndicate(T) //Assault borg by default

	var/brainfirstname = pick(GLOB.first_names_male)
	if(prob(50))
		brainfirstname = pick(GLOB.first_names_female)
	var/brainopslastname = pick(GLOB.last_names)
	if(SSticker.mode.nukeops_lastname)  //the brain inside the syndiborg has the same last name as the other ops.
		brainopslastname = SSticker.mode.nukeops_lastname
	var/brainopsname = "[brainfirstname] [brainopslastname]"

	R.mmi.name = "Man-Machine Interface: [brainopsname]"
	R.mmi.brain.name = "[brainopsname]'s brain"
	R.mmi.brainmob.real_name = brainopsname
	R.mmi.brainmob.name = brainopsname
	R.real_name = R.name

	R.key = C.key
	R.mind.make_Nuke(null, nuke_code = null,leader=0, telecrystals = TRUE)
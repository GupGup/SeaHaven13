//Objects that spawn ghosts in as a certain role when they click on it, i.e. away mission bartenders.

//Space Hotel Staff
/obj/effect/mob_spawn/human/hotel_staff //not free antag u little shits
	name = "staff sleeper"
	desc = "A sleeper designed for long-term stasis between guest visits."
	mob_name = "hotel staff member"
	icon = 'icons/obj/Cryogenic2.dmi'
	icon_state = "sleeper_s"
	objectives = "Cater to visiting guests with your fellow staff. Do not leave your assigned hotel and always remember: The customer is always right!"
	death = FALSE
	roundstart = FALSE
	random = TRUE
	outfit = /datum/outfit/hotelstaff
	flavour_text = "You are a staff member of a top-of-the-line space hotel! Cater to guests and <font size=6><b>DON'T</b></font> leave the hotel, lest the manager fire you for\
		dereliction of duty!"
	assignedrole = "Hotel Staff"

/datum/outfit/hotelstaff
	name = "Hotel Staff"
	uniform = /obj/item/clothing/under/assistantformal
	shoes = /obj/item/clothing/shoes/laceup
	r_pocket = /obj/item/device/radio/off
	back = /obj/item/storage/backpack
	implants = list(/obj/item/implant/mindshield)

/obj/effect/mob_spawn/human/hotel_staff/security
	name = "hotel security sleeper"
	mob_name = "hotel security member"
	outfit = /datum/outfit/hotelstaff/security
	flavour_text = "You are a peacekeeper assigned to this hotel to protect the interests of the company while keeping the peace between \
		guests and the staff. Do <font size=6><b>NOT</b></font> leave the hotel, as that is grounds for contract termination."
	objectives = "Do not leave your assigned hotel. Try and keep the peace between staff and guests, non-lethal force heavily advised if possible."

/datum/outfit/hotelstaff/security
	name = "Hotel Secuirty"
	uniform = /obj/item/clothing/under/rank/security/blueshirt
	shoes = /obj/item/clothing/shoes/jackboots
	suit = /obj/item/clothing/suit/armor/vest/blueshirt
	head = /obj/item/clothing/head/helmet/blueshirt
	back = /obj/item/storage/backpack/security
	belt = /obj/item/storage/belt/security/full

/obj/effect/mob_spawn/human/hotel_staff/Destroy()
	new/obj/structure/fluff/empty_sleeper/syndicate(get_turf(src))
	..()

/obj/effect/mob_spawn/human/demonic_friend
	name = "Essence of friendship"
	desc = "Oh boy! Oh boy! A friend!"
	mob_name = "Demonic friend"
	icon = 'icons/obj/cardboard_cutout.dmi'
	icon_state = "cutout_basic"
	outfit = /datum/outfit/demonic_friend
	death = FALSE
	roundstart = FALSE
	random = TRUE
	id_job = "SuperFriend"
	id_access = "assistant"
	var/obj/effect/proc_holder/spell/targeted/summon_friend/spell
	var/datum/mind/owner
	assignedrole = "SuperFriend"

/obj/effect/mob_spawn/human/demonic_friend/Initialize(mapload, datum/mind/owner_mind, obj/effect/proc_holder/spell/targeted/summon_friend/summoning_spell)
	. = ..()
	owner = owner_mind
	flavour_text = "You have been given a reprieve from your eternity of torment, to be [owner.name]'s friend for their short mortal coil.  Be aware that if you do not live up to [owner.name]'s expectations, they can send you back to hell with a single thought.  [owner.name]'s death will also return you to hell."
	var/area/A = get_area(src)
	if(!mapload && A)
		notify_ghosts("\A friendship shell has been completed in \the [A.name].", source = src, action=NOTIFY_ATTACK, flashwindow = FALSE)
	objectives = "Be [owner.name]'s friend, and keep [owner.name] alive, so you don't get sent back to hell."
	spell = summoning_spell


/obj/effect/mob_spawn/human/demonic_friend/special(mob/living/L)
	if(!QDELETED(owner.current) && owner.current.stat != DEAD)
		L.real_name = "[owner.name]'s best friend"
		L.name = L.real_name
		soullink(/datum/soullink/oneway, owner.current, L)
		spell.friend = L
		spell.charge_counter = spell.charge_max
		L.mind.hasSoul = FALSE
		var/mob/living/carbon/human/H = L
		var/obj/item/worn = H.wear_id
		var/obj/item/card/id/id = worn.GetID()
		id.registered_name = L.real_name
		id.update_label()
	else
		to_chat(L, "<span class='userdanger'>Your owner is already dead!  You will soon perish.</span>")
		addtimer(CALLBACK(L, /mob.proc/dust, 150)) //Give em a few seconds as a mercy.

/datum/outfit/demonic_friend
	name = "Demonic Friend"
	uniform = /obj/item/clothing/under/assistantformal
	shoes = /obj/item/clothing/shoes/laceup
	r_pocket = /obj/item/device/radio/off
	back = /obj/item/storage/backpack
	implants = list(/obj/item/implant/mindshield) //No revolutionaries, he's MY friend.
	id = /obj/item/card/id

/obj/effect/mob_spawn/human/syndicate
	name = "Syndicate Operative"
	roundstart = FALSE
	death = FALSE
	icon = 'icons/obj/Cryogenic2.dmi'
	icon_state = "sleeper_s"
	id_access_list = list(ACCESS_SYNDICATE)
	outfit = /datum/outfit/syndicate_empty
	assignedrole = "Space Syndicate"	//I know this is really dumb, but Syndicate operative is nuke ops

/datum/outfit/syndicate_empty
	name = "Syndicate Operative Empty"
	uniform = /obj/item/clothing/under/syndicate
	shoes = /obj/item/clothing/shoes/combat
	gloves = /obj/item/clothing/gloves/combat
	ears = /obj/item/device/radio/headset/syndicate/alt
	back = /obj/item/storage/backpack
	implants = list(/obj/item/implant/weapons_auth)
	id = /obj/item/card/id

/datum/outfit/syndicate_empty/post_equip(mob/living/carbon/human/H)
	H.faction |= "syndicate"

/obj/effect/mob_spawn/human/syndicate/battlecruiser
	name = "Syndicate Battlecruiser Ship Operative"
	flavour_text = "<font size=3>You are a crewmember aboard the syndicate flagship: the SBC Starfury. <span class='danger'><b>Your job is to follow your captain's orders, maintain the ship, and keep the engine running.</b></span> If you are not familiar with how the supermatter engine functions: <b>do not attempt to start it.</b><br><br><span class='danger'><b>The armory is not a candy store, and your role is not to assault the station directly, leave that work to the assault operatives.</b></span></font>"
	outfit = /datum/outfit/syndicate_empty/SBC

/datum/outfit/syndicate_empty/SBC
	name = "Syndicate Battlecruiser Ship Operative"
	l_pocket = /obj/item/gun/ballistic/automatic/pistol
	r_pocket = /obj/item/kitchen/knife/combat/survival
	belt = /obj/item/storage/belt/military/assault

/obj/effect/mob_spawn/human/syndicate/battlecruiser/assault
	name = "Syndicate Battlecruiser Assault Operative"
	flavour_text = "<font size=3>You are an assault operative aboard the syndicate flagship: the SBC Starfury. <span class='danger'><b>Your job is to follow your captain's orders, keep intruders out of the ship, and assault Space Station 13.</b></span> There is an armory, multiple assault ships, and beam cannons to attack the station with.<br><br><span class='danger'><b>Work as a team with your fellow operatives and work out a plan of attack. If you are overwhelmed, escape back to your ship!</b></span></font>"
	outfit = /datum/outfit/syndicate_empty/SBC/assault

/datum/outfit/syndicate_empty/SBC/assault
	name = "Syndicate Battlecruiser Assault Operative"
	uniform = /obj/item/clothing/under/syndicate/combat
	l_pocket = /obj/item/ammo_box/magazine/m10mm
	r_pocket = /obj/item/kitchen/knife/combat/survival
	belt = /obj/item/storage/belt/military
	suit = /obj/item/clothing/suit/armor/vest
	suit_store = /obj/item/gun/ballistic/automatic/pistol
	back = /obj/item/storage/backpack/security
	mask = /obj/item/clothing/mask/gas/syndicate

/obj/effect/mob_spawn/human/syndicate/battlecruiser/captain
	name = "Syndicate Battlecruiser Captain"
	flavour_text = "<font size=3>You are the captain aboard the syndicate flagship: the SBC Starfury. <span class='danger'><b>Your job is to oversee your crew, defend the ship, and destroy Space Station 13.</b></span> The ship has an armory, multiple ships, beam cannons, and multiple crewmembers to accomplish this goal.<br><br><span class='danger'><b>As the captain, this whole operation falls on your shoulders.</b></span> You do not need to nuke the station, causing sufficient damage and preventing your ship from being destroyed will be enough.</font>"
	outfit = /datum/outfit/syndicate_empty/SBC/assault/captain
	id_access_list = list(150,151)

/datum/outfit/syndicate_empty/SBC/assault/captain
	name = "Syndicate Battlecruiser Captain"
	l_pocket = /obj/item/melee/transforming/energy/sword/saber/red
	r_pocket = /obj/item/melee/classic_baton/telescopic
	suit = /obj/item/clothing/suit/armor/vest/capcarapace/syndicate
	suit_store = /obj/item/gun/ballistic/revolver/mateba
	back = /obj/item/storage/backpack/satchel/leather
	head = /obj/item/clothing/head/HoS/syndicate
	mask = /obj/item/clothing/mask/cigarette/cigar/havana
	glasses = /obj/item/clothing/glasses/thermal/eyepatch

//Ancient cryogenic sleepers. Players become NT crewmen from a hundred year old space station, now on the verge of collapse.
/obj/effect/mob_spawn/human/oldsec
	name = "old cryogenics pod"
	desc = "A humming cryo pod. You can barely recognise a security uniform underneath the built up ice. The machine is attempting to wake up its occupant."
	mob_name = "a security officer"
	icon = 'icons/obj/cryogenic2.dmi'
	icon_state = "sleeper"
	roundstart = FALSE
	death = FALSE
	random = TRUE
	mob_species = /datum/species/human
	flavour_text = "<font size=3><b>Y</b></font><b>ou are a security officer working for Nanotrasen, stationed onboard a state of the art research station. You vaguely recall rushing into a \
	cryogenics pod due to an oncoming radiation storm. The last thing you remember is the station's Artifical Program telling you that you would only be asleep for eight hours. As you open \
	your eyes, everything seems rusted and broken, a dark feeling sweels in your gut as you climb out of your pod."
	uniform = /obj/item/clothing/under/rank/security
	shoes = /obj/item/clothing/shoes/jackboots
	id = /obj/item/card/id/away/old/sec
	r_pocket = /obj/item/restraints/handcuffs
	l_pocket = /obj/item/device/assembly/flash/handheld
	assignedrole = "Ancient Crew"

/obj/effect/mob_spawn/human/oldsec/Destroy()
	new/obj/structure/showcase/machinery/oldpod/used(drop_location())
	return ..()

/obj/effect/mob_spawn/human/oldeng
	name = "old cryogenics pod"
	desc = "A humming cryo pod. You can barely recognise an engineering uniform underneath the built up ice. The machine is attempting to wake up its occupant."
	mob_name = "an engineer"
	icon = 'icons/obj/cryogenic2.dmi'
	icon_state = "sleeper"
	roundstart = FALSE
	death = FALSE
	random = TRUE
	mob_species = /datum/species/human
	flavour_text = "<font size=3><b>Y</b></font><b>ou are an engineer working for Nanotrasen, stationed onboard a state of the art research station. You vaguely recall rushing into a \
	cryogenics pod due to an oncoming radiation storm. The last thing you remember is the station's Artifical Program telling you that you would only be asleep for eight hours. As you open \
	your eyes, everything seems rusted and broken, a dark feeling sweels in your gut as you climb out of your pod."
	uniform = /obj/item/clothing/under/rank/engineer
	shoes = /obj/item/clothing/shoes/workboots
	id = /obj/item/card/id/away/old/eng
	gloves = /obj/item/clothing/gloves/color/fyellow/old
	l_pocket = /obj/item/tank/internals/emergency_oxygen
	assignedrole = "Ancient Crew"

/obj/effect/mob_spawn/human/oldeng/Destroy()
	new/obj/structure/showcase/machinery/oldpod/used(drop_location())
	return ..()

/obj/effect/mob_spawn/human/oldsci
	name = "old cryogenics pod"
	desc = "A humming cryo pod. You can barely recognise a science uniform underneath the built up ice. The machine is attempting to wake up its occupant."
	mob_name = "a scientist"
	icon = 'icons/obj/cryogenic2.dmi'
	icon_state = "sleeper"
	roundstart = FALSE
	death = FALSE
	random = TRUE
	mob_species = /datum/species/human
	flavour_text = "<font size=3><b>Y</b></font><b>ou are a scientist working for Nanotrasen, stationed onboard a state of the art research station. You vaguely recall rushing into a \
	cryogenics pod due to an oncoming radiation storm. The last thing you remember is the station's Artifical Program telling you that you would only be asleep for eight hours. As you open \
	your eyes, everything seems rusted and broken, a dark feeling sweels in your gut as you climb out of your pod."
	uniform = /obj/item/clothing/under/rank/scientist
	shoes = /obj/item/clothing/shoes/laceup
	id = /obj/item/card/id/away/old/sci
	l_pocket = /obj/item/stack/medical/bruise_pack
	assignedrole = "Ancient Crew"

/obj/effect/mob_spawn/human/oldsci/Destroy()
	new/obj/structure/showcase/machinery/oldpod/used(drop_location())
	return ..()


#define PIRATE_NAMES_FILE "pirates.json"

/obj/effect/mob_spawn/human/pirate
	name = "space pirate sleeper"
	desc = "A cryo sleeper smelling faintly of rum."
	random = TRUE
	icon = 'icons/obj/cryogenic2.dmi'
	icon_state = "sleeper"
	mob_name = "a space pirate"
	mob_species = /datum/species/human
	outfit = /datum/outfit/pirate/space
	roundstart = FALSE
	death = FALSE
	anchored = TRUE
	density = FALSE
	show_flavour = FALSE //Flavour only exists for spawners menu
	flavour_text = "<font size=3><b>Y</b></font><b>ou are a space pirate. The station refused to pay for your protection, protect the ship, siphon the credits from the station and raid it for even more loot.</b>"
	assignedrole = "Space Pirate"
	var/rank = "Mate"

/obj/effect/mob_spawn/human/pirate/special(mob/living/new_spawn)
	new_spawn.fully_replace_character_name(new_spawn.real_name,generate_pirate_name())
	new_spawn.mind.add_antag_datum(/datum/antagonist/pirate)

/obj/effect/mob_spawn/human/pirate/proc/generate_pirate_name()
	var/beggings = strings(PIRATE_NAMES_FILE, "beginnings")
	var/endings = strings(PIRATE_NAMES_FILE, "endings")
	return "[rank] [pick(beggings)][pick(endings)]"

/obj/effect/mob_spawn/human/pirate/Destroy()
	new/obj/structure/showcase/machinery/oldpod/used(drop_location())
	return ..()

/obj/effect/mob_spawn/human/pirate/captain
	rank = "Captain"
	outfit = /datum/outfit/pirate/space/captain

/obj/effect/mob_spawn/human/pirate/gunner
	rank = "Gunner"
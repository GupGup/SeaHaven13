/obj/item/circuitboard/computer/turbine_computer
	name = "Turbine Computer (Computer Board)"
	build_path = /obj/machinery/computer/turbine_computer
	origin_tech = "programming=4;engineering=4;powerstorage=4"

/obj/item/circuitboard/computer/message_monitor
	name = "Message Monitor (Computer Board)"
	build_path = /obj/machinery/computer/message_monitor
	origin_tech = "programming=2"

/obj/item/circuitboard/computer/security
	name = "Security Cameras (Computer Board)"
	build_path = /obj/machinery/computer/security
	origin_tech = "programming=2;combat=2"

/obj/item/circuitboard/computer/xenobiology
	name = "circuit board (Xenobiology Console)"
	build_path = /obj/machinery/computer/camera_advanced/xenobio
	origin_tech = "programming=3;biotech=3"

/obj/item/circuitboard/computer/aiupload
	name = "AI Upload (Computer Board)"
	build_path = /obj/machinery/computer/upload/ai
	origin_tech = "programming=4;engineering=4"

/obj/item/circuitboard/computer/borgupload
	name = "Cyborg Upload (Computer Board)"
	build_path = /obj/machinery/computer/upload/borg
	origin_tech = "programming=4;engineering=4"

/obj/item/circuitboard/computer/med_data
	name = "Medical Records Console (Computer Board)"
	build_path = /obj/machinery/computer/med_data
	origin_tech = "programming=2;biotech=2"

/obj/item/circuitboard/computer/pandemic
	name = "PanD.E.M.I.C. 2200 (Computer Board)"
	build_path = /obj/machinery/computer/pandemic
	origin_tech = "programming=2;biotech=2"

/obj/item/circuitboard/computer/scan_consolenew
	name = "DNA Machine (Computer Board)"
	build_path = /obj/machinery/computer/scan_consolenew
	origin_tech = "programming=2;biotech=2"

/obj/item/circuitboard/computer/communications
	name = "Communications (Computer Board)"
	build_path = /obj/machinery/computer/communications
	origin_tech = "programming=3;magnets=3"
	var/lastTimeUsed = 0

/obj/item/circuitboard/computer/card
	name = "ID Console (Computer Board)"
	build_path = /obj/machinery/computer/card
	origin_tech = "programming=3"

/obj/item/circuitboard/computer/card/centcom
	name = "CentCom ID Console (Computer Board)"
	build_path = /obj/machinery/computer/card/centcom

/obj/item/circuitboard/computer/card/minor
	name = "Department Management Console (Computer Board)"
	build_path = /obj/machinery/computer/card/minor
	var/target_dept = 1
	var/list/dept_list = list("General","Security","Medical","Science","Engineering")

/obj/item/circuitboard/computer/card/minor/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/screwdriver))
		target_dept = (target_dept == dept_list.len) ? 1 : (target_dept + 1)
		to_chat(user, "<span class='notice'>You set the board to \"[dept_list[target_dept]]\".</span>")
	else
		return ..()

/obj/item/circuitboard/computer/card/minor/examine(user)
	..()
	to_chat(user, "Currently set to \"[dept_list[target_dept]]\".")

//obj/item/circuitboard/computer/shield
//	name = "Shield Control (Computer Board)"
//	build_path = /obj/machinery/computer/stationshield

/obj/item/circuitboard/computer/secure_data
	name = "Security Records Console (Computer Board)"
	build_path = /obj/machinery/computer/secure_data
	origin_tech = "programming=2;combat=2"

/obj/item/circuitboard/computer/stationalert
	name = "Station Alerts (Computer Board)"
	build_path = /obj/machinery/computer/station_alert

/obj/item/circuitboard/computer/atmos_control
	name = "Atmospheric Monitor (Computer Board)"
	build_path = /obj/machinery/computer/atmos_control

/obj/item/circuitboard/computer/atmos_control/tank
	name = "Tank Control (Computer Board)"
	build_path = /obj/machinery/computer/atmos_control/tank
	origin_tech = "programming=2;engineering=3;materials=2"

/obj/item/circuitboard/computer/atmos_alert
	name = "Atmospheric Alert (Computer Board)"
	build_path = /obj/machinery/computer/atmos_alert

/obj/item/circuitboard/computer/pod
	name = "Massdriver control (Computer Board)"
	build_path = /obj/machinery/computer/pod

/obj/item/circuitboard/computer/robotics
	name = "Robotics Control (Computer Board)"
	build_path = /obj/machinery/computer/robotics
	origin_tech = "programming=3"

/obj/item/circuitboard/computer/cloning
	name = "Cloning (Computer Board)"
	build_path = /obj/machinery/computer/cloning
	origin_tech = "programming=2;biotech=2"

/obj/item/circuitboard/computer/arcade/battle
	name = "Arcade Battle (Computer Board)"
	build_path = /obj/machinery/computer/arcade/battle
	origin_tech = "programming=1"

/obj/item/circuitboard/computer/arcade/orion_trail
	name = "Orion Trail (Computer Board)"
	build_path = /obj/machinery/computer/arcade/orion_trail
	origin_tech = "programming=1"

/obj/item/circuitboard/computer/turbine_control
	name = "Turbine control (Computer Board)"
	build_path = /obj/machinery/computer/turbine_computer

/obj/item/circuitboard/computer/solar_control
	name = "Solar Control (Computer Board)"  //name fixed 250810
	build_path = /obj/machinery/power/solar_control
	origin_tech = "programming=2;powerstorage=2"

/obj/item/circuitboard/computer/powermonitor
	name = "Power Monitor (Computer Board)"  //name fixed 250810
	build_path = /obj/machinery/computer/monitor
	origin_tech = "programming=2;powerstorage=2"

/obj/item/circuitboard/computer/olddoor
	name = "DoorMex (Computer Board)"
	build_path = /obj/machinery/computer/pod/old

/obj/item/circuitboard/computer/syndicatedoor
	name = "ProComp Executive (Computer Board)"
	build_path = /obj/machinery/computer/pod/old/syndicate

/obj/item/circuitboard/computer/swfdoor
	name = "Magix (Computer Board)"
	build_path = /obj/machinery/computer/pod/old/swf

/obj/item/circuitboard/computer/prisoner
	name = "Prisoner Management Console (Computer Board)"
	build_path = /obj/machinery/computer/prisoner

/obj/item/circuitboard/computer/rdconsole
	name = "R&D Console (Computer Board)"
	build_path = /obj/machinery/computer/rdconsole/core

/obj/item/circuitboard/computer/rdconsole/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/screwdriver))
		if(build_path == /obj/machinery/computer/rdconsole/core)
			name = "R&D Console - Robotics (Computer Board)"
			build_path = /obj/machinery/computer/rdconsole/robotics
			to_chat(user, "<span class='notice'>Access protocols successfully updated.</span>")
		else
			name = "R&D Console (Computer Board)"
			build_path = /obj/machinery/computer/rdconsole/core
			to_chat(user, "<span class='notice'>Defaulting access protocols.</span>")
	else
		return ..()

/obj/item/circuitboard/computer/mecha_control
	name = "Exosuit Control Console (Computer Board)"
	build_path = /obj/machinery/computer/mecha

/obj/item/circuitboard/computer/rdservercontrol
	name = "R&D Server Control (Computer Board)"
	build_path = /obj/machinery/computer/rdservercontrol

/obj/item/circuitboard/computer/crew
	name = "Crew Monitoring Console (Computer Board)"
	build_path = /obj/machinery/computer/crew
	origin_tech = "programming=2;biotech=2"

/obj/item/circuitboard/computer/mech_bay_power_console
	name = "Mech Bay Power Control Console (Computer Board)"
	build_path = /obj/machinery/computer/mech_bay_power_console
	origin_tech = "programming=3;powerstorage=3"

/obj/item/circuitboard/computer/operating
	name = "Operating Computer (Computer Board)"
	build_path = /obj/machinery/computer/operating
	origin_tech = "programming=2;biotech=3"

/obj/item/circuitboard/computer/mining
	name = "Outpost Status Display (Computer Board)"
	build_path = /obj/machinery/computer/security/mining

/obj/item/circuitboard/computer/comm_monitor
	name = "Telecommunications Monitor (Computer Board)"
	build_path = /obj/machinery/computer/telecomms/monitor
	origin_tech = "programming=3;magnets=3;bluespace=2"

/obj/item/circuitboard/computer/comm_server
	name = "Telecommunications Server Monitor (Computer Board)"
	build_path = /obj/machinery/computer/telecomms/server
	origin_tech = "programming=3;magnets=3;bluespace=2"

/obj/item/circuitboard/computer/holodeck// Not going to let people get this, but it's just here for future
	name = "Holodeck Control (Computer Board)"
	build_path = /obj/machinery/computer/holodeck
	origin_tech = "programming=4"

/obj/item/circuitboard/computer/aifixer
	name = "AI Integrity Restorer (Computer Board)"
	build_path = /obj/machinery/computer/aifixer
	origin_tech = "programming=2;biotech=2"

/obj/item/circuitboard/computer/libraryconsole
	name = "Library Visitor Console (Computer Board)"
	build_path = /obj/machinery/computer/libraryconsole
	origin_tech = "programming=1"

/obj/item/circuitboard/computer/libraryconsole/attackby(obj/item/I, mob/user, params)
	if(istype(I, /obj/item/screwdriver))
		if(build_path == /obj/machinery/computer/libraryconsole/bookmanagement)
			name = "Library Visitor Console (Computer Board)"
			build_path = /obj/machinery/computer/libraryconsole
			to_chat(user, "<span class='notice'>Defaulting access protocols.</span>")
		else
			name = "Book Inventory Management Console (Computer Board)"
			build_path = /obj/machinery/computer/libraryconsole/bookmanagement
			to_chat(user, "<span class='notice'>Access protocols successfully updated.</span>")
	else
		return ..()

/obj/item/circuitboard/computer/apc_control
	name = "\improper Power Flow Control Console (Computer Board)"
	build_path = /obj/machinery/computer/apc_control
	origin_tech = "programming=3;engineering=3;powerstorage=2"
/datum/quirk/jailbird
	name = "Jailbird"
	desc = "You're a wanted criminal! You start the round set to arrest for a random crime."
	value = -1

/datum/quirk/jailbird/post_add()
	. = ..()
	spawn(3 SECONDS) //Deliberately delayed a while to allow for the actual data_core entry to be created
		var/mob/living/carbon/human/H = quirk_holder
		var/quirk_crime	= pick(world.file2list("monkestation/strings/random_crimes.txt"))
		to_chat(H, "<span class='boldnotice'>You are on the run for your crime of: [quirk_crime]!</span>")
		var/crime = GLOB.data_core.createCrimeEntry(quirk_crime, "Galactic Crime Broadcast", "[pick(world.file2list("monkestation/strings/random_police.txt"))]", "[(rand(9)+1)] [pick("days", "weeks", "months", "years")] ago", 0)
		var/perpname = H.name
		var/datum/data/record/R = find_record("name", perpname, GLOB.data_core.security)
		GLOB.data_core.addCrime(R.fields["id"], crime)
		R.fields["criminal"] = "Arrest"
		H.sec_hud_set_security_status()

/datum/quirk/stowaway
	name = "Stowaway"
	desc = "You're a station stowaway with no ID card that wakes up inside a random locker, who knows where you'll end up?"
	value = -2

/datum/quirk/stowaway/on_spawn()
	. = ..()
	var/mob/living/carbon/human/H = quirk_holder
	H.Sleeping(5 SECONDS, TRUE, TRUE) //This is both flavorful and gives time for the rest of the code to work.
	var/obj/item/card/id/trashed = H.get_item_by_slot(ITEM_SLOT_ID) //No ID
	qdel(trashed)
	if(prob(20))
		H.drunkenness = 50 //What did I DO last night?
	var/obj/structure/closet/selected_closet = get_unlocked_closed_locker() //Find your new home
	if(selected_closet)
		H.forceMove(selected_closet) //Move in


/datum/quirk/stowaway/post_add()
	. = ..()
	spawn(4 SECONDS) //Gives enough time for the data_core entry to get created
		var/mob/living/carbon/human/H = quirk_holder
		var/perpname = H.name
		var/datum/data/record/R = find_record("name", perpname, GLOB.data_core.general)
		qdel(R)
		to_chat(H, "<span class='boldnotice'>You've awoken to find yourself inside [GLOB.station_name] without identification!</span>")

/datum/quirk/unstable_ass
	name = "Unstable Rear"
	desc = "For reasons unknown, your posterior is unstable and will fall off more often."
	value = -1
	//All effects are handled directly in butts.dm

/datum/quirk/kleptomaniac
	name = "Kleptomaniac"
	desc = "The station's just full of free stuff!  Nobody would notice if you just... took it, right?"
	mob_trait = TRAIT_KLEPTOMANIAC
	value = -2

/datum/quirk/kleptomaniac/add()
	var/datum/brain_trauma/mild/kleptomania/T = new()
	var/mob/living/carbon/human/H = quirk_holder
	H.gain_trauma(T, TRAUMA_RESILIENCE_ABSOLUTE)

/datum/quirk/kleptomaniac/remove()
	var/mob/living/carbon/human/H = quirk_holder
	H.cure_trauma_type(/datum/brain_trauma/mild/kleptomania, TRAUMA_RESILIENCE_ABSOLUTE)

/datum/quirk/fluffy_tongue
	name = "Fluffy Tongue"
	desc = "After spending too much time watching anime you have developed a horrible speech impediment."
	value = 5

/datum/quirk/fluffy_tongue/on_spawn()
	RegisterSignal(quirk_holder, COMSIG_MOB_SAY, .proc/handle_speech)

/datum/quirk/fluffy_tongue/remove()
	UnregisterSignal(quirk_holder, COMSIG_MOB_SAY)


/datum/quirk/fluffy_tongue/proc/handle_speech(datum/source, list/speech_args)
	var/message = speech_args[SPEECH_MESSAGE]
	if(message[1] != "*")
		message = replacetext(message, "ne", "nye")
		message = replacetext(message, "nu", "nyu")
		message = replacetext(message, "na", "nya")
		message = replacetext(message, "no", "nyo")
		message = replacetext(message, "ove", "uv")
		message = replacetext(message, "r", "w")
		message = replacetext(message, "l", "w")
	speech_args[SPEECH_MESSAGE] = message

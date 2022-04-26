/// *!! Random Rooms - BoxStation Area Spawners !!*
//Random Engines
/obj/effect/spawner/room/engine/box
	name = "box engine spawner"
	dedicated_rooms = list(/datum/map_template/random_room/box_supermatter = 5, /datum/map_template/random_room/box_particle_accelerator = 2)
	room_width = 32
	room_height = 27


/// *!! Random Rooms - MetaStation Area Spawners !!*
//Random Engines
/obj/effect/spawner/room/engine/meta
	name = "meta engine spawner"
	dedicated_rooms = list(/datum/map_template/random_room/meta_supermatter = 5, /datum/map_template/random_room/meta_particle_accelerator = 2)
	room_width = 32
	room_height = 26

//Random Bars
/obj/effect/spawner/room/bar/meta
	name = "meta bar spawner"
	dedicated_rooms = list(/datum/map_template/random_room/meta_default_bar = 1, /datum/map_template/random_room/meta_grungy_bar = 1)
	room_width = 9
	room_height = 9

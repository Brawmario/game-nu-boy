extends Node2D

var crate_count: int

onready var player := $Player as Player
onready var level_map := $Level1 as LevelMap
onready var level_ui := $UI/LevelUI as LevelUI


func _ready():
	var crates := get_tree().get_nodes_in_group("object_crate")
	for crate in crates:
		crate.connect("destroyed", self, "crate_destroyed")
	crate_count = crates.size()
	level_ui.update_crates(crate_count)

	level_map.death_plane.connect("player_fell", self, "player_death")


func crate_destroyed() -> void:
	crate_count -= 1
	level_ui.update_crates(crate_count)


func player_death() -> void:
	Globals.player_lives -= 1
	if Globals.player_lives > 0:
		player.teleport(level_map.start.global_position)
	else:
		player.die()

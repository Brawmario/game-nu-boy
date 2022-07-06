extends Node2D

var crate_count: int


func _ready():
	var crates := get_tree().get_nodes_in_group("object_crate")
	for crate in crates:
		crate.connect("destroyed", self, "crate_destroyed")
	crate_count = crates.size()
	$UI/LevelUI.update_crates(crate_count)


func crate_destroyed() -> void:
	crate_count -= 1
	$UI/LevelUI.update_crates(crate_count)

class_name LevelMap
extends TileMap

const CRATE_ID = 2

var CrateArea := preload("res://World/CrateArea.tscn")

onready var start = $Start as Position2D
onready var death_plane = $DeathPlane as DeathPlane


func _ready() -> void:
	assert(start)
	assert(death_plane)

	var crates_cellv := get_used_cells_by_id(CRATE_ID)
	for cellv in crates_cellv:
		var crate_area := CrateArea.instance()
		crate_area.tile_map = self
		crate_area.cellv = cellv
		crate_area.position = map_to_world(cellv)
		add_child(crate_area)

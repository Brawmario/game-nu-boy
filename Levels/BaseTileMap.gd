extends TileMap

const CRATE_ID = 2

var CrateArea := preload("res://World/CrateArea.tscn")


func _ready() -> void:
	var crates := get_used_cells_by_id(CRATE_ID)
	for crate in crates:
		var crate_area := CrateArea.instance()
		crate_area.tile_map = self
		crate_area.cellv = crate
		crate_area.position = map_to_world(crate)
		add_child(crate_area)

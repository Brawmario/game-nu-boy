extends Area2D

var tile_map: TileMap = null
var cellv := Vector2()


func _ready() -> void:
	assert(tile_map, "TileMap not set")


func _on_CrateArea_area_entered(area: Area2D) -> void:
	if area.is_in_group("break_hitbox"):
		tile_map.set_cellv(cellv, -1)
		queue_free()

extends Area2D

var CratePiece := preload("res://World/CratePiece.tscn")

var tile_map: TileMap = null
var cellv := Vector2()


func _ready() -> void:
	assert(tile_map, "TileMap not set")


func _on_CrateArea_area_entered(area: Area2D) -> void:
	if area.is_in_group("break_hitbox"):
		tile_map.set_cellv(cellv, -1)
		for _i in range(4):
			var piece := CratePiece.instance() as RigidBody2D
			piece.apply_central_impulse(Vector2(rand_range(-100, 100), rand_range(-50, -100)))
			call_deferred("add_child", piece)
			get_tree().create_timer(30).connect("timeout", piece, "queue_free")

		$CollisionShape2D.set_deferred("disabled", true)

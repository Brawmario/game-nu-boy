extends Node

signal player_lives_updated(value)

var player_lives := 3 setget _set_player_lives


func _set_player_lives(value: int) -> void:
	player_lives = value
	emit_signal("player_lives_updated", value)

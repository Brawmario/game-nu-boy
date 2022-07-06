class_name DeathPlane
extends Area2D

signal player_fell


func _on_DeathPlane_body_entered(body: Node) -> void:
	var player := body as Player
	if player:
		emit_signal("player_fell")

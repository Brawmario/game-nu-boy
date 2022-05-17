extends Area2D

export var start_node := NodePath()

onready var start: Position2D = get_node(start_node)


func _ready() -> void:
	assert(start, "Start node not set")


func _on_DeathPlane_body_entered(body: Node) -> void:
	var player := body as Player
	if player:
		player.teleport(start.global_position)

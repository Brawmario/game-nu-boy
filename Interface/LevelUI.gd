extends ColorRect

onready var lives := $VBoxContainer/Lives as Label


func _ready() -> void:
	Globals.connect("player_lives_updated", self, "update_lives")
	update_lives(Globals.player_lives)


func update_lives(value: int) -> void:
	lives.text = "X%d" % value

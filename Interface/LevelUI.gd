class_name LevelUI
extends ColorRect

onready var lives := $VBoxContainer/Lives as Label
onready var crates := $VBoxContainer/Crates as Label
onready var game_over := $VBoxContainer/GameOver as Label


func _ready() -> void:
	Globals.connect("player_lives_updated", self, "update_lives")
	update_lives(Globals.player_lives)


func update_lives(value: int) -> void:
	lives.text = "X%d" % value
	if value == 0:
		game_over.visible = true


func update_crates(value: int) -> void:
	if value > 0:
		crates.text = "X%d" % value
	else:
		crates.text = "All Clear!"

class_name State
extends Node

var state_machine


func _ready() -> void:
	yield(owner, "ready")


func process(_delta: float) -> void:
	pass


func physics_process(_delta: float) -> void:
	pass


func enter(_msg := {}) -> void:
	pass


func exit() -> void:
	pass

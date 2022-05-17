class_name StateMachine
extends Node

export var initial_state := NodePath()

onready var state: State = get_node(initial_state)

var states := {}


func _ready() -> void:
	yield(owner, "ready")
	for child in get_children():
		states[child.name] = child
		child.state_machine = self
	assert(state, "Initial state not set")
	state.enter()


func _process(delta: float) -> void:
	state.process(delta)


func _physics_process(delta: float) -> void:
	state.physics_process(delta)


func transition_to(target_state_name: String, msg: Dictionary = {}) -> void:
	var target_state: State = states.get(target_state_name)

	assert(target_state, "Transitioning to non existent state")

	state.exit()
	state = target_state
	state.enter(msg)

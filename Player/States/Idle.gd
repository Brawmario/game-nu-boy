extends PlayerState


func enter(_msg := {}) -> void:
	player._velocity = Vector2.ZERO
	player._sprite_anim.play("Idle")


func physics_process(_delta: float) -> void:
	if not player.is_on_floor():
		state_machine.transition_to("Fall", {"coyote": true})
	elif Input.is_action_just_pressed("jump"):
		state_machine.transition_to("Jump")
	elif Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"):
		state_machine.transition_to("Run")
	elif Input.is_action_just_pressed("dash"):
		state_machine.transition_to("Dash")

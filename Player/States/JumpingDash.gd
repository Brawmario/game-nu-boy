extends PlayerState


func enter(msg := {}) -> void:
	player.jump(msg.get("free", false))
	player._audio_dash.playing = true


func exit() -> void:
	player._audio_dash.stop()


func physics_process(delta: float) -> void:
	player._velocity.x = player.base_move_speed * player.dash_multiplier * player.get_facing_direction()
	player._velocity.y += player._jump_gravity * delta
	player._velocity = player.move_and_slide_with_snap(player._velocity, Vector2.ZERO, Vector2.UP, true)

	if Input.is_action_just_released("jump"):
		player._velocity.y /= 3.0

	if Input.is_action_just_pressed("jump"):
		if player.extra_jumps_left >= 1:
			state_machine.transition_to("JumpingDash")
	elif player._velocity.y >= 0:
		state_machine.transition_to("FallingDash")

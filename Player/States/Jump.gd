extends PlayerState


func enter(msg: Dictionary = {}) -> void:
	player._sprite_anim.play("Jump")
	player.jump(msg.get("free", false))


func physics_process(delta: float) -> void:
	var input_direction_x := player._get_input_velocity()
	player._velocity.x = player.base_move_speed * input_direction_x
	player._velocity.y += player._jump_gravity * delta
	player._velocity = player.move_and_slide_with_snap(player._velocity, Vector2.ZERO, Vector2.UP, true)

	if player._velocity.y >= 0:
		state_machine.transition_to("Fall")

	if Input.is_action_just_released("jump"):
		player._velocity.y /= 3.0

	if Input.is_action_just_pressed("jump"):
		if player.extra_jumps_left >= 1:
			state_machine.transition_to("Jump")

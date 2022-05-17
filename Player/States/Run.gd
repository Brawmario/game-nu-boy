extends PlayerState


func enter(_msg := {}) -> void:
	player._sprite_anim.play("Walk")


func physics_process(delta: float) -> void:
	var input_direction_x := player._get_input_velocity()
	player._velocity.x = player.base_move_speed * input_direction_x
	player._velocity.y += player._fall_gravity * delta
	player._velocity = player.move_and_slide_with_snap(player._velocity, player.snap_normal, Vector2.UP, true)

	if Input.is_action_just_pressed("jump"):
		state_machine.transition_to("Jump", {"free": true})
	elif not player.is_on_floor():
		state_machine.transition_to("Fall", {"coyote": true})
	elif Input.is_action_just_pressed("dash"):
		state_machine.transition_to("Dash")
	elif is_equal_approx(input_direction_x, 0.0):
		state_machine.transition_to("Idle")

extends PlayerState

onready var _duration: Timer = $Duration


func enter(_msg := {}) -> void:
	player._dash_hitbox_shape.set_deferred("disabled", false)
	player._sprite_anim.play("Dash")
	_duration.start()

func exit() -> void:
	player._dash_hitbox_shape.set_deferred("disabled", true)

func physics_process(delta: float) -> void:
	player._velocity.x = player.base_move_speed * player.dash_multiplier * player.get_facing_direction()
	player._velocity.y += player._fall_gravity * delta
	player._velocity = player.move_and_slide_with_snap(player._velocity, player.snap_normal, Vector2.UP, true)

	if not player.is_on_floor():
		if Input.is_action_just_pressed("jump"):
			state_machine.transition_to("Jump", {"free": true})
		else:
			state_machine.transition_to("Fall", {"coyote": true})
	elif _duration.is_stopped():
		if Input.is_action_just_pressed("jump"):
			state_machine.transition_to("Jump", {"free": true})
		elif not is_equal_approx(player._get_input_velocity(), 0.0):
			state_machine.transition_to("Run")
		else:
			state_machine.transition_to("Idle")

extends PlayerState

onready var _coyote: Timer = $Coyote
onready var _buffer_jump: Timer = $BufferJump


func enter(msg: Dictionary = {}) -> void:
	player._sprite_anim.play("Fall")
	if "coyote" in msg:
		_coyote.start()


func exit() -> void:
	_coyote.stop()


func physics_process(delta: float) -> void:
	var input_direction_x := player._get_input_velocity()
	player._velocity.x = player.base_move_speed * input_direction_x
	player._velocity.y += player._fall_gravity * delta
	player._velocity = player.move_and_slide_with_snap(player._velocity, Vector2.ZERO, Vector2.UP, true)

	if player.is_on_floor():
		if not _buffer_jump.is_stopped():
			state_machine.transition_to("Jump", {"free": true})
			return
		elif is_equal_approx(player._velocity.x, 0.0):
			state_machine.transition_to("Idle")
			return
		else:
			state_machine.transition_to("Run")
			return

	if Input.is_action_just_pressed("jump"):
		if not _coyote.is_stopped():
			state_machine.transition_to("Jump", {"free": true})
		elif player.extra_jumps_left >= 1:
			state_machine.transition_to("Jump")
		else:
			_buffer_jump.start()

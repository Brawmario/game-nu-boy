extends PlayerState

onready var _coyote: Timer = $"../Fall/Coyote"
onready var _buffer_jump: Timer = $"../Fall/BufferJump"

var _should_disable_hitbox_on_exit: bool


func enter(msg := {}) -> void:
	if "coyote" in msg:
		_coyote.start()
	_should_disable_hitbox_on_exit = true


func exit() -> void:
	_coyote.stop()
	player._dash_hitbox_shape.set_deferred("disabled", _should_disable_hitbox_on_exit)


func physics_process(delta: float) -> void:
	player._velocity.x = player.base_move_speed * player.dash_multiplier * player.get_facing_direction()
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
			_should_disable_hitbox_on_exit = false
			state_machine.transition_to("JumpingDash", {"free": true})
		elif player.extra_jumps_left >= 1:
			_should_disable_hitbox_on_exit = false
			state_machine.transition_to("JumpingDash")
		else:
			_buffer_jump.start()

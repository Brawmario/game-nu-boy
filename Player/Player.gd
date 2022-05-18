class_name Player
extends KinematicBody2D

const BLOCK_WIDTH := 16

export var base_move_speed := 5.0 * BLOCK_WIDTH
export var dash_multiplier := 1.5
export var max_jump_height := 3.0 * BLOCK_WIDTH setget _set_max_jump_height
export var max_jump_distance := 2.0 * BLOCK_WIDTH setget _set_max_jump_distance
export var max_fall_distance := 2.0 * BLOCK_WIDTH setget _set_max_jump_distance
export var extra_jump_count := 1

onready var _jump_velocity := _calculate_jump_velocity(max_jump_height, max_jump_distance, base_move_speed)
onready var _jump_gravity := _calculate_jump_gravity(max_jump_height, max_jump_distance, base_move_speed)
onready var _fall_gravity := _calculate_jump_gravity(max_jump_height, max_fall_distance, base_move_speed)

onready var _body := $Body as Node2D
onready var _sprite_anim := $Body/Sprite/AnimationPlayer as AnimationPlayer
onready var _dash_hitbox := $Body/DashHitbox as Area2D

var snap_normal := Vector2.DOWN * BLOCK_WIDTH / 2
var extra_jumps_left := extra_jump_count

var _velocity := Vector2.ZERO


func _physics_process(_delta: float) -> void:
	if is_on_floor():
		extra_jumps_left = extra_jump_count


func jump(free: bool = false) -> void:
	_velocity.y = _jump_velocity

	if not free:
		extra_jumps_left -= 1

	if extra_jumps_left < 0:
		extra_jumps_left = 0


func teleport(to: Vector2) -> void:
	set_global_position(to)


func get_facing_direction() -> float:
	return _body.scale.x


func _get_input_velocity() -> float:
	var horizontal := 0.0

	if Input.is_action_pressed("move_left"):
		horizontal -= 1.0
	if Input.is_action_pressed("move_right"):
		horizontal += 1.0

	if horizontal != 0.0:
		_body.scale.x = horizontal

	return horizontal


func _calculate_jump_velocity(max_height: float, max_distance: float, horizontal_velocity: float) -> float:
	return ((-2.0 * max_height * horizontal_velocity) / max_distance)


func _calculate_jump_gravity(max_height: float, max_distance: float, horizontal_velocity: float) -> float:
	return ((2.0 * max_height * horizontal_velocity * horizontal_velocity) / (max_distance * max_distance))


func _set_max_jump_height(value: float) -> void:
	max_jump_height = value
	_jump_velocity = _calculate_jump_velocity(max_jump_height, max_jump_distance, base_move_speed)
	_jump_gravity = _calculate_jump_gravity(max_jump_height, max_jump_distance, base_move_speed)
	_fall_gravity = _calculate_jump_gravity(max_jump_height, max_fall_distance, base_move_speed)


func _set_max_jump_distance(value: float) -> void:
	max_jump_distance = value
	_jump_velocity = _calculate_jump_velocity(max_jump_height, max_jump_distance, base_move_speed)
	_jump_gravity = _calculate_jump_gravity(max_jump_height, max_jump_distance, base_move_speed)


func _set_max_fall_distance(value: float) -> void:
	max_fall_distance = value
	_fall_gravity = _calculate_jump_gravity(max_jump_height, max_fall_distance, base_move_speed)

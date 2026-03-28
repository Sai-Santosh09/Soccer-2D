class_name Player extends CharacterBody2D

enum ControlScheme {CPU, P1, P2}

@export var control_scheme : ControlScheme
@export var speed : float = 80.0

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var player_sprite: Sprite2D = $PlayerSprite


var Left_or_Right := Vector2.RIGHT

func _process( _delta : float ) -> void:
	if control_scheme == ControlScheme.CPU:
		pass
	else:
		handle_human_movement()
	set_movement_animation()
	set_Left_or_Right()
	flip_sprite()
	move_and_slide()


func set_movement_animation() -> void:
	if velocity.length() > 0:
		animation_player.play("run")
	else:
		animation_player.play("idle")
	pass


func handle_human_movement() -> void:
	var direction := KeyUtil.get_input_vector(control_scheme)
	velocity = direction * speed


func set_Left_or_Right() -> void:
	if velocity.x > 0:
		Left_or_Right = Vector2.RIGHT
	elif velocity.x < 0:
		Left_or_Right = Vector2.LEFT


func flip_sprite() -> void:
	if Left_or_Right == Vector2.RIGHT:
		player_sprite.flip_h = false
	elif Left_or_Right == Vector2.LEFT:
		player_sprite.flip_h = true

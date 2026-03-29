class_name Player extends CharacterBody2D

const DURATION_TACKLE := 200

enum ControlScheme {CPU, P1, P2}
enum State {MOVING, TACKLING, RECOVERING}

@export var control_scheme : ControlScheme
@export var speed : float = 80.0

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var player_sprite: Sprite2D = $PlayerSprite


var Left_or_Right := Vector2.RIGHT
var current_state : PlayerState = null
var state_factory := PlayerStateFactory.new()


func _ready() -> void:
	switch_states(State.MOVING)


func _process( _delta : float ) -> void:
	flip_sprite()
	move_and_slide()


func switch_states( state : State ) -> void:
	if current_state != null:
		current_state.queue_free()
	current_state = state_factory.get_fresh_state(state)
	current_state.setup(self, animation_player)
	current_state.state_transition_requested.connect(switch_states.bind())
	current_state.name = "PlayerStateMachine: " + str(state)
	call_deferred("add_child", current_state)
	 


func set_movement_animation() -> void:
	if velocity.length() > 0:
		animation_player.play("run")
	else:
		animation_player.play("idle")
	pass


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

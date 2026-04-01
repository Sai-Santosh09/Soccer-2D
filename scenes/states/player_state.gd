class_name PlayerState extends Node

signal state_transition_requested( new_state : Player.State, shot_power : float, shot_direction : Vector2 )


var animation_player : AnimationPlayer = null
var player : Player = null


func setup(context_player : Player, context_animation_player : AnimationPlayer) -> void:
	player = context_player
	animation_player = context_animation_player


func transition_state( new_state : Player.State ) -> void:
	state_transition_requested.emit( new_state )


func on_animation_complete() -> void:
	pass

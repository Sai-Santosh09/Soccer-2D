class_name BallState extends Node

signal state_transition_requested(new_state : BallState)

var animation_player : AnimationPlayer
var ball : Ball = null
var carrier : Player = null
var player_detection : Area2D = null

func setup(context_ball : Ball, context_player_detection : Area2D, context_carrier : Player, context_animation_player : AnimationPlayer) -> void:
	ball = context_ball
	player_detection = context_player_detection
	carrier = context_carrier
	animation_player = context_animation_player

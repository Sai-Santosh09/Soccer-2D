class_name PlayerStateShooting extends PlayerState



func _enter_tree() -> void:
	animation_player.play("kick")


func on_animation_complete() -> void:
	if player.control_scheme == Player.ControlScheme.CPU:
		state_transition_requested.emit(Player.State.RECOVERING)
	else:
		state_transition_requested.emit(Player.State.MOVING)
	shoot_ball()


func shoot_ball() -> void:
	print("shoot")

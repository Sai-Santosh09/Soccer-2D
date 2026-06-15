class_name PlayerStateMoving extends PlayerState


func _process(_delta: float) -> void:
	if player.control_scheme == Player.ControlScheme.CPU:
		pass
	else:
		handle_human_movement()
	player.set_movement_animation()
	player.set_Left_or_Right()


func handle_human_movement() -> void:
	var direction := KeyUtil.get_input_vector(player.control_scheme)
	player.velocity = direction * player.speed
	if player.velocity != Vector2.ZERO:
		teammate_detection_area.rotation = player.velocity.angle()
	
	if player.has_ball():
		if KeyUtil.is_action_just_pressed(player.control_scheme, KeyUtil.Action.PASS):
			transition_state(Player.State.PASSING)
		elif KeyUtil.is_action_just_pressed(player.control_scheme, KeyUtil.Action.SHOOT):
			transition_state(Player.State.PREPPING_SHOT)
	elif ball.can_air_interact() and KeyUtil.is_action_just_pressed(player.control_scheme, KeyUtil.Action.SHOOT):
		if player.velocity == Vector2.ZERO:
			if is_facing_target_goal():
				transition_state( Player.State.VOLLEY_KICK )
			else:
				transition_state( Player.State.BICYCLE_KICK )
		else:
			transition_state(Player.State.HEADER)
	
	#if player.velocity != Vector2.ZERO and KeyUtil.is_action_just_pressed(player.control_scheme, KeyUtil.Action.SHOOT):
		#state_transition_requested.emit( Player.State.TACKLING )


func is_facing_target_goal() -> bool:
	var direction_to_target_goal := player.position.direction_to( target_goal.position )
	return player.Left_or_Right.dot( direction_to_target_goal ) > 0

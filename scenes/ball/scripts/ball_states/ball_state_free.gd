class_name BallStateFree extends BallState


func _enter_tree() -> void:
	player_detection.body_entered.connect(on_player_enter.bind())


func on_player_enter(body : Player) -> void:
	ball.carrier = body 
	state_transition_requested.emit(Ball.State.CARRIED)
	
#
#func _process(delta: float) -> void:
	#if ball.velocity == Vector2.ZERO:
		#animation_player.play("idle")
	#elif ball.velocity.x > 0:
		#animation_player.play("roll")
		#animation_player.advance(0)
	#else:
		#animation_player.play_backwards("roll")
		#animation_player.advance(0)
	#ball.move_and_collide( ball.velocity * delta )
